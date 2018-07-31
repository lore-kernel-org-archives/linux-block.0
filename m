Return-Path: <msnitzer@redhat.com>
Date: Tue, 31 Jul 2018 11:32:18 -0400
From: Mike Snitzer <snitzer@redhat.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Kent Overstreet <kent.overstreet@gmail.com>
Subject: Re: [PATCH 0/3] block: fix mismatch of figuring out physical segment
 number
Message-ID: <20180731153218.GA17281@redhat.com>
References: <20180731104914.17249-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180731104914.17249-1-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

On Tue, Jul 31 2018 at  6:49am -0400,
Ming Lei <ming.lei@redhat.com> wrote:

> Hi,
> 
> This patchset fixes one issue related with physical segment computation,
> which is found by Mike. In case of dm-rq, the warning of 'blk_cloned_rq_check_limits:
> over max segments limit' can be triggered easily.
> 
> Follows the cause:
> 
> 1) in IO fast path(blk_queue_split()), we always figure out physical segment number
> no matter the flag of QUEUE_FLAG_NO_SG_MERGE is set or not.
> 
> 2) only blk_recount_segments() and blk_recalc_rq_segments() uses the flag of
> QUEUE_FLAG_NO_SG_MERGE, but the two are only called in some unusual
> cases, such as request clone in dm-rq.
> 
> 3) the above two computation don't match, and cause the warning of
> "blk_cloned_rq_check_limits: over max segments limit".
> 
> This patchset fixes this issue by killing the queue flag since it is basically
> bypassed since v4.4, and no one complains that at all. Also multipage bvec will
> come soon, and it doesn't make sense to keep QUEUE_FLAG_NO_SG_MERGE any more.

Thanks Ming, for the series:

Acked-by: Mike Snitzer <snitzer@redhat.com>
