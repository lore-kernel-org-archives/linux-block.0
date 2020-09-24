Return-Path: <SRS0=VsgY=DB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B62BC4346E
	for <linux-block@archiver.kernel.org>; Thu, 24 Sep 2020 06:36:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 106D32376E
	for <linux-block@archiver.kernel.org>; Thu, 24 Sep 2020 06:36:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="bL3w7sQY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbgIXGgL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Sep 2020 02:36:11 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:61716 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726846AbgIXGgK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Sep 2020 02:36:10 -0400
X-Greylist: delayed 586 seconds by postgrey-1.27 at vger.kernel.org; Thu, 24 Sep 2020 02:36:08 EDT
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20200924062621epoutp02ccb3872d4e9f596dd9e4892c88b77e45~3pD6TVDQL2173321733epoutp02D
        for <linux-block@vger.kernel.org>; Thu, 24 Sep 2020 06:26:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20200924062621epoutp02ccb3872d4e9f596dd9e4892c88b77e45~3pD6TVDQL2173321733epoutp02D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1600928781;
        bh=HeG8aWIhrEZAkwa+FxAXC7YWSPKTr7bHhw/QbTWCtwM=;
        h=From:To:Cc:Subject:Date:References:From;
        b=bL3w7sQYb+lBv/HX/YetnXyYnBwy56J/UoXncCwKerDVSXbuk3m1MU2XsT6NfVzRX
         9idrFnsXf+H+oG5AL6tn0FupXBSW+SaRupWUx9rjjtQC+vHc0TChj2ND5XLksIBDrn
         0UMfP6oDQbFZoiC65qz4FAs8ZwgvbsxenfA6WBpI=
