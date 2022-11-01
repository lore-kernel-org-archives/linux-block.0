Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1397FC433FE
	for <linux-block@archiver.kernel.org>; Tue,  1 Nov 2022 11:11:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbiKALLT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Nov 2022 07:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiKALLT (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Nov 2022 07:11:19 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E37FA18E2C
        for <linux-block@vger.kernel.org>; Tue,  1 Nov 2022 04:11:18 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id D05996732D; Tue,  1 Nov 2022 12:11:15 +0100 (CET)
Date:   Tue, 1 Nov 2022 12:11:15 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Subject: Re: [bug?] blk_queue_may_bounce() has the comparison max_low_pfn
 and max_pfn wrong way
Message-ID: <20221101111115.GA14221@lst.de>
References: <Y1wZTtENDq3fvs6n@ZenIV> <01ce222b-8ad6-b4b3-428a-bae9534795e7@kernel.dk> <Y1wr0g39GzHcAk9v@ZenIV> <Y11YuS3kiOWoOjuI@ZenIV> <20221030075032.GC4214@lst.de> <Y17GxQf8TV2/zNo1@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y17GxQf8TV2/zNo1@ZenIV>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Oct 30, 2022 at 06:47:33PM +0000, Al Viro wrote:
> static inline void set_bio_status(struct bio *bio, blk_status_t status)
> {
> 	if (unlikely(status))
> 		cmpxchg(&bio->bi_status, 0, status);
> }
> 
> with e.g.
>         if (bio->bi_status && !dio->bio.bi_status)
> 		dio->bio.bi_status = bio->bi_status;
> in blkdev_bio_end_io() replaced with
> 	set_bio_status(&dio->bio, bio->bi_status);
> 
> perhaps?

I think so, yes.

> That would probably do for almost all users, but...  what about
> e.g. drivers/md/raid1.c:fix_sync_read_error()?  Looks like it really
> intends non-zero -> zero change; I'm not familiar enough with the guts
> of that sucker to tell if it is guaranteed to get no propagation from
> another bio...

I think the clearing to zero here is intentional as the bio failed,
but it manages to get the data from the other leg of the mirror.  But
the md code is really hard to follow, and any change to this code
needs careful review from the maintainer and the linux-raid list.
