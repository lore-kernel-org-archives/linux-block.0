Return-Path: <zwp10758@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20171017155621.GA38911@bogon.didichuxing.com>
References: <20171017155621.GA38911@bogon.didichuxing.com>
From: weiping zhang <zwp10758@gmail.com>
Date: Sat, 4 Nov 2017 23:03:35 +0800
Message-ID: <CAA70yB75_pqkYpdwDyozfXurtmFpkDDdcXD1Cz7u_DWA0AqYVw@mail.gmail.com>
Subject: Re: [PATCH v4] blkcg: add sanity check for blkcg policy operations
To: "axboe@kernel.dk" <axboe@kernel.dk>, "jthumshirn@suse.de" <jthumshirn@suse.de>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Type: multipart/alternative; boundary="f403045c21528b0588055d2986ae"
List-ID: <linux-block@vger.kernel.org>

--f403045c21528b0588055d2986ae
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2017=E5=B9=B410=E6=9C=8817=E6=97=A5=E6=98=9F=E6=9C=9F=E4=BA=8C=EF=BC=8Cweip=
ing zhang <zhangweiping@didichuxing.com> =E5=86=99=E9=81=93=EF=BC=9A

> blkcg policy should keep cpd/pd's alloc_fn and free_fn in pairs,
> otherwise policy would register fail.
>
> Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de <javascript:;>>
> Signed-off-by: weiping zhang <zhangweiping@didichuxing.com <javascript:;>=
>
> ---
> Changes since V4:
>  * merge "if(cpd->xxx)" and "if(pd->xxx)" together
>
> Changes since V3:
>  * make if more cleaner by using !pold->cpd_alloc_fn ^ !pol->cpd_free_fn
>
> Chagnes since V2:
>  * merge blkcg_policy_check_ops into the caller blkcg_policy_register
>
> V1:
>  * add blkcg_policy_check_ops to check cpd/pd's alloc_fn and free_fn in
>  * pairs.
>
>  block/blk-cgroup.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
> index e7ec676..4117524 100644
> --- a/block/blk-cgroup.c
> +++ b/block/blk-cgroup.c
> @@ -1419,6 +1419,11 @@ int blkcg_policy_register(struct blkcg_policy *pol=
)
>         if (i >=3D BLKCG_MAX_POLS)
>                 goto err_unlock;
>
> +       /* Make sure cpd/pd_alloc_fn and cpd/pd_free_fn in pairs */
> +       if ((!pol->cpd_alloc_fn ^ !pol->cpd_free_fn) ||
> +               (!pol->pd_alloc_fn ^ !pol->pd_free_fn))
> +               goto err_unlock;
> +
>         /* register @pol */
>         pol->plid =3D i;
>         blkcg_policy[pol->plid] =3D pol;
> --
> 2.9.4
>
> Hello Jens,

A consolidation for blkcg policy operations, would you pick it up?

Thanks ^_^

--f403045c21528b0588055d2986ae
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>2017=E5=B9=B410=E6=9C=8817=E6=97=A5=E6=98=9F=E6=9C=9F=E4=BA=8C=EF=
=BC=8Cweiping zhang &lt;<a href=3D"mailto:zhangweiping@didichuxing.com">zha=
ngweiping@didichuxing.com</a>&gt; =E5=86=99=E9=81=93=EF=BC=9A<br><blockquot=
e class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc sol=
id;padding-left:1ex">blkcg policy should keep cpd/pd&#39;s alloc_fn and fre=
e_fn in pairs,<br>
otherwise policy would register fail.<br>
<br>
Reviewed-by: Johannes Thumshirn &lt;<a href=3D"javascript:;" onclick=3D"_e(=
event, &#39;cvml&#39;, &#39;jthumshirn@suse.de&#39;)">jthumshirn@suse.de</a=
>&gt;<br>
Signed-off-by: weiping zhang &lt;<a href=3D"javascript:;" onclick=3D"_e(eve=
nt, &#39;cvml&#39;, &#39;zhangweiping@didichuxing.com&#39;)">zhangweiping@d=
idichuxing.com</a>&gt;<br>
---<br>
Changes since V4:<br>
=C2=A0* merge &quot;if(cpd-&gt;xxx)&quot; and &quot;if(pd-&gt;xxx)&quot; to=
gether<br>
<br>
Changes since V3:<br>
=C2=A0* make if more cleaner by using !pold-&gt;cpd_alloc_fn ^ !pol-&gt;cpd=
_free_fn<br>
<br>
Chagnes since V2:<br>
=C2=A0* merge blkcg_policy_check_ops into the caller blkcg_policy_register<=
br>
<br>
V1:<br>
=C2=A0* add blkcg_policy_check_ops to check cpd/pd&#39;s alloc_fn and free_=
fn in<br>
=C2=A0* pairs.<br>
<br>
=C2=A0block/blk-cgroup.c | 5 +++++<br>
=C2=A01 file changed, 5 insertions(+)<br>
<br>
diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c<br>
index e7ec676..4117524 100644<br>
--- a/block/blk-cgroup.c<br>
+++ b/block/blk-cgroup.c<br>
@@ -1419,6 +1419,11 @@ int blkcg_policy_register(struct blkcg_policy *pol)<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (i &gt;=3D BLKCG_MAX_POLS)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err_unlock;<br=
>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Make sure cpd/pd_alloc_fn and cpd/pd_free_fn=
 in pairs */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if ((!pol-&gt;cpd_alloc_fn ^ !pol-&gt;cpd_free_=
fn) ||<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(!pol-&gt;pd_alloc_=
fn ^ !pol-&gt;pd_free_fn))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto err_unlock;<br=
>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* register @pol */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 pol-&gt;plid =3D i;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 blkcg_policy[pol-&gt;plid] =3D pol;<br>
--<br>
2.9.4<br>
<br>
</blockquote><div>Hello Jens,</div><div><br></div><div>A consolidation for =
blkcg policy operations, would you pick it up?</div><div><br></div><div>Tha=
nks ^_^</div>

--f403045c21528b0588055d2986ae--
