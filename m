Return-Path: <SRS0=UAvt=AT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF6BDC433E0
	for <linux-block@archiver.kernel.org>; Wed,  8 Jul 2020 09:13:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC76720658
	for <linux-block@archiver.kernel.org>; Wed,  8 Jul 2020 09:13:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iqqhTd4m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbgGHJNl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 8 Jul 2020 05:13:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33122 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726900AbgGHJNl (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 8 Jul 2020 05:13:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594199619;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=d47wJkNUtSmAHQ4wGGNz/6M8oem5ncUNw5yCpllg8Qc=;
        b=iqqhTd4mwsXyylHH6C2OHfFRZgCoTgTTuW9u54/PZ2kPqG0CqRjsksNEJ29CnAH3SZo9YB
        Nc9LvlEAwuR4r9f/r7Js09YzDSM+Yx6dk+vp4h9A7UCRmDWoF771tyb5tC2ekqqNtI7o3R
        A9fbx9EV11oyfTutS18sHLrSvWHyZSI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-308-bnzmUXJyPneI9IWbzSU6cQ-1; Wed, 08 Jul 2020 05:13:35 -0400
X-MC-Unique: bnzmUXJyPneI9IWbzSU6cQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7E240EC1A6;
        Wed,  8 Jul 2020 09:13:30 +0000 (UTC)
Received: from T590 (ovpn-12-31.pek2.redhat.com [10.72.12.31])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AD3731001268;
        Wed,  8 Jul 2020 09:13:22 +0000 (UTC)
Date:   Wed, 8 Jul 2020 17:13:18 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 2/2] block: loop: delete partitions after clearing &
 changing fd
Message-ID: <20200708091318.GA3321276@T590>
References: <20200707084552.3294693-1-ming.lei@redhat.com>
 <20200707084552.3294693-3-ming.lei@redhat.com>
 <20200707175312.GB3730@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200707175312.GB3730@lst.de>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jul 07, 2020 at 07:53:12PM +0200, Christoph Hellwig wrote:
> On Tue, Jul 07, 2020 at 04:45:52PM +0800, Ming Lei wrote:
> > After clearing fd or changing fd, we have to delete old partitions,
> > otherwise they may become ghost partitions.
> > 
> > Fix this issue by clearing GENHD_FL_NO_PART_SCAN during calling
> > bdev_disk_changed() which won't drop old partitions if GENHD_FL_NO_PART_SCAN
> > isn't set.
> 
> I don't think messing with GENHD_FL_NO_PART_SCAN is a good idea, as
> that will also cause an actual partition scan.  But except for historic
> reasons I can't think of a good idea to even check for
> GENHD_FL_NO_PART_SCAN in blk_drop_partitions.

I think it is safe to not check it in blk_drop_partitions(), how about
the following patch?

From a20209464c367c338beee5555f2cb5c8e8ad9f78 Mon Sep 17 00:00:00 2001
From: Ming Lei <ming.lei@redhat.com>
Date: Wed, 8 Jul 2020 16:07:19 +0800
Subject: [PATCH] block: always remove partitions in blk_drop_partitions()

So far blk_drop_partitions() only removes partitions when
disk_part_scan_enabled() return true. This way can make ghost partition on
loop device after changing/clearing FD in case that PARTSCAN is disabled.

Fix this issue by always removing partitions in blk_drop_partitions(), and
this way is correct because:

1) only loop, mmc and GENHD_FL_HIDDEN disks(nvme multipath) may set
GENHD_FL_NO_PART_SCAN

2) GENHD_FL_HIDDEN disks doesn't expose disk to block device fs, and
bdev_disk_changed()/blk_drop_partitions() won't be called for this kind of
disk

3) for mmc, if GENHD_FL_NO_PART_SCAN is set, no any partitions can be added
for this kind of disk, so blk_drop_partitions() basically does nothing no
matter if GENHD_FL_NO_PART_SCAN is set or not because disk_max_parts(disk) <= 1

4) for loop, bdev_disk_changed() is called in two cases: one is set fd and set
status, when there shouldn't be any partitions; another is clearing/changing fd,
we need to remove old partitions and re-read new partitions if there are and
PART_SCAN is enabled.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/partitions/core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/block/partitions/core.c b/block/partitions/core.c
index 78951e33b2d7..e62a98a8eeb7 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -619,8 +619,6 @@ int blk_drop_partitions(struct block_device *bdev)
 	struct disk_part_iter piter;
 	struct hd_struct *part;
 
-	if (!disk_part_scan_enabled(bdev->bd_disk))
-		return 0;
 	if (bdev->bd_part_count)
 		return -EBUSY;
 
-- 
2.25.2




thanks,
Ming

