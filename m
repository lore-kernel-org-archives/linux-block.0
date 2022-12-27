Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50BCFC4167B
	for <linux-block@archiver.kernel.org>; Tue, 27 Dec 2022 19:10:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbiL0TKj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Dec 2022 14:10:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231382AbiL0TK3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Dec 2022 14:10:29 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92FF6D11C
        for <linux-block@vger.kernel.org>; Tue, 27 Dec 2022 11:10:26 -0800 (PST)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BR8bc88025139
        for <linux-block@vger.kernel.org>; Tue, 27 Dec 2022 11:10:26 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=8lWMOo7s3t7bslmyj1hXmKHzRL4o6rShe7V090vN9jc=;
 b=WzRq8in02eZJidHiEliVyRBWF7YARK3GCVupt05rbI5Sn/9RkhcgD+s2yXCJNrn9kS99
 pLlWlOz1Hbee1TUFFeX4LJkTQhig0cIhiuw78Iun453NlHFzvFiYi4Ua8sLLa5x4zVRF
 CAOPUFbbjhdbwE2ZHEV5XTJV5ODtzvCTPkI8aYDLkx4uFfR4flcfXBBf/9G4MpR7dNMY
 OeLffxWmj/EeNs5VdiMHRSXSgcLFElvxXctPhREbCkxZjBsWO+pQDmXINA9fyjq1HrDr
 stsLsAV+ZH6AKg4mlyUDlgiWilXDwHgUi47KnTYcHmObB3x/UbjPBQkvlWUIhbddbbB/ vQ== 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3mnwmwqkj4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-block@vger.kernel.org>; Tue, 27 Dec 2022 11:10:26 -0800
Received: from twshared19053.17.frc2.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 27 Dec 2022 11:10:24 -0800
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
        id 25572DB09A59; Tue, 27 Dec 2022 11:10:12 -0800 (PST)
From:   Keith Busch <kbusch@meta.com>
To:     <linux-block@vger.kernel.org>, <axboe@kernel.dk>
CC:     <hch@lst.de>, <martin.petersen@oracle.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Keith Busch <kbusch@kernel.org>
Subject: [PATCHv3 2/2] block: save user max_sectors limit
Date:   Tue, 27 Dec 2022 11:10:09 -0800
Message-ID: <20221227191009.2277326-2-kbusch@meta.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221227191009.2277326-1-kbusch@meta.com>
References: <20221227191009.2277326-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: _visEPFhaQ4kEOLSQIqCe94dCImqryLl
X-Proofpoint-GUID: _visEPFhaQ4kEOLSQIqCe94dCImqryLl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-27_15,2022-12-27_01,2022-06-22_01
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Keith Busch <kbusch@kernel.org>

The user can set the max_sectors limit to any valid value via sysfs
/sys/block/<dev>/queue/max_sectors_kb attribute. If the device limits
are ever rescanned, though, the limit reverts back to the potentially
artificially low BLK_DEF_MAX_SECTORS value.

Preserve the user's setting as the max_sectors limit as long as it's
valid. The user can reset back to defaults by writing 0 to the sysfs
file.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
v2->v3:

  Added documentation update (Damien)

  Using the unsigned BLK_DEF_MAX_SECTORS (Christoph)

 Documentation/ABI/stable/sysfs-block |  3 ++-
 block/blk-settings.c                 |  9 +++++++--
 block/blk-sysfs.c                    | 13 ++++++++++---
 include/linux/blkdev.h               |  1 +
 4 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/Documentation/ABI/stable/sysfs-block b/Documentation/ABI/sta=
ble/sysfs-block
index cd14ecb3c9a5a..ac1e519272aa2 100644
--- a/Documentation/ABI/stable/sysfs-block
+++ b/Documentation/ABI/stable/sysfs-block
@@ -432,7 +432,8 @@ Contact:	linux-block@vger.kernel.org
 Description:
 		[RW] This is the maximum number of kilobytes that the block
 		layer will allow for a filesystem request. Must be smaller than
-		or equal to the maximum size allowed by the hardware.
+		or equal to the maximum size allowed by the hardware. Write 0
+		to use default kernel settings.
=20
=20
 What:		/sys/block/<disk>/queue/max_segment_size
diff --git a/block/blk-settings.c b/block/blk-settings.c
index 9875ca131eb0c..9c9713c9269cc 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -40,7 +40,7 @@ void blk_set_default_limits(struct queue_limits *lim)
 	lim->virt_boundary_mask =3D 0;
 	lim->max_segment_size =3D BLK_MAX_SEGMENT_SIZE;
 	lim->max_sectors =3D lim->max_hw_sectors =3D BLK_SAFE_MAX_SECTORS;
-	lim->max_dev_sectors =3D 0;
+	lim->max_user_sectors =3D lim->max_dev_sectors =3D 0;
 	lim->chunk_sectors =3D 0;
 	lim->max_write_zeroes_sectors =3D 0;
 	lim->max_zone_append_sectors =3D 0;
@@ -135,7 +135,12 @@ void blk_queue_max_hw_sectors(struct request_queue *=
q, unsigned int max_hw_secto
 	limits->max_hw_sectors =3D max_hw_sectors;
=20
 	max_sectors =3D min_not_zero(max_hw_sectors, limits->max_dev_sectors);
-	max_sectors =3D min(max_sectors, BLK_DEF_MAX_SECTORS);
+
+	if (limits->max_user_sectors)
+		max_sectors =3D min(max_sectors, limits->max_user_sectors);
+	else
+		max_sectors =3D min(max_sectors, BLK_DEF_MAX_SECTORS);
+
 	max_sectors =3D round_down(max_sectors,
 				 limits->logical_block_size >> SECTOR_SHIFT);
 	limits->max_sectors =3D max_sectors;
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 93d9e9c9a6ea8..e67acd859d072 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -249,9 +249,16 @@ queue_max_sectors_store(struct request_queue *q, con=
st char *page, size_t count)
=20
 	max_hw_sectors_kb =3D min_not_zero(max_hw_sectors_kb, (unsigned long)
 					 q->limits.max_dev_sectors >> 1);
-
-	if (max_sectors_kb > max_hw_sectors_kb || max_sectors_kb < page_kb)
-		return -EINVAL;
+	if (max_sectors_kb =3D=3D 0) {
+		q->limits.max_user_sectors =3D 0;
+		max_sectors_kb =3D min(max_hw_sectors_kb,
+				     BLK_DEF_MAX_SECTORS >> 1);
+	} else {
+		if (max_sectors_kb > max_hw_sectors_kb ||
+		    max_sectors_kb < page_kb)
+			return -EINVAL;
+		q->limits.max_user_sectors =3D max_sectors_kb << 1;
+	}
=20
 	spin_lock_irq(&q->queue_lock);
 	q->limits.max_sectors =3D max_sectors_kb << 1;
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 69f7199d38da8..8f5bb00d12ece 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -288,6 +288,7 @@ struct queue_limits {
 	unsigned int		max_dev_sectors;
 	unsigned int		chunk_sectors;
 	unsigned int		max_sectors;
+	unsigned int		max_user_sectors;
 	unsigned int		max_segment_size;
 	unsigned int		physical_block_size;
 	unsigned int		logical_block_size;
--=20
2.30.2

