Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35ADEC433F5
	for <linux-block@archiver.kernel.org>; Tue, 15 Feb 2022 11:53:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237360AbiBOLxW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Feb 2022 06:53:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235055AbiBOLxV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Feb 2022 06:53:21 -0500
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2067.outbound.protection.outlook.com [40.107.220.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4584FA88A0
        for <linux-block@vger.kernel.org>; Tue, 15 Feb 2022 03:53:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bJeEuE9qM4PmeXcsVzr9pQWjVhezux+iyOjlnDwKZf3VNwKKZV1KifM6DMrG8A8plODAcqX/viUjm9hiLB0RKsdRshhR6r+i2yvhPeGOG7m0E0Xdg3sFoQ5g6/kVPzogT7ip2gwKzwT49gAiikItBEzmV9be8KEEAKgnBojGOlBasqm/UTJq6t3g97yOUllaIYpdTRSxz4KNmSxKqrWwkwXMB0hS8zNoZxMbLTpB5vA6VuBoHo5p9Glp/6G7W9piSWWLfG/yMZHI2nqDUUur1zjisfRzT8nQG0jKKKVQAz4XcuV5X95bxhaHdhH/+Ch1wwKoM5k27no/nqqZDKkydw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=30dWUz5/3OnOLi+k4QfmcnaD36gy8U87St1ZylRHnQY=;
 b=mZUyh0tPFdw7Qiswko3gatisCHCM5GeWY8u4GBTQRdqptua+EM4Bq9II5uV+cDGS/g1RDnzGLLXh/wmRAUdfo8oYLtPrYaql5gNWACCkr/uab/kIX535pSufDcAlhSNMgLWFuOw5aQ7hpNToG/9DOODNKBLCorQWQ4kHwdwGbMqSHBr9+YWDrFSRIrV9X67GecfWCJyNfWhEOALjUHR5TnhSTy3xKbhBCr9VjM1amtPwMN5g8sXJDfpptKE2l2RbGAScc27H2njhkc26LQ1ze8ZcPmno+os2bKQiYshyL3RxgWKtYNHo9MAzEGbScXfzBV/HBensLEiG+Fynr2dg5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=wdc.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=30dWUz5/3OnOLi+k4QfmcnaD36gy8U87St1ZylRHnQY=;
 b=T9+SsmQgwPHD5wKKdbuzuzPcYR98Gng3ifmshLrNJCkkgyqxpEaqMPHf18fOBWRU+pln6I7XDei9Mmtzo3PJSLcEVWW3icF0q5aW3A7VNmmSUx0Ubkfu/rjVr5J3M6o9M05kAEZrAvnE7wEkCYwLKmidYl9lXMlayW+i9YF7MZD7Wt9brWSB43zkfKjmy8N6G+EKy3UH5DD2+cKLDleYIYcUSTULvwfS73iVO7MKylLkDDC3rwqUZp3/MtIuelMGe43MjUyeiNHsBljJ2ah5v2Njli9IMRUALbX4CSqsNLtp5PRXanSpJ3y83YXJ6fwyVsO/PHAR7XEbVCYPMO8h2Q==
Received: from DM5PR19CA0040.namprd19.prod.outlook.com (2603:10b6:3:9a::26) by
 CY4PR12MB1222.namprd12.prod.outlook.com (2603:10b6:903:3b::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4975.17; Tue, 15 Feb 2022 11:53:09 +0000
Received: from DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:9a:cafe::28) by DM5PR19CA0040.outlook.office365.com
 (2603:10b6:3:9a::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.16 via Frontend
 Transport; Tue, 15 Feb 2022 11:53:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 DM6NAM11FT060.mail.protection.outlook.com (10.13.173.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4975.11 via Frontend Transport; Tue, 15 Feb 2022 11:53:09 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 15 Feb
 2022 11:53:06 +0000
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Tue, 15 Feb 2022
 03:53:05 -0800
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-block@vger.kernel.org>
CC:     <axboe@kernel.dk>, <ming.lei@redhat.com>, <damien.lemoal@wdc.com>,
        <jiangguoqing@kylinos.cn>, <shinichiro.kawasaki@wdc.com>,
        Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH V2 1/1] blk-lib: don't check bdev_get_queue() NULL check
Date:   Tue, 15 Feb 2022 03:52:47 -0800
Message-ID: <20220215115247.11717-2-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20220215115247.11717-1-kch@nvidia.com>
References: <20220215115247.11717-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0f906a66-7a5f-41d3-8cc2-08d9f079bc7d
X-MS-TrafficTypeDiagnostic: CY4PR12MB1222:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB1222ED77F1345E0725C6F96BA3349@CY4PR12MB1222.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iP6AyExg0ZXktgZCuBEPl/mfHlOmMaZkmgL5NM7vAIqnZ6zA70UM+0jRwnuE1plA/nqm/9nCIb8vuy5VDl73bjoFEQYkjnZMrfW1UFkP0Qw/bJkCG+q/Zy6dWjiUf2QKBDgvXWbEahsclw0RgWHT53uG0EHZkhW3AApiHgXCLcZy+4ai6CwxdUGAi81AUVrOUXkCG3JEj5nwbXHc8NmUprGmq3f9BoEJtkWNJB4rURpCVwJdE3dgcrAbcq0D7QXsVTfj2QVqlKDxsTI+E8dVIXsRDQK3CHKTyke04fzJufT7B25XkfNH5Und9emigGvqCTFi5pkpMIwJ6N87ycLUhe9mW1/nQrMCwCv2w7K/nxxcxKxpDeYI6VoTIIyNEGypKuqc7ewk4IBgWgQqNrpXAbeGMdsLH6DwYfGIsFmgc/oI94DXQGnmBmT+cXIOj0gIroa78N4Y+ZefuByGmbSNJpNf9UVa4Xrj5w462513vjt6BO3QzSSJqx8ELMXXnK2hyB8vJaz1vT3GBT4LaMdJcofcmKpms9mnpmyV9ogEsJ3QSTNkJ0nseI8tS+vGMz1yr3EcPVOS0PBMcifYx1xTy4DqUxolIUgAreiO6rRMP2irGUd+y7Rh5IL6bvvFaUJbNFdXsbUZGCBYBhzxwX3WwtDkXilwZ4ieAEWnWVdlQ8iG+5OOAzq694Jq2gxS941OXCG0Vuba3fSNrXE9/xwp6w==
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(6916009)(107886003)(54906003)(5660300002)(16526019)(7696005)(186003)(316002)(336012)(47076005)(2616005)(1076003)(26005)(83380400001)(8676002)(36756003)(82310400004)(81166007)(426003)(2906002)(70206006)(8936002)(36860700001)(70586007)(40460700003)(6666004)(356005)(4326008)(508600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 11:53:09.2439
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f906a66-7a5f-41d3-8cc2-08d9f079bc7d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1222
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Based on the comment present in the bdev_get_queue()
bdev->bd_queue can never be NULL. Remove the NULL check for the local
variable q that is set from bdev_get_queue() for discard, write_same,
and write_zeroes.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 block/blk-lib.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/block/blk-lib.c b/block/blk-lib.c
index 1b8ced45e4e5..fc6ea52e7482 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -19,9 +19,6 @@ int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
 	unsigned int op;
 	sector_t bs_mask, part_offset = 0;
 
-	if (!q)
-		return -ENXIO;
-
 	if (bdev_read_only(bdev))
 		return -EPERM;
 
@@ -156,9 +153,6 @@ static int __blkdev_issue_write_same(struct block_device *bdev, sector_t sector,
 	struct bio *bio = *biop;
 	sector_t bs_mask;
 
-	if (!q)
-		return -ENXIO;
-
 	if (bdev_read_only(bdev))
 		return -EPERM;
 
@@ -232,10 +226,6 @@ static int __blkdev_issue_write_zeroes(struct block_device *bdev,
 {
 	struct bio *bio = *biop;
 	unsigned int max_write_zeroes_sectors;
-	struct request_queue *q = bdev_get_queue(bdev);
-
-	if (!q)
-		return -ENXIO;
 
 	if (bdev_read_only(bdev))
 		return -EPERM;
@@ -284,14 +274,10 @@ static int __blkdev_issue_zero_pages(struct block_device *bdev,
 		sector_t sector, sector_t nr_sects, gfp_t gfp_mask,
 		struct bio **biop)
 {
-	struct request_queue *q = bdev_get_queue(bdev);
 	struct bio *bio = *biop;
 	int bi_size = 0;
 	unsigned int sz;
 
-	if (!q)
-		return -ENXIO;
-
 	if (bdev_read_only(bdev))
 		return -EPERM;
 
-- 
2.29.0

