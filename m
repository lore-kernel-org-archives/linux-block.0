Return-Path: <SRS0=K2Ob=YP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45278CA9EA0
	for <linux-block@archiver.kernel.org>; Tue, 22 Oct 2019 09:15:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 202BF218AE
	for <linux-block@archiver.kernel.org>; Tue, 22 Oct 2019 09:15:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388277AbfJVJPQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Oct 2019 05:15:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:42168 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388244AbfJVJPQ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Oct 2019 05:15:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5F61FBD76;
        Tue, 22 Oct 2019 09:15:14 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 80ED51E47FF; Tue, 22 Oct 2019 11:15:13 +0200 (CEST)
Date:   Tue, 22 Oct 2019 11:15:13 +0200
From:   Jan Kara <jack@suse.cz>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 1/2] bdev: Factor out bdev revalidation into a common
 helper
Message-ID: <20191022091513.GF2436@quack2.suse.cz>
References: <20191021083132.5351-1-jack@suse.cz>
 <20191021083808.19335-1-jack@suse.cz>
 <BYAPR04MB5816C126635CB91E06A6FF48E7680@BYAPR04MB5816.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR04MB5816C126635CB91E06A6FF48E7680@BYAPR04MB5816.namprd04.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue 22-10-19 07:58:08, Damien Le Moal wrote:
> On 2019/10/21 17:38, Jan Kara wrote:
> > Factor out code handling revalidation of bdev on disk change into a
> > common helper.
> > 
> > Signed-off-by: Jan Kara <jack@suse.cz>
> > ---
> >  fs/block_dev.c | 26 ++++++++++++++------------
> >  1 file changed, 14 insertions(+), 12 deletions(-)
> > 
> > diff --git a/fs/block_dev.c b/fs/block_dev.c
> > index 9c073dbdc1b0..88c6d35ec71d 100644
> > --- a/fs/block_dev.c
> > +++ b/fs/block_dev.c
> > @@ -1512,6 +1512,14 @@ EXPORT_SYMBOL(bd_set_size);
> >  
> >  static void __blkdev_put(struct block_device *bdev, fmode_t mode, int for_part);
> >  
> > +static void bdev_disk_changed(struct block_device *bdev, bool invalidate)
> > +{
> > +	if (invalidate)
> > +		invalidate_partitions(bdev->bd_disk, bdev);
> > +	else
> > +		rescan_partitions(bdev->bd_disk, bdev);
> > +}
> > +
> >  /*
> >   * bd_mutex locking:
> >   *
> > @@ -1594,12 +1602,9 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode, int for_part)
> >  			 * The latter is necessary to prevent ghost
> >  			 * partitions on a removed medium.
> >  			 */
> > -			if (bdev->bd_invalidated) {
> > -				if (!ret)
> > -					rescan_partitions(disk, bdev);
> > -				else if (ret == -ENOMEDIUM)
> > -					invalidate_partitions(disk, bdev);
> > -			}
> > +			if (bdev->bd_invalidated &&
> > +			    (!ret || ret == -ENOMEDIUM))
> > +				bdev_disk_changed(bdev, ret == -ENOMEDIUM);
> 
> This is a little confusing since from its name, bdev_disk_changed() seem
> to imply that a new disk is present but this is called only if bdev is
> invalidated... What about calling this simply bdev_revalidate_disk(),
> since rescan_partitions() will call the disk revalidate method.

Honestly, the whole disk revalidation code is confusing to me :) I had to
draw a graph of which function calls which to understand what's going on in
that code and I think it could really use some refactoring. But that's
besides current point :)

Your "only if bdev is invalidated" is true but not actually a full story.
->bd_invalidated effectively gets set only through check_disk_change(). All
other places that end up calling flush_disk() clear bd_invalidated shortly
afterwards. So the function I've created is a direct counterpart to
check_disk_change() that just needs to happen after the device is
successfully open. I wanted to express that in the name - hence
bdev_disk_changed(). So yes, bdev_disk_changed() should be called exactly
when the new disk is present. It is bd_invalidated that is actually
misnamed.

Now I'm not really tied to bdev_disk_changed(). bdev_revalidate_disk()
seems a bit confusing to me though because the disk has actually been
already revalidated in check_disk_change() and the function won't
revalidate the disk for devices with partition scan disabled.

> Also, it seems to me that this function could be used without the
> complex "if ()" condition by slightly modifying it:
> 
> static void bdev_revalidate_disk(struct block_device *bdev,
> 			         bool invalidate)
> {
> 	if (bdev->bd_invalidated && invalidate)
> 		invalidate_partitions(bdev->bd_disk, bdev);
> 	else
> 		rescan_partitions(bdev->bd_disk, bdev);
> }
> 
> Otherwise, this all looks fine to me.

Well, but you don't want to call rescan_partitions() if bd_invalidated is
not set. But yes, we could move bd_invalidated check into
bdev_disk_changed(), but then it would seem less clear why this function is
getting called. This ties somewhat to the discussion above. Hum, I guess if
we call the function just bdev_revalidate(), the name won't be confusing
and it would then make sense to move the bd_invalidated condition in there.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
