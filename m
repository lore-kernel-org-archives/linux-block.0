Return-Path: <linux-fsdevel-owner@vger.kernel.org>
Date: Mon, 26 Jun 2017 23:12:11 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@infradead.org>,
        Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 16/51] block: bounce: avoid direct access to bvec table
Message-ID: <20170627061211.GA27359@bombadil.infradead.org>
References: <20170626121034.3051-1-ming.lei@redhat.com>
 <20170626121034.3051-17-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170626121034.3051-17-ming.lei@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

On Mon, Jun 26, 2017 at 08:09:59PM +0800, Ming Lei wrote:
>  	bio_for_each_segment_all(bvec, bio, i) {
> -		org_vec = bio_orig->bi_io_vec + i + start;
> -
> -		if (bvec->bv_page == org_vec->bv_page)
> -			continue;
> +		orig_vec = bio_iter_iovec(bio_orig, orig_iter);
> +		if (bvec->bv_page == orig_vec.bv_page)
> +			goto next;
>  
>  		dec_zone_page_state(bvec->bv_page, NR_BOUNCE);
>  		mempool_free(bvec->bv_page, pool);
> + next:
> +		bio_advance_iter(bio_orig, &orig_iter, orig_vec.bv_len);
>  	}
>  

I think this might be written more clearly as:

 	bio_for_each_segment_all(bvec, bio, i) {
		orig_vec = bio_iter_iovec(bio_orig, orig_iter);
		if (bvec->bv_page != orig_vec.bv_page) {
 			dec_zone_page_state(bvec->bv_page, NR_BOUNCE);
	 		mempool_free(bvec->bv_page, pool);
		}
		bio_advance_iter(bio_orig, &orig_iter, orig_vec.bv_len);
 	}

What do you think?
