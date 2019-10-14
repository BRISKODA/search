# BRISKODA Search

The 2019 BRISKODA Search minisite, using [Hugo], deployed via [Netlify]

[![Netlify Status](https://api.netlify.com/api/v1/badges/f71bc439-45fe-45a0-8f37-af61ae6b95fd/deploy-status)](https://app.netlify.com/sites/briskoda-search-88b619/deploys)

## Building

To work locally with this project, you'll have to follow the steps below:

1. Fork, clone or download this project
1. [Install][] Hugo
1. Preview your project: `hugo server`
1. Add content
1. Generate the website: `hugo` (optional)

Read more at Hugo's [documentation][].

### Preview your site

If you clone or download this project to your local computer and run `hugo server`,
your site can be accessed under `localhost:1313/hugo/`.

## Troubleshooting

1. CSS is missing! That means two things:

   Either that you have wrongly set up the CSS URL in your templates, or
   your static generator has a configuration option that needs to be explicitly
   set in order to serve static assets under a relative URL.

[hugo]: https://gohugo.io
[netlify]: https://netlify.com
[install]: https://gohugo.io/overview/installing/
[documentation]: https://gohugo.io/overview/introduction/
