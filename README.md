# Markdown Blog
[![Code Climate](https://codeclimate.com/github/mc388/markdown-blog/badges/gpa.svg)](https://codeclimate.com/github/mc388/markdown-blog)
[![Test Coverage](https://codeclimate.com/github/mc388/markdown-blog/badges/coverage.svg)](https://codeclimate.com/github/mc388/markdown-blog/coverage)

A ruby on rails blog engine

- Copy `config/application.yml.skel` to `config/application.yml` and set the missing parameters


## Content

Supported content types:
- `blog`: An article in a blog
- `header`: A site which will be linked in the header (e.g. About me)
- `footer`: A site which will be linked in the footer (e.g. Impressum)

Example content:

```markdown
---
title: "Some title"
type: "blog"
author: "Marvin Caspar"
tags: "tag1, tag2"
---
# Some title

Content goes here
```
