Return-Path: <linux-fsdevel-owner@vger.kernel.org>
Date: Thu, 10 Aug 2017 05:16:12 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@infradead.org>,
        Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3 37/49] fs/mpage: convert to
 bio_for_each_segment_all_sp()
Message-ID: <20170810121612.GG14607@infradead.org>
References: <20170808084548.18963-1-ming.lei@redhat.com>
 <20170808084548.18963-38-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170808084548.18963-38-ming.lei@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

>  	struct bio_vec *bv;
> +	struct bvec_iter_all bia;
>  	int i;
>  
> -	bio_for_each_segment_all(bv, bio, i) {
> +	bio_for_each_segment_all_sp(bv, bio, i, bia) {
>  		struct page *page = bv->bv_page;
>  		page_endio(page, op_is_write(bio_op(bio)),
>  				blk_status_to_errno(bio->bi_status));

Hmm.  Going back to my previous comment about implementing the single
page variants on top of multipage - I wonder if we should simply
do that in the callers, e.g. something like:

	bio_for_each_segment_all(bv, bio, i) {
		bvec_for_each_page(page, bv, j) {
			page_endio(page, op_is_write(bio_op(bio)),
				blk_status_to_errno(bio->bi_status));
		}
	}

with additional helpers to get the length and offset for the page, e.g.

bvec_page_offset(bv, idx)
bvev_page_len(bv, idx)

While this is a little more code in the callers it's a lot easier to
understand.
