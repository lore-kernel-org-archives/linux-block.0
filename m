Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53098 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751543AbdF0HfU (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Jun 2017 03:35:20 -0400
Date: Tue, 27 Jun 2017 15:34:55 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@infradead.org>,
        Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 16/51] block: bounce: avoid direct access to bvec table
Message-ID: <20170627073454.GA31283@ming.t460p>
References: <20170626121034.3051-1-ming.lei@redhat.com>
 <20170626121034.3051-17-ming.lei@redhat.com>
 <20170627061211.GA27359@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170627061211.GA27359@bombadil.infradead.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Jun 26, 2017 at 11:12:11PM -0700, Matthew Wilcox wrote:
> On Mon, Jun 26, 2017 at 08:09:59PM +0800, Ming Lei wrote:
> >  	bio_for_each_segment_all(bvec, bio, i) {
> > -		org_vec = bio_orig->bi_io_vec + i + start;
> > -
> > -		if (bvec->bv_page == org_vec->bv_page)
> > -			continue;
> > +		orig_vec = bio_iter_iovec(bio_orig, orig_iter);
> > +		if (bvec->bv_page == orig_vec.bv_page)
> > +			goto next;
> >  
> >  		dec_zone_page_state(bvec->bv_page, NR_BOUNCE);
> >  		mempool_free(bvec->bv_page, pool);
> > + next:
> > +		bio_advance_iter(bio_orig, &orig_iter, orig_vec.bv_len);
> >  	}
> >  
> 
> I think this might be written more clearly as:
> 
>  	bio_for_each_segment_all(bvec, bio, i) {
> 		orig_vec = bio_iter_iovec(bio_orig, orig_iter);
> 		if (bvec->bv_page != orig_vec.bv_page) {
>  			dec_zone_page_state(bvec->bv_page, NR_BOUNCE);
> 	 		mempool_free(bvec->bv_page, pool);
> 		}
> 		bio_advance_iter(bio_orig, &orig_iter, orig_vec.bv_len);
>  	}
> 
> What do you think?

Yeah, looks the above code is more clean, will do it in V3.

thanks,
Ming
