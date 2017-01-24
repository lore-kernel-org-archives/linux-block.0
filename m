Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:43644 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750841AbdAXN12 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Jan 2017 08:27:28 -0500
Subject: Re: [PATCH 04/10] blk-mq: add extra request information to debugfs
To: Omar Sandoval <osandov@osandov.com>, Jens Axboe <axboe@fb.com>,
        linux-block@vger.kernel.org
References: <cover.1485197480.git.osandov@fb.com>
 <cd6b47c9df287e862190d5ba5de7527f1fa0a89f.1485197480.git.osandov@fb.com>
Cc: kernel-team@fb.com
From: Hannes Reinecke <hare@suse.de>
Message-ID: <fe36d38b-52c4-ee14-a9f8-aee129920c11@suse.de>
Date: Tue, 24 Jan 2017 14:27:25 +0100
MIME-Version: 1.0
In-Reply-To: <cd6b47c9df287e862190d5ba5de7527f1fa0a89f.1485197480.git.osandov@fb.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 01/23/2017 07:59 PM, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> The request pointers by themselves aren't super useful.
> 
> Signed-off-by: Omar Sandoval <osandov@fb.com>
> ---
>  block/blk-mq-debugfs.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
> index 1967c06d80e0..ee947f2f605b 100644
> --- a/block/blk-mq-debugfs.c
> +++ b/block/blk-mq-debugfs.c
> @@ -87,7 +87,9 @@ static int blk_mq_debugfs_rq_show(struct seq_file *m, void *v)
>  {
>  	struct request *rq = list_entry_rq(v);
>  
> -	seq_printf(m, "%p\n", rq);
> +	seq_printf(m, "%p {.cmd_type=%u, .cmd_flags=0x%x, .rq_flags=0x%x, .tag=%d, .internal_tag=%d}\n",
> +		   rq, rq->cmd_type, rq->cmd_flags, (unsigned int)rq->rq_flags,
> +		   rq->tag, rq->internal_tag);
>  	return 0;
>  }
>  
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: F. Imend�rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N�rnberg)
