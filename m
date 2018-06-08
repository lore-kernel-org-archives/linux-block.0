Return-Path: <liwan@redhat.com>
MIME-Version: 1.0
In-Reply-To: <75ca49d6-0a09-20d5-20c9-dac77604fdd4@kernel.dk>
References: <CAEemH2fbPv2wphVBHxSSS+KEK5S-rercXhvgLJ7YMOZnrTpexg@mail.gmail.com>
 <20180606084105.GA10720@kmo-pixel> <015f6160-216a-31ba-e251-11336e7ff5d6@kernel.dk>
 <CABATaM7FHcXF7rO5kuMVFRFKFqhqnkoJ_t4w-y4=mNx42=b3Cg@mail.gmail.com>
 <39e797fa-b24c-d122-c06b-196ba2a2d395@kernel.dk> <75ca49d6-0a09-20d5-20c9-dac77604fdd4@kernel.dk>
From: Li Wang <liwang@redhat.com>
Date: Fri, 8 Jun 2018 14:06:56 +0800
Message-ID: <CAEemH2d_ZSfGJ4JqL+aRghaqn5_rvnpwofuHTQ=OzD+mkf0sqQ@mail.gmail.com>
Subject: Re: Block IO issue in kernel-v4.17
To: Jens Axboe <axboe@kernel.dk>
Cc: Chunyu Hu <chuhu.ncepu@gmail.com>, Kent Overstreet <kent.overstreet@gmail.com>,
	Coly Li <colyli@suse.de>, hch@lst.de, darrick.wong@oracle.com, snitzer@redhat.com,
	linux-block@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: multipart/alternative; boundary="0000000000000c97bf056e1b3519"
List-ID: <linux-block@vger.kernel.org>

--0000000000000c97bf056e1b3519
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jens,

On Thu, Jun 7, 2018 at 11:41 PM, Jens Axboe <axboe@kernel.dk> wrote:

> On 6/7/18 8:46 AM, Jens Axboe wrote:
> > On 6/7/18 12:33 AM, Chunyu Hu wrote:
> >> kasan reported a user-after-free. I'm using a kvm machine, it panic
> >> during boot. I'm using the latest linux tree. which contains below.
> >>
> >> commit d377535405686f735b90a8ad4ba269484cd7c96e
> >> Author: Kent Overstreet <kent.overstreet@gmail.com>
> >> Date:   Tue Jun 5 05:26:33 2018 -0400
> >>
> >>     dm: Use kzalloc for all structs with embedded biosets/mempools
> >
> > Can you try with the below? Li Wang, would be great if you could too.
>
> Please try this one instead.
>

=E2=80=8BThe problem was gone after applying this patch. Thanks!
=E2=80=8B

