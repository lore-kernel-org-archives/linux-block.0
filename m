Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:45063 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750758AbdEDLYU (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 4 May 2017 07:24:20 -0400
Subject: Re: [PATCH v2 05/12] blk-mq-debugfs: rename hw queue directories from
 <n> to hctx<n>
To: Omar Sandoval <osandov@osandov.com>, Jens Axboe <axboe@fb.com>,
        linux-block@vger.kernel.org
References: <cover.1493882751.git.osandov@fb.com>
 <d93cf237ca97fa3fa7213689ebdaffaf12a32146.1493882751.git.osandov@fb.com>
Cc: Bart Van Assche <bart.vanassche@sandisk.com>, kernel-team@fb.com
From: Hannes Reinecke <hare@suse.de>
Message-ID: <3ce428ae-8356-a6e3-e4c8-229837be9a76@suse.de>
Date: Thu, 4 May 2017 13:24:17 +0200
MIME-Version: 1.0
In-Reply-To: <d93cf237ca97fa3fa7213689ebdaffaf12a32146.1493882751.git.osandov@fb.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 05/04/2017 09:31 AM, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> It's not clear what these numbered directories represent unless you
> consult the code. We're about to get rid of the intermediate "mq"
> directory, so these would be even more confusing without that context.
> 
> Signed-off-by: Omar Sandoval <osandov@fb.com>
> ---
>  block/blk-mq-debugfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
> index 109ae9f3d400..2eae3238fb35 100644
> --- a/block/blk-mq-debugfs.c
> +++ b/block/blk-mq-debugfs.c
> @@ -936,7 +936,7 @@ static int blk_mq_debugfs_register_hctx(struct request_queue *q,
>  	char name[20];
>  	int i;
>  
> -	snprintf(name, sizeof(name), "%u", hctx->queue_num);
> +	snprintf(name, sizeof(name), "hctx%u", hctx->queue_num);
>  	hctx_dir = debugfs_create_dir(name, q->mq_debugfs_dir);
>  	if (!hctx_dir)
>  		return -ENOMEM;
> 
Hmm. The number actually corresponds to /sys/block/XX/mq/<num>
With this patch we would break this mapping, no?

I'd rather keep it in sync with /sys/block ...

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: F. Imend�rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N�rnberg)
