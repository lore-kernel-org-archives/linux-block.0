Return-Path: <SRS0=ZuuS=ZW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49622C432C0
	for <linux-block@archiver.kernel.org>; Sat, 30 Nov 2019 22:06:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A8B320833
	for <linux-block@archiver.kernel.org>; Sat, 30 Nov 2019 22:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575151604;
	bh=2xayJs4oZK6B8/2irCWF8SEufg76S3680V4/IlMpP4s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ynIWKdOlu2ek9vSiq5fCYnb/ALIEoz5VPz1taJoNXRkq/Yf3j0FUbhHitVtISxyiU
	 LIeDptx9fsd1KupKfNQi+o8b0tf5pEo/3xh4pM1V4/TH2X1sxpvFxIiSRIEzrkpjuA
	 A4B/lIN8NC9sUPXMqeY7ovrVA0BkehWTgP6LBRI4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727312AbfK3WGn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 30 Nov 2019 17:06:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:42728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727179AbfK3WGn (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 30 Nov 2019 17:06:43 -0500
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C4232082E;
        Sat, 30 Nov 2019 22:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575151602;
        bh=2xayJs4oZK6B8/2irCWF8SEufg76S3680V4/IlMpP4s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PgX0R7kV5FM7xuss2R9PJ895BZvid6ReH+njGhKpCjbQsFlKu1tPIEtiOHdyKrDpd
         SMtZxmVt/frn0+h6g+W6OMirxFl25tuUCsM3oBUATQwNi2TNzJUvZuquY1kDchyabt
         ZoBjFehhHiJqibWj12P678S6f84pxGGtC2PRtE3U=
Date:   Sat, 30 Nov 2019 14:06:41 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        linux-block@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH 2/7] block: merge invalidate_partitions into
 rescan_partitions
Message-ID: <20191130220641.GA669@sol.localdomain>
References: <20191114143438.14681-1-hch@lst.de>
 <20191114143438.14681-3-hch@lst.de>
 <20191130214942.GA676@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191130214942.GA676@sol.localdomain>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Nov 30, 2019 at 01:49:42PM -0800, Eric Biggers wrote:
> Hi Christoph,
> 
> On Thu, Nov 14, 2019 at 03:34:33PM +0100, Christoph Hellwig wrote:
> > A lot of the logic in invalidate_partitions and rescan_partitions is
> > shared.  Merge the two functions to simplify things.  There is a small
> > behavior change in that we now send the kevent change notice also if we
> > were not invalidating but no partitions were found, which seems like
> > the right thing to do.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > Reviewed-by: Jan Kara <jack@suse.cz>
> > ---
> >  block/ioctl.c             |  2 +-
> >  block/partition-generic.c | 38 ++++++++++++++------------------------
> >  fs/block_dev.c            |  5 +----
> >  include/linux/genhd.h     |  4 ++--
> >  4 files changed, 18 insertions(+), 31 deletions(-)
> > 
> 
> Mainline is broken for me because systemd-udevd spins forever using max CPU
> starting at boot time.  I bisected it to this commit.
> 
> I'm not an expert in this code, but the following patch fixes it:
> 
> diff --git a/block/partition-generic.c b/block/partition-generic.c
> index 6b9f4f5d993a..b0eebd7580ab 100644
> --- a/block/partition-generic.c
> +++ b/block/partition-generic.c
> @@ -599,7 +599,8 @@ int rescan_partitions(struct gendisk *disk, struct block_device *bdev,
>  		 * Tell userspace that the media / partition table may have
>  		 * changed.
>  		 */
> -		kobject_uevent(&disk_to_dev(disk)->kobj, KOBJ_CHANGE);
> +		if (invalidate)
> +			kobject_uevent(&disk_to_dev(disk)->kobj, KOBJ_CHANGE);
>  		return 0;
>  	}
> 
> 
> Do you have any better suggestion, or should I just send this as a formal patch?
> 

Actually this code was moved around more between the bad commit and mainline,
so the fix for mainline would be:

diff --git a/fs/block_dev.c b/fs/block_dev.c
index ee63c2732fa2..69bf2fb6f7cd 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1531,7 +1531,7 @@ int bdev_disk_changed(struct block_device *bdev, bool invalidate)
 		ret = blk_add_partitions(disk, bdev);
 		if (ret == -EAGAIN)
 			goto rescan;
-	} else {
+	} else if (invalidate) {
 		/*
 		 * Tell userspace that the media / partition table may have
 		 * changed.
