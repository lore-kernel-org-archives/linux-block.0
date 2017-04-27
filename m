Return-Path: <jmoyer@redhat.com>
From: Jeff Moyer <jmoyer@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk,  linux-nvme@lists.infradead.org,  linux-block@vger.kernel.org
Subject: Re: [PATCH 1/5] blk-mq: update ->init_request and ->exit_request prototypes
References: <20170427174501.18965-1-hch@lst.de>
	<20170427174501.18965-2-hch@lst.de>
Date: Thu, 27 Apr 2017 14:20:21 -0400
In-Reply-To: <20170427174501.18965-2-hch@lst.de> (Christoph Hellwig's message
	of "Thu, 27 Apr 2017 19:44:57 +0200")
Message-ID: <x49inlpsoey.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

Hi, Christoph,

Christoph Hellwig <hch@lst.de> writes:

> Remove the request_idx parameter, which can't be used safely now that we
> support I/O schedulers with blk-mq.  Except for a superflous check in
> mtip32xx it was unused anyway.

I'm not sure how your patch builds.  If I look at the mtip32xx driver in
for-4.12/post-merge, I see this:

static int mtip_init_cmd(void *data, struct request *rq, unsigned int hctx_idx,
			 unsigned int request_idx, unsigned int numa_node)
{
...
	/* Point the command headers at the command tables. */
	cmd->command_header = dd->port->command_list +
				(sizeof(struct mtip_cmd_hdr) * request_idx);
	cmd->command_header_dma = dd->port->command_list_dma +
				(sizeof(struct mtip_cmd_hdr) * request_idx);

If you got rid of request_idx, then this shouldn't build.  So, is there
some other prerequisite patch I'm missing?

Note that the patch that introduced the request_idx check fixed a bug,
where module load would walk off the end of an array.  See commit
74c9c9134bf8.

Cheers,
Jeff

> diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/mtip32xx.c
> index eba8bcd677fa..75e3f91de199 100644
> --- a/drivers/block/mtip32xx/mtip32xx.c
> +++ b/drivers/block/mtip32xx/mtip32xx.c
> @@ -3821,10 +3821,10 @@ static int mtip_queue_rq(struct blk_mq_hw_ctx *hctx,
>  	return BLK_MQ_RQ_QUEUE_ERROR;
>  }
>  
> -static void mtip_free_cmd(void *data, struct request *rq,
> -			  unsigned int hctx_idx, unsigned int request_idx)
> +static void mtip_free_cmd(struct blk_mq_tag_set *set, struct request *rq,
> +			  unsigned int hctx_idx)
>  {
> -	struct driver_data *dd = data;
> +	struct driver_data *dd = set->driver_data;
>  	struct mtip_cmd *cmd = blk_mq_rq_to_pdu(rq);
>  
>  	if (!cmd->command)
> @@ -3834,21 +3834,13 @@ static void mtip_free_cmd(void *data, struct request *rq,
>  				cmd->command, cmd->command_dma);
>  }
>  
> -static int mtip_init_cmd(void *data, struct request *rq, unsigned int hctx_idx,
> -			 unsigned int request_idx, unsigned int numa_node)
> +static int mtip_init_cmd(struct blk_mq_tag_set *set, struct request *rq,
> +			 unsigned int hctx_idx, unsigned int numa_node)
>  {
> -	struct driver_data *dd = data;
> +	struct driver_data *dd = set->driver_data;
>  	struct mtip_cmd *cmd = blk_mq_rq_to_pdu(rq);
>  	u32 host_cap_64 = readl(dd->mmio + HOST_CAP) & HOST_CAP_64;
>  
> -	/*
> -	 * For flush requests, request_idx starts at the end of the
> -	 * tag space.  Since we don't support FLUSH/FUA, simply return
> -	 * 0 as there's nothing to be done.
> -	 */
> -	if (request_idx >= MTIP_MAX_COMMAND_SLOTS)
> -		return 0;
> -
>  	cmd->command = dmam_alloc_coherent(&dd->pdev->dev, CMD_DMA_ALLOC_SZ,
>  			&cmd->command_dma, GFP_KERNEL);
>  	if (!cmd->command)