>
>
> diff --git a/block/bio.c b/block/bio.c
> index 595663e0281a..0616d86b15c6 100644
> --- a/block/bio.c
> +++ b/block/bio.c
> @@ -1967,6 +1967,21 @@ int bioset_init(struct bio_set *bs,
>  }
>  EXPORT_SYMBOL(bioset_init);
>
> +int bioset_init_from_src(struct bio_set *new, struct bio_set *src)
> +{
> +       unsigned int pool_size =3D src->bio_pool.min_nr;
> +       int flags;
> +
> +       flags =3D 0;
> +       if (src->bvec_pool.min_nr)
> +               flags |=3D BIOSET_NEED_BVECS;
> +       if (src->rescue_workqueue)
> +               flags |=3D BIOSET_NEED_RESCUER;
> +
> +       return bioset_init(new, pool_size, src->front_pad, flags);
> +}
> +EXPORT_SYMBOL(bioset_init_from_src);
> +
>  #ifdef CONFIG_BLK_CGROUP
>
>  /**
> diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> index 98dff36b89a3..20a8d63754bf 100644
> --- a/drivers/md/dm.c
> +++ b/drivers/md/dm.c
> @@ -1953,9 +1953,10 @@ static void free_dev(struct mapped_device *md)
>         kvfree(md);
>  }
>
> -static void __bind_mempools(struct mapped_device *md, struct dm_table *t=
)
> +static int __bind_mempools(struct mapped_device *md, struct dm_table *t)
>  {
>         struct dm_md_mempools *p =3D dm_table_get_md_mempools(t);
> +       int ret =3D 0;
>
>         if (dm_table_bio_based(t)) {
>                 /*
> @@ -1982,13 +1983,16 @@ static void __bind_mempools(struct mapped_device
> *md, struct dm_table *t)
>                bioset_initialized(&md->bs) ||
>                bioset_initialized(&md->io_bs));
>
> -       md->bs =3D p->bs;
> -       memset(&p->bs, 0, sizeof(p->bs));
> -       md->io_bs =3D p->io_bs;
> -       memset(&p->io_bs, 0, sizeof(p->io_bs));
> +       ret =3D bioset_init_from_src(&md->bs, &p->bs);
> +       if (ret)
> +               goto out;
> +       ret =3D bioset_init_from_src(&md->io_bs, &p->io_bs);
> +       if (ret)
> +               bioset_exit(&md->bs);
>  out:
>         /* mempool bind completed, no longer need any mempools in the
> table */
>         dm_table_free_md_mempools(t);
> +       return ret;
>  }
>
>  /*
> @@ -2033,6 +2037,7 @@ static struct dm_table *__bind(struct mapped_device
> *md, struct dm_table *t,
>         struct request_queue *q =3D md->queue;
>         bool request_based =3D dm_table_request_based(t);
>         sector_t size;
> +       int ret;
>
>         lockdep_assert_held(&md->suspend_lock);
>
> @@ -2068,7 +2073,11 @@ static struct dm_table *__bind(struct mapped_devic=
e
> *md, struct dm_table *t,
>                 md->immutable_target =3D dm_table_get_immutable_target(t)=
;
>         }
>
> -       __bind_mempools(md, t);
> +       ret =3D __bind_mempools(md, t);
> +       if (ret) {
> +               old_map =3D ERR_PTR(ret);
> +               goto out;
> +       }
>
>         old_map =3D rcu_dereference_protected(md->map,
> lockdep_is_held(&md->suspend_lock));
>         rcu_assign_pointer(md->map, (void *)t);
> @@ -2078,6 +2087,7 @@ static struct dm_table *__bind(struct mapped_device
> *md, struct dm_table *t,
>         if (old_map)
>                 dm_sync_table(md);
>
> +out:
>         return old_map;
>  }
>
> diff --git a/include/linux/bio.h b/include/linux/bio.h
> index 810a8bee8f85..307682ac2f31 100644
> --- a/include/linux/bio.h
> +++ b/include/linux/bio.h
> @@ -417,6 +417,7 @@ enum {
>  extern int bioset_init(struct bio_set *, unsigned int, unsigned int, int
> flags);
>  extern void bioset_exit(struct bio_set *);
>  extern int biovec_init_pool(mempool_t *pool, int pool_entries);
> +extern int bioset_init_from_src(struct bio_set *new, struct bio_set *src=
);
>
>  extern struct bio *bio_alloc_bioset(gfp_t, unsigned int, struct bio_set
> *);
>  extern void bio_put(struct bio *);
>
> --
> Jens Axboe
>
>


--=20
Regards,
Li Wang

--0000000000000c97bf056e1b3519
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-size:small">Hi =
Jens,<br></div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On=
 Thu, Jun 7, 2018 at 11:41 PM, Jens Axboe <span dir=3D"ltr">&lt;<a href=3D"=
mailto:axboe@kernel.dk" target=3D"_blank">axboe@kernel.dk</a>&gt;</span> wr=
ote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border=
-left:1px #ccc solid;padding-left:1ex"><span class=3D"">On 6/7/18 8:46 AM, =
Jens Axboe wrote:<br>
&gt; On 6/7/18 12:33 AM, Chunyu Hu wrote:<br>
&gt;&gt; kasan reported a user-after-free. I&#39;m using a kvm machine, it =
panic<br>
&gt;&gt; during boot. I&#39;m using the latest linux tree. which contains b=
elow.<br>
&gt;&gt;<br>
&gt;&gt; commit d377535405686f735b90a8ad4ba269<wbr>484cd7c96e<br>
&gt;&gt; Author: Kent Overstreet &lt;<a href=3D"mailto:kent.overstreet@gmai=
l.com">kent.overstreet@gmail.com</a>&gt;<br>
&gt;&gt; Date:=C2=A0 =C2=A0Tue Jun 5 05:26:33 2018 -0400<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0dm: Use kzalloc for all structs with embedded b=
iosets/mempools<br>
&gt; <br>
&gt; Can you try with the below? Li Wang, would be great if you could too.<=
br>
<br>
</span>Please try this one instead.<br></blockquote><div><br></div><div sty=
le=3D"font-size:small" class=3D"gmail_default">=E2=80=8BThe problem was gon=
e after applying this patch. Thanks!<br></div><div style=3D"font-size:small=
" class=3D"gmail_default">=E2=80=8B</div><blockquote class=3D"gmail_quote" =
style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
<br>
diff --git a/block/bio.c b/block/bio.c<br>
index 595663e0281a..0616d86b15c6 100644<br>
--- a/block/bio.c<br>
+++ b/block/bio.c<br>
@@ -1967,6 +1967,21 @@ int bioset_init(struct bio_set *bs,<br>
=C2=A0}<br>
=C2=A0EXPORT_SYMBOL(bioset_init);<br>
<br>
+int bioset_init_from_src(struct bio_set *new, struct bio_set *src)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int pool_size =3D src-&gt;bio_pool.min=
_nr;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int flags;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0flags =3D 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (src-&gt;bvec_pool.min_nr)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0flags |=3D BIOSET_N=
EED_BVECS;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (src-&gt;rescue_workqueue)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0flags |=3D BIOSET_N=
EED_RESCUER;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return bioset_init(new, pool_size, src-&gt;fron=
t_pad, flags);<br>
+}<br>
+EXPORT_SYMBOL(bioset_init_<wbr>from_src);<br>
<span class=3D"">+<br>
=C2=A0#ifdef CONFIG_BLK_CGROUP<br>
<br>
=C2=A0/**<br>
diff --git a/drivers/md/dm.c b/drivers/md/dm.c<br>
</span>index 98dff36b89a3..20a8d63754bf 100644<br>
--- a/drivers/md/dm.c<br>
+++ b/drivers/md/dm.c<br>
@@ -1953,9 +1953,10 @@ static void free_dev(struct mapped_device *md)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 kvfree(md);<br>
=C2=A0}<br>
<br>
-static void __bind_mempools(struct mapped_device *md, struct dm_table *t)<=
br>
+static int __bind_mempools(struct mapped_device *md, struct dm_table *t)<b=
r>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct dm_md_mempools *p =3D dm_table_get_md_me=
mpools(t);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int ret =3D 0;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (dm_table_bio_based(t)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
@@ -1982,13 +1983,16 @@ static void __bind_mempools(struct mapped_device *m=
d, struct dm_table *t)<br>
<span class=3D"">=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bio=
set_initialized(&amp;md-&gt;bs) ||<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bioset_initialized(&=
amp;md-&gt;io_bs)<wbr>);<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0md-&gt;bs =3D p-&gt;bs;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0memset(&amp;p-&gt;bs, 0, sizeof(p-&gt;bs));<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0md-&gt;io_bs =3D p-&gt;io_bs;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0memset(&amp;p-&gt;io_bs, 0, sizeof(p-&gt;io_bs)=
);<br>
</span>+=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D bioset_init_from_src(&amp;md-&gt=
;bs, &amp;p-&gt;bs);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D bioset_init_from_src(&amp;md-&gt;io_<wb=
r>bs, &amp;p-&gt;io_bs);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bioset_exit(&amp;md=
-&gt;bs);<br>
<span class=3D"">=C2=A0out:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* mempool bind completed, no longer need any m=
empools in the table */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 dm_table_free_md_mempools(t);<br>
</span>+=C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
=C2=A0}<br>
<br>
=C2=A0/*<br>
@@ -2033,6 +2037,7 @@ static struct dm_table *__bind(struct mapped_device *=
md, struct dm_table *t,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct request_queue *q =3D md-&gt;queue;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bool request_based =3D dm_table_request_based(t=
);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 sector_t size;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0int ret;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 lockdep_assert_held(&amp;md-&gt;<wbr>suspend_lo=
ck);<br>
<br>
@@ -2068,7 +2073,11 @@ static struct dm_table *__bind(struct mapped_device =
*md, struct dm_table *t,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 md-&gt;immutable_ta=
rget =3D dm_table_get_immutable_target(<wbr>t);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0__bind_mempools(md, t);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D __bind_mempools(md, t);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0old_map =3D ERR_PTR=
(ret);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 old_map =3D rcu_dereference_protected(md-&gt;<w=
br>map, lockdep_is_held(&amp;md-&gt;suspend_<wbr>lock));<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 rcu_assign_pointer(md-&gt;map, (void *)t);<br>
@@ -2078,6 +2087,7 @@ static struct dm_table *__bind(struct mapped_device *=
md, struct dm_table *t,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (old_map)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dm_sync_table(md);<=
br>
<br>
+out:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return old_map;<br>
=C2=A0}<br>
<br>
diff --git a/include/linux/bio.h b/include/linux/bio.h<br>
index 810a8bee8f85..307682ac2f31 100644<br>
<span class=3D"">--- a/include/linux/bio.h<br>
+++ b/include/linux/bio.h<br>
@@ -417,6 +417,7 @@ enum {<br>
=C2=A0extern int bioset_init(struct bio_set *, unsigned int, unsigned int, =
int flags);<br>
=C2=A0extern void bioset_exit(struct bio_set *);<br>
=C2=A0extern int biovec_init_pool(mempool_t *pool, int pool_entries);<br>
</span>+extern int bioset_init_from_src(struct bio_set *new, struct bio_set=
 *src);<br>
<div class=3D"HOEnZb"><div class=3D"h5">=C2=A0<br>
=C2=A0extern struct bio *bio_alloc_bioset(gfp_t, unsigned int, struct bio_s=
et *);<br>
=C2=A0extern void bio_put(struct bio *);<br>
<br>
</div></div><span class=3D"HOEnZb"><font color=3D"#888888">-- <br>
Jens Axboe<br>
<br>
</font></span></blockquote></div><br><br clear=3D"all"><br>-- <br><div clas=
s=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div dir=3D"ltr"><=
div>Regards,<br></div><div>Li Wang<br></div></div></div>
</div></div>

--0000000000000c97bf056e1b3519--
