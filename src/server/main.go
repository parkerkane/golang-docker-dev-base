package main

import (
	"github.com/martini-contrib/render"
	"net/http"

	"github.com/go-martini/martini"
	"github.com/jamieomatthews/validation"
	"github.com/martini-contrib/binding"
)

type BlogPost struct {
	Title   string `json:"title" binding:"required"`
	Content string `json:"content"`
	Status  int    `json:"status"`
}

func (bp BlogPost) Validate(errors binding.Errors, req *http.Request) binding.Errors {

	v := validation.NewValidation(&errors, bp)

	v.Validate(&bp.Title).Key("title").MinLength(4)

	return *v.Errors.(*binding.Errors)
}
func main() {
	m := martini.Classic()

	m.Use(render.Renderer())

	m.Post("/blog", binding.Json(BlogPost{}), binding.ErrorHandler, func(blogpost BlogPost, r render.Render) {
		blogpost.Status = 42
		r.JSON(200, blogpost)
	})

	m.Run()
}
