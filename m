Return-Path: <SRS0=IPXt=RP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52599C43381
	for <linux-block@archiver.kernel.org>; Tue, 12 Mar 2019 01:06:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A98C214D8
	for <linux-block@archiver.kernel.org>; Tue, 12 Mar 2019 01:06:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbfCLBGt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Mar 2019 21:06:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41540 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725861AbfCLBGt (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Mar 2019 21:06:49 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E9EE230833B2;
        Tue, 12 Mar 2019 01:06:48 +0000 (UTC)
Received: from ming.t460p (ovpn-8-22.pek2.redhat.com [10.72.8.22])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 15B9B5D70E;
        Tue, 12 Mar 2019 01:06:43 +0000 (UTC)
Date:   Tue, 12 Mar 2019 09:06:39 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Omar Sandoval <osandov@fb.com>
Subject: Re: [PATCH 5/6] block: enable multi-page bvec for passthrough IO
Message-ID: <20190312010637.GA28841@ming.t460p>
References: <20190309013737.27741-1-ming.lei@redhat.com>
 <20190309013737.27741-6-ming.lei@redhat.com>
 <20190311143554.GE7850@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190311143554.GE7850@lst.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Tue, 12 Mar 2019 01:06:49 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Mar 11, 2019 at 03:35:54PM +0100, Christoph Hellwig wrote:
> >  		struct bio_vec *prev = &bio->bi_io_vec[bio->bi_vcnt - 1];
> >  
> > +		/* segment size is always >= PAGE_SIZE */
> 
> I don't think that actually is true.  We have various drivers with 4k
> segment size, for which this would not be true with a 64k page size
> system.

Please look at blk_queue_max_segment_size():

void blk_queue_max_segment_size(struct request_queue *q, unsigned int max_size)
{
        if (max_size < PAGE_SIZE) {
                max_size = PAGE_SIZE;
                printk(KERN_INFO "%s: set to minimum %d\n",
                       __func__, max_size);
        }

        q->limits.max_segment_size = max_size;
}

But your concern is correct wrt. 4k segment size vs. 64k page size,
however, seems not see any such report.

> 
> >  		if (page == prev->bv_page &&
> >  		    offset == prev->bv_offset + prev->bv_len) {
> >  			if (put_same_page)
> >  				put_page(page);
> > + bvec_merge:
> >  			prev->bv_len += len;
> >  			bio->bi_iter.bi_size += len;
> 
> Please throw in a cleanup patch that removes prev and and always uses
> bvec, then we can just move the done label up by two lines and handle
> the increment of bv_len and bi_size in a common branch.

Seems only one line of 'bio->bi_iter.bi_size += len;' can be shared.

> 
> >   done:
> > +	bio->bi_phys_segments = bio->bi_vcnt;
> > +	if (!bio_flagged(bio, BIO_SEG_VALID))
> > +		bio_set_flag(bio, BIO_SEG_VALID);
> 
> How would BIO_SEG_VALID get set previously?  And even if it did

bio_add_pc_page() is run over each page.

> we wouldn't optimize much here, I'd just do it unconditionally.

OK.

> 
> Btw, there are various comments in this function that either already
> were or have become out of data, like talking about REQ_PC or
> file system I/O - I think they could use some love.

OK.

Thanks,
Ming
