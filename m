Return-Path: <SRS0=hB6L=Q5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C26AC43381
	for <linux-block@archiver.kernel.org>; Fri, 22 Feb 2019 14:07:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A55F207E0
	for <linux-block@archiver.kernel.org>; Fri, 22 Feb 2019 14:07:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GfF1/8sM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbfBVOHb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Feb 2019 09:07:31 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:43428 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbfBVOHa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Feb 2019 09:07:30 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1ME43i5017338;
        Fri, 22 Feb 2019 14:07:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=9B34j/FS9yVPGPhkLyq9uZEJGnTRNxE6DDWvhz4b2ZI=;
 b=GfF1/8sMjHybbmrXfdCNMHZufaysJZWOxy9bjKfTW/Re/gwb4W1ezAvF5k+WtN+nSShj
 kbHA3Q3E4hlhl0nr3Tjq7ih8CJSSL0cBfIwQFAwVzpS/mk9ojdrgbWN+cNNDWJEkCh/+
 bE8gkcCb4X90dZCQ2Ig98dTXWde8xFJ3PZP1W9gxfellxvyTGPz4x0Nj+gZCjwuyBExK
 Duw9o2LHDvn9xbeMl9IWa/P1ICDzHcJGZeLDpxx61RTENYWGUixIHgWSwXU3MrnOYDKX
 cFGqVjDJkuWmf5M6dbVBLur3ifh9d+AAy3xKLn0U3Jxmj493Y+34hhfuXaiwHp120fm1 6w== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2qpb5ryapf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Feb 2019 14:07:24 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x1ME7Ioo025381
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 Feb 2019 14:07:19 GMT
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x1ME7IkL009336;
        Fri, 22 Feb 2019 14:07:18 GMT
Received: from linux.cn.oracle.com (/10.182.69.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 22 Feb 2019 06:07:18 -0800
From:   Dongli Zhang <dongli.zhang@oracle.com>
To:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     jack@suse.cz
Subject: [PATCH v3 2/2] loop: set GENHD_FL_NO_PART_SCAN after blkdev_reread_part()
Date:   Fri, 22 Feb 2019 22:10:20 +0800
Message-Id: <1550844620-6550-3-git-send-email-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550844620-6550-1-git-send-email-dongli.zhang@oracle.com>
References: <1550844620-6550-1-git-send-email-dongli.zhang@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9174 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902220100
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
Reviewed-by: Jan Kara <jack@suse.cz>
---
Changed since v1:
  * move the setting of lo->lo_state to Lo_unbound after partscan has finished as well
    (suggested by Jan Kara)

Changed since v2:
  * Put the code inline in __loop_clr_fd() but not introduce new function
    (suggested by Jan Kara)

 drivers/block/loop.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 7908673..7ec3297 100644
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
@@ -1121,6 +1117,23 @@ static int __loop_clr_fd(struct loop_device *lo, bool release)
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
2.7.4

