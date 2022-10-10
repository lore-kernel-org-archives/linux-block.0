Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA19EC433F5
	for <linux-block@archiver.kernel.org>; Mon, 10 Oct 2022 17:01:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbiJJRBz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Oct 2022 13:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbiJJRBy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Oct 2022 13:01:54 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2046.outbound.protection.outlook.com [40.107.92.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 601233FA21
        for <linux-block@vger.kernel.org>; Mon, 10 Oct 2022 10:01:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ALgrC5M11Id59DHnVzZnWcTb0MrUofnkFXlZYqp8HpqQPDGkNY8YbaJvLEVxKlvNrrrs0/Z6hwt74G5fEU+QaYuols95s0aMxOgSCf5HKggsgXppVDvDp+Kx+mc733J//kEKfa633Rj2jOpL49e5bYZndEvmMHL0G1wlslz+RSWs1lcTumRQRJM6myFbxBvtUeYm9odYkA6SC2jIdGmhPoAq2rWTubLOgiEYdNVqtAM8rIgYnBDjDlxl4l/dV/VWsfdzjY3eYAfS/uhM/9YxTADZRMdZVyIHEu0g1gno1dgp3VSHcVwEtNL4U1ObW3HHqtMzqfNq4g8rlfwSLgGrAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sc8XT2hDD65HCxC6GQQw20MIw9BjmG6MFOx3ppWkz+4=;
 b=M+RGSl/ZEOt4VfRixoEBro72VvWz0ShpnnbKOEv9Xs/jBa9kN0pLuJYVPmyeGeCpdZUpISsWosNUb7B1zUlY7F2ZJEAkPM8pBdNxj+cFMGZ7wasLtAYPXso3c7e4BWTAVtnEUubH18+t4bFBMM6R808tFKy6JXepDRc9MKSGNz2oRpj1n+H25QZAKk6TlymfsslrNRaVy7OqKxJu7w7uqIQd/iuyWru+eq9jegd54NYzWgb9k1bif3Dz9dZwdrpIU5OBj06qBGsMsiMMwRqSpi4SYU5Gt9qRU4NfFme1vqM2SaADubk67n986ydphdaFy4v9hLDFynQju+THWsDtkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sc8XT2hDD65HCxC6GQQw20MIw9BjmG6MFOx3ppWkz+4=;
 b=Oa5Uuj1RlfwYD/N5tFPL2zgNySK6UhIK/zENnFa3Aln/ulUtTHF1FVxktGqaItnq45AosoE05sBBBHtoA4z3QYEKi8O0OdbJvb32uJSUyFG/+1p8esBOeEgU8aEjnfTRyY1xdIthkfjBD/pRlHwi1LfLI0266HmJMhs6ATYdMsErA6jae2sfE/hkUZ1oPpQbMIkSqPxDONzujssfVaVVZRWqHXxZpg0BrYPMcG/oNY2mwdIv5Z7T+kxJMVIc+wP+DIm0uFVKMYDKkUSQP5YCaH+kwA0ZLVDopTxE/iFAmCjZxy6MJvrFvC7XMDdT5T1cZ+U0xyb6bK3z7gGu9dbN8A==
Received: from CY5P221CA0102.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:9::33) by
 MW3PR12MB4457.namprd12.prod.outlook.com (2603:10b6:303:2e::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.15; Mon, 10 Oct 2022 17:01:49 +0000
Received: from CY4PEPF0000B8E8.namprd05.prod.outlook.com
 (2603:10b6:930:9:cafe::d3) by CY5P221CA0102.outlook.office365.com
 (2603:10b6:930:9::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15 via Frontend
 Transport; Mon, 10 Oct 2022 17:01:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000B8E8.mail.protection.outlook.com (10.167.241.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5676.17 via Frontend Transport; Mon, 10 Oct 2022 17:01:49 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Mon, 10 Oct
 2022 10:01:29 -0700
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 10 Oct
 2022 10:01:28 -0700
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-block@vger.kernel.org>
CC:     <axboe@kernel.dk>, <kch@nvidia.com>, <hch@lst.de>,
        <damien.lemoal@opensource.wdc.com>, <johannes.thumshirn@wdc.com>,
        <bvanassche@acm.org>, <ming.lei@redhat.com>,
        <shinichiro.kawasaki@wdc.com>, <vincent.fu@samsung.com>
Subject: [RFC PATCH 4/6] nvme-apple: use init alloc tagset helper
Date:   Mon, 10 Oct 2022 10:00:24 -0700
Message-ID: <20221010170026.49808-5-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20221010170026.49808-1-kch@nvidia.com>
References: <20221010170026.49808-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000B8E8:EE_|MW3PR12MB4457:EE_
X-MS-Office365-Filtering-Correlation-Id: 0adc84ea-0b15-4e5a-4fcf-08daaae11f44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5WKvCvbf9AykPeetcGKk+tiR/cZdw2bXjX2lzsPpZjYiJcFLVjb/Vi78qv1NV3EebGvx2tA0GpA8cAb+9pF/+htxSWxBqjHAr+CW4bGpApD4GqtKwanPFGw035NtVx1TSfZiGPYtOPzdwYVNDl7+Ixk/MsHjRnXvn/QJlCd8ixgAj5YyTb6LaWRSpPhkYiy4nqZ5q56A5vzgvJkHjEnCnt6M2yvGk4Xayb2K7v4QWnBhSuY0LV/r2DCOGHqAe2fe6Iz0xNhLaG8O7QWMGKf85xHlj6BOJdBapWPf/C/EZtdHRZNLqRMzFtc4p5JA7/MQDDoG4CqY9V3ewvPHXM0XEpuAV0C7GMeZ6Ihhka3xKV4kNZ3llKsqDzpvYhD219Phq9VuBamdndgDzdIqtOynDW5BCvhVM5gne/Ot2fQiGq8atrNbYhvo+d81b+R0UIR3/+XZ55fg85wfe9Teqe0acc2H7snwIXlHU3+GFgca6usVgLFjzo4s5WibnYHko+YDOJsWGd9IA5g2E2lG2+byLJH4VgJtAn+619Z8i2SDXVeReUoEdeYQWjkbBGRb3g4oY5NIQ8QOIinmkuSvYFtQ8q13aD8dg0nd7GDql2AbpxNu4qQRw0XB+ENYfL2lXQJm09Q0B5hNw3hgScnpTtitbYQWohHTmKzacuDBi8qO6kv+ZNFcgqRSERMqF1gDdkUXcZ9gb+pdkmRJG1ttgNq/KHoltm2R7XLL+ZkQ/pB2F3Cagz+4h8AY4FhpBHJfpFWoVKspJcJCRt/nHremUYN6lJ+0diKIM/m0uzqiyF4u0Fw0IP+7opTVfY0jEdGndQDs
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(39860400002)(346002)(136003)(47660400002)(451199015)(36840700001)(40470700004)(46966006)(2616005)(40480700001)(426003)(36860700001)(356005)(40460700003)(7636003)(8676002)(70586007)(70206006)(82310400005)(4326008)(54906003)(36756003)(6916009)(41300700001)(2906002)(6666004)(82740400003)(47076005)(316002)(83380400001)(336012)(478600001)(5660300002)(8936002)(1076003)(26005)(186003)(7696005)(16526019)(46800400005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2022 17:01:49.3561
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0adc84ea-0b15-4e5a-4fcf-08daaae11f44
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000B8E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4457
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/host/apple.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
index 5fc5ea196b40..baafee23e32a 100644
--- a/drivers/nvme/host/apple.c
+++ b/drivers/nvme/host/apple.c
@@ -1228,16 +1228,13 @@ static int apple_nvme_alloc_tagsets(struct apple_nvme *anv)
 {
 	int ret;
 
-	anv->admin_tagset.ops = &apple_nvme_mq_admin_ops;
-	anv->admin_tagset.nr_hw_queues = 1;
-	anv->admin_tagset.queue_depth = APPLE_NVME_AQ_MQ_TAG_DEPTH;
 	anv->admin_tagset.timeout = NVME_ADMIN_TIMEOUT;
 	anv->admin_tagset.numa_node = NUMA_NO_NODE;
 	anv->admin_tagset.cmd_size = sizeof(struct apple_nvme_iod);
 	anv->admin_tagset.flags = BLK_MQ_F_NO_SCHED;
-	anv->admin_tagset.driver_data = &anv->adminq;
 
-	ret = blk_mq_alloc_tag_set(&anv->admin_tagset);
+	ret = blk_mq_alloc_tag_set(&anv->admin_tagset, apple_nvme_mq_admin_ops,
+				   1, APPLE_NVME_AQ_MQ_TAG_DEPTH, &anv->adminq);
 	if (ret)
 		return ret;
 	ret = devm_add_action_or_reset(anv->dev, devm_apple_nvme_put_tag_set,
@@ -1245,8 +1242,6 @@ static int apple_nvme_alloc_tagsets(struct apple_nvme *anv)
 	if (ret)
 		return ret;
 
-	anv->tagset.ops = &apple_nvme_mq_ops;
-	anv->tagset.nr_hw_queues = 1;
 	anv->tagset.nr_maps = 1;
 	/*
 	 * Tags are used as an index to the NVMMU and must be unique across
@@ -1254,14 +1249,13 @@ static int apple_nvme_alloc_tagsets(struct apple_nvme *anv)
 	 * must be marked as reserved in the IO queue.
 	 */
 	anv->tagset.reserved_tags = APPLE_NVME_AQ_DEPTH;
-	anv->tagset.queue_depth = APPLE_ANS_MAX_QUEUE_DEPTH - 1;
 	anv->tagset.timeout = NVME_IO_TIMEOUT;
 	anv->tagset.numa_node = NUMA_NO_NODE;
 	anv->tagset.cmd_size = sizeof(struct apple_nvme_iod);
 	anv->tagset.flags = BLK_MQ_F_SHOULD_MERGE;
-	anv->tagset.driver_data = &anv->ioq;
 
-	ret = blk_mq_alloc_tag_set(&anv->tagset);
+	ret = blk_mq_alloc_tag_set(&anv->tagset, *apple_nvme_mq_ops, 1,
+			APPLE_ANS_MAX_QUEUE_DEPTH - 1, &anv->ioq);
 	if (ret)
 		return ret;
 	ret = devm_add_action_or_reset(anv->dev, devm_apple_nvme_put_tag_set,
-- 
2.29.0

