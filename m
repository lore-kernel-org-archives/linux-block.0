Return-Path: <SRS0=4xm9=X2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96A61C352AA
	for <linux-block@archiver.kernel.org>; Tue,  1 Oct 2019 15:34:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69E3120842
	for <linux-block@archiver.kernel.org>; Tue,  1 Oct 2019 15:34:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389635AbfJAPeq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Oct 2019 11:34:46 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:7100 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727362AbfJAPeq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 1 Oct 2019 11:34:46 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x91FS7cR145777
        for <linux-block@vger.kernel.org>; Tue, 1 Oct 2019 11:34:45 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2vc7146bea-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-block@vger.kernel.org>; Tue, 01 Oct 2019 11:34:44 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-block@vger.kernel.org> from <sth@linux.ibm.com>;
        Tue, 1 Oct 2019 16:34:42 +0100
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 1 Oct 2019 16:34:41 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x91FYdgd44433788
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 1 Oct 2019 15:34:39 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9CB69A404D;
        Tue,  1 Oct 2019 15:34:39 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 83E80A4040;
        Tue,  1 Oct 2019 15:34:39 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue,  1 Oct 2019 15:34:39 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 20191)
        id 18221E060F; Tue,  1 Oct 2019 17:34:39 +0200 (CEST)
From:   Stefan Haberland <sth@linux.ibm.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, hoeppner@linux.ibm.com,
        linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com,
        gor@linux.ibm.com, borntraeger@de.ibm.com
Subject: [PATCH 2/2] Revert "s390/dasd: Add discard support for ESE volumes"
Date:   Tue,  1 Oct 2019 17:34:39 +0200
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191001153439.62672-1-sth@linux.ibm.com>
References: <20191001153439.62672-1-sth@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19100115-0020-0000-0000-000003740264
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19100115-0021-0000-0000-000021CA0264
Message-Id: <20191001153439.62672-3-sth@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-01_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910010138
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This reverts commit 7e64db1597fe114b83fe17d0ba96c6aa5fca419a.

The thin provisioning feature introduces an IOCTL and the discard support
to allow userspace tools and filesystems to release unused and previously
allocated space respectively.

During some internal performance improvements and further tests, the
release of allocated space revealed some issues that may lead to data
corruption in some configurations when filesystems are mounted with
discard support enabled.

While we're working on a fix and trying to clarify the situation,
this commit reverts the discard support for ESE volumes to prevent
potential data corruption.

Cc: <stable@vger.kernel.org> # 5.3
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
---
 drivers/s390/block/dasd_eckd.c | 57 ++--------------------------------
 1 file changed, 3 insertions(+), 54 deletions(-)

diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index b213c40d1a51..c94184d080f8 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -2055,9 +2055,6 @@ dasd_eckd_check_characteristics(struct dasd_device *device)
 	if (readonly)
 		set_bit(DASD_FLAG_DEVICE_RO, &device->flags);
 
