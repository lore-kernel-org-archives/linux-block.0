Return-Path: <mpatalan@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20180802102326.6859-1-ming.lei@redhat.com>
References: <20180802102326.6859-1-ming.lei@redhat.com>
From: Marco Patalano <mpatalan@redhat.com>
Date: Thu, 2 Aug 2018 15:27:59 -0400
Message-ID: <CAOqaMiyTynt7EzbUScAtzr5SveOnJuMyLyPZSP+ADfYkQ-ABNw@mail.gmail.com>
Subject: Re: [PATCH] blk-mq: fix updating tags depth
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	"Ewan D. Milne" <emilne@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000023568d057278cfce"
List-ID: <linux-block@vger.kernel.org>

--00000000000023568d057278cfce
Content-Type: text/plain; charset="UTF-8"

Tested by: Marco Patalano <mpatalan@redhat.com>

On Thu, Aug 2, 2018 at 6:23 AM, Ming Lei <ming.lei@redhat.com> wrote:

> The passed 'nr' from userspace represents the total depth, meantime
> inside 'struct blk_mq_tags', 'nr_tags' stores the total tag depth,
> and 'nr_reserved_tags' stores the reserved part.
>
> There are two issues in blk_mq_tag_update_depth() now:
>
> 1) for growing tags, we should have used the passed 'nr', and keep the
> number of reserved tags not changed.
>
> 2) the passed 'nr' should have been used for checking against
> 'tags->nr_tags', instead of number of the normal part.
>
> This patch fixes the above two cases, and avoids kernel crash caused
> by wrong resizing sbitmap queue.
>
> Cc: Marco Patalano <mpatalan@redhat.com>
> Cc: "Ewan D. Milne" <emilne@redhat.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Bart Van Assche <bart.vanassche@sandisk.com>
> Cc: Omar Sandoval <osandov@fb.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  block/blk-mq-tag.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
> index 09b2ee6694fb..c43b3398d7b4 100644
> --- a/block/blk-mq-tag.c
> +++ b/block/blk-mq-tag.c
> @@ -399,8 +399,6 @@ int blk_mq_tag_update_depth(struct blk_mq_hw_ctx *hctx,
>         if (tdepth <= tags->nr_reserved_tags)
>                 return -EINVAL;
>
> -       tdepth -= tags->nr_reserved_tags;
> -
>         /*
>          * If we are allowed to grow beyond the original size, allocate
>          * a new set of tags before freeing the old one.
> @@ -420,7 +418,8 @@ int blk_mq_tag_update_depth(struct blk_mq_hw_ctx *hctx,
>                 if (tdepth > 16 * BLKDEV_MAX_RQ)
>                         return -EINVAL;
>
> -               new = blk_mq_alloc_rq_map(set, hctx->queue_num, tdepth, 0);
> +               new = blk_mq_alloc_rq_map(set, hctx->queue_num, tdepth,
> +                               tags->nr_reserved_tags);
>                 if (!new)
>                         return -ENOMEM;
>                 ret = blk_mq_alloc_rqs(set, new, hctx->queue_num, tdepth);
> @@ -437,7 +436,8 @@ int blk_mq_tag_update_depth(struct blk_mq_hw_ctx *hctx,
>                  * Don't need (or can't) update reserved tags here, they
>                  * remain static and should never need resizing.
>                  */
> -               sbitmap_queue_resize(&tags->bitmap_tags, tdepth);
> +               sbitmap_queue_resize(&tags->bitmap_tags,
> +                               tdepth - tags->nr_reserved_tags);
>         }
>
>         return 0;
> --
> 2.9.5
>
>

--00000000000023568d057278cfce
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><span style=3D"font-size:12.8px;text-decoration-style:init=
ial;text-decoration-color:initial;float:none;display:inline">Tested by: Mar=
co Patalano &lt;</span><a href=3D"mailto:mpatalan@redhat.com" target=3D"_bl=
ank" style=3D"color:rgb(17,85,204);font-size:12.8px">mpatalan@redhat.com</a=
><span style=3D"font-size:12.8px;text-decoration-style:initial;text-decorat=
ion-color:initial;float:none;display:inline">&gt;</span><br></div><div clas=
s=3D"gmail_extra"><br><div class=3D"gmail_quote">On Thu, Aug 2, 2018 at 6:2=
3 AM, Ming Lei <span dir=3D"ltr">&lt;<a href=3D"mailto:ming.lei@redhat.com"=
 target=3D"_blank">ming.lei@redhat.com</a>&gt;</span> wrote:<br><blockquote=
 class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc soli=
