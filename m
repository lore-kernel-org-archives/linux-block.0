Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:21780 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754354AbdECUvP (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 May 2017 16:51:15 -0400
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "osandov@osandov.com" <osandov@osandov.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@fb.com" <axboe@fb.com>
CC: "kernel-team@fb.com" <kernel-team@fb.com>
Subject: Re: [PATCH 3/9] blk-mq-debugfs: get rid of a bunch of boilerplate
Date: Wed, 3 May 2017 20:51:11 +0000
Message-ID: <1493844669.3901.38.camel@sandisk.com>
References: <cover.1493839103.git.osandov@fb.com>
         <6cac60b55b78044dd26226706f1bb5cd00f59d4b.1493839103.git.osandov@fb.com>
In-Reply-To: <6cac60b55b78044dd26226706f1bb5cd00f59d4b.1493839103.git.osandov@fb.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, 2017-05-03 at 12:18 -0700, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
>=20
> A large part of blk-mq-debugfs.c is file_operations and seq_file
> boilerplate. This sucks as is but will suck even more when schedulers
> can define their own debugfs entries. Factor it all out into a single
> blk_mq_debugfs_fops which multiplexes as needed. We store the
> request_queue, blk_mq_hw_ctx, or blk_mq_ctx in the parent directory
> dentry, which is kind of hacky, but it works.
>=20
> Signed-off-by: Omar Sandoval <osandov@fb.com>
> ---
>  block/blk-mq-debugfs.c | 469 +++++++++++++++----------------------------=
------
>  1 file changed, 138 insertions(+), 331 deletions(-)
>=20
> diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
> index f58a116d6cca..00cc89c34590 100644
> --- a/block/blk-mq-debugfs.c
> +++ b/block/blk-mq-debugfs.c
> @@ -26,23 +26,12 @@
>  struct blk_mq_debugfs_attr {
>  	const char *name;
>  	umode_t mode;
> -	const struct file_operations *fops;
> +	int (*show)(void *, struct seq_file *);

Hello Omar,

The current show functions have the seq_file pointer as first argument
but for .show() it is the second argument. Please consider to keep that
pointer as the first argument.

> +static ssize_t queue_state_write(void *data, const char __user *buf,
> +				 size_t count, loff_t *ppos)
>  {
> -	struct request_queue *q =3D file_inode(file)->i_private;
> +	struct request_queue *q =3D data;
>  	char op[16] =3D { }, *s;
> =20
> -	len =3D min(len, sizeof(op) - 1);
> -	if (copy_from_user(op, ubuf, len))
> +	if (copy_from_user(op, buf, min(count, sizeof(op) - 1)))
>  		return -EFAULT;
>  	s =3D op;
>  	strsep(&s, " \t\n"); /* strip trailing whitespace */
> @@ -127,22 +115,9 @@ static ssize_t blk_queue_flags_store(struct file *fi=
le, const char __user *ubuf,
>  		       __func__, op);
>  		return -EINVAL;
>  	}
> -	return len;
> -}
> -
> -static int blk_queue_flags_open(struct inode *inode, struct file *file)
> -{
> -	return single_open(file, blk_queue_flags_show, inode->i_private);
> +	return count;
>  }

Please move the return value changes of queue_state_write() into a separate
patch since these are a bug fix and not related to the removal of the
boilerplate code.

Thanks,

Bart.
