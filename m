Return-Path: <SRS0=IPXt=RP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A955EC43381
	for <linux-block@archiver.kernel.org>; Tue, 12 Mar 2019 01:19:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72A07214AF
	for <linux-block@archiver.kernel.org>; Tue, 12 Mar 2019 01:19:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726209AbfCLBTp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Mar 2019 21:19:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60372 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725932AbfCLBTp (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Mar 2019 21:19:45 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BCD0E88313;
        Tue, 12 Mar 2019 01:19:44 +0000 (UTC)
Received: from ming.t460p (ovpn-8-22.pek2.redhat.com [10.72.8.22])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 75C5B5D70E;
        Tue, 12 Mar 2019 01:19:39 +0000 (UTC)
Date:   Tue, 12 Mar 2019 09:19:34 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Omar Sandoval <osandov@fb.com>
Subject: Re: [PATCH 6/6] block: don't check if adjacent bvecs in one bio can
 be mergeable
Message-ID: <20190312011933.GB28841@ming.t460p>
References: <20190309013737.27741-1-ming.lei@redhat.com>
 <20190309013737.27741-7-ming.lei@redhat.com>
 <20190311144024.GF7850@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190311144024.GF7850@lst.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Tue, 12 Mar 2019 01:19:44 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Mar 11, 2019 at 03:40:24PM +0100, Christoph Hellwig wrote:
> > +	bool new_bio;
> >  
> >  	if (!bio)
> >  		return 0;
> > @@ -377,9 +377,10 @@ static unsigned int __blk_recalc_rq_segments(struct request_queue *q,
> >  	fbio = bio;
> >  	seg_size = 0;
> >  	nr_phys_segs = 0;
> > +	new_bio = false;
> 
> I'd just initialize it to false in the declaration line.

OK.

> 
> > +/* only try to merge bvecs into one sg if they are from two bios */
> > +static inline bool
> > +__blk_segment_map_sg_merge(struct request_queue *q, struct bio_vec *bvec,
> > +			   struct bio_vec *bvprv, struct scatterlist **sg)
> >  {
> >  	int nbytes = bvec->bv_len;
> >  
> > +	if (!*sg)
> > +		return false;
> >  
> > +	if ((*sg)->length + nbytes > queue_max_segment_size(q))
> > +		return false;
> > +
> > +	if (!biovec_phys_mergeable(q, bvprv, bvec))
> > +		return false;
> > +
> > +	(*sg)->length += nbytes;
> > +
> > +	return true;
> > +}
> > +
> > +static inline void
> > +__blk_segment_map_sg(struct request_queue *q, struct bio_vec *bvec,
> > +		     struct scatterlist *sglist, struct scatterlist **sg,
> > +		     int *nsegs)
> > +{
> > +	if (bvec->bv_offset + bvec->bv_len <= PAGE_SIZE) {
> > +		*sg = blk_next_sg(sg, sglist);
> > +		sg_set_page(*sg, bvec->bv_page, bvec->bv_len, bvec->bv_offset);
> > +		(*nsegs) += 1;
> 
> This branch is basically the same as __blk_bvec_map_sg, I wonder if
> we can reuse it.

Good point!

> 
> > +	} else
> > +		(*nsegs) += blk_bvec_map_sg(q, bvec, sglist, sg);
> >  }
> 
> And then maybe just kill off __blk_segment_map_sg entirely by moving
> the if else into the caller.
> 
> > @@ -535,11 +543,24 @@ static int __blk_bios_map_sg(struct request_queue *q, struct bio *bio,
> >  	struct bio_vec bvec, bvprv = { NULL };
> >  	struct bvec_iter iter;
> >  	int nsegs = 0;
> > +	bool new_bio = false;
> >  
> > +	for_each_bio(bio) {
> > +		bio_for_each_bvec(bvec, bio, iter) {
> > +			/*
> > +			 * Only try to merge bvecs from two bios given we
> > +			 * have done bio internal merge when adding pages
> > +			 * to bio
> > +			 */
> > +			if (!new_bio || !__blk_segment_map_sg_merge(q,
> > +						&bvec, &bvprv, sg))
> 
> Somewhat hard to read.  Why not:
> 
> 			if (new_bio ||
> 			    !__blk_segment_map_sg_merge(q, &bvec, &bvprv, sg))

OK.

> 
> That being said I'd really like to see some stats on workloads that
> actually trigger cross-bio segment merges.  If we get a lot of those
> we are doing something wrong.

Please see 729204ef49ec00b ("block: relax check on sg gap"):

    If the last bvec of the 1st bio and the 1st bvec of the next
    bio are physically contigious, and the latter can be merged
    to last segment of the 1st bio, we should think they don't
    violate sg gap(or virt boundary) limit.

    Both Vitaly and Dexuan reported lots of unmergeable small bios
    are observed when running mkfs on Hyper-V virtual storage, and
    performance becomes quite low. This patch fixes that performance
    issue.

    The same issue should exist on NVMe, since it sets virt boundary too.

However, if the related fs code can be fixed to not generate too many
small bios, we might kill the cross-bio segment merge. Also not sure if
mkfs is the only such case.
    
Thanks,
Ming
