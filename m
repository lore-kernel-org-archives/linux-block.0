Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 590A0C43219
	for <linux-block@archiver.kernel.org>; Thu,  3 Nov 2022 15:26:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231484AbiKCP0R (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 3 Nov 2022 11:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231544AbiKCP0P (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 3 Nov 2022 11:26:15 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 569A222C
        for <linux-block@vger.kernel.org>; Thu,  3 Nov 2022 08:26:14 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A3CAdCH010471
        for <linux-block@vger.kernel.org>; Thu, 3 Nov 2022 08:26:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=VRuJvXeK/qEkN/Gz3nNXuaOmUIBiKtT2mf4BKmu/TR8=;
 b=ONishvUOt71bIdKPstDsIY36NzfbO1FOtWI3cBE0OsRpV6EGkjHTy71axBOYQd5OPQ41
 UsE3P3HujBXqx6N//JhftFb2LKR7gV804sdTW7JXI/60FohLBwvu64obtyp3RaqIktca
 TMiiNpOVRy+QOVHSloLj2teBNuNfdHJeK1do1SjEtR1QXUmUhc9EZbF4hTDHGcRl/+3v
 ddxXnCkrS14jhg/Om6s9iFvZ7C6M6Mvdd4VB+0OMmQs2QGef/FhdHlEEG3dozHIgOgtk
 GngjihC6HTjHW37wQv/SOoFFM+c1EBT/o6C3hKEpZ1RizGSou4tc+zbMAlcpKtC8NLfP wA== 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3kmddh1kqu-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-block@vger.kernel.org>; Thu, 03 Nov 2022 08:26:13 -0700
Received: from twshared6758.06.ash9.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 3 Nov 2022 08:26:12 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
        id 216FFAA9A075; Thu,  3 Nov 2022 08:26:00 -0700 (PDT)
From:   Keith Busch <kbusch@meta.com>
To:     <linux-block@vger.kernel.org>, <dm-devel@redhat.com>,
        <axboe@kernel.dk>
CC:     <stefanha@redhat.com>, <ebiggers@kernel.org>, <me@demsh.org>,
        <mpatocka@redhat.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH 1/3] block: make dma_alignment a stacking queue_limit
Date:   Thu, 3 Nov 2022 08:25:57 -0700
Message-ID: <20221103152559.1909328-2-kbusch@meta.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221103152559.1909328-1-kbusch@meta.com>
References: <20221103152559.1909328-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 1kMdJqFEVu7TgVM0V8LXDvKd-UOTAYms
X-Proofpoint-GUID: 1kMdJqFEVu7TgVM0V8LXDvKd-UOTAYms
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-03_04,2022-11-03_01,2022-06-22_01
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Keith Busch <kbusch@kernel.org>

Device mappers had always been getting the default 511 dma mask, but
the underlying device might have a larger alignment requirement. Since
this value is used to determine alloweable direct-io alignment, this
needs to be a stackable limit.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/blk-core.c       |  1 -
 block/blk-settings.c   |  8 +++++---
 include/linux/blkdev.h | 15 ++++++++-------
 3 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 3a2ed8dadf73..9d6a947024ea 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -418,7 +418,6 @@ struct request_queue *blk_alloc_queue(int node_id)
 				PERCPU_REF_INIT_ATOMIC, GFP_KERNEL))
 		goto fail_stats;
=20
-	blk_queue_dma_alignment(q, 511);
 	blk_set_default_limits(&q->limits);
 	q->nr_requests =3D BLKDEV_DEFAULT_RQ;
=20
diff --git a/block/blk-settings.c b/block/blk-settings.c
index 8bb9eef5310e..4949ed3ce7c9 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -57,6 +57,7 @@ void blk_set_default_limits(struct queue_limits *lim)
 	lim->misaligned =3D 0;
 	lim->zoned =3D BLK_ZONED_NONE;
 	lim->zone_write_granularity =3D 0;
+	lim->dma_alignment =3D 511;
 }
 EXPORT_SYMBOL(blk_set_default_limits);
=20
@@ -600,6 +601,7 @@ int blk_stack_limits(struct queue_limits *t, struct q=
ueue_limits *b,
=20
 	t->io_min =3D max(t->io_min, b->io_min);
 	t->io_opt =3D lcm_not_zero(t->io_opt, b->io_opt);
+	t->dma_alignment =3D max(t->dma_alignment, b->dma_alignment);
=20
 	/* Set non-power-of-2 compatible chunk_sectors boundary */
 	if (b->chunk_sectors)
@@ -773,7 +775,7 @@ EXPORT_SYMBOL(blk_queue_virt_boundary);
  **/
 void blk_queue_dma_alignment(struct request_queue *q, int mask)
 {
-	q->dma_alignment =3D mask;
+	q->limits.dma_alignment =3D mask;
 }
 EXPORT_SYMBOL(blk_queue_dma_alignment);
=20
@@ -795,8 +797,8 @@ void blk_queue_update_dma_alignment(struct request_qu=
eue *q, int mask)
 {
 	BUG_ON(mask > PAGE_SIZE);
=20
-	if (mask > q->dma_alignment)
-		q->dma_alignment =3D mask;
+	if (mask > q->limits.dma_alignment)
+		q->limits.dma_alignment =3D mask;
 }
 EXPORT_SYMBOL(blk_queue_update_dma_alignment);
=20
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 854b4745cdd1..69ee5ea29e2f 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -310,6 +310,13 @@ struct queue_limits {
 	unsigned char		discard_misaligned;
 	unsigned char		raid_partial_stripes_expensive;
 	enum blk_zoned_model	zoned;
+
+	/*
+	 * Drivers that set dma_alignment to less than 511 must be prepared to
+	 * handle individual bvec's that are not a multiple of a SECTOR_SIZE
+	 * due to possible offsets.
+	 */
+	unsigned int		dma_alignment;
 };
=20
 typedef int (*report_zones_cb)(struct blk_zone *zone, unsigned int idx,
@@ -455,12 +462,6 @@ struct request_queue {
 	unsigned long		nr_requests;	/* Max # of requests */
=20
 	unsigned int		dma_pad_mask;
-	/*
-	 * Drivers that set dma_alignment to less than 511 must be prepared to
-	 * handle individual bvec's that are not a multiple of a SECTOR_SIZE
-	 * due to possible offsets.
-	 */
-	unsigned int		dma_alignment;
=20
 #ifdef CONFIG_BLK_INLINE_ENCRYPTION
 	struct blk_crypto_profile *crypto_profile;
@@ -1318,7 +1319,7 @@ static inline sector_t bdev_zone_sectors(struct blo=
ck_device *bdev)
=20
 static inline int queue_dma_alignment(const struct request_queue *q)
 {
-	return q ? q->dma_alignment : 511;
+	return q ? q->limits.dma_alignment : 511;
 }
=20
 static inline unsigned int bdev_dma_alignment(struct block_device *bdev)
--=20
2.30.2

