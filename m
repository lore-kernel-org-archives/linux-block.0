Return-Path: <axboe@kernel.dk>
Subject: Re: remove nvme_reinit_tagset and blk_mq_tagset_iter
To: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org
References: <20180614123015.5989-1-hch@lst.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <248094d8-afe6-b6b7-8c8b-b8db452ec030@kernel.dk>
Date: Thu, 14 Jun 2018 08:45:07 -0600
MIME-Version: 1.0
In-Reply-To: <20180614123015.5989-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 6/14/18 6:30 AM, Christoph Hellwig wrote:
> Now that nvme-fc moved off the reinit request concept both the core nvme
> and blk-mq code for it becomes unused.
> 
> Jens, are you ok with queuing up the blk-mq side with the pending nvme
> changes?

Are you asking if you can queue it up, presumable because the nvme-fc
change isn't upstream yet? That's fine with me, you can add my
reviewed-by to the patches.

-- 
Jens Axboe
