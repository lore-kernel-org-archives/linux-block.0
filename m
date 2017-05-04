Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:13570 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752114AbdEDXKi (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 May 2017 19:10:38 -0400
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "osandov@osandov.com" <osandov@osandov.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>
CC: "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH v2 04/12] blk-mq-debugfs: don't open code strstrip()
Date: Thu, 4 May 2017 23:10:34 +0000
Message-ID: <1493939434.2692.15.camel@sandisk.com>
References: <cover.1493882751.git.osandov@fb.com>
         <65b6e5cb3c0be1eaa543a38e47512c2f45a0ace1.1493882751.git.osandov@fb.com>
In-Reply-To: <65b6e5cb3c0be1eaa543a38e47512c2f45a0ace1.1493882751.git.osandov@fb.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, 2017-05-04 at 00:31 -0700, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
>=20
> Slightly more readable, plus we also strip leading spaces.
>=20
> Signed-off-by: Omar Sandoval <osandov@fb.com>
> ---
>  block/blk-mq-debugfs.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>=20
> diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
> index 2a19237455d4..109ae9f3d400 100644
> --- a/block/blk-mq-debugfs.c
> +++ b/block/blk-mq-debugfs.c
> @@ -111,17 +111,16 @@ static ssize_t blk_queue_flags_store(struct file *f=
ile, const char __user *buf,
>  				     size_t count, loff_t *ppos)
>  {
>  	struct request_queue *q =3D file_inode(file)->i_private;
> -	char op[16] =3D { }, *s;
> +	char opbuf[16] =3D { }, *op;
> =20
> -	if (count >=3D sizeof(op)) {
> +	if (count >=3D sizeof(opbuf)) {
>  		pr_err("%s: operation too long\n", __func__);
>  		goto inval;
>  	}
> =20
> -	if (copy_from_user(op, buf, count))
> +	if (copy_from_user(opbuf, buf, count))
>  		return -EFAULT;
> -	s =3D op;
> -	strsep(&s, " \t\n"); /* strip trailing whitespace */
> +	op =3D strstrip(opbuf);
>  	if (strcmp(op, "run") =3D=3D 0) {
>  		blk_mq_run_hw_queues(q, true);
>  	} else if (strcmp(op, "start") =3D=3D 0) {

Hello Omar,

Sorry but in my opinion the value of this patch is so small that I'm not su=
re
it's worth to merge this patch.

Bart.=