Received: from epsmges5p1new.samsung.com (unknown [182.195.42.73]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20200924062620epcas5p1b0570884dc857e5200e3166a7d7520f2~3pD5zLu-52615526155epcas5p15;
        Thu, 24 Sep 2020 06:26:20 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F3.0A.09573.C0C3C6F5; Thu, 24 Sep 2020 15:26:20 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20200924062620epcas5p2f0468a1f41d4177ce15727c519bfbad5~3pD5W54YT2598725987epcas5p2Z;
        Thu, 24 Sep 2020 06:26:20 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200924062620epsmtrp283f870e843077d49575bd861df355d9b~3pD5WIu7h2884828848epsmtrp2C;
        Thu, 24 Sep 2020 06:26:20 +0000 (GMT)
X-AuditID: b6c32a49-a7dff70000002565-62-5f6c3c0c263f
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        86.D7.08604.C0C3C6F5; Thu, 24 Sep 2020 15:26:20 +0900 (KST)
Received: from localhost.localdomain (unknown [107.110.206.5]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200924062618epsmtip17b0514c65dfb6d55c6b274b31a756c33~3pD3-kH8V2751627516epsmtip1B;
        Thu, 24 Sep 2020 06:26:18 +0000 (GMT)
From:   Kanchan Joshi <joshi.k@samsung.com>
To:     axboe@kernel.dk, Damien.LeMoal@wdc.com
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        selvakuma.s1@samsung.com, nj.shetty@samsung.com,
        javier.gonz@samsung.com, Kanchan Joshi <joshi.k@samsung.com>
Subject: [PATCH] null_blk: synchronization fix for zoned device
Date:   Thu, 24 Sep 2020 11:51:36 +0530
Message-Id: <20200924062136.47019-1-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrHIsWRmVeSWpSXmKPExsWy7bCmli6PTU68wemH8har7/azWbS2f2Oy
        eHznM7vF0f9v2Sz23tK2uLxrDpvFtt/zmS2uTFnEbPH6x0k2B06Py2dLPfq2rGL0+LxJzqP9
        QDdTAEsUl01Kak5mWWqRvl0CV8b0Z0+ZCxrMK2Ze2czUwPhDu4uRk0NCwESi++10pi5GLg4h
        gd2MEpMXvmUCSQgJfGKUONujBJH4xiixZMt6oAQHWMeHCWEQ8b2MEkf2LYDq/swoMefdfjaQ
        IjYBTYkLk0tBBokIaEks3drIBlLDLLABqKb7GBtIQljAXmLCpHtgNouAqsTu3n4WEJtXwELi
        4v5TLBDnyUvMvPSdHSIuKHFy5hOwODNQvHnrbGaQoRIC19gltvT9YIZocJHYOn8VO4QtLPHq
        +BYoW0ri87u9bBB2scSvO0ehmjsYJa43zITaZi9xcc9fsDeZgT5Yv0sfYhmfRO/vJ1Df80p0
        tAlBVCtK3Jv0lBXCFpd4OGMJlO0h0dq+jRESirESH+ZtY5vAKDcLyQuzkLwwC2HZAkbmVYyS
        qQXFuempxaYFhnmp5XrFibnFpXnpesn5uZsYwUlEy3MH490HH/QOMTJxMB5ilOBgVhLhvaGW
        HS/Em5JYWZValB9fVJqTWnyIUZqDRUmcV+nHmTghgfTEktTs1NSC1CKYLBMHp1QDk8wZ83dV
        x1asj/k95eJai9oNvfuUjbmMrofstvfb3uTdySzjcC7Hu3AZRzjLpL3xqmeqFnT3HN+zx/+t
        H2fYQznWl+GlL15/P2XiHjl3nk+ohqzKyxzln1f3l311dw3+VcD59GnavavXXszbdiuXNTrX
        eocHh/7c35wz2upZC5cf0gm8Wer9fOmnk6x37v/W2Oy700mtLqN/gna0ia2nRQzbqo37av98
        /lTx/M6K/z2fwqY6ZXYrbu3YusWy5vQ9q8P3drXcl0i6+Sydj40v0sf1FPcf3lXPFOtsujmS
        zzAoJf9fYRRof1rIdc2lJzwRLZwZl0olbqnkXxWPfno2zGeRmdvqvnmJd7dUvD/0X4mlOCPR
        UIu5qDgRAFlxitWRAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrILMWRmVeSWpSXmKPExsWy7bCSnC6PTU68wfnZ7Bar7/azWbS2f2Oy
        eHznM7vF0f9v2Sz23tK2uLxrDpvFtt/zmS2uTFnEbPH6x0k2B06Py2dLPfq2rGL0+LxJzqP9
        QDdTAEsUl01Kak5mWWqRvl0CV8b0Z0+ZCxrMK2Ze2czUwPhDu4uRg0NCwETiw4SwLkYuDiGB
        3YwSMzYdYOxi5ASKi0s0X/vBDmELS6z895wdougjo8TS82tZQZrZBDQlLkwuBakREdCR2Pex
        jQWkhllgG6PEgzWr2UASwgL2EhMm3QOzWQRUJXb39rOA2LwCFhIX959igVggLzHz0nd2iLig
        xMmZT8DizEDx5q2zmScw8s1CkpqFJLWAkWkVo2RqQXFuem6xYYFhXmq5XnFibnFpXrpecn7u
        JkZwqGpp7mDcvuqD3iFGJg7GQ4wSHMxKIrw31LLjhXhTEiurUovy44tKc1KLDzFKc7AoifPe
        KFwYJySQnliSmp2aWpBaBJNl4uCUamCqq2N5MPPSu7RfLGYTN8td61R6p1G9QHsue1jRg3NH
        sucHXd8+g+mIbETHDy2pqecdUj7GRbkwsBhxcZy/ciJ0E/cvhcXnJ7k82S1fsZPvquPE3Td/
        HvL27dNcLBQXsKdC/LnOqmc81y8Xb4nTunL709ZbLjFqn/feFTyTezbp+cnfyxS/WW8+9qX7
        kJTDr4y1hSueT91lECCxL+mp2NFfz+1vd2es2dL3YpJjkl1RtpQXd9aLqJ0Pet6lfzs092ml
        vs7tiYwuIQyfA3+qzci0jF+TlKfhsr1Q3mLmw4UaQb+aPrqte3Bb+Ev/qe61S+3vy0x+uN3o
        QUFZ3GfjZyeFOftZf1ZYbDn6Jer+3UV7WpRYijMSDbWYi4oTAWjSMePEAgAA
X-CMS-MailID: 20200924062620epcas5p2f0468a1f41d4177ce15727c519bfbad5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CMS-RootMailID: 20200924062620epcas5p2f0468a1f41d4177ce15727c519bfbad5
References: <CGME20200924062620epcas5p2f0468a1f41d4177ce15727c519bfbad5@epcas5p2.samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Parallel write,read,zone-mgmt operations accessing/altering zone state
and write-pointer may get into race. Avoid the situation by using a new
spinlock for zoned device.
Concurrent zone-appends (on a zone) returning same write-pointer issue
is also avoided using this lock.

Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
---
 drivers/block/null_blk.h       |  1 +
 drivers/block/null_blk_zoned.c | 84 +++++++++++++++++++++++-----------
 2 files changed, 58 insertions(+), 27 deletions(-)

diff --git a/drivers/block/null_blk.h b/drivers/block/null_blk.h
index daed4a9c3436..b3f4d62e7c38 100644
--- a/drivers/block/null_blk.h
+++ b/drivers/block/null_blk.h
@@ -44,6 +44,7 @@ struct nullb_device {
 	unsigned int nr_zones;
 	struct blk_zone *zones;
 	sector_t zone_size_sects;
+	spinlock_t zlock;
 
 	unsigned long size; /* device size in MB */
 	unsigned long completion_nsec; /* time in ns to complete a request */
diff --git a/drivers/block/null_blk_zoned.c b/drivers/block/null_blk_zoned.c
index 3d25c9ad2383..04fbf267703a 100644
--- a/drivers/block/null_blk_zoned.c
+++ b/drivers/block/null_blk_zoned.c
@@ -45,6 +45,7 @@ int null_init_zoned_dev(struct nullb_device *dev, struct request_queue *q)
 	if (!dev->zones)
 		return -ENOMEM;
 
+	spin_lock_init(&dev->zlock);
 	if (dev->zone_nr_conv >= dev->nr_zones) {
 		dev->zone_nr_conv = dev->nr_zones - 1;
 		pr_info("changed the number of conventional zones to %u",
@@ -124,6 +125,7 @@ int null_report_zones(struct gendisk *disk, sector_t sector,
 	nr_zones = min(nr_zones, dev->nr_zones - first_zone);
 	trace_nullb_report_zones(nullb, nr_zones);
 
+	spin_lock_irq(&dev->zlock);
 	for (i = 0; i < nr_zones; i++) {
 		/*
 		 * Stacked DM target drivers will remap the zone information by
@@ -134,10 +136,13 @@ int null_report_zones(struct gendisk *disk, sector_t sector,
 		memcpy(&zone, &dev->zones[first_zone + i],
 		       sizeof(struct blk_zone));
 		error = cb(&zone, i, data);
-		if (error)
+		if (error) {
+			spin_unlock_irq(&dev->zlock);
 			return error;
+		}
 	}
 
+	spin_unlock_irq(&dev->zlock);
 	return nr_zones;
 }
 
@@ -147,16 +152,24 @@ size_t null_zone_valid_read_len(struct nullb *nullb,
 	struct nullb_device *dev = nullb->dev;
 	struct blk_zone *zone = &dev->zones[null_zone_no(dev, sector)];
 	unsigned int nr_sectors = len >> SECTOR_SHIFT;
+	size_t ret = 0;
 
+	spin_lock_irq(&dev->zlock);
 	/* Read must be below the write pointer position */
 	if (zone->type == BLK_ZONE_TYPE_CONVENTIONAL ||
-	    sector + nr_sectors <= zone->wp)
-		return len;
+	    sector + nr_sectors <= zone->wp) {
+		ret = len;
+		goto out_unlock;
+	}
 
 	if (sector > zone->wp)
-		return 0;
+		goto out_unlock;
+
+	ret = (zone->wp - sector) << SECTOR_SHIFT;
 
-	return (zone->wp - sector) << SECTOR_SHIFT;
+out_unlock:
+	spin_unlock_irq(&dev->zlock);
+	return ret;
 }
 
 static blk_status_t null_zone_write(struct nullb_cmd *cmd, sector_t sector,
@@ -165,17 +178,19 @@ static blk_status_t null_zone_write(struct nullb_cmd *cmd, sector_t sector,
 	struct nullb_device *dev = cmd->nq->dev;
 	unsigned int zno = null_zone_no(dev, sector);
 	struct blk_zone *zone = &dev->zones[zno];
-	blk_status_t ret;
+	blk_status_t ret = BLK_STS_OK;
 
 	trace_nullb_zone_op(cmd, zno, zone->cond);
 
 	if (zone->type == BLK_ZONE_TYPE_CONVENTIONAL)
 		return null_process_cmd(cmd, REQ_OP_WRITE, sector, nr_sectors);
 
+	spin_lock_irq(&dev->zlock);
 	switch (zone->cond) {
 	case BLK_ZONE_COND_FULL:
 		/* Cannot write to a full zone */
-		return BLK_STS_IOERR;
+		ret = BLK_STS_IOERR;
+		break;
 	case BLK_ZONE_COND_EMPTY:
 	case BLK_ZONE_COND_IMP_OPEN:
 	case BLK_ZONE_COND_EXP_OPEN:
@@ -193,27 +208,33 @@ static blk_status_t null_zone_write(struct nullb_cmd *cmd, sector_t sector,
 			else
 				cmd->rq->__sector = sector;
 		} else if (sector != zone->wp) {
-			return BLK_STS_IOERR;
+			ret = BLK_STS_IOERR;
+			break;
 		}
 
-		if (zone->wp + nr_sectors > zone->start + zone->capacity)
-			return BLK_STS_IOERR;
+		if (zone->wp + nr_sectors > zone->start + zone->capacity) {
+			ret = BLK_STS_IOERR;
+			break;
+		}
 
 		if (zone->cond != BLK_ZONE_COND_EXP_OPEN)
 			zone->cond = BLK_ZONE_COND_IMP_OPEN;
 
 		ret = null_process_cmd(cmd, REQ_OP_WRITE, sector, nr_sectors);
 		if (ret != BLK_STS_OK)
-			return ret;
+			break;
 
 		zone->wp += nr_sectors;
 		if (zone->wp == zone->start + zone->capacity)
 			zone->cond = BLK_ZONE_COND_FULL;
-		return BLK_STS_OK;
+		break;
 	default:
 		/* Invalid zone condition */
-		return BLK_STS_IOERR;
+		ret = BLK_STS_IOERR;
 	}
+
+	spin_unlock_irq(&dev->zlock);
+	return ret;
 }
 
 static blk_status_t null_zone_mgmt(struct nullb_cmd *cmd, enum req_opf op,
@@ -223,7 +244,9 @@ static blk_status_t null_zone_mgmt(struct nullb_cmd *cmd, enum req_opf op,
 	unsigned int zone_no = null_zone_no(dev, sector);
 	struct blk_zone *zone = &dev->zones[zone_no];
 	size_t i;
+	blk_status_t ret = BLK_STS_OK;
 
+	spin_lock_irq(&dev->zlock);
 	switch (op) {
 	case REQ_OP_ZONE_RESET_ALL:
 		for (i = 0; i < dev->nr_zones; i++) {
@@ -234,25 +257,29 @@ static blk_status_t null_zone_mgmt(struct nullb_cmd *cmd, enum req_opf op,
 		}
 		break;
 	case REQ_OP_ZONE_RESET:
-		if (zone->type == BLK_ZONE_TYPE_CONVENTIONAL)
-			return BLK_STS_IOERR;
+		if (zone->type == BLK_ZONE_TYPE_CONVENTIONAL) {
+			ret = BLK_STS_IOERR;
+			break;
+		}
 
 		zone->cond = BLK_ZONE_COND_EMPTY;
 		zone->wp = zone->start;
 		break;
 	case REQ_OP_ZONE_OPEN:
-		if (zone->type == BLK_ZONE_TYPE_CONVENTIONAL)
-			return BLK_STS_IOERR;
-		if (zone->cond == BLK_ZONE_COND_FULL)
-			return BLK_STS_IOERR;
+		if (zone->type == BLK_ZONE_TYPE_CONVENTIONAL ||
+				zone->cond == BLK_ZONE_COND_FULL) {
+			ret = BLK_STS_IOERR;
+			break;
+		}
 
 		zone->cond = BLK_ZONE_COND_EXP_OPEN;
 		break;
 	case REQ_OP_ZONE_CLOSE:
-		if (zone->type == BLK_ZONE_TYPE_CONVENTIONAL)
-			return BLK_STS_IOERR;
-		if (zone->cond == BLK_ZONE_COND_FULL)
-			return BLK_STS_IOERR;
+		if (zone->type == BLK_ZONE_TYPE_CONVENTIONAL ||
+				zone->cond == BLK_ZONE_COND_FULL) {
+			ret = BLK_STS_IOERR;
+			break;
+		}
 
 		if (zone->wp == zone->start)
 			zone->cond = BLK_ZONE_COND_EMPTY;
@@ -260,18 +287,21 @@ static blk_status_t null_zone_mgmt(struct nullb_cmd *cmd, enum req_opf op,
 			zone->cond = BLK_ZONE_COND_CLOSED;
 		break;
 	case REQ_OP_ZONE_FINISH:
-		if (zone->type == BLK_ZONE_TYPE_CONVENTIONAL)
-			return BLK_STS_IOERR;
+		if (zone->type == BLK_ZONE_TYPE_CONVENTIONAL) {
+			ret = BLK_STS_IOERR;
+			break;
+		}
 
 		zone->cond = BLK_ZONE_COND_FULL;
 		zone->wp = zone->start + zone->len;
 		break;
 	default:
-		return BLK_STS_NOTSUPP;
+		ret = BLK_STS_NOTSUPP;
 	}
 
+	spin_unlock_irq(&dev->zlock);
 	trace_nullb_zone_op(cmd, zone_no, zone->cond);
-	return BLK_STS_OK;
+	return ret;
 }
 
 blk_status_t null_process_zoned_cmd(struct nullb_cmd *cmd, enum req_opf op,
-- 
2.25.1

