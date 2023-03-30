Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B31DAC7619A
	for <linux-block@archiver.kernel.org>; Thu, 30 Mar 2023 21:33:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbjC3VdQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 Mar 2023 17:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjC3VdP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Mar 2023 17:33:15 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2070.outbound.protection.outlook.com [40.107.93.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0287835B5
        for <linux-block@vger.kernel.org>; Thu, 30 Mar 2023 14:33:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QRBLccT7F43ud1cDs9lI24DES2+Teymn2hm6Mwo1UUFjM8aycE49yRBF6IjKgS/7QhMOWFG/H9C1q8tFbDecOVSY0HvyJV141yCEb2szvjzlTxZXUr2HNh7YHmmrAWU1mA3nl8/hgQtmD0c3ux2B4FqphFNSZpNv57PMtJflirzAdlV9Tw+TUo5qUE3MPysmxP6rf4sa2Ea0lw93Eh8aZPC8SWJHaaPS/yokW55EybgOe4hCqJ5WOHNRhPpCBAKxvg1Tey4Yn/b86Dm9w/SfaLKd2qDh4mE+g4NK508WlGVWRDA+vOpWUPVVa4hDkVwYXUFQoVJVe2npOUvkPpchgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ay5Z0N6oBRZ4/K2Or1meAgFWdvIhSKpu/PSEKaryELc=;
 b=WK8H+y+r/LUKjKbWyAFl5UaTGcSC6fZreu6d4sUU3m933XeMK/s2INqdYtCCrjgf8TwIXH00rOvURmTmLU9GlvMvuV7hsZ9ZQzo5RAvxCQQAwrPZqfXiMZK+TwxuYeNNauH/gli0hOESmF243MDsPPQdBB7fqlAr55xKpBg9hjxLQ6ZL+n125ihQqlyizmmEM3B6dhAwyElcZiJdjuMV1K9+uUgFf6gNVny/8bsGF/7vEZjS/+1CJ47JAuA2MihHpngZCqX5sJZVdsanYWy1guC4CfnNL7v3BvfqtFF8d9v8m6wBE8QOi1kPXbM2f9RYof2PDQ4wiX7XFojLzuWnjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ay5Z0N6oBRZ4/K2Or1meAgFWdvIhSKpu/PSEKaryELc=;
 b=tJqpdejCL5F+ty01Bor6pNb9Efc1U/hgNAt4+JWCiX/3KOI4dVJCkTRANzGMvbuz6220rS9E8GIUIXmzdfLgfu+oNeMeyezOlXEVRt3GROdmZ3JR8nJl4rGpD1tYf7UV4KvmrEtMFuNgpVG2AyhQXLzEmA06wy6YnuGnBuEvKM9Q7kqlM7adS2FO9suRdsxt+HII5DkThftN9pJbS8jlrbQSajJ469qz4vKRBq5tn6Fx1Tdeq+vt1/EgtcrrJWpb0B7p+DgSqERuFn+KXfD0iaKf6pFUVawJqEbmp1kef93PGcGTGKR9Vv1BHeoKKajhD6ysHkeHr2B25fJbbKppAQ==
Received: from MW4P220CA0012.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::17)
 by SJ1PR12MB6337.namprd12.prod.outlook.com (2603:10b6:a03:456::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.32; Thu, 30 Mar
 2023 21:33:11 +0000
Received: from CO1NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:115:cafe::fa) by MW4P220CA0012.outlook.office365.com
 (2603:10b6:303:115::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22 via Frontend
 Transport; Thu, 30 Mar 2023 21:33:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT005.mail.protection.outlook.com (10.13.174.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6254.21 via Frontend Transport; Thu, 30 Mar 2023 21:33:10 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 30 Mar 2023
 14:33:03 -0700
Received: from dev.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 30 Mar
 2023 14:33:03 -0700
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-block@vger.kernel.org>
CC:     <axboe@kernel.dk>, <kch@nvidia.com>,
        <damien.lemoal@opensource.wdc.com>, <johannes.thumshirn@wdc.com>,
        <ming.lei@redhat.com>, <bvanassche@acm.org>,
        <shinichiro.kawasaki@wdc.com>, <vincent.fu@samsung.com>
Subject: [PATCH V2 7/9] null_blk: check for valid queue depth value
Date:   Thu, 30 Mar 2023 14:31:32 -0700
Message-ID: <20230330213134.131298-8-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20230330213134.131298-1-kch@nvidia.com>
References: <20230330213134.131298-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT005:EE_|SJ1PR12MB6337:EE_
X-MS-Office365-Filtering-Correlation-Id: 791ace4c-cc38-450a-c54d-08db31665c76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: usPD2AvvedW7IQqeaj3k1SXCjZmVdE5H4l/zajC3wT9AxrdIXhoMU2K7HPSbyj7O91OG4NIbSBK1ay0xBkq611owkRBWUmAmirPqMcrVva+idBdkiIWuuwMYWozM8vgJ+qmOWckEWRnY8AFOzauLYH5jRIu+dKQLZn31vIT7PYY9gpjyubVOfQhXlQj/ZoRNTzWtJa+eL0s0tQHOCfbA0QTFUGnuy7cSEA4WeJ38UHFGVJ/6SPbXIihpggUppZ26F4zMvFVPVozSUgCcBLahzILGf0ztpAa/T7aQeWTFrisc0SbhTo9Rnkp0OlwGrTslSrmdEqZH3JRVszBr52awf9HqpU8GJN+rTUYmWO7LvAu5kIBqJ1Y7JZvF+hC1OD6a8J+j2l/mtGayVPsYsFuZDUUa7eqjzP8oQA3mS0uCyCjSFxZIycFALx02sbG6qymgVMaEcxonmMmkXsKjqfI9BOcm6HNYsOg/aX6rYEvc8i50QeLrKMwuPSNsMF2iSPq9R2ZryMf1f2v4UZ2kxO8nBAa1JXB2wR15zoHSiYQa03ZiFRPigitYCihX9zU9PoCyiwYChqN82WUITMBNVgCnGQqAGFYeeVIhFfCf5u4N87D2/QdLXXvC0Ed2jxlHrc8J1QSeb71goRu/MGkR6vACfPtkEqN2pSkbit2R1NcKnN+UHzGpol4wpS7f/Fp7zMc7rP5A6R56QJigQ3TL3QwTYW7Nff95kKT+2Q/34X2tmJ4hxq+IP1b0M55yEI35VThBxBdzGYwBY1Pt/bQtto8/U1VQnLYs8zkz2/MLz4OFekI=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(396003)(39860400002)(136003)(451199021)(46966006)(40470700004)(36840700001)(6666004)(70206006)(4326008)(40460700003)(1076003)(316002)(6916009)(8936002)(47076005)(26005)(54906003)(34020700004)(82740400003)(41300700001)(356005)(7636003)(70586007)(186003)(83380400001)(5660300002)(2616005)(478600001)(8676002)(336012)(36860700001)(7696005)(426003)(16526019)(82310400005)(2906002)(36756003)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 21:33:10.9676
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 791ace4c-cc38-450a-c54d-08db31665c76
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6337
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Right now we don't check for valid module parameter value for
queue depth, that allows user to set negative values.

Add a callback to error out when queue depth value is set < 1 before
module is loaded.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/block/null_blk/main.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index c13f0f2b8d86..96ced0485e35 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -264,8 +264,23 @@ static unsigned long g_completion_nsec = 10000;
 module_param_named(completion_nsec, g_completion_nsec, ulong, 0444);
 MODULE_PARM_DESC(completion_nsec, "Time in ns to complete a request in hardware. Default: 10,000ns");
 
+static int null_set_hw_queue_depth(const char *s, const struct kernel_param *kp)
+{
+	int ret;
+
+	ret = null_param_store_int(s, kp->arg, 1, INT_MAX);
+	if (ret)
+		pr_err("only positive values are allowed for queue_depth\n");
+	return ret;
+}
+
+static const struct kernel_param_ops null_hw_qdepth_param_ops = {
+	.set	= null_set_hw_queue_depth,
+	.get	= param_get_int,
+};
+
 static int g_hw_queue_depth = 64;
-module_param_named(hw_queue_depth, g_hw_queue_depth, int, 0444);
+device_param_cb(hw_queue_depth, &null_hw_qdepth_param_ops, &g_hw_queue_depth, 0444);
 MODULE_PARM_DESC(hw_queue_depth, "Queue depth for each hardware queue. Default: 64");
 
 static bool g_use_per_node_hctx;
-- 
2.29.0

