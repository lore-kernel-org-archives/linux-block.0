Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:43371 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751003AbdAXNZm (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Jan 2017 08:25:42 -0500
Subject: Re: [PATCH 02/10] blk-mq: add hctx->{state,flags} to debugfs
To: Omar Sandoval <osandov@osandov.com>, Jens Axboe <axboe@fb.com>,
        linux-block@vger.kernel.org
References: <cover.1485197480.git.osandov@fb.com>
 <ab6a91d92e1832116be1fdd8c47dca471badd727.1485197480.git.osandov@fb.com>
Cc: kernel-team@fb.com
From: Hannes Reinecke <hare@suse.de>
Message-ID: <d08e8c98-4ada-6f1c-2a62-86a9295b6d88@suse.de>
Date: Tue, 24 Jan 2017 14:25:39 +0100
MIME-Version: 1.0
In-Reply-To: <ab6a91d92e1832116be1fdd8c47dca471badd727.1485197480.git.osandov@fb.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 01/23/2017 07:59 PM, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> hctx->state could come in handy for bugs where the hardware queue gets
> stuck in the stopped state, and hctx->flags is just useful to know.
> 
> Signed-off-by: Omar Sandoval <osandov@fb.com>
> ---
>  block/blk-mq-debugfs.c | 42 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
> 
Hehe. I've found myself adding exactly the same attributes when
debugging mq-deadline :-)

> diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
> index 01711bbf5ade..0c14511fa9e0 100644
> --- a/block/blk-mq-debugfs.c
> +++ b/block/blk-mq-debugfs.c
> @@ -29,7 +29,49 @@ struct blk_mq_debugfs_attr {
>  
>  static struct dentry *block_debugfs_root;
>  
> +static int hctx_state_show(struct seq_file *m, void *v)
> +{
> +	struct blk_mq_hw_ctx *hctx = m->private;
> +
> +	seq_printf(m, "0x%lx\n", hctx->state);
> +	return 0;
> +}
> +
What about decoding it?
Would make life so much easier, and one doesn't have to have a kernel
source tree available when looking things up...

> +static int hctx_state_open(struct inode *inode, struct file *file)
> +{
> +	return single_open(file, hctx_state_show, inode->i_private);
> +}
> +
> +static const struct file_operations hctx_state_fops = {
> +	.open		= hctx_state_open,
> +	.read		= seq_read,
> +	.llseek		= seq_lseek,
> +	.release	= single_release,
> +};
> +
> +static int hctx_flags_show(struct seq_file *m, void *v)
> +{
> +	struct blk_mq_hw_ctx *hctx = m->private;
> +
> +	seq_printf(m, "0x%lx\n", hctx->flags);
> +	return 0;
> +}
> +
Same argument here.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: F. Imend�rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N�rnberg)
