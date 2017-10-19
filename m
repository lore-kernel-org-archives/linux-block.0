Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51594 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751056AbdJSX6Y (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 Oct 2017 19:58:24 -0400
Date: Fri, 20 Oct 2017 07:58:13 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Jens Axboe <axboe@fb.com>, Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3 37/49] fs/mpage: convert to
 bio_for_each_segment_all_sp()
Message-ID: <20171019235813.GF27130@ming.t460p>
References: <20170808084548.18963-1-ming.lei@redhat.com>
 <20170808084548.18963-38-ming.lei@redhat.com>
 <20170810121612.GG14607@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170810121612.GG14607@infradead.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Aug 10, 2017 at 05:16:12AM -0700, Christoph Hellwig wrote:
> >  	struct bio_vec *bv;
> > +	struct bvec_iter_all bia;
> >  	int i;
> >  
> > -	bio_for_each_segment_all(bv, bio, i) {
> > +	bio_for_each_segment_all_sp(bv, bio, i, bia) {
> >  		struct page *page = bv->bv_page;
> >  		page_endio(page, op_is_write(bio_op(bio)),
> >  				blk_status_to_errno(bio->bi_status));
> 
> Hmm.  Going back to my previous comment about implementing the single
> page variants on top of multipage - I wonder if we should simply
> do that in the callers, e.g. something like:
> 
> 	bio_for_each_segment_all(bv, bio, i) {
> 		bvec_for_each_page(page, bv, j) {
> 			page_endio(page, op_is_write(bio_op(bio)),
> 				blk_status_to_errno(bio->bi_status));
> 		}
> 	}
> 
> with additional helpers to get the length and offset for the page, e.g.
> 
> bvec_page_offset(bv, idx)
> bvev_page_len(bv, idx)
> 
> While this is a little more code in the callers it's a lot easier to
> understand.

Actually this patch is only a rename and the helper's sematics isn't
changed, so it doesn't affect the readability or understandablity,
and it clarifies that the helper fetches one page each time.

Also, once multipage bvec is done, we can rename bio_for_each_segment_all_sp()
into bio_for_each_page_all(), and rename bio_for_each_segment_all_mp() into
bio_for_each_segment_all(), which should be much easier to understand.

-- 
Ming