-	if (dasd_eckd_is_ese(device))
-		dasd_set_feature(device->cdev, DASD_FEATURE_DISCARD, 1);
-
 	dev_info(&device->cdev->dev, "New DASD %04X/%02X (CU %04X/%02X) "
 		 "with %d cylinders, %d heads, %d sectors%s\n",
 		 private->rdc_data.dev_type,
@@ -3691,14 +3688,6 @@ static int dasd_eckd_release_space(struct dasd_device *device,
 		return -EINVAL;
 }
 
-static struct dasd_ccw_req *
-dasd_eckd_build_cp_discard(struct dasd_device *device, struct dasd_block *block,
-			   struct request *req, sector_t first_trk,
-			   sector_t last_trk)
-{
-	return dasd_eckd_dso_ras(device, block, req, first_trk, last_trk, 1);
-}
-
 static struct dasd_ccw_req *dasd_eckd_build_cp_cmd_single(
 					       struct dasd_device *startdev,
 					       struct dasd_block *block,
@@ -4443,10 +4432,6 @@ static struct dasd_ccw_req *dasd_eckd_build_cp(struct dasd_device *startdev,
 	cmdwtd = private->features.feature[12] & 0x40;
 	use_prefix = private->features.feature[8] & 0x01;
 
-	if (req_op(req) == REQ_OP_DISCARD)
-		return dasd_eckd_build_cp_discard(startdev, block, req,
-						  first_trk, last_trk);
-
 	cqr = NULL;
 	if (cdlspecial || dasd_page_cache) {
 		/* do nothing, just fall through to the cmd mode single case */
@@ -4725,14 +4710,12 @@ static struct dasd_ccw_req *dasd_eckd_build_alias_cp(struct dasd_device *base,
 						     struct dasd_block *block,
 						     struct request *req)
 {
-	struct dasd_device *startdev = NULL;
 	struct dasd_eckd_private *private;
-	struct dasd_ccw_req *cqr;
+	struct dasd_device *startdev;
 	unsigned long flags;
+	struct dasd_ccw_req *cqr;
 
-	/* Discard requests can only be processed on base devices */
-	if (req_op(req) != REQ_OP_DISCARD)
-		startdev = dasd_alias_get_start_dev(base);
+	startdev = dasd_alias_get_start_dev(base);
 	if (!startdev)
 		startdev = base;
 	private = startdev->private;
@@ -6513,20 +6496,8 @@ static void dasd_eckd_setup_blk_queue(struct dasd_block *block)
 	unsigned int logical_block_size = block->bp_block;
 	struct request_queue *q = block->request_queue;
 	struct dasd_device *device = block->base;
-	struct dasd_eckd_private *private;
-	unsigned int max_discard_sectors;
-	unsigned int max_bytes;
-	unsigned int ext_bytes; /* Extent Size in Bytes */
-	int recs_per_trk;
-	int trks_per_cyl;
-	int ext_limit;
-	int ext_size; /* Extent Size in Cylinders */
 	int max;
 
-	private = device->private;
-	trks_per_cyl = private->rdc_data.trk_per_cyl;
-	recs_per_trk = recs_per_track(&private->rdc_data, 0, logical_block_size);
-
 	if (device->features & DASD_FEATURE_USERAW) {
 		/*
 		 * the max_blocks value for raw_track access is 256
@@ -6547,28 +6518,6 @@ static void dasd_eckd_setup_blk_queue(struct dasd_block *block)
 	/* With page sized segments each segment can be translated into one idaw/tidaw */
 	blk_queue_max_segment_size(q, PAGE_SIZE);
 	blk_queue_segment_boundary(q, PAGE_SIZE - 1);
-
-	if (dasd_eckd_is_ese(device)) {
-		/*
-		 * Depending on the extent size, up to UINT_MAX bytes can be
-		 * accepted. However, neither DASD_ECKD_RAS_EXTS_MAX nor the
-		 * device limits should be exceeded.
-		 */
-		ext_size = dasd_eckd_ext_size(device);
-		ext_limit = min(private->real_cyl / ext_size, DASD_ECKD_RAS_EXTS_MAX);
-		ext_bytes = ext_size * trks_per_cyl * recs_per_trk *
-			logical_block_size;
-		max_bytes = UINT_MAX - (UINT_MAX % ext_bytes);
-		if (max_bytes / ext_bytes > ext_limit)
-			max_bytes = ext_bytes * ext_limit;
-
-		max_discard_sectors = max_bytes / 512;
-
-		blk_queue_max_discard_sectors(q, max_discard_sectors);
-		blk_queue_flag_set(QUEUE_FLAG_DISCARD, q);
-		q->limits.discard_granularity = ext_bytes;
-		q->limits.discard_alignment = ext_bytes;
-	}
 }
 
 static struct ccw_driver dasd_eckd_driver = {
-- 
2.17.1

