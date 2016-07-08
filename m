Return-Path: <hch@lst.de>
Date: Fri, 8 Jul 2016 11:36:50 +0200
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: mst@redhat.com, ooo@electrozaur.com, nab@linux-iscsi.org,
	linux-block@vger.kernel.org
Subject: Re: passthrough request improvements V3
Message-ID: <20160708093650.GB8682@lst.de>
References: <1466068471-15746-1-git-send-email-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1466068471-15746-1-git-send-email-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

ping?  Seems like you were mostly happy with the previous versions,
and I should have addressed all comments.

On Thu, Jun 16, 2016 at 11:14:24AM +0200, Christoph Hellwig wrote:
> These days we have a lot more users of struct request for driver internal
> use than just REQ_TYPE_BLOCK_PC, so let's polish this infrastructure
> up a bit.
> 
> Changes since V2:
>  - really drop zeroing ->cmd from blk_get_request
>  - add ACK from Boaz
> Changes since V1:
>  - keep blk_rq_set_block_pc for now and leave zeroing ->cmd in it
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-block" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
---end quoted text---
