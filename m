Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5D7DC433F5
	for <linux-block@archiver.kernel.org>; Mon, 14 Feb 2022 10:47:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349218AbiBNKrU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Feb 2022 05:47:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348451AbiBNKqw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Feb 2022 05:46:52 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2076.outbound.protection.outlook.com [40.107.92.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55B8F85650
        for <linux-block@vger.kernel.org>; Mon, 14 Feb 2022 02:09:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bLBhVNsLHU7rrTiDtF0D0MOoB8Mx9KMOsmz5/xelaE7mx5t6JqwwRNHaU8wf3OZuISSk9nI95qbkbdgQSI9VThvfGfx/6TxdD/xYsoX7W7Khfl6l5b4+UWnvo06g/JCL7/jRI4KzLCHFye38DUmXi422wYqlIuyagSGXADL2FvXDiHYT0XweedhDG30O4veIQSVNuUo3gIcXPyxGc5YN6ds4NKbWtzJxTes7vI+bYwtuD/fjr1rxpTCwbPLYWnsjdLq9vDB4nxOe+HeIBnAuOZG+82MAOpFf41vigWw8FQZ9QfJMUS51/EQoPndpKqRa/iWNB7I5/i2DrkcmUIZNuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QlzxcwN142BvZSNTCvDujXgH4I+VpWO2ni5+a6NkBqM=;
 b=BlzgT/T3E+TS1DiKckezrxwTxuzxbVpo/VEiEL+2poYED/1kLYFwZz6+mP3bQpwbbhu0CX63V5X5fukMoK23EEOeOmxp2MMvEvnEb9wCXeGzhpFGLNI66VeyAw6gb1qrJXkFmFSXsp3oXcFkjuMXQdHqG75baEtEZ9WVpd3Z2LRUkB0r1lVgwogGaCOIZ5fulOJqPQVtfB9jlL4LDnDu3Nl/mARCVr6OSXq8z43BUWDygtPVAuJSx/R1EM5d0sDIXr9LjPq47R41aLzU40ZSf3yM4G9fD4ezVs6QH9BNHwgcN17ZeLsLfrFZNRBOEZoOdlblA0voZntL30l6DobmTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=wdc.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QlzxcwN142BvZSNTCvDujXgH4I+VpWO2ni5+a6NkBqM=;
 b=i3L3mIjRB8ZeqYLhIQHvGukvbS125asAFY+Hn6fgpEXgxhM4vZTLakKBtMPCXTwcKKGVBsH+e5Lfe6kNAhoVyQf86DO2B/j98z+XVnr3DJ/eqGGmkVhIKuN6g3T5ZcbjozeyKND2nbUvuVgTCyeMsNxCkzWy6uYDSbbG6oNxd5r0b0ARcwLXHbKKPUayD0GAMJ1/q5THEESQee7Ctg5ji2pVCVGznyrKyRwtNhu4+RAL0PB4WlAypXsWHKlwTnnNRfqhi23Sbtd1KQbxp9FInugFHM+fzzfkKyAU76uBKk7N1LXeyWfklQwtqsUl4u2A9E0IXfk6152p9QAAcrhxJg==
Received: from DM5PR08CA0034.namprd08.prod.outlook.com (2603:10b6:4:60::23) by
 DM4PR12MB5245.namprd12.prod.outlook.com (2603:10b6:5:398::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4975.17; Mon, 14 Feb 2022 10:09:39 +0000
Received: from DM6NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:60:cafe::eb) by DM5PR08CA0034.outlook.office365.com
 (2603:10b6:4:60::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11 via Frontend
 Transport; Mon, 14 Feb 2022 10:09:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 DM6NAM11FT052.mail.protection.outlook.com (10.13.172.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4975.11 via Frontend Transport; Mon, 14 Feb 2022 10:09:39 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 14 Feb
 2022 10:09:39 +0000
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Mon, 14 Feb 2022
 02:09:38 -0800
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-block@vger.kernel.org>
CC:     <axboe@kernel.dk>, <ming.lei@redhat.com>, <damien.lemoal@wdc.com>,
        <jiangguoqing@kylinos.cn>, <shinichiro.kawasaki@wdc.com>,
        Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 2/4] blk-lib: don't check bdev_get_queue() NULL check
Date:   Mon, 14 Feb 2022 02:08:57 -0800
Message-ID: <20220214100859.9400-3-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20220214100859.9400-1-kch@nvidia.com>
References: <20220214100859.9400-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f10eb2e9-0a90-49d1-936c-08d9efa21ce4
X-MS-TrafficTypeDiagnostic: DM4PR12MB5245:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB52458AA5C5031117C1D26871A3339@DM4PR12MB5245.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RCTGJf32FZwysiYKsHk3XIckBZ7A74JDtB/ynYwex/TULMlNy5iBiLtJD8DjGaUiAsA24uqp8UMQC4OhO5LgwyG0+8hjxYAF+KUM8+TZgVQyPpWwoN0FZKV08FsEZsqyivbRe6E73rULpX28QFzB/UnR6na2aNGwZ90ruUmUFJO9OlWsDIVP4sEzSqtJD+uZSUDMXzqIpbrQvKxlEhJbUqoGJNiu30BMl5HdyMRX3s8P2GUSf8Qc6kPDck4wKUN0Pt+p9S0VBVpFGjaFXW1OLQgYyxdfv+pCudtnBvGKb5uv8TgnAqD+dPo1uAqPj+iM/73jxNLyuY4qbMY+rgTEQYBX/YVMXdm3b9dhZukJUCaApBLvA08uoZCGCzAllAhIqCdfzOfjri2q/28ByznlWBi4D5b1DiKePcL1BpN8ErU7PhCYGGrmD9nHRxjJbc4ZxyXPVwhEW8TFmr3NtI4zYdjrku0RUSCQXRQjWtF7qhaoKJKcKSPuM4ZVAt1AVcD48+gB/euIwuRL6eyR1MeD5BbtCxU0/KAIwd1JzY4GTkkLa9+bAZUFtES7KaXXAvcBw+T65Bm2XXaO07kytnMSj8e8Tim74Z4zhT0Fw5D5AluhCD7Aqecf6MKgfxLmurTEfufh4SObhSuiaUBKQS7+XR6W+PYGK3ksKhORDX8Rm2qzDYmr67HYY59vpKrnpLupl87GfwhPDlSibxTP7rcagg==
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(36860700001)(2906002)(7696005)(4744005)(83380400001)(2616005)(107886003)(1076003)(26005)(186003)(426003)(336012)(16526019)(47076005)(82310400004)(508600001)(316002)(8936002)(36756003)(54906003)(40460700003)(4326008)(70586007)(70206006)(8676002)(6916009)(6666004)(5660300002)(81166007)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2022 10:09:39.6868
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f10eb2e9-0a90-49d1-936c-08d9efa21ce4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5245
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Based on the comment present in the bdev_get_queue()
bdev->bd_disk->queue can never be NULL. Remove the NULL check for the
local variabel q that is set from bdev_get_queue() in the function
__blkdev_issue_write_same().

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 block/blk-lib.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/block/blk-lib.c b/block/blk-lib.c
index 08ac56eb3a70..473888d667a1 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -169,9 +169,6 @@ static int __blkdev_issue_write_same(struct block_device *bdev, sector_t sector,
 	struct bio *bio = *biop;
 	sector_t bs_mask;
 
-	if (!q)
-		return -ENXIO;
-
 	if (bdev_read_only(bdev))
 		return -EPERM;
 
-- 
2.29.0

