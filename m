Return-Path: <ming.lei@redhat.com>
Date: Thu, 2 Aug 2018 07:11:12 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Mike Snitzer <snitzer@redhat.com>,
	Kent Overstreet <kent.overstreet@gmail.com>
Subject: Re: [PATCH 2/3] block: kill QUEUE_FLAG_NO_SG_MERGE
Message-ID: <20180801231111.GA28270@ming.t460p>
References: <20180731104914.17249-1-ming.lei@redhat.com>
 <20180731104914.17249-3-ming.lei@redhat.com>
 <20180801145402.GB28668@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180801145402.GB28668@lst.de>
List-ID: <linux-block@vger.kernel.org>

On Wed, Aug 01, 2018 at 04:54:02PM +0200, Christoph Hellwig wrote:
> We still hit __blk_recalc_rq_segments at least once per submission,
> don't we?  Either rather wait with this until we have multi-page bvecs.

No.

Please see blk_queue_split(), where the physical segment number is
always updated, and the flag of BIO_SEG_VALID is set meantime.

And for callers of blk_recount_segments(), it will check the VALID flag
first, and blk_recount_segments() is only run when this flag isn't set.

blk_recount_segments
    bio_phys_segments
        ll_new_hw_segment
            ll_back_merge_fn
            ll_front_merge_fn 
        blk_rq_bio_prep
            blk_rq_append_bio
            blk_init_request_from_bio
    bio_add_pc_page
    ll_back_merge_fn
    ll_front_merge_fn


Thanks,
Ming
