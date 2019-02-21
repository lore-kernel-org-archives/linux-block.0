Return-Path: <SRS0=5S7O=Q4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E6C1C43381
	for <linux-block@archiver.kernel.org>; Thu, 21 Feb 2019 04:14:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5509D2070B
	for <linux-block@archiver.kernel.org>; Thu, 21 Feb 2019 04:14:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KQMahG9T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbfBUEOj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Feb 2019 23:14:39 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:45252 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727162AbfBUEOj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Feb 2019 23:14:39 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1L4E8qw056565;
        Thu, 21 Feb 2019 04:14:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=kLciAT+AyzRLAoa7LpOuXSr3oO5lyoPSVcEHLqmqO5o=;
 b=KQMahG9TjCbehGGe6D2iVH4BsJ2aXpc459im7IIjl0YYZ1watJLMkToGH4+Z35uZr5xz
 2cae4KLFM5C8d1O8lEicjzWjw/5rGrDI9dJYMJIIdWuV5MUZNJ4Ktw1H7i909LakDxuT
 ToOSGMatBQIlK+5Nuhr4KAyGYbe+CrK22Qh2XOv1b3yCbkwl+mjFBbSyebSqOtQDbEkr
 2dLp0WqWv6rMDrEd13JJ1U7i+IQevPlQGcqFkTF9s2se0Q3MF7HyCPwRK6hRd0pK17aI
 3fsD6kT0n2H/au7sS44uMP+PHIwbQIBkOclua5JhTFRZP61Xrc7djjC+P1h97Cydap5M yQ== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2qp9xu5m7a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Feb 2019 04:14:34 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x1L4EYY6007259
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Feb 2019 04:14:34 GMT
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x1L4EXPe015674;
        Thu, 21 Feb 2019 04:14:34 GMT
Received: from linux.cn.oracle.com (/10.182.69.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 20 Feb 2019 20:14:33 -0800
From:   Dongli Zhang <dongli.zhang@oracle.com>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     axboe@kernel.dk, jack@suse.cz
Subject: [PATCH 2/2] loop: set GENHD_FL_NO_PART_SCAN after blkdev_reread_part()
Date:   Thu, 21 Feb 2019 12:17:35 +0800
Message-Id: <1550722655-15102-3-git-send-email-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550722655-15102-1-git-send-email-dongli.zhang@oracle.com>
References: <1550722655-15102-1-git-send-email-dongli.zhang@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9173 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902210031
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

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
---
 drivers/block/loop.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 7908673..736e55b 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1034,6 +1034,15 @@ loop_init_xfer(struct loop_device *lo, struct loop_func_table *xfer,
 	return err;
 }
 
+static void loop_disable_partscan(struct loop_device *lo)
+{
+	mutex_lock(&loop_ctl_mutex);
+	lo->lo_flags = 0;
+	if (!part_shift)
+		lo->lo_disk->flags |= GENHD_FL_NO_PART_SCAN;
+	mutex_unlock(&loop_ctl_mutex);
+}
+
 static int __loop_clr_fd(struct loop_device *lo, bool release)
 {
 	struct file *filp = NULL;
@@ -1096,9 +1105,6 @@ static int __loop_clr_fd(struct loop_device *lo, bool release)
 
 	partscan = lo->lo_flags & LO_FLAGS_PARTSCAN && bdev;
 	lo_number = lo->lo_number;
-	lo->lo_flags = 0;
-	if (!part_shift)
-		lo->lo_disk->flags |= GENHD_FL_NO_PART_SCAN;
 	loop_unprepare_queue(lo);
 out_unlock:
 	mutex_unlock(&loop_ctl_mutex);
@@ -1121,6 +1127,9 @@ static int __loop_clr_fd(struct loop_device *lo, bool release)
 		/* Device is gone, no point in returning error */
 		err = 0;
 	}
+
+	loop_disable_partscan(lo);
+
 	/*
 	 * Need not hold loop_ctl_mutex to fput backing file.
 	 * Calling fput holding loop_ctl_mutex triggers a circular
-- 
2.7.4

