Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7F45C77B7C
	for <linux-block@archiver.kernel.org>; Fri, 12 May 2023 08:30:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240058AbjELIap (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 12 May 2023 04:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240207AbjELIam (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 May 2023 04:30:42 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B3231157B
        for <linux-block@vger.kernel.org>; Fri, 12 May 2023 01:30:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V6HzSewevdMRuP1ly6zW5fMPvwvUMO9Wk9X4X3d5B/pk7PXxgOIVB974Uw9XxRoQGhSOApNqCkCkqa4JlO97z076vccjdF04THpa4bCZ2LC9zTe/Lnx1AN8R4MH1r3a6oGJkYh0KxZKvfOatPYQlr3tZJEgwFC2QjW6bvfjdHEtzp5DHm/dZc20s9Ns8oIFN/A8+jDOeu+/W1rp6UPzD4flmxmBYHVForckkDB5iYdPklqfd02eOyni4fZ5d4VDwB8OUgCzVADA8BhSJIOTgZgau29L8JQAzbDmEmMJUcBRYkt4jesKuRLqVLB4NMim6k6PKULxYvfAgKaSju0xbtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xcBIOFVwsOJwwiiiwT2wHt88eI+LSq1jKSPeXcH5azs=;
 b=LG+n1U7MhOMI1HqPWh2Ax3Cs8g2BKwFMgW/1sGUFLaWjXgzWZKLZEIWp/DUfkI17A7NAp2RUwFBHwF+rkIi1oSA/WLD/8v+JXxCd0LGvGGhBemHba/a6xYfLzLi+9/M5v+D632Xa7Q1MGvVA/mWrVmreCRgks03PLnfegSN/6UyVIGxO3TFpxQITXYCLsUGXO9IDJMxHWiggq/BNatKYPT/LXH/17n34rj3DgMzrmqvWgEGea/KEi0IICjB19wQ8mxVrk7PsPJyzIwbzEYJgmeEG07ztDP57+t60RXQrzsLTDx2TXhkx3e1zTa1S4aweXMyamtD82axon+IEVhPJ7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xcBIOFVwsOJwwiiiwT2wHt88eI+LSq1jKSPeXcH5azs=;
 b=eJYfgE6uBcazTjehLybrfyE1pAD1B5XhWJQaJ/hJHp0oEy4xhkvGJq3uPivZSqn56PIpO2EIARgmKvbL5m1bgbuCl4Qtmaoj1i4AS+Z6OG70JJoTUoBTOkx6sswjs+i1fqG8IcwRpN6E//VEGmXWdo4anzOiszbzMxiOhhE9I03y9aUNzrU6NbAHalJgVjsYsJpOcYk/GNJezuj49pcSvdb81NzvBH9A28q/umBGrFJBD6ROawKSeravADC4Dj2sT0AZ+X8918FXt1DzJBnkaIZO0J4ux/P1DqUzazNPOq/aKUgK6T6aOjQ4osfNEpNbp91p2ztlPeoUKoevDPiRUA==
Received: from BYAPR06CA0057.namprd06.prod.outlook.com (2603:10b6:a03:14b::34)
 by SN7PR12MB6791.namprd12.prod.outlook.com (2603:10b6:806:268::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Fri, 12 May
 2023 08:30:33 +0000
Received: from DM6NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:14b:cafe::8) by BYAPR06CA0057.outlook.office365.com
 (2603:10b6:a03:14b::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.24 via Frontend
 Transport; Fri, 12 May 2023 08:30:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT030.mail.protection.outlook.com (10.13.172.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.24 via Frontend Transport; Fri, 12 May 2023 08:30:32 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 12 May 2023
 01:30:16 -0700
Received: from dev.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Fri, 12 May
 2023 01:30:15 -0700
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <minchan@kernel.org>, <senozhatsky@chromium.org>
CC:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 1/3] zram: allow user to set QUEUE_FLAG_NOWAIT
Date:   Fri, 12 May 2023 01:29:56 -0700
Message-ID: <20230512082958.6550-2-kch@nvidia.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230512082958.6550-1-kch@nvidia.com>
References: <20230512082958.6550-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT030:EE_|SN7PR12MB6791:EE_
X-MS-Office365-Filtering-Correlation-Id: 22f93c43-16b1-4970-4dd2-08db52c326c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EyTrWy5dWAsS51uKAtqWhjJ9RkPe1Ju5aEzHVxsS0NSOMqXzXaEtRo8bTXgEeaDhQ554EygkQMVnjN1mk9xDC1HLDzt6tKueQLXB+kr1cX+lgHD7RfcJjBCizKKxwfANF9rD1zHstARKj+ia1PDpa6YD7QG1BTZkjagLb/PmqyUCQfoEkSef7qiu/ujV6fPREW6sjS3bgYbwIdMuHw5X3kILTb01pNDMCigADlx4KxEh/YxQ2umuixivqi1v+HfOvrGuz6bfSt/5o1FcFzYjEvOQCUHGcA0EfOZivKDIujuQMD4zVZVXAHnd8v10sq9KRMilSp+9WhhdAA3cuoeEcQle5+D6/bfMbQ8x1UW7nZGb8tSE9P1E7bay8zzpe3F1bQ5FLfNs2P9Y0DovNqfMY9xHTAVbjXkYIl48+nJl1WYaDQXnvnaZFNFzBliX5JYYWkLZbZYVCDQ5rzPmTpKo+dbNLHHDNWXxd/jQA+eSbXnKT5tPwrcmY4QnO6Ft9qEXrzkiy7Ma4FxMcFjuL0voBcz8ryPg90LpUL+nn/r2GP3Q1Z64xR1CGwVbmaLyK6OeLnDD/5Z6WaT34+4hAuM6psQXFNQXML9L2zwg+3uGHoYT6E05O9CPXQiJ5nHFUFsM6WsFk9+Nnk408Ryky4L1yl7aINyi1knqib7XDGQ1ol/0k0MLSA4BsBV22BqmUJF42SvwEycOuDZxcpso0uNGuQ==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(396003)(39860400002)(451199021)(46966006)(36840700001)(40470700004)(40460700003)(70586007)(36756003)(4326008)(478600001)(316002)(70206006)(7696005)(110136005)(54906003)(356005)(2616005)(426003)(336012)(186003)(83380400001)(1076003)(107886003)(36860700001)(26005)(6666004)(47076005)(40480700001)(2906002)(41300700001)(5660300002)(82310400005)(16526019)(82740400003)(8676002)(8936002)(7636003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2023 08:30:32.4321
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22f93c43-16b1-4970-4dd2-08db52c326c9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6791
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Allow user to set the QUEUE_FLAG_NOWAIT optionally using module
parameter to retain the default behaviour. Also, update respective
allocation flags in the write path. Following are the performance
numbers with io_uring fio engine for random read, note that device has
been populated fully with randwrite workload before taking these
numbers :-

* linux-block (for-next) # grep IOPS  zram*fio | column -t 

default-nowait-off-1.fio:  read:  IOPS=802k,  BW=3133MiB/s
default-nowait-off-2.fio:  read:  IOPS=796k,  BW=3111MiB/s
default-nowait-off-3.fio:  read:  IOPS=796k,  BW=3108MiB/s

nowait-on-1.fio:           read:  IOPS=857k,  BW=3346MiB/s
nowait-on-2.fio:           read:  IOPS=857k,  BW=3347MiB/s
nowait-on-3.fio:           read:  IOPS=858k,  BW=3353MiB/s

* linux-block (for-next) # grep cpu  zram*fio | column -t 
default-nowait-off-1.fio:  cpu  :  usr=5.82%,  sys=13.54%,  ctx=36301915
default-nowait-off-2.fio:  cpu  :  usr=5.84%,  sys=13.03%,  ctx=37781937
default-nowait-off-3.fio:  cpu  :  usr=5.84%,  sys=12.90%,  ctx=37492533

nowait-on-1.fio:           cpu  :  usr=1.74%,  sys=97.62%,  ctx=24068,  
nowait-on-2.fio:           cpu  :  usr=1.74%,  sys=97.57%,  ctx=24674,  
nowait-on-3.fio:           cpu  :  usr=1.76%,  sys=97.59%,  ctx=24725,  

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/block/zram/zram_drv.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index f6d90f1ba5cf..b2e419f15f71 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -36,6 +36,10 @@
 
 #include "zram_drv.h"
 
+static bool g_nowait;
+module_param_named(nowait, g_nowait, bool, 0444);
+MODULE_PARM_DESC(nowait, "set QUEUE_FLAG_NOWAIT. Default: False");
+
 static DEFINE_IDR(zram_index_idr);
 /* idr index must be protected */
 static DEFINE_MUTEX(zram_index_mutex);
@@ -1540,9 +1544,10 @@ static int zram_write_page(struct zram *zram, struct page *page, u32 index)
 static int zram_bvec_write_partial(struct zram *zram, struct bio_vec *bvec,
 				   u32 index, int offset, struct bio *bio)
 {
-	struct page *page = alloc_page(GFP_NOIO);
+	struct page *page;
 	int ret;
 
+	page = alloc_page(bio->bi_opf & REQ_NOWAIT ? GFP_NOWAIT : GFP_NOIO);
 	if (!page)
 		return -ENOMEM;
 
@@ -2215,6 +2220,8 @@ static int zram_add(void)
 	/* zram devices sort of resembles non-rotational disks */
 	blk_queue_flag_set(QUEUE_FLAG_NONROT, zram->disk->queue);
 	blk_queue_flag_set(QUEUE_FLAG_SYNCHRONOUS, zram->disk->queue);
+	if (g_nowait)
+		blk_queue_flag_set(QUEUE_FLAG_NOWAIT, zram->disk->queue);
 
 	/*
 	 * To ensure that we always get PAGE_SIZE aligned
-- 
2.40.0

