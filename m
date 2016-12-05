Return-Path: <BATV+942a091854393eb11ca5+4852+infradead.org+hch@bombadil.srs.infradead.org>
Date: Mon, 5 Dec 2016 05:05:17 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@fb.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, paolo.valente@linaro.org
Subject: Re: [PATCH 1/7] block: use legacy path for flush requests for MQ
 with a scheduler
Message-ID: <20161205130517.GA7100@infradead.org>
References: <1480734921-23701-1-git-send-email-axboe@fb.com>
 <1480734921-23701-2-git-send-email-axboe@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1480734921-23701-2-git-send-email-axboe@fb.com>
List-ID: <linux-block@vger.kernel.org>

On Fri, Dec 02, 2016 at 08:15:15PM -0700, Jens Axboe wrote:
> No functional changes with this patch, it's just in preparation for
> supporting legacy schedulers on blk-mq.

Ewww.  I think without refactoring to clear what 'use_mq_path'
means here and better naming this is a total non-started.  Even with
that we'll now have yet another code path to worry about.  Is there
any chance to instead consolidate into a single path?

>  struct request *blk_get_request(struct request_queue *q, int rw, gfp_t gfp_mask)
>  {
> -	if (q->mq_ops)
> +	if (blk_use_mq_path(q))
>  		return blk_mq_alloc_request(q, rw,
>  			(gfp_mask & __GFP_DIRECT_RECLAIM) ?
>  				0 : BLK_MQ_REQ_NOWAIT);

So now with blk-mq and an elevator set we go into blk_old_get_request,
hich will simply allocate new requests.  How does this not break
every existing driver?
