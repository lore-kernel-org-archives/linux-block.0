Return-Path: <josef@toxicpanda.com>
Return-Path: <josef@toxicpanda.com>
Date: Wed, 30 May 2018 13:27:32 -0400
From: Josef Bacik <josef@toxicpanda.com>
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, keith.busch@intel.com, josef@toxicpanda.com,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] blk-mq: only iterate over inflight requests in
 blk_mq_tagset_busy_iter
Message-ID: <20180530172731.md54u3wuri3qmfbv@destiny>
References: <20180530165100.31186-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180530165100.31186-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

On Wed, May 30, 2018 at 06:51:00PM +0200, Christoph Hellwig wrote:
> We already check for started commands in all callbacks, but we should
> also protect against already completed commands.  Do this by taking
> the checks to common code.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Josef Bacik <josef@toxicpanda.com>

for the nbd portion.  Thanks,

Josef
