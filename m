Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C7B1C433ED
	for <linux-block@archiver.kernel.org>; Sat, 24 Apr 2021 06:55:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61CA661492
	for <linux-block@archiver.kernel.org>; Sat, 24 Apr 2021 06:55:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233122AbhDXG4V (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 24 Apr 2021 02:56:21 -0400
Received: from verein.lst.de ([213.95.11.211]:36222 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244174AbhDXGxa (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 24 Apr 2021 02:53:30 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2E20E68B05; Sat, 24 Apr 2021 08:52:49 +0200 (CEST)
Date:   Sat, 24 Apr 2021 08:52:48 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [GIT PULL] Block fix for 5.12 final
Message-ID: <20210424065248.GA9706@lst.de>
References: <c657100e-aef5-0710-2760-1d02f193cab6@kernel.dk> <CAHk-=wi5otGvBvWGx-XC=es88Xghe1TNFEYg_ZwoiZBzRvGeRA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wi5otGvBvWGx-XC=es88Xghe1TNFEYg_ZwoiZBzRvGeRA@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Apr 23, 2021 at 02:54:36PM -0700, Linus Torvalds wrote:
> On Fri, Apr 23, 2021 at 2:06 PM Jens Axboe <axboe@kernel.dk> wrote:
> >
> > A single fix for a behavioral regression in this series, when re-reading
> > the partition table with partitions open.
> 
> Hmm. The fact that it's no longer calling blk_drop_partitions() didn't
> just mean that the check for "bdev->bd_part_count" was lost (now
> re-instated).

It still calls blk_drop_partitions:

  blkdev_reread_part
    -> blkdev_get_by_dev
      -> __blkdev_get
        -> bdev_disk_changed
	  -> blk_drop_partitions

The difference is that before blkdev_reread_part called
bdev_disk_changed directly.  We now do it through blkdev_get to hook
into the driver.  But __blkdev_get ignores the return value from
bdev_disk_changed.

> It also seems to mean that blkdev_reread_part() no longer does the
> 
>         sync_blockdev(bdev);
>         invalidate_bdev(bdev);
> 
> to write back and invalidate any caches.
> 
> Are we sure cache writeback/invalidate isn't needed? Or does it get
> done some other place?

It is still in place.  But given how our cache coherency works not
actually needed anyway, but peeling that onion will take a while.
