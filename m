Return-Path: <keith.busch@intel.com>
Date: Tue, 7 Feb 2017 13:34:54 -0500
From: Keith Busch <keith.busch@intel.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 4/4] nvme: support ranged discard requests
Message-ID: <20170207183453.GC10133@localhost.localdomain>
References: <20170207164658.32449-1-hch@lst.de>
 <20170207164658.32449-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170207164658.32449-5-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

On Tue, Feb 07, 2017 at 05:46:58PM +0100, Christoph Hellwig wrote:
> @@ -1233,6 +1243,8 @@ static void nvme_set_queue_limits(struct nvme_ctrl *ctrl,
>  	if (ctrl->vwc & NVME_CTRL_VWC_PRESENT)
>  		vwc = true;
>  	blk_queue_write_cache(q, vwc, vwc);
> +	blk_queue_max_discard_segments(q,
> +			PAGE_SIZE / sizeof(struct nvme_dsm_range));

We need to use ctrl->page_size rather than PAGE_SIZE.

Otherwise, this looks really good!
