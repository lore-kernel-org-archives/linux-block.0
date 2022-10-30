Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FFDCECAAA1
	for <linux-block@archiver.kernel.org>; Sun, 30 Oct 2022 18:47:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbiJ3Srm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 30 Oct 2022 14:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiJ3Srl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 30 Oct 2022 14:47:41 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8834562CE
        for <linux-block@vger.kernel.org>; Sun, 30 Oct 2022 11:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WZHaOXZSQl1Gx2UwmlfgjO5egX5KL1UtlVsNFcqgE1A=; b=dB9MWYnuBeUbVHVshZvikbZq9a
        8gMKTbq0xTSqWDWUtfOBS81k85c3uEad9FKEMquo22YttpDf479wksBMR07XwXGgCOTsVNa3MmZ8p
        QSUq9VTfp8Vt/2LBvs8Qu5MWzvJ2yaEkAiBPnEuGrd/JhiWr45rl7XI1Vgx0bRVa+ABD0+x4cfbGI
        m04ZvaHkQoGyaFa2QbGt8adsXYScv8E3/9vYjHQ3/g8Tc1mwR0fEdaHSe2kVXk2sWhOFmWK31mYoM
        L3adyeneeEXP74yV7wXsd0Pyzbd8VkGudU/ew6Xt9EuOMRpANxfidEOop00cErLKCGcp+RG0/98Dj
        xnK1Gp+A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1opDLJ-00GHnC-11;
        Sun, 30 Oct 2022 18:47:33 +0000
Date:   Sun, 30 Oct 2022 18:47:33 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [bug?] blk_queue_may_bounce() has the comparison max_low_pfn and
 max_pfn wrong way
Message-ID: <Y17GxQf8TV2/zNo1@ZenIV>
References: <Y1wZTtENDq3fvs6n@ZenIV>
 <01ce222b-8ad6-b4b3-428a-bae9534795e7@kernel.dk>
 <Y1wr0g39GzHcAk9v@ZenIV>
 <Y11YuS3kiOWoOjuI@ZenIV>
 <20221030075032.GC4214@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221030075032.GC4214@lst.de>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Oct 30, 2022 at 08:50:32AM +0100, Christoph Hellwig wrote:
> On Sat, Oct 29, 2022 at 05:45:45PM +0100, Al Viro wrote:
> > completion (in NULL_Q_BIO case, at least).  What happens if request
> > gets split and split-off part finishes first with an error?  AFAICS,
> > its ->bi_status will be copied to parent (original bio, the one that
> > covers the tail).  Now the IO on the original bio is over as well
> > and we hit drivers/block/null_blk/main.c:end_cmd().  Suppose this
> > part succeeds; won't we end up overwriting ->bi_status with zero
> > and assuming that the entire thing had succeeded, despite the
> > (now lost) error on the split-off part?
> 
> As a rule of thumb drives should never set bi_status to 0, so null_blk
> here has a bug.  What is missing everywhere is proper memory barriers,
> though.

Something like

static inline void set_bio_status(struct bio *bio, blk_status_t status)
{
	if (unlikely(status))
		cmpxchg(&bio->bi_status, 0, status);
}

with e.g.
        if (bio->bi_status && !dio->bio.bi_status)
		dio->bio.bi_status = bio->bi_status;
in blkdev_bio_end_io() replaced with
	set_bio_status(&dio->bio, bio->bi_status);

perhaps?  That would probably do for almost all users, but...  what about
e.g. drivers/md/raid1.c:fix_sync_read_error()?  Looks like it really
intends non-zero -> zero change; I'm not familiar enough with the guts
of that sucker to tell if it is guaranteed to get no propagation from
another bio...
