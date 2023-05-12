Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0B50C77B7F
	for <linux-block@archiver.kernel.org>; Fri, 12 May 2023 08:31:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239781AbjELIbR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 12 May 2023 04:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239907AbjELIbQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 May 2023 04:31:16 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2064.outbound.protection.outlook.com [40.107.101.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E599F106C3
        for <linux-block@vger.kernel.org>; Fri, 12 May 2023 01:30:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wiir7C05sW+Li0Vrn9vl2gfszZtUiu6ntQG+NZyURexOAqqGpIcW/olW0OWygtKCsYlDo0m1lryRubgwKp3oMAVxQpOxOhgSOeHK0b+7KIaaZMhSQOhVgn3ed2fckJqtK+v68IAtWfS9iDroeeP8nklQo3JBYCLSRp3CxZhmUX1t3ip+XJMnrGM7ZEev2PPEuD5pzI/azUbSk8g5uJGgO/4FTeDUcsZTgsKYXh6tyjhqqSUYdd3/ohfN8iFogmzNeNdK7qpPgDgrschrSVzdz/NIRUMDNeIDBVHeYKO2XtfDXEcTZTIeB5jXc+lWuYokR75OLmgERD6Ys+Yb9jg2dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8wv6rUVhlGfBXmUi0AdfQomrvvsc310WLhnIb5sAlKc=;
 b=LhWLcwQp5TwzIfSMjJKyU1LeJ9aXgTWIWYC9EqHlZyZk433k2sffUD1yRQ68I+QyCVKgIpIAOmAamNXuUh03gBF6XLF2X3kCt1yce0YgwsYCEwWLVxWr/qU1326X9ZuPSy+e8+9lqbplUEdwDy3OanmXwJGhP7bDvhRIVr8oY4ttC3Nr23Cd+oPgHL/FUgS/c4voKNUXFqm9NmbS+04Iz5kW8USWxbx6fE5jc3bXCXf/PLedLBlTjJ/Vm239txfFSvc11i/lFaZXIY3kfWa10UbGPvD9TSIVCqDduL9cVvLJucIVi0WW+Fkw/S7V/IlDkzROVnuu8XsQMWqMVtvSsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8wv6rUVhlGfBXmUi0AdfQomrvvsc310WLhnIb5sAlKc=;
 b=TZWA144KIIRrCr+RvU1MEePO6HSiJabXYt59ee0XV+f1h2LCia7/6ctUcfs8/xSbSfeGhv4vpAEZhy1SOv/UEEnqTH+SOpoLNFhP9yyH0P+4uRtz4dkM0krqg+L0eM8ECD8ZPlsbczBH3sa7jRqaHajX8hVjhAu+mzE4OQWIeMDtxXjWA0267RO1R5a3/VsrD4wlqHR5IbaRqAxEL/wPkudNKckMAf7ZrpZBVAm+TwLkEYecdQxv+gk2xa3hizF3MJ0jYZR7s40xJc3HjGFXCm2JVneA47yVqfFaLhUZqjpTOxNihjY4qCNz/0vLoH02Brb08H+6cAkVI4CUCr7GFg==
Received: from BN9PR03CA0662.namprd03.prod.outlook.com (2603:10b6:408:10e::7)
 by SJ1PR12MB6027.namprd12.prod.outlook.com (2603:10b6:a03:48a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.23; Fri, 12 May
 2023 08:30:44 +0000
Received: from BN8NAM11FT092.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10e:cafe::11) by BN9PR03CA0662.outlook.office365.com
 (2603:10b6:408:10e::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.24 via Frontend
 Transport; Fri, 12 May 2023 08:30:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT092.mail.protection.outlook.com (10.13.176.180) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.24 via Frontend Transport; Fri, 12 May 2023 08:30:44 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 12 May 2023
 01:30:27 -0700
Received: from dev.nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Fri, 12 May
 2023 01:30:27 -0700
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <minchan@kernel.org>, <senozhatsky@chromium.org>
CC:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 2/3] zram: consolidate zram_bio_read()_zram_bio_write()
Date:   Fri, 12 May 2023 01:29:57 -0700
Message-ID: <20230512082958.6550-3-kch@nvidia.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230512082958.6550-1-kch@nvidia.com>
References: <20230512082958.6550-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT092:EE_|SJ1PR12MB6027:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ff18cd3-235a-498a-3d25-08db52c32df6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AAcfP6PbtwKx/M3mls0l7Iwh87y7ERv2di2KHI7egrJeDp71+nDffkLnlO4jFmqZ7HGICjNFgfUGBNbZASsYnEgyX1bNa/O4hpsC7UfoHnckSKpFqoxM/DzPkRSPPHtYfRR6uTIeMFbphqlRySgicjLigdF/ace0ReaJGno55eGzRXwmG8DoYIp0XMBh+vzX8PfiIAsvpNdrVQtpMacrrX+tELe5DkO25r6glF7Pj880tmpnE7tBuD5iASuI/bZv0ixglCMVU/7oxTzGK8txpQR/Ap9ivTvWW7/kdzMlyGJ4npKGPyRVVv03uE6uZS11EK87JYLb/50LAVauOUPY9yzZGlb+d3R5wyf6m2G8OwsMOqw7bPTYVEX7x2tOT69ORuJD6VXASdAIGtf2h0z1nw7MrveUfhFflbJqFno24Hp6kJCbVdh440R9OzeLSZHrzFV7wg8wKtov5rxKnmXb9mlaPpSHyrjAtEvJeF+nLnnC1b5t347ev+/8u6MnZpGPrW9UggpAPbMfFliphAB2Hp41s7uguUpg8cc55+USuoT+gRmdR38P1tGCjkrIJrGFArxU9Rh6iQ18L0+6zzk3d4Nu59EVoQFcQB+gnx8XawGl9OzDTa5TGNrmqF1zbS0VMPRjmJwjtfvgwN/o8r8iifue9d0g0tRSqSOqHkFqecGpckcuTfu5Gl02IzH93X7eK5U3DWYkEIZvjSrPMaRw1e5pskgt1dhV5Q4ITbDF/EKFlsf41kaNN2Nya07Iu+se
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(39860400002)(376002)(396003)(451199021)(40470700004)(36840700001)(46966006)(82740400003)(7636003)(356005)(426003)(336012)(26005)(83380400001)(40480700001)(1076003)(2616005)(186003)(16526019)(47076005)(36860700001)(107886003)(2906002)(8676002)(5660300002)(8936002)(36756003)(478600001)(40460700003)(54906003)(110136005)(7696005)(6666004)(41300700001)(316002)(70586007)(4326008)(70206006)(82310400005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2023 08:30:44.4394
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ff18cd3-235a-498a-3d25-08db52c32df6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT092.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6027
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

zram_bio_read() and zram_bio_write() are 26 lines rach and share most of
the code except call to zram_bdev_read() and zram_bvec_write() calls.
Consolidate code into single zram_bio_rw() to remove the duplicate code
and an extra function that is only needed for 2 lines of code :-

1c1
< static void zram_bio_read(struct zram *zram, struct bio *bio)
---
> static void zram_bio_write(struct zram *zram, struct bio *bio)
13,14c13,14
< 		if (zram_bvec_read(zram, &bv, index, offset, bio) < 0) {
< 			atomic64_inc(&zram->stats.failed_reads);
---
> 		if (zram_bvec_write(zram, &bv, index, offset, bio) < 0) {
> 			atomic64_inc(&zram->stats.failed_writes);
18d17
< 		flush_dcache_page(bv.bv_page);

diff stats with this patch :-

 drivers/block/zram/zram_drv.c | 53 ++++++++++++-----------------------
 1 file changed, 18 insertions(+), 35 deletions(-)

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/block/zram/zram_drv.c | 53 ++++++++++++-----------------------
 1 file changed, 18 insertions(+), 35 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index b2e419f15f71..fc37419b3735 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1873,38 +1873,12 @@ static void zram_bio_discard(struct zram *zram, struct bio *bio)
 	bio_endio(bio);
 }
 
-static void zram_bio_read(struct zram *zram, struct bio *bio)
-{
-	struct bvec_iter iter;
-	struct bio_vec bv;
-	unsigned long start_time;
-
-	start_time = bio_start_io_acct(bio);
-	bio_for_each_segment(bv, bio, iter) {
-		u32 index = iter.bi_sector >> SECTORS_PER_PAGE_SHIFT;
-		u32 offset = (iter.bi_sector & (SECTORS_PER_PAGE - 1)) <<
-				SECTOR_SHIFT;
-
-		if (zram_bvec_read(zram, &bv, index, offset, bio) < 0) {
-			atomic64_inc(&zram->stats.failed_reads);
-			bio->bi_status = BLK_STS_IOERR;
-			break;
-		}
-		flush_dcache_page(bv.bv_page);
-
-		zram_slot_lock(zram, index);
-		zram_accessed(zram, index);
-		zram_slot_unlock(zram, index);
-	}
-	bio_end_io_acct(bio, start_time);
-	bio_endio(bio);
-}
-
-static void zram_bio_write(struct zram *zram, struct bio *bio)
+static void zram_bio_rw(struct zram *zram, struct bio *bio)
 {
 	struct bvec_iter iter;
 	struct bio_vec bv;
 	unsigned long start_time;
+	int ret;
 
 	start_time = bio_start_io_acct(bio);
 	bio_for_each_segment(bv, bio, iter) {
@@ -1912,10 +1886,21 @@ static void zram_bio_write(struct zram *zram, struct bio *bio)
 		u32 offset = (iter.bi_sector & (SECTORS_PER_PAGE - 1)) <<
 				SECTOR_SHIFT;
 
-		if (zram_bvec_write(zram, &bv, index, offset, bio) < 0) {
-			atomic64_inc(&zram->stats.failed_writes);
-			bio->bi_status = BLK_STS_IOERR;
-			break;
+		if (op_is_write(bio_op(bio))) {
+			ret = zram_bvec_write(zram, &bv, index, offset, bio);
+			if (ret < 0) {
+				atomic64_inc(&zram->stats.failed_writes);
+				bio->bi_status = BLK_STS_IOERR;
+				break;
+			}
+		} else {
+			ret = zram_bvec_read(zram, &bv, index, offset, bio);
+			if (ret < 0) {
+				atomic64_inc(&zram->stats.failed_reads);
+				bio->bi_status = BLK_STS_IOERR;
+				break;
+			}
+			flush_dcache_page(bv.bv_page);
 		}
 
 		zram_slot_lock(zram, index);
@@ -1935,10 +1920,8 @@ static void zram_submit_bio(struct bio *bio)
 
 	switch (bio_op(bio)) {
 	case REQ_OP_READ:
-		zram_bio_read(zram, bio);
-		break;
 	case REQ_OP_WRITE:
-		zram_bio_write(zram, bio);
+		zram_bio_rw(zram, bio);
 		break;
 	case REQ_OP_DISCARD:
 	case REQ_OP_WRITE_ZEROES:
-- 
2.40.0

