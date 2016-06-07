Return-Path: <nab@linux-iscsi.org>
Message-ID: <1465282193.5365.59.camel@haakon3.risingtidesystems.com>
Subject: Re: [PATCH 1/3] block: Export blk_poll
From: "Nicholas A. Bellinger" <nab@linux-iscsi.org>
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, keith.busch@intel.com, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, Sagi Grimberg
	 <sagi@grimberg.me>
Date: Mon, 06 Jun 2016 23:49:53 -0700
In-Reply-To: <1465248177-17970-2-git-send-email-hch@lst.de>
References: <1465248177-17970-1-git-send-email-hch@lst.de>
	 <1465248177-17970-2-git-send-email-hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Mon, 2016-06-06 at 23:22 +0200, Christoph Hellwig wrote:
> From: Sagi Grimberg <sagi@grimberg.me>
> 
> The new NVMe over fabrics target will make use of this outside from a
> module.
> 
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/blk-core.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 2475b1c7..ad5270e 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -3377,6 +3377,7 @@ bool blk_poll(struct request_queue *q, blk_qc_t cookie)
>  
>  	return false;
>  }
> +EXPORT_SYMBOL_GPL(blk_poll);
>  
>  #ifdef CONFIG_PM
>  /**

Looks good.

Reviewed-by: Nicholas Bellinger <nab@linux-iscsi.org>
