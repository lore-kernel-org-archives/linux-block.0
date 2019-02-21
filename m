Return-Path: <SRS0=5S7O=Q4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C44EAC43381
	for <linux-block@archiver.kernel.org>; Thu, 21 Feb 2019 15:30:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9394D20842
	for <linux-block@archiver.kernel.org>; Thu, 21 Feb 2019 15:30:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="o/aNC0UP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725832AbfBUPar (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Feb 2019 10:30:47 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:58828 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728305AbfBUPaq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Feb 2019 10:30:46 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1LFSs5p034479;
        Thu, 21 Feb 2019 15:30:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=0jr6pMmYk/w6OiYL4H77HqpSIEDJZp1hkdQy563ts0s=;
 b=o/aNC0UPOKotLTSwo7NaxHoNNLBJw8AGXPk/kffNlego7EzHLhV1BN8NeAcHP290LrlV
 s/u2FN2RPreBg6707yTeY7jLwUuME83tugWUAZotGaQNa+YmNlCoEKm4yP7Ahf3gAErX
 xOgxXzT2jGsnWLswsB+eFvg4EaJ3He+zXzSZgfdsoQuGhuKd/sG2EhKTDj6OU7/YGFwV
 XWocZn3FoyuAnjVkox35cchMjK123ew1F3LgBQfk+iqxf5kODhAVUm5heM8ryzT69iYH
 YdXItaFlw/KIN/uC3KR7+YmdkGZMmf+w5T5mhRnbk0CAwc2I871+TYEJiA1nD0wt3zWo Fg== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2qpb5rrmja-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Feb 2019 15:30:42 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x1LFUffC002005
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 21 Feb 2019 15:30:42 GMT
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x1LFUfBc006545;
        Thu, 21 Feb 2019 15:30:41 GMT
Received: from linux.cn.oracle.com (/10.182.69.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 21 Feb 2019 07:30:41 -0800
From:   Dongli Zhang <dongli.zhang@oracle.com>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     axboe@kernel.dk, jack@suse.cz
Subject: [PATCH v2 2/2] loop: set GENHD_FL_NO_PART_SCAN after blkdev_reread_part()
Date:   Thu, 21 Feb 2019 23:33:43 +0800
Message-Id: <1550763223-21764-3-git-send-email-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550763223-21764-1-git-send-email-dongli.zhang@oracle.com>
References: <1550763223-21764-1-git-send-email-dongli.zhang@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9174 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902210112
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
Changed since v1:
  * move the setting of lo->lo_state to Lo_unbound after partscan has finished as well
    (suggested by Jan Kara)

 drivers/block/loop.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 7908673..a13f5dc 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1034,6 +1034,16 @@ loop_init_xfer(struct loop_device *lo, struct loop_func_table *xfer,
 	return err;
 }
 
+static void loop_disable_partscan(struct loop_device *lo)
+{
+	mutex_lock(&loop_ctl_mutex);
+	lo->lo_flags = 0;
+	if (!part_shift)
+		lo->lo_disk->flags |= GENHD_FL_NO_PART_SCAN;
+	lo->lo_state = Lo_unbound;
+	mutex_unlock(&loop_ctl_mutex);
+}
+
 static int __loop_clr_fd(struct loop_device *lo, bool release)
 {
 	struct file *filp = NULL;
@@ -1089,16 +1099,12 @@ static int __loop_clr_fd(struct loop_device *lo, bool release)
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
@@ -1121,6 +1127,18 @@ static int __loop_clr_fd(struct loop_device *lo, bool release)
 		/* Device is gone, no point in returning error */
 		err = 0;
 	}
+
+	/*
+	 * lo->lo_state is set to Lo_unbound inside loop_disable_partscan()
+	 * here after above partscan has finished.
+	 *
+	 * There cannot be anybody else entering __loop_clr_fd() as
+	 * lo->lo_backing_file is already cleared and Lo_rundown state
+	 * protects us from all the other places trying to change the 'lo'
+	 * device.
+	 */
+	loop_disable_partscan(lo);
+
 	/*
 	 * Need not hold loop_ctl_mutex to fput backing file.
 	 * Calling fput holding loop_ctl_mutex triggers a circular
-- 
2.7.4

