Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83796C46467
	for <linux-block@archiver.kernel.org>; Tue, 27 Dec 2022 19:10:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbiL0TKk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Dec 2022 14:10:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbiL0TK3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Dec 2022 14:10:29 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D91C8D2C3
        for <linux-block@vger.kernel.org>; Tue, 27 Dec 2022 11:10:26 -0800 (PST)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BR8bc89025139
        for <linux-block@vger.kernel.org>; Tue, 27 Dec 2022 11:10:26 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=s2048-2021-q4;
 bh=sHDzzlSOqsqkIE3dIKIATyyGzvSvZeQfGOq/jof0bHE=;
 b=b7hVaFnnc2DD3O8cmKyd7MyDoVSVBNf68mXSiLRWWFAkvTdh+oZ03T/M/UMOnlrmM4Nd
 d+c92ei3ZM19ex7HB7ov0+XJGhFHpOPnhC1q2/Xag9w5Q7KwXfWsUHhVxUYQ92nrwaWk
 xEwtN2VvhTDBw5Lsl8sdH7uXvXpzlAQBqwjeb0Px8Lmec9h7rsclVCVD2oQpsZ69Ixl1
 arl8gTjh8udKjuIUo3GcvSqUN4fatEAWPe3M8r66n0BVPbTkaf/yaidYmy1E61uRTlKL
 INYHUBV7NMK/FJS2oD+sM+0w53cxdS7bURIBN34/PeHYSRWM79iaOZadoEisH7GTCO7Y Nw== 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3mnwmwqkj4-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-block@vger.kernel.org>; Tue, 27 Dec 2022 11:10:26 -0800
Received: from twshared3750.06.ash8.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 27 Dec 2022 11:10:25 -0800
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
        id 18F8CDB09A57; Tue, 27 Dec 2022 11:10:12 -0800 (PST)
From:   Keith Busch <kbusch@meta.com>
To:     <linux-block@vger.kernel.org>, <axboe@kernel.dk>
CC:     <hch@lst.de>, <martin.petersen@oracle.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Keith Busch <kbusch@kernel.org>
Subject: [PATCHv3 1/2] block: make BLK_DEF_MAX_SECTORS unsigned
Date:   Tue, 27 Dec 2022 11:10:08 -0800
Message-ID: <20221227191009.2277326-1-kbusch@meta.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: xgDLkhRxTwhfym168cIfXNwtC0Nk0v1F
X-Proofpoint-GUID: xgDLkhRxTwhfym168cIfXNwtC0Nk0v1F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-27_15,2022-12-27_01,2022-06-22_01
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Keith Busch <kbusch@kernel.org>

This is used as an unsigned value, so define it that way to avoid
having to cast it.

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/blk-settings.c          | 2 +-
 drivers/block/null_blk/main.c | 3 +--
 include/linux/blkdev.h        | 3 ++-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index 0477c4d527fee..9875ca131eb0c 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -135,7 +135,7 @@ void blk_queue_max_hw_sectors(struct request_queue *q=
, unsigned int max_hw_secto
 	limits->max_hw_sectors =3D max_hw_sectors;
=20
 	max_sectors =3D min_not_zero(max_hw_sectors, limits->max_dev_sectors);
-	max_sectors =3D min_t(unsigned int, max_sectors, BLK_DEF_MAX_SECTORS);
+	max_sectors =3D min(max_sectors, BLK_DEF_MAX_SECTORS);
 	max_sectors =3D round_down(max_sectors,
 				 limits->logical_block_size >> SECTOR_SHIFT);
 	limits->max_sectors =3D max_sectors;
diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.=
c
index 7d28e3aa406c2..4c601ca9552a0 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -2123,8 +2123,7 @@ static int null_add_dev(struct nullb_device *dev)
 	blk_queue_physical_block_size(nullb->q, dev->blocksize);
 	if (!dev->max_sectors)
 		dev->max_sectors =3D queue_max_hw_sectors(nullb->q);
-	dev->max_sectors =3D min_t(unsigned int, dev->max_sectors,
-				 BLK_DEF_MAX_SECTORS);
+	dev->max_sectors =3D min(dev->max_sectors, BLK_DEF_MAX_SECTORS);
 	blk_queue_max_hw_sectors(nullb->q, dev->max_sectors);
=20
 	if (dev->virt_boundary)
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 301cf1cf4f2fa..69f7199d38da8 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1095,11 +1095,12 @@ static inline bool bdev_is_partition(struct block=
_device *bdev)
 enum blk_default_limits {
 	BLK_MAX_SEGMENTS	=3D 128,
 	BLK_SAFE_MAX_SECTORS	=3D 255,
-	BLK_DEF_MAX_SECTORS	=3D 2560,
 	BLK_MAX_SEGMENT_SIZE	=3D 65536,
 	BLK_SEG_BOUNDARY_MASK	=3D 0xFFFFFFFFUL,
 };
=20
+#define BLK_DEF_MAX_SECTORS 2560u
+
 static inline unsigned long queue_segment_boundary(const struct request_=
queue *q)
 {
 	return q->limits.seg_boundary_mask;
--=20
2.30.2

