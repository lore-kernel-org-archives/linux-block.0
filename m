Return-Path: <SRS0=uWmC=R6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D650C4360F
	for <linux-block@archiver.kernel.org>; Wed, 27 Mar 2019 19:26:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61337206C0
	for <linux-block@archiver.kernel.org>; Wed, 27 Mar 2019 19:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553714779;
	bh=3us/v9f8j5BYRgqxZZlbrsxO9WOuZuT2mCaJ0oYJW1E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Jwm1u7CFejECWDAJUIz+HS7yngaBJ4bpmv1/8tdBkmTzC5nzxPVooNqMggVtg/hJ2
	 93ESa2UfnRXoRACngReYGwB8Gn1vO5R1Wa1MDmY3ibJXAwCsYCt67mVKtn5kXLvEKz
	 KdYrQ0LUpgrBwjc5xRltb3zpZzTE5zHFePbZ3MA8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387574AbfC0T0G (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Mar 2019 15:26:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:46034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387569AbfC0SFF (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Mar 2019 14:05:05 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09BEA2075C;
        Wed, 27 Mar 2019 18:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553709903;
        bh=3us/v9f8j5BYRgqxZZlbrsxO9WOuZuT2mCaJ0oYJW1E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WAHcTycuuDmfjghDP7bWRJKsTGKnQCk6jamcI63P42wSaAztCMiJj+fpJRMrfcTpk
         T2n8efCNyGmXmVBWZ6P3JYnOT0QSwYyxLQrqTAq60oZTR2zD3lMR8j7JYFi5XvoTwr
         DurAGrSN3E1Rhqyhqj0+ZaH6SFuDTRwip6oxX3Dc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dongli Zhang <dongli.zhang@oracle.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 5.0 101/262] loop: set GENHD_FL_NO_PART_SCAN after blkdev_reread_part()
Date:   Wed, 27 Mar 2019 13:59:16 -0400
Message-Id: <20190327180158.10245-101-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327180158.10245-1-sashal@kernel.org>
References: <20190327180158.10245-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Dongli Zhang <dongli.zhang@oracle.com>

[ Upstream commit 758a58d0bc67457f1215321a536226654a830eeb ]

Commit 0da03cab87e6
("loop: Fix deadlock when calling blkdev_reread_part()") moves
blkdev_reread_part() out of the loop_ctl_mutex. However,
GENHD_FL_NO_PART_SCAN is set before __blkdev_reread_part(). As a result,
__blkdev_reread_part() will fail the check of GENHD_FL_NO_PART_SCAN and
will not rescan the loop device to delete all partitions.

Below are steps to reproduce the issue:

step1 # dd if=/dev/zero of=tmp.raw bs=1M count=100
step2 # losetup -P /dev/loop0 tmp.raw
step3 # parted /dev/loop0 mklabel gpt
step4 # parted -a none -s /dev/loop0 mkpart primary 64s 1
step5 # losetup -d /dev/loop0

Step5 will not be able to delete /dev/loop0p1 (introduced by step4) and
there is below kernel warning message:

[  464.414043] __loop_clr_fd: partition scan of loop0 failed (rc=-22)

This patch sets GENHD_FL_NO_PART_SCAN after blkdev_reread_part().

Fixes: 0da03cab87e6 ("loop: Fix deadlock when calling blkdev_reread_part()")
Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/loop.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index cf5538942834..23aa2e9b3be0 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1089,16 +1089,12 @@ static int __loop_clr_fd(struct loop_device *lo, bool release)
 		kobject_uevent(&disk_to_dev(bdev->bd_disk)->kobj, KOBJ_CHANGE);
 	}
 	mapping_set_gfp_mask(filp->f_mapping, gfp);
-	lo->lo_state = Lo_unbound;
 	/* This is safe: open() is still holding a reference. */
 	module_put(THIS_MODULE);
 	blk_mq_unfreeze_queue(lo->lo_queue);
 
 	partscan = lo->lo_flags & LO_FLAGS_PARTSCAN && bdev;
 	lo_number = lo->lo_number;
-	lo->lo_flags = 0;
-	if (!part_shift)
-		lo->lo_disk->flags |= GENHD_FL_NO_PART_SCAN;
 	loop_unprepare_queue(lo);
 out_unlock:
 	mutex_unlock(&loop_ctl_mutex);
@@ -1120,6 +1116,23 @@ static int __loop_clr_fd(struct loop_device *lo, bool release)
 		/* Device is gone, no point in returning error */
 		err = 0;
 	}
+
+	/*
+	 * lo->lo_state is set to Lo_unbound here after above partscan has
+	 * finished.
+	 *
+	 * There cannot be anybody else entering __loop_clr_fd() as
+	 * lo->lo_backing_file is already cleared and Lo_rundown state
+	 * protects us from all the other places trying to change the 'lo'
+	 * device.
+	 */
+	mutex_lock(&loop_ctl_mutex);
+	lo->lo_flags = 0;
+	if (!part_shift)
+		lo->lo_disk->flags |= GENHD_FL_NO_PART_SCAN;
+	lo->lo_state = Lo_unbound;
+	mutex_unlock(&loop_ctl_mutex);
+
 	/*
 	 * Need not hold loop_ctl_mutex to fput backing file.
 	 * Calling fput holding loop_ctl_mutex triggers a circular
-- 
2.19.1

