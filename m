Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B199C433FE
	for <linux-block@archiver.kernel.org>; Mon, 16 May 2022 14:01:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239384AbiEPOBQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 16 May 2022 10:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244227AbiEPOBP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 May 2022 10:01:15 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AB24B1D1
        for <linux-block@vger.kernel.org>; Mon, 16 May 2022 07:01:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 81A90CE16C5
        for <linux-block@vger.kernel.org>; Mon, 16 May 2022 14:01:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56494C385AA;
        Mon, 16 May 2022 14:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652709670;
        bh=5KlJCwyfgyJDAVd8aUbwhlMDHECAzrDDqMdF/3AQlzw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oiSppv+OFQB00xBuqE/UZPL7CjpcNUimhkzPzL1cZ930lDLT23r05pi1LVLv4JE+b
         YOEUiauXqEPN+mTwZ3vR/Nk1noP3siA9AsUcXWVbXAFoWqBRIH3pvx+cRMxd1TAKw9
         CN2q0nhdBa5bNusRF2ejX937STTq5+hKcAtlfwLkMbxsmJxkWOvoXEZDJUAL6tgpjg
         1E5WuIh7TT6TjU3jPispNreSBIj9fyNCTHvdQM6t/prrjGe2/aiSolJ3DrcHbWc37G
         zMuZv92VsAblgxM6JlAtErE8bOfwpCscNBMx2F9VwtitnnTkHDDEub2Wp0BumU7nyn
         cGS486YXrt5kw==
Date:   Mon, 16 May 2022 08:01:07 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Keith Busch <kbusch@fb.com>, linux-block@vger.kernel.org,
        axboe@kernel.dk, Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH 3/3] block: ensure direct io is a block size
Message-ID: <YoJZI6VzBjfL2t84@kbusch-mbp.dhcp.thefacebook.com>
References: <20220513161339.1580042-1-kbusch@fb.com>
 <20220513161339.1580042-3-kbusch@fb.com>
 <9e3cd199-4333-5db2-c201-d0d2d2a05e86@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e3cd199-4333-5db2-c201-d0d2d2a05e86@opensource.wdc.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, May 16, 2022 at 12:13:10PM +0200, Damien Le Moal wrote:
> On 2022/05/13 18:13, Keith Busch wrote:
> > From: Keith Busch <kbusch@kernel.org>
> > 
> > If the iterator has an offset, filling a bio to the max bvecs may result
> > in a size that isn't aligned to the block size. Mask off bytes for the
> > bio being constructed.
> > 
> > Signed-off-by: Keith Busch <kbusch@kernel.org>
> > ---
> >  block/bio.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/block/bio.c b/block/bio.c
> > index 4259125e16ab..b42a9e3ff068 100644
> > --- a/block/bio.c
> > +++ b/block/bio.c
> > @@ -1144,6 +1144,7 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
> >  {
> >  	unsigned short nr_pages = bio->bi_max_vecs - bio->bi_vcnt;
> >  	unsigned short entries_left = bio->bi_max_vecs - bio->bi_vcnt;
> > +	struct request_queue *q = bdev_get_queue(bio->bi_bdev);
> >  	struct bio_vec *bv = bio->bi_io_vec + bio->bi_vcnt;
> >  	struct page **pages = (struct page **)bv;
> >  	bool same_page = false;
> > @@ -1160,6 +1161,9 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
> >  	pages += entries_left * (PAGE_PTRS_PER_BVEC - 1);
> >  
> >  	size = iov_iter_get_pages(iter, pages, LONG_MAX, nr_pages, &offset);
> > +	if (size > 0)
> > +		size = size & ~(queue_logical_block_size(q) - 1);
> 
> I think that __bio_iov_append_get_pages() needs the same change. And given that
> both __bio_iov_append_get_pages() and __bio_iov_iter_get_pages() start with
> iov_iter_get_pages(), should we do that and check the size in the single caller:
> bio_iov_iter_get_pages() ?

Right, __bio_iov_append_get_pages needs this too. I'll see if we can remove much
of the duplicated code among these two functions as a prep patch.
