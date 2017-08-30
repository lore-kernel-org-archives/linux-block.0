Return-Path: <onatalen@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20170814092712.14062-1-oleksandr@redhat.com>
References: <20170814092712.14062-1-oleksandr@redhat.com>
From: Oleksandr Natalenko <oleksandr@redhat.com>
Date: Wed, 30 Aug 2017 08:04:32 +0200
Message-ID: <CAHcwAbRdZ33+WTZk_Ao_vAkacoZTRUwWhkzs-e+mkyp06xNYiQ@mail.gmail.com>
Subject: Re: [RFC] block: deprecate choosing elevator via boot param
To: linux-block@vger.kernel.org
Cc: axboe@kernel.dk, linux-kernel@vger.kernel.org
Content-Type: multipart/alternative; boundary="f403043c399c4155dc0557f24dda"
List-ID: <linux-block@vger.kernel.org>

--f403043c399c4155dc0557f24dda
Content-Type: text/plain; charset="UTF-8"

Jens,

any thoughts about this?

On Mon, Aug 14, 2017 at 11:27 AM, Oleksandr Natalenko <oleksandr@redhat.com>
wrote:

> Setting I/O scheduler via kernel command line is not flexible enough
> anymore. Different schedulers might be desirable for different types
> of devices (SSDs and HDDs, for instance). Moreover, setting elevator
> while using blk-mq framework does not work in this way already.
>
> This commit enables warning if user specifies "elevator" boot param.
> Removing this option at all might be considered in some future.
>
> Signed-off-by: Oleksandr Natalenko <oleksandr@redhat.com>
> ---
>  block/elevator.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/block/elevator.c b/block/elevator.c
> index 4bb2f0c93fa6..9ade7e12e417 100644
> --- a/block/elevator.c
> +++ b/block/elevator.c
> @@ -130,6 +130,9 @@ static int __init elevator_setup(char *str)
>          * Be backwards-compatible with previous kernels, so users
>          * won't get the wrong elevator.
>          */
> +       printk(KERN_WARNING
> +               "Setting I/O scheduler via kernel command line " \
> +               "is deprecated. Use udev rule instead.");
>         strncpy(chosen_elevator, str, sizeof(chosen_elevator) - 1);
>         return 1;
>  }
> --
> 2.14.1
>
>


-- 
Best regards,
  Oleksandr Natalenko (post-factum)
  Software Maintenance Engineer

--f403043c399c4155dc0557f24dda
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Jens,<br><br></div>any thoughts about this?<br></div>=
<div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Mon, Aug 14, 2=
017 at 11:27 AM, Oleksandr Natalenko <span dir=3D"ltr">&lt;<a href=3D"mailt=
o:oleksandr@redhat.com" target=3D"_blank">oleksandr@redhat.com</a>&gt;</spa=
n> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;b=
order-left:1px #ccc solid;padding-left:1ex">Setting I/O scheduler via kerne=
l command line is not flexible enough<br>
anymore. Different schedulers might be desirable for different types<br>
of devices (SSDs and HDDs, for instance). Moreover, setting elevator<br>
while using blk-mq framework does not work in this way already.<br>
<br>
This commit enables warning if user specifies &quot;elevator&quot; boot par=
am.<br>
Removing this option at all might be considered in some future.<br>
<br>
Signed-off-by: Oleksandr Natalenko &lt;<a href=3D"mailto:oleksandr@redhat.c=
om">oleksandr@redhat.com</a>&gt;<br>
---<br>
=C2=A0block/elevator.c | 3 +++<br>
=C2=A01 file changed, 3 insertions(+)<br>
<br>
diff --git a/block/elevator.c b/block/elevator.c<br>
index 4bb2f0c93fa6..9ade7e12e417 100644<br>
--- a/block/elevator.c<br>
+++ b/block/elevator.c<br>
@@ -130,6 +130,9 @@ static int __init elevator_setup(char *str)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Be backwards-compatible with previous k=
ernels, so users<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* won&#39;t get the wrong elevator.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0printk(KERN_WARNING<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;Setting I/O s=
cheduler via kernel command line &quot; \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;is deprecated=
. Use udev rule instead.&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 strncpy(chosen_elevator, str, sizeof(chosen_ele=
vator) - 1);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 1;<br>
=C2=A0}<br>
<span class=3D"HOEnZb"><font color=3D"#888888">--<br>
2.14.1<br>
<br>
</font></span></blockquote></div><br><br clear=3D"all"><br>-- <br><div clas=
s=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div dir=3D"ltr"><=
div><div dir=3D"ltr"><span><div><div dir=3D"ltr"><div style=3D"padding-top:=
0px;border-top:0px"><div style=3D"padding-top:0px;border-top:0px"><font siz=
e=3D"1" face=3D"arial, helvetica, sans-serif" color=3D"#333333">Best regard=
s,</font></div><div style=3D"padding-top:0px;border-top:0px"><font size=3D"=
1" face=3D"arial, helvetica, sans-serif" color=3D"#333333">=C2=A0 Oleksandr=
 Natalenko (post-factum)<br></font></div><div style=3D"padding-top:0px;bord=
er-top:0px none"><font size=3D"1" face=3D"arial, helvetica, sans-serif" col=
or=3D"#333333">=C2=A0 Software Maintenance Engineer</font></div></div></div=
></div></span></div></div></div></div>
</div>

--f403043c399c4155dc0557f24dda--
