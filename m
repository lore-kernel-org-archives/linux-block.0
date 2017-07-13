Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:33650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750967AbdGMQu0 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Jul 2017 12:50:26 -0400
Date: Thu, 13 Jul 2017 09:50:23 -0700
From: Shaohua Li <shli@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org, axboe@fb.com, Shaohua Li <shli@fb.com>
Subject: Re: [PATCH 2/2] block: delete bio_uninit
Message-ID: <20170713165023.vcnumrgvbu4cw6jx@kernel.org>
References: <cover.1499881589.git.shli@fb.com>
 <094050f349fdf7eed4a20335e9a7573d7c8c9b35.1499881589.git.shli@fb.com>
 <20170713074519.GA13404@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170713074519.GA13404@lst.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Jul 13, 2017 at 09:45:19AM +0200, Christoph Hellwig wrote:
> >  static void bio_free(struct bio *bio)
> >  {
> >  	struct bio_set *bs = bio->bi_pool;
> >  	void *p;
> >  
> > -	bio_uninit(bio);
> > +	bio_disassociate_task(bio);
> 
> As said in the last mail I think there is no point in having this call..

I'm hesitant to do this. bio_associate_blkcg/bio_associate_current can be
called in any time for a bio, so we not just attach cgroup info to info in bio
submit (maybe the bio_associate_blkcg/bio_associate_current callers do sumbit
always, but I didn't audit yet). The other reason is I'd like
blk_throtl_bio_endio is only called once for the whole bio not for splitted
bio, so this depends on bio_free to free cgroup info for chained bio which
always does bio_put.

> > @@ -294,7 +289,7 @@ void bio_reset(struct bio *bio)
> >  {
> >  	unsigned long flags = bio->bi_flags & (~0UL << BIO_RESET_BITS);
> >  
> > -	bio_uninit(bio);
> > +	bio_disassociate_task(bio);
> 
> .. and this one.  And I suspect it would make sense to have all these
> changes in a single patch.

This one is likely ok, but again I didn't audit yet. I'm ok these changes are
in a single patch.

Thanks,
Shaohua
