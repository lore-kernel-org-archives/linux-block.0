Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90C19C433F5
	for <linux-block@archiver.kernel.org>; Tue,  1 Mar 2022 02:23:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbiCACYR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Feb 2022 21:24:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbiCACYQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Feb 2022 21:24:16 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2054.outbound.protection.outlook.com [40.107.220.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A13F727B22
        for <linux-block@vger.kernel.org>; Mon, 28 Feb 2022 18:23:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CPf7Dsvi9BltGVzgNGGRBNB4zxLkt+NtG/f/1bz4kHZANrL0vRJIhqRNlYpF9cw+UiutBz5B0oUFZ2Ih6gxKJ7zayq/wDuqy/phELI1tmsHy1+HHy1e0AEvUxrH3rxeaPQYKq9sNO4+Cjki30o0GN/eG5SsGsdl59cR3c/JYg5EAZ6YnMvWpDAdZ+9vnl6X5eN7c+17a6/4VgNGI/4bFbQCBOx2K/6xndkDWGHiQl5ssrE5rviz62bTmmMvnpSHeV4MsbLJKYjTY0NhoB7WgOoQTZBwSPUJndrvTDc9OGUy8ZcuwdFuXtggUl4GWzcN3I0Ht0rbSGAXnvd/cAT8/Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yc6RkM7dET2GEF5HE6kN7w25tS+W6RqK1ZAj6tQOyQM=;
 b=cuVwwUlmV/QJZMLccJgMwdKvCdrsY0ogJtwF/2dni0JI49DABQ+jlYWtKrnofW+DuKrFRPFFVPQHZJGmy+jz0xSnElhT6PlJMkrnpL/DoHrEqduLdcojy6oOz7nGCEBPHCGQi+CfTPLDzEQ6JNJ+uABAYS+JRcoG0MO9E0Se/6LuzgdFWqiZEs6fvXwN6NKSXH+Vt03A776OFJAuv+Zh3xO6ndDmo5OQYC+n46viXa8t4FA1Dv5hXh4lBhcDD65kAshxpm4Y3C6LDs4qclQmN+EdYvZFLFBOoZKqIlYGnoKm29MRhWKj8UpuYQXJJkhqxTFj12L1KjgUkhyHeFCx+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=kernel.dk smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yc6RkM7dET2GEF5HE6kN7w25tS+W6RqK1ZAj6tQOyQM=;
 b=Iqu2pURxXAR8/3JG5gMG+tMFZWHD7rnzeHuvxFxiqaURptSoaPCuz/m8WcR1hokvgCycCzIC/35/58dXYWYNVBf5XvMHZ/fTYTtpAkObGUX22rLnPr6fEK54Apxf5ZN4Geq/repNtcMPJdIlrdjQpcEG+CjRFlHnLHt1H2sItvbnhLhHxTkTfttqWdj54TUoErLsLxPPXPYiW6mrBmpIeSqyIDSKOe10n+Msgi2XQ/SkJaC0KL+TAk3OKSO+dkI6QlIO7Jz7RGCgMpzljB6aGTfkQsBkGFZc38zlLUjcW+ww0oBNb3ZtNQ/6E1ZA/49tib9E03c45jbQNsGizH54yg==
Received: from BN0PR02CA0028.namprd02.prod.outlook.com (2603:10b6:408:e4::33)
 by PH0PR12MB5465.namprd12.prod.outlook.com (2603:10b6:510:ec::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Tue, 1 Mar
 2022 02:23:35 +0000
Received: from BN8NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e4:cafe::91) by BN0PR02CA0028.outlook.office365.com
 (2603:10b6:408:e4::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21 via Frontend
 Transport; Tue, 1 Mar 2022 02:23:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 BN8NAM11FT059.mail.protection.outlook.com (10.13.177.120) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5017.22 via Frontend Transport; Tue, 1 Mar 2022 02:23:34 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 1 Mar
 2022 02:23:33 +0000
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Mon, 28 Feb 2022
 18:23:32 -0800
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>
CC:     <damien.lemoal@wdc.com>, <axboe@kernel.dk>, <hch@lst.de>,
        <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 1/1] block: move sector bio member into blk_next_bio()
Date:   Mon, 28 Feb 2022 18:23:10 -0800
Message-ID: <20220301022310.8579-2-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20220301022310.8579-1-kch@nvidia.com>
References: <20220301022310.8579-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d3b47e39-80b1-4473-4770-08d9fb2a7c69
X-MS-TrafficTypeDiagnostic: PH0PR12MB5465:EE_
X-Microsoft-Antispam-PRVS: <PH0PR12MB54652BCD7FADA1CE06E934A2A3029@PH0PR12MB5465.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1hZz095LtJo2j01sfRjC1WVjnoIWGEVmBeV/+ciTagSyh45ewGcAaJlMCDzUeyJRnJIq0t7ncxWeIzkBn87j0SP7kiVt4deJlPpzoV7fsTvYxAPylUh4+7XapP/+slrrF34a8xeIh9SwCSj2imJIlP6tO7kF62/anrtqN1dOm9kXH+4h44ZiwvRpPmHfsYfeSrMJKNgx3RHWs0Cu6U2ugoGuAILMACpYvk96ov3fAysIrORlX4uYzL3y4M/dSlmJenoaKLMlbFgfOoA8ju5MINJr51Lp17bj3lJOAqgTUxS3Z08vJLnmCPKYg4vKqET1mla+8K1HjtHF2IeGCHeX7m7rbIGk9CeEybmf9XKfww9Rv7AEJjAg45af1C0r5RxaEGo40gd7Yfgj5JQZoyyFoeXKNEJsZ40/LqEiiYEkCgASTx4RiMUEKLuAA97iPXs8nqBrzQ4Oh6jWcQjX+rJWQS4/WhScrNqraqlOxX3r9qBBznVfvrbw0sjTUMgNA33kMQ8ZwJEcXF14T1nhFWsA0Q00tsekvq4lvv0gW2toOs8vr/fN/pZKfvP8vZTRwJ45kotXDECULCmiOidJHaFTSOr5k8No1IJVQHYV7C6IepPmRLODntfvUtVfGkHXoukevrTn0Fi3pwmF2FyR4KDNTVLvm/nh08WtHJyRuQdPXs9XRCfH1faXuH3uSKCpr801nVcnpneRCV8vsrFYLoL4GqANWGakVk5JfStd4A1zF0U=
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(54906003)(107886003)(110136005)(6666004)(7696005)(83380400001)(16526019)(2616005)(26005)(1076003)(426003)(82310400004)(47076005)(36860700001)(5660300002)(186003)(316002)(336012)(8936002)(40460700003)(508600001)(2906002)(356005)(36756003)(4326008)(70206006)(70586007)(81166007)(8676002)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2022 02:23:34.2389
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3b47e39-80b1-4473-4770-08d9fb2a7c69
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5465
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

blk_next_bio() is the central function which allocates bios for
e.g. discard, write-same, write-zeroes, zone-mgmt and initializes
common members of bios to avoid code duplication. The initialization of
sector bio member is duplicated in disacrd, write-same, write-zeores,
and NVMeOF Target zns backend etc.

The callers of the blk_next_bio() __blkdev_issue_discard(),
__blkdev_issue_write_same(), __blkdev_issue_write_zeroes(),
__blkdev_issue_zero_pages(), blkdev_zone_reset_all_emulated(),
blkdev_zone_mgmt() and nvmet_bdev_zone_mgmt_emulated_all() initialize
bio->bi_iter.bi_sector after the call to blk_next_bio(), so we can
safely move newly returned bio's sector initialization into the
blk_next_bio().

Move sector member to the blk_next_bio() just like we have moved other
members to blk_next_bio().

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 block/bio.c               |  5 ++++-
 block/blk-lib.c           | 20 +++++++++-----------
 block/blk-zoned.c         |  9 ++++-----
 drivers/nvme/target/zns.c |  3 +--
 include/linux/bio.h       |  3 ++-
 5 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index b15f5466ce08..0a68091685ee 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -353,7 +353,8 @@ void bio_chain(struct bio *bio, struct bio *parent)
 EXPORT_SYMBOL(bio_chain);
 
 struct bio *blk_next_bio(struct bio *bio, struct block_device *bdev,
-		unsigned int nr_pages, unsigned int opf, gfp_t gfp)
+			 sector_t sect, unsigned int nr_pages,
+			 unsigned int opf, gfp_t gfp)
 {
 	struct bio *new = bio_alloc(bdev, nr_pages, opf, gfp);
 
@@ -362,6 +363,8 @@ struct bio *blk_next_bio(struct bio *bio, struct block_device *bdev,
 		submit_bio(bio);
 	}
 
+	new->bi_iter.bi_sector = sect;
+
 	return new;
 }
 EXPORT_SYMBOL_GPL(blk_next_bio);
