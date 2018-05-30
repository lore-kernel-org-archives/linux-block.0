Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] blk-mq: only iterate over inflight requests in
 blk_mq_tagset_busy_iter
To: Christoph Hellwig <hch@lst.de>
Cc: keith.busch@intel.com, josef@toxicpanda.com, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <20180530165100.31186-1-hch@lst.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <4c37d268-7676-03ad-2276-d6dcd25b8d8c@kernel.dk>
Date: Wed, 30 May 2018 11:32:09 -0600
MIME-Version: 1.0
In-Reply-To: <20180530165100.31186-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 5/30/18 10:51 AM, Christoph Hellwig wrote:
> We already check for started commands in all callbacks, but we should
> also protect against already completed commands.  Do this by taking
> the checks to common code.

Looks good, applied.

-- 
Jens Axboe
