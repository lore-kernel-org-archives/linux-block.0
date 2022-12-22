Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5C2BC4332F
	for <linux-block@archiver.kernel.org>; Thu, 22 Dec 2022 17:52:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbiLVRwN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 22 Dec 2022 12:52:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbiLVRwM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Dec 2022 12:52:12 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55484B7CC
        for <linux-block@vger.kernel.org>; Thu, 22 Dec 2022 09:52:11 -0800 (PST)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BMHiaUR011753
        for <linux-block@vger.kernel.org>; Thu, 22 Dec 2022 09:52:10 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=s2048-2021-q4;
 bh=F65TMfIBR/GCVPxYnrLZEA/djWWUoUGXVl6copPTWZQ=;
 b=NurrL9d6r12JPMsnysxw3iOWWTi5aYIAYRzsuLLgMHJT0QlfUhTjO+PzD+9KDxnP8/l0
 czXxHYJZvC7q0Ypm9fsWGu26mdT51l/c+Av/UJcbmp0mO+LUEPDY3jAxi2Oatpm+GP4y
 pRjlltXOOYyzBkVDQVzm6Gbdzew8dycujZ/qde+ZURh393BoumTBkMfswQXQEQyBUDKD
 TgNgTahhK3V10IA48TJUha9uh5p+NOfqdbfzxtL2cwnW5mNB5HbzXScjsFBbxAqpuL4i
 P9UvKgocFXlYOUrL5vSQf6JLYmRl0JrHLHWAc/M/kcML4vxuG3Etb4CyqTRRTxfg7zHW jg== 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3mkx85jpb1-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-block@vger.kernel.org>; Thu, 22 Dec 2022 09:52:10 -0800
Received: from twshared41876.03.ash8.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 22 Dec 2022 09:52:09 -0800
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
        id 5E14DD60CAC5; Thu, 22 Dec 2022 09:52:04 -0800 (PST)
From:   Keith Busch <kbusch@meta.com>
To:     <linux-block@vger.kernel.org>, <axboe@kernel.dk>
CC:     <hch@lst.de>, <martin.petersen@oracle.com>,
        Keith Busch <kbusch@kernel.org>
Subject: [PATCH] block: save user max_sectors limit
Date:   Thu, 22 Dec 2022 09:52:04 -0800
Message-ID: <20221222175204.1782061-1-kbusch@meta.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: ZbJQED3_k8JO5nAwzg_djK8XacN75tlt
X-Proofpoint-GUID: ZbJQED3_k8JO5nAwzg_djK8XacN75tlt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-22_09,2022-12-22_03,2022-06-22_01
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Keith Busch <kbusch@kernel.org>

The user can set the max_sectors limit to any valid value via sysfs
/sys/block/<dev>/queue/max_sectors_kb attribute. If the device limits
are ever rescanned, though, the limit reverts back to the kernel defined
BLK_DEF_MAX_SECTORS limit.

Preserve the user's setting for the max_sectors limit as long as it's
valid. The user can reset back to defaults by writing 0 to the sysfs
file.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/blk-settings.c   |  9 +++++++--
 block/blk-sysfs.c      | 10 +++++++++-
 include/linux/blkdev.h |  1 +
 3 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index 0477c4d527fee..e75304f853bd5 100644
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
-	max_sectors =3D min_t(unsigned int, max_sectors, BLK_DEF_MAX_SECTORS);
+
+	if (limits->max_user_sectors)
+		max_sectors =3D min_not_zero(max_sectors, limits->max_user_sectors);
+	else
+		max_sectors =3D min_t(unsigned int, max_sectors, BLK_DEF_MAX_SECTORS);
+
 	max_sectors =3D round_down(max_sectors,
 				 limits->logical_block_size >> SECTOR_SHIFT);
 	limits->max_sectors =3D max_sectors;
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 93d9e9c9a6ea8..db5d1d908f5d9 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -250,8 +250,16 @@ queue_max_sectors_store(struct request_queue *q, con=
st char *page, size_t count)
 	max_hw_sectors_kb =3D min_not_zero(max_hw_sectors_kb, (unsigned long)
 					 q->limits.max_dev_sectors >> 1);
=20
-	if (max_sectors_kb > max_hw_sectors_kb || max_sectors_kb < page_kb)
+	if (max_sectors_kb =3D=3D 0) {
+		q->limits.max_user_sectors =3D 0;
+		max_sectors_kb =3D min_t(unsigned int, max_hw_sectors_kb,
+				       BLK_DEF_MAX_SECTORS >> 1);
+	} else if (max_sectors_kb > max_hw_sectors_kb ||
+		   max_sectors_kb < page_kb)  {
 		return -EINVAL;
+	} else {
+		q->limits.max_user_sectors =3D max_sectors_kb << 1;
+	}
=20
 	spin_lock_irq(&q->queue_lock);
 	q->limits.max_sectors =3D max_sectors_kb << 1;
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 301cf1cf4f2fa..71e97f0a87264 100644
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

