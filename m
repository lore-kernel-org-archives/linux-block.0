Return-Path: <SRS0=zBYI=YO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50A0ECA9EB5
	for <linux-block@archiver.kernel.org>; Mon, 21 Oct 2019 09:12:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A6C120873
	for <linux-block@archiver.kernel.org>; Mon, 21 Oct 2019 09:12:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbfJUJM6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Oct 2019 05:12:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:42714 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726181AbfJUJM6 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Oct 2019 05:12:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A4E18B59A;
        Mon, 21 Oct 2019 09:12:56 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 30DD71E4AA0; Mon, 21 Oct 2019 11:12:56 +0200 (CEST)
Date:   Mon, 21 Oct 2019 11:12:56 +0200
From:   Jan Kara <jack@suse.cz>
To:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Cc:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 2/2] bdev: Refresh bdev size for disks without
 partitioning
Message-ID: <20191021091256.GB17810@quack2.suse.cz>
References: <20191021083132.5351-1-jack@suse.cz>
 <20191021083808.19335-2-jack@suse.cz>
 <4d58a159-e935-1200-1a71-8eb252fc5bdc@cloud.ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d58a159-e935-1200-1a71-8eb252fc5bdc@cloud.ionos.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon 21-10-19 10:49:54, Guoqing Jiang wrote:
> 
> 
> On 10/21/19 10:38 AM, Jan Kara wrote:
> > Currently, block device size in not updated on second and further open
> > for block devices where partition scan is disabled. This is particularly
> > annoying for example for DVD drives as that means block device size does
> > not get updated once the media is inserted into a drive if the device is
> > already open when inserting the media. This is actually always the case
> > for example when pktcdvd is in use.
> > 
> > Fix the problem by revalidating block device size on every open even for
> > devices with partition scan disabled.
> > 
> > Signed-off-by: Jan Kara <jack@suse.cz>
> > ---
> >   fs/block_dev.c | 19 ++++++++++---------
> >   1 file changed, 10 insertions(+), 9 deletions(-)
> > 
> > diff --git a/fs/block_dev.c b/fs/block_dev.c
> > index 88c6d35ec71d..d612468ee66b 100644
> > --- a/fs/block_dev.c
> > +++ b/fs/block_dev.c
> > @@ -1403,11 +1403,7 @@ static void flush_disk(struct block_device *bdev, bool kill_dirty)
> >   		       "resized disk %s\n",
> >   		       bdev->bd_disk ? bdev->bd_disk->disk_name : "");
> >   	}
> > -
> > -	if (!bdev->bd_disk)
> > -		return;
> > -	if (disk_part_scan_enabled(bdev->bd_disk))
> > -		bdev->bd_invalidated = 1;
> > +	bdev->bd_invalidated = 1;
> >   }
> >   /**
> > @@ -1514,10 +1510,15 @@ static void __blkdev_put(struct block_device *bdev, fmode_t mode, int for_part);
> >   static void bdev_disk_changed(struct block_device *bdev, bool invalidate)
> >   {
> > -	if (invalidate)
> > -		invalidate_partitions(bdev->bd_disk, bdev);
> > -	else
> > -		rescan_partitions(bdev->bd_disk, bdev);
> > +	if (disk_part_scan_enabled(bdev->bd_disk)) {
> > +		if (invalidate)
> > +			invalidate_partitions(bdev->bd_disk, bdev);
> > +		else
> > +			rescan_partitions(bdev->bd_disk, bdev);
> 
> Maybe use the new common helper to replace above.

What do you mean exactly? Because there's only this place that has the code
pattern here...

								Honza

> > +	} else {
> > +		check_disk_size_change(bdev->bd_disk, bdev, !invalidate);
> > +		bdev->bd_invalidated = 0;
> > +	}
> >   }
> >   /*
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
