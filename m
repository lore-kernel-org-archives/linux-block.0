Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23178C433FE
	for <linux-block@archiver.kernel.org>; Thu,  3 Nov 2022 15:26:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbiKCP0O (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 3 Nov 2022 11:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231404AbiKCP0N (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 3 Nov 2022 11:26:13 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 477EC1A234
        for <linux-block@vger.kernel.org>; Thu,  3 Nov 2022 08:26:12 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A3EpUfr014639
        for <linux-block@vger.kernel.org>; Thu, 3 Nov 2022 08:26:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=B4kQCEO7e1uaX4xOqHmVbkBneaeAJi2KeOM4H2ft5PE=;
 b=OhYPCjP8+88uPuXH4sviHYSfMgTE1FfzVB/AwTzYt1ndtIR7yOK5HqrliXbEPYGSd37z
 q5+wnIFk/Mbq9mCwT7dPVvzrH4/lD0toEc5E4MhgBf6bf2+mXf28LNXFLcdL1R3R6PEL
 5xlt/QvrSI8qu9sTj37gGBIEQJc7lo1Z+oG33cWDGOVuWYkKPOio504baf05vSmudbVi
 ojXCt+PI5/sj42jQRcLEdMA7pXzqQ1Ju5pS+XWK11I4vCNBgteiwtxP3f/Rr+oeYGQdr
 3H/L0c6X2DdwW3DTPaYmjzaJRRS202o0fXKTtqA79OoJhV4G4FKnlCeI6Y/H2iE/AlcM mQ== 
Received: from maileast.thefacebook.com ([163.114.130.3])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3kkva1a8hy-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-block@vger.kernel.org>; Thu, 03 Nov 2022 08:26:10 -0700
Received: from twshared14438.02.ash8.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 3 Nov 2022 08:26:09 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
        id BA164AA9A07E; Thu,  3 Nov 2022 08:26:00 -0700 (PDT)
From:   Keith Busch <kbusch@meta.com>
To:     <linux-block@vger.kernel.org>, <dm-devel@redhat.com>,
        <axboe@kernel.dk>
CC:     <stefanha@redhat.com>, <ebiggers@kernel.org>, <me@demsh.org>,
        <mpatocka@redhat.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH 3/3] block: make blk_set_default_limits() private
Date:   Thu, 3 Nov 2022 08:25:59 -0700
Message-ID: <20221103152559.1909328-4-kbusch@meta.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221103152559.1909328-1-kbusch@meta.com>
References: <20221103152559.1909328-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: Z4luO0HVsW2z_gTgxW_f9tBsSsEmtdqM
X-Proofpoint-ORIG-GUID: Z4luO0HVsW2z_gTgxW_f9tBsSsEmtdqM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-03_04,2022-11-03_01,2022-06-22_01
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Keith Busch <kbusch@kernel.org>

There are no external users of this function.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/blk-settings.c   | 1 -
 block/blk.h            | 1 +
 include/linux/blkdev.h | 1 -
 3 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index 4949ed3ce7c9..8ac1038d0c79 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -59,7 +59,6 @@ void blk_set_default_limits(struct queue_limits *lim)
 	lim->zone_write_granularity =3D 0;
 	lim->dma_alignment =3D 511;
 }
-EXPORT_SYMBOL(blk_set_default_limits);
=20
 /**
  * blk_set_stacking_limits - set default limits for stacking devices
diff --git a/block/blk.h b/block/blk.h
index d259d1da4cb4..4849a2efa4c5 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -330,6 +330,7 @@ void blk_rq_set_mixed_merge(struct request *rq);
 bool blk_rq_merge_ok(struct request *rq, struct bio *bio);
 enum elv_merge blk_try_merge(struct request *rq, struct bio *bio);
=20
+void blk_set_default_limits(struct queue_limits *lim);
 int blk_dev_init(void);
=20
 /*
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 69ee5ea29e2f..704bc175a732 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -939,7 +939,6 @@ extern void blk_queue_io_min(struct request_queue *q,=
 unsigned int min);
 extern void blk_limits_io_opt(struct queue_limits *limits, unsigned int =
opt);
 extern void blk_queue_io_opt(struct request_queue *q, unsigned int opt);
 extern void blk_set_queue_depth(struct request_queue *q, unsigned int de=
pth);
-extern void blk_set_default_limits(struct queue_limits *lim);
 extern void blk_set_stacking_limits(struct queue_limits *lim);
 extern int blk_stack_limits(struct queue_limits *t, struct queue_limits =
*b,
 			    sector_t offset);
--=20
2.30.2