diff --git a/block/blk-lib.c b/block/blk-lib.c
index fc6ea52e7482..3407b1afc079 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -79,8 +79,7 @@ int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
 
 		WARN_ON_ONCE((req_sects << 9) > UINT_MAX);
 
-		bio = blk_next_bio(bio, bdev, 0, op, gfp_mask);
-		bio->bi_iter.bi_sector = sector;
+		bio = blk_next_bio(bio, bdev, sector, 0, op, gfp_mask);
 		bio->bi_iter.bi_size = req_sects << 9;
 		sector += req_sects;
 		nr_sects -= req_sects;
@@ -167,8 +166,8 @@ static int __blkdev_issue_write_same(struct block_device *bdev, sector_t sector,
 	max_write_same_sectors = bio_allowed_max_sectors(q);
 
 	while (nr_sects) {
-		bio = blk_next_bio(bio, bdev, 1, REQ_OP_WRITE_SAME, gfp_mask);
-		bio->bi_iter.bi_sector = sector;
+		bio = blk_next_bio(bio, bdev, sector, 1, REQ_OP_WRITE_SAME,
+				   gfp_mask);
 		bio->bi_vcnt = 1;
 		bio->bi_io_vec->bv_page = page;
 		bio->bi_io_vec->bv_offset = 0;
@@ -224,6 +223,8 @@ static int __blkdev_issue_write_zeroes(struct block_device *bdev,
 		sector_t sector, sector_t nr_sects, gfp_t gfp_mask,
 		struct bio **biop, unsigned flags)
 {
+	unsigned int opf = flags & BLKDEV_ZERO_NOUNMAP ? REQ_NOUNMAP : 0;
+	unsigned int op = REQ_OP_WRITE_ZEROES;
 	struct bio *bio = *biop;
 	unsigned int max_write_zeroes_sectors;
 
@@ -237,10 +238,7 @@ static int __blkdev_issue_write_zeroes(struct block_device *bdev,
 		return -EOPNOTSUPP;
 
 	while (nr_sects) {
-		bio = blk_next_bio(bio, bdev, 0, REQ_OP_WRITE_ZEROES, gfp_mask);
-		bio->bi_iter.bi_sector = sector;
-		if (flags & BLKDEV_ZERO_NOUNMAP)
-			bio->bi_opf |= REQ_NOUNMAP;
+		bio = blk_next_bio(bio, bdev, sector, 0, op | opf, gfp_mask);
 
 		if (nr_sects > max_write_zeroes_sectors) {
 			bio->bi_iter.bi_size = max_write_zeroes_sectors << 9;
@@ -274,6 +272,7 @@ static int __blkdev_issue_zero_pages(struct block_device *bdev,
 		sector_t sector, sector_t nr_sects, gfp_t gfp_mask,
 		struct bio **biop)
 {
+	unsigned int nr_pages = __blkdev_sectors_to_bio_pages(nr_sects);
 	struct bio *bio = *biop;
 	int bi_size = 0;
 	unsigned int sz;
@@ -282,9 +281,8 @@ static int __blkdev_issue_zero_pages(struct block_device *bdev,
 		return -EPERM;
 
 	while (nr_sects != 0) {
-		bio = blk_next_bio(bio, bdev, __blkdev_sectors_to_bio_pages(nr_sects),
-				   REQ_OP_WRITE, gfp_mask);
-		bio->bi_iter.bi_sector = sector;
+		bio = blk_next_bio(bio, bdev, sector, nr_pages, REQ_OP_WRITE,
+				   gfp_mask);
 
 		while (nr_sects != 0) {
 			sz = min((sector_t) PAGE_SIZE, nr_sects << 9);
diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 602bef54c813..0a8680df3f1c 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -215,9 +215,8 @@ static int blkdev_zone_reset_all_emulated(struct block_device *bdev,
 			continue;
 		}
 
-		bio = blk_next_bio(bio, bdev, 0, REQ_OP_ZONE_RESET | REQ_SYNC,
-				   gfp_mask);
-		bio->bi_iter.bi_sector = sector;
+		bio = blk_next_bio(bio, bdev, sector, 0,
+				   REQ_OP_ZONE_RESET | REQ_SYNC, gfp_mask);
 		sector += zone_sectors;
 
 		/* This may take a while, so be nice to others */
@@ -302,8 +301,8 @@ int blkdev_zone_mgmt(struct block_device *bdev, enum req_opf op,
 	}
 
 	while (sector < end_sector) {
-		bio = blk_next_bio(bio, bdev, 0, op | REQ_SYNC, gfp_mask);
-		bio->bi_iter.bi_sector = sector;
+		bio = blk_next_bio(bio, bdev, sector, 0, op | REQ_SYNC,
+				   gfp_mask);
 		sector += zone_sectors;
 
 		/* This may take a while, so be nice to others */
diff --git a/drivers/nvme/target/zns.c b/drivers/nvme/target/zns.c
index 3e421217a7ad..cb4ba3f3a95e 100644
--- a/drivers/nvme/target/zns.c
+++ b/drivers/nvme/target/zns.c
@@ -412,10 +412,9 @@ static u16 nvmet_bdev_zone_mgmt_emulate_all(struct nvmet_req *req)
 
 	while (sector < get_capacity(bdev->bd_disk)) {
 		if (test_bit(blk_queue_zone_no(q, sector), d.zbitmap)) {
-			bio = blk_next_bio(bio, bdev, 0,
+			bio = blk_next_bio(bio, bdev, sector, 0,
 				zsa_req_op(req->cmd->zms.zsa) | REQ_SYNC,
 				GFP_KERNEL);
-			bio->bi_iter.bi_sector = sector;
 			/* This may take a while, so be nice to others */
 			cond_resched();
 		}
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 7523aba4ddf7..c34fd40c8867 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -788,6 +788,7 @@ static inline void bio_set_polled(struct bio *bio, struct kiocb *kiocb)
 }
 
 struct bio *blk_next_bio(struct bio *bio, struct block_device *bdev,
-		unsigned int nr_pages, unsigned int opf, gfp_t gfp);
+			 sector_t sect, unsigned int nr_pages,
+			 unsigned int opf, gfp_t gfp);
 
 #endif /* __LINUX_BIO_H */
-- 
2.29.0

