Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B90CEC433FE
	for <linux-block@archiver.kernel.org>; Thu, 10 Nov 2022 18:46:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbiKJSqH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Nov 2022 13:46:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbiKJSqG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Nov 2022 13:46:06 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07B4B1005B
        for <linux-block@vger.kernel.org>; Thu, 10 Nov 2022 10:46:04 -0800 (PST)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2AAIf7Cx020213
        for <linux-block@vger.kernel.org>; Thu, 10 Nov 2022 10:46:04 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=t/1hhYaJpYvNHhaVQIuZetdlJs1ckoYF//KTiN2SMYY=;
 b=BG9gR5coBSh/xucDyhY2D8qzHpDLA0LUTGdfEBIEHTHqc5fKJKRTxxUEfXGL3DuhzxcF
 vWyxIZUnjQiI+zeKcW75MhW7kditVEmmvjASfPmplhP9DAUE61PIMLOZXzTGPyxuOfgm
 iEprJrqGAQWHktmxpzdTjRlhmR3FM9M89ed2mUn8nU7/x7EZBRhtjIhGJaUyiGA3FV0s
 h0f+94aXsmppnvE8pJzX1YHpq1XKmrY1uzzJUpc5KhuuHD+roD4R9galUjNF9a21jKUT
 T+XNuqZ7OFf1ucc0VpTyXHVls72FmYQkoXkzqF3Oq8aVcnHe7v2O+EswDYYioBJoZQzP xQ== 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ks34kj2fx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-block@vger.kernel.org>; Thu, 10 Nov 2022 10:46:04 -0800
Received: from snc-exhub201.TheFacebook.com (2620:10d:c085:21d::7) by
 snc-exhub204.TheFacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 10 Nov 2022 10:46:03 -0800
Received: from twshared27579.05.ash9.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 10 Nov 2022 10:45:33 -0800
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
        id C6B08B08CDEB; Thu, 10 Nov 2022 10:45:03 -0800 (PST)
From:   Keith Busch <kbusch@meta.com>
To:     <linux-block@vger.kernel.org>, <dm-devel@redhat.com>,
        <axboe@kernel.dk>
CC:     <stefanha@redhat.com>, <ebiggers@kernel.org>, <me@demsh.org>,
        <mpatocka@redhat.com>, Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCHv2 3/5] block: make blk_set_default_limits() private
Date:   Thu, 10 Nov 2022 10:44:59 -0800
Message-ID: <20221110184501.2451620-4-kbusch@meta.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221110184501.2451620-1-kbusch@meta.com>
References: <20221110184501.2451620-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: uGJz2WhY_ztAQ7K0A8UhMeEkZUw7CRZJ
X-Proofpoint-GUID: uGJz2WhY_ztAQ7K0A8UhMeEkZUw7CRZJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-10_12,2022-11-09_01,2022-06-22_01
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Keith Busch <kbusch@kernel.org>

There are no external users of this function.

Signed-off-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
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
index d6ea0d1a6db0..a186ea20f39d 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -331,6 +331,7 @@ void blk_rq_set_mixed_merge(struct request *rq);
 bool blk_rq_merge_ok(struct request *rq, struct bio *bio);
 enum elv_merge blk_try_merge(struct request *rq, struct bio *bio);
=20
+void blk_set_default_limits(struct queue_limits *lim);
 int blk_dev_init(void);
=20
 /*
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 9898e34b2c2d..891f8cbcd043 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -945,7 +945,6 @@ extern void blk_queue_io_min(struct request_queue *q,=
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

