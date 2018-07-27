Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-it0-f67.google.com ([209.85.214.67]:33577 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388942AbeG0TBE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Jul 2018 15:01:04 -0400
MIME-Version: 1.0
References: <20180726142239.44669-1-colyli@suse.de> <20180726142239.44669-9-colyli@suse.de>
In-Reply-To: <20180726142239.44669-9-colyli@suse.de>
From: Noah Massey <noah.massey@gmail.com>
Date: Fri, 27 Jul 2018 13:37:57 -0400
Message-ID: <CADfjVrhRtwdGF6bs_yCQms=TXxHynZb87r9gzRNoicQ70-n8OQ@mail.gmail.com>
Subject: Re: [PATCH 8/9] bcache: initiate bcache_debug to NULL
To: Coly Li <colyli@suse.de>
Cc: linux-bcache@vger.kernel.org, linux-block@vger.kernel.org
Content-Type: multipart/alternative; boundary="000000000000356dc30571fe93c9"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

--000000000000356dc30571fe93c9
Content-Type: text/plain; charset="UTF-8"

On Thu, Jul 26, 2018, 10:23 AM Coly Li <colyli@suse.de> wrote:

> Global variable bcache_debug is firstly initialized in bch_debug_init(),
> and destroyed in bch_debug_exit(). bch_debug_init() is called in
> bcache_init() with many other functions, if one of the previous calling
> onces failed, bcache_exit() will be called in the failure path.
>
> The problem is, if bcache_init() fails before bch_debug_init() is called,
> then in bcache_exit() when bch_debug_exit() is called to destroy global
> variable bcache_debug, at this moment bcache_debug is unndefined, then the
> test of "if (!IS_ERR_OR_NULL(bcache_debug))" might be buggy.
>
> This patch initializes global varabile bcache_debug to be NULL, to make
> the failure code path to be predictable.
>
> Signed-off-by: Coly Li <colyli@suse.de>
> ---
>

Makes sense

Reviewed-by: Noah Massey <noah.massey@gmail.com>

 drivers/md/bcache/debug.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/md/bcache/debug.c b/drivers/md/bcache/debug.c
> index 57f8f5aeee55..24b0eb65ddec 100644
> --- a/drivers/md/bcache/debug.c
> +++ b/drivers/md/bcache/debug.c
> @@ -17,7 +17,7 @@
>  #include <linux/random.h>
>  #include <linux/seq_file.h>
>
> -struct dentry *bcache_debug;
> +struct dentry *bcache_debug = NULL;
>
>  #ifdef CONFIG_BCACHE_DEBUG
>
> --
> 2.17.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bcache" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

--000000000000356dc30571fe93c9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr">=
On Thu, Jul 26, 2018, 10:23 AM Coly Li &lt;<a href=3D"mailto:colyli@suse.de=
">colyli@suse.de</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" =
style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Glo=
bal variable bcache_debug is firstly initialized in bch_debug_init(),<br>
and destroyed in bch_debug_exit(). bch_debug_init() is called in<br>
bcache_init() with many other functions, if one of the previous calling<br>
onces failed, bcache_exit() will be called in the failure path.<br>
<br>
The problem is, if bcache_init() fails before bch_debug_init() is called,<b=
r>
then in bcache_exit() when bch_debug_exit() is called to destroy global<br>
variable bcache_debug, at this moment bcache_debug is unndefined, then the<=
br>
test of &quot;if (!IS_ERR_OR_NULL(bcache_debug))&quot; might be buggy.<br>
<br>
This patch initializes global varabile bcache_debug to be NULL, to make<br>
the failure code path to be predictable.<br>
<br>
Signed-off-by: Coly Li &lt;<a href=3D"mailto:colyli@suse.de" target=3D"_bla=
nk" rel=3D"noreferrer">colyli@suse.de</a>&gt;<br>
---<br></blockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"aut=
o">Makes sense</div><div dir=3D"auto"><br></div><div dir=3D"auto">Reviewed-=
by: Noah Massey &lt;<a href=3D"mailto:noah.massey@gmail.com">noah.massey@gm=
ail.com</a>&gt;</div><div dir=3D"auto"><br></div><div dir=3D"auto"><div cla=
ss=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 =
.8ex;border-left:1px #ccc solid;padding-left:1ex">
=C2=A0drivers/md/bcache/debug.c | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/drivers/md/bcache/debug.c b/drivers/md/bcache/debug.c<br>
index 57f8f5aeee55..24b0eb65ddec 100644<br>
--- a/drivers/md/bcache/debug.c<br>
+++ b/drivers/md/bcache/debug.c<br>
@@ -17,7 +17,7 @@<br>
=C2=A0#include &lt;linux/random.h&gt;<br>
=C2=A0#include &lt;linux/seq_file.h&gt;<br>
<br>
-struct dentry *bcache_debug;<br>
+struct dentry *bcache_debug =3D NULL;<br>
<br>
=C2=A0#ifdef CONFIG_BCACHE_DEBUG<br>
<br>
-- <br>
2.17.1<br>
<br>
--<br>
To unsubscribe from this list: send the line &quot;unsubscribe linux-bcache=
&quot; in<br>
the body of a message to <a href=3D"mailto:majordomo@vger.kernel.org" targe=
t=3D"_blank" rel=3D"noreferrer">majordomo@vger.kernel.org</a><br>
More majordomo info at=C2=A0 <a href=3D"http://vger.kernel.org/majordomo-in=
fo.html" rel=3D"noreferrer noreferrer" target=3D"_blank">http://vger.kernel=
.org/majordomo-info.html</a><br>
</blockquote></div></div></div>

--000000000000356dc30571fe93c9--
