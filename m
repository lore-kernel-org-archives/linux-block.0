Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8115C3DA78
	for <linux-block@archiver.kernel.org>; Tue, 17 Jan 2023 06:02:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235695AbjAQGCC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 Jan 2023 01:02:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235697AbjAQGBC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Jan 2023 01:01:02 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74FDB20055
        for <linux-block@vger.kernel.org>; Mon, 16 Jan 2023 22:01:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jD+IEtOBy+8oEghjLUpcDMP427/c3+5KkTQ/VJ3AZHU=; b=IF2R4UmRKBet00lLzGgDa0Aoof
        WFq+0ZMBuDYzOq2DSfdLrCsjq9o8VvbD2Mnw0b2WVBsFx6GKjNoxN460tYjyCQ8ztSkAOccm12/g9
        /Y9ukfbYQovjqH9x/Iz0/uc2ZY9sewvTt/VVNcON+K97bKfgQmX+Oprec6BeY7ypykUI+wKsNdXvp
        dTF2fAxljaat2/tSuBDqkRUxzmZkokzqcjAJgqhcpQpxXKoxs3vtKXmcOL1VeHXj62I6eLzMVApNW
        LPYUadcKWvVlEv7nDwUO95+VqS8SoYaVgr0dMe3GIcVcGV2Lpv8feF9R96oSJpki2F91ryigerPkW
        6v3hJgKw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pHf1p-00D1SU-1C; Tue, 17 Jan 2023 06:01:01 +0000
Date:   Mon, 16 Jan 2023 22:01:01 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, mikelley@microsoft.com
Subject: Re: [PATCH 1/2] block: handle bio_split_to_limits() NULL return
Message-ID: <Y8Y5nSB4pP1p7Q3E@infradead.org>
References: <20230104160938.62636-1-axboe@kernel.dk>
 <20230104160938.62636-2-axboe@kernel.dk>
 <Y70t2r+fOadEnDpE@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y70t2r+fOadEnDpE@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Per the question in the other thread: these are my comments to it.

On Tue, Jan 10, 2023 at 01:20:26AM -0800, Christoph Hellwig wrote:
> >  		split = bio_split_rw(bio, lim, nr_segs, bs,
> >  				get_max_io_size(bio, lim) << SECTOR_SHIFT);
> > +		if (IS_ERR(split))
> > +			return NULL;
> 
> Can we decide on either passing an ERR_PTR or NULL and do it through
> the whole stack? 
> 
> > diff --git a/drivers/block/drbd/drbd_req.c b/drivers/block/drbd/drbd_req.c
> > index eb14ec8ec04c..e36216d50753 100644
> > --- a/drivers/block/drbd/drbd_req.c
> > +++ b/drivers/block/drbd/drbd_req.c
> > @@ -1607,6 +1607,8 @@ void drbd_submit_bio(struct bio *bio)
> >  	struct drbd_device *device = bio->bi_bdev->bd_disk->private_data;
> >  
> >  	bio = bio_split_to_limits(bio);
> > +	if (!bio)
> > +		return;
> 
> So for the callers in drivers, do we need thee checks for drivers
> that don't even support REQ_NOWAIT? 
---end quoted text---
