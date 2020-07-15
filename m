Return-Path: <SRS0=PIBb=A2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1670FC433E3
	for <linux-block@archiver.kernel.org>; Wed, 15 Jul 2020 08:36:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCF89206E9
	for <linux-block@archiver.kernel.org>; Wed, 15 Jul 2020 08:36:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BrGbjMMs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730268AbgGOIgd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Jul 2020 04:36:33 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47368 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730269AbgGOIgd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Jul 2020 04:36:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594802191;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=2hBedVP56Gc7tO1+rdsGC37hPrJ8v6J3aBBm+CJA7Lg=;
        b=BrGbjMMs9TNXJaO2yrEHXSYZ+wTBsiqIdfp8ftVl58ZLR+hXmAkhwz8jmHcexaRvxZZya8
        4nZlDf1quX28lYHMe5QrMB1F3BmroWAlBv9EvEajE+KO/iJWn7aAfSAJgKGM7bPr7dtq+L
        mnnJ4zmzfjwg2kGN5snjOnOI4zNkgLM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-341-69Y27cQsOnOgINm04PsX6g-1; Wed, 15 Jul 2020 04:36:29 -0400
X-MC-Unique: 69Y27cQsOnOgINm04PsX6g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A45D81083E82;
        Wed, 15 Jul 2020 08:36:28 +0000 (UTC)
Received: from localhost (ovpn-12-91.pek2.redhat.com [10.72.12.91])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CA4E46FED1;
        Wed, 15 Jul 2020 08:36:23 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH] block: always remove partitions from blk_drop_partitions()
Date:   Wed, 15 Jul 2020 16:36:19 +0800
Message-Id: <20200715083619.624249-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In theory, when GENHD_FL_NO_PART_SCAN is set, no partitions can be created
on one disk. However, ioctl(BLKPG, BLKPG_ADD_PARTITION) doesn't check
GENHD_FL_NO_PART_SCAN, so partitions still can be added even though
GENHD_FL_NO_PART_SCAN is set.

So far blk_drop_partitions() only removes partitions when disk_part_scan_enabled()
return true. This way can make ghost partition on loop device after changing/clearing
FD in case that PARTSCAN is disabled, such as partitions can be added
via 'parted' on loop disk even though GENHD_FL_NO_PART_SCAN is set.

Fix this issue by always removing partitions in blk_drop_partitions(), and
this way is correct because the current code supposes that no partitions
can be added in case of GENHD_FL_NO_PART_SCAN.

Cc: Christoph Hellwig <hch@lst.de>
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