d;padding-left:1ex">The passed &#39;nr&#39; from userspace represents the t=
otal depth, meantime<br>
inside &#39;struct blk_mq_tags&#39;, &#39;nr_tags&#39; stores the total tag=
 depth,<br>
and &#39;nr_reserved_tags&#39; stores the reserved part.<br>
<br>
There are two issues in blk_mq_tag_update_depth() now:<br>
<br>
1) for growing tags, we should have used the passed &#39;nr&#39;, and keep =
the<br>
number of reserved tags not changed.<br>
<br>
2) the passed &#39;nr&#39; should have been used for checking against<br>
&#39;tags-&gt;nr_tags&#39;, instead of number of the normal part.<br>
<br>
This patch fixes the above two cases, and avoids kernel crash caused<br>
by wrong resizing sbitmap queue.<br>
<br>
Cc: Marco Patalano &lt;<a href=3D"mailto:mpatalan@redhat.com">mpatalan@redh=
at.com</a>&gt;<br>
Cc: &quot;Ewan D. Milne&quot; &lt;<a href=3D"mailto:emilne@redhat.com">emil=
ne@redhat.com</a>&gt;<br>
Cc: Christoph Hellwig &lt;<a href=3D"mailto:hch@lst.de">hch@lst.de</a>&gt;<=
br>
Cc: Bart Van Assche &lt;<a href=3D"mailto:bart.vanassche@sandisk.com">bart.=
vanassche@sandisk.com</a>&gt;<br>
Cc: Omar Sandoval &lt;<a href=3D"mailto:osandov@fb.com">osandov@fb.com</a>&=
gt;<br>
Signed-off-by: Ming Lei &lt;<a href=3D"mailto:ming.lei@redhat.com">ming.lei=
@redhat.com</a>&gt;<br>
---<br>
=C2=A0block/blk-mq-tag.c | 8 ++++----<br>
=C2=A01 file changed, 4 insertions(+), 4 deletions(-)<br>
<br>
diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c<br>
index 09b2ee6694fb..c43b3398d7b4 100644<br>
--- a/block/blk-mq-tag.c<br>
+++ b/block/blk-mq-tag.c<br>
@@ -399,8 +399,6 @@ int blk_mq_tag_update_depth(struct blk_mq_hw_ctx *hctx,=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (tdepth &lt;=3D tags-&gt;nr_reserved_tags)<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0tdepth -=3D tags-&gt;nr_reserved_tags;<br>
-<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* If we are allowed to grow beyond the or=
iginal size, allocate<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* a new set of tags before freeing the ol=
d one.<br>
@@ -420,7 +418,8 @@ int blk_mq_tag_update_depth(struct blk_mq_hw_ctx *hctx,=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (tdepth &gt; 16 =
* BLKDEV_MAX_RQ)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 return -EINVAL;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0new =3D blk_mq_allo=
c_rq_map(set, hctx-&gt;queue_num, tdepth, 0);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0new =3D blk_mq_allo=
c_rq_map(set, hctx-&gt;queue_num, tdepth,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tags-&gt;nr_reserved_tags);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!new)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 return -ENOMEM;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D blk_mq_allo=
c_rqs(set, new, hctx-&gt;queue_num, tdepth);<br>
@@ -437,7 +436,8 @@ int blk_mq_tag_update_depth(struct blk_mq_hw_ctx *hctx,=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Don&#39;t n=
eed (or can&#39;t) update reserved tags here, they<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* remain stat=
ic and should never need resizing.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sbitmap_queue_resiz=
e(&amp;tags-&gt;<wbr>bitmap_tags, tdepth);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sbitmap_queue_resiz=
e(&amp;tags-&gt;<wbr>bitmap_tags,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tdepth - tags-&gt;nr_reserved_tags);<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
<span class=3D"HOEnZb"><font color=3D"#888888">-- <br>
2.9.5<br>
<br>
</font></span></blockquote></div><br></div>

--00000000000023568d057278cfce--
