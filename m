Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C124C433EF
	for <linux-block@archiver.kernel.org>; Thu, 23 Sep 2021 01:51:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E92F6115A
	for <linux-block@archiver.kernel.org>; Thu, 23 Sep 2021 01:51:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238851AbhIWBwv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Sep 2021 21:52:51 -0400
Received: from mail-mw2nam12on2080.outbound.protection.outlook.com ([40.107.244.80]:55520
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238817AbhIWBwv (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Sep 2021 21:52:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RpvJU0ZM9R6PEGGlK2pV1QLd9SqTPhvT0ZyCtL3rL2Ir689lMyzoBDXXGcwcXOxnGc2pkyPrJIu1otMIrCX1Vt6/wocWAExHqRKOi5fEQI057plxvOH3rhZwfdh9NaVqDE3dmGVIhd3Drlon1ggh4WL3YDWwMBXsFzEPqu7Rz8Lzk2p9l6oBMKZSR/XI52AgsPVGlG8e4kyHqqmnlMoiFRZBqOyVG8NAAkI9EvcTk5Gn9TVBSwvT6tcDrFF0nPQlEOA2crWaQK7PM90mpI+yP4PZM+YfNEAq3GXVLvPZHmAZ4eeUBKOIWzGBu6BGSJQCSASvyuDnIFCELeItw1NYjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=WhegZps1GvwBN9JBNm4GtwfYiV3aHgaDGOveINy+oYg=;
 b=Iuno+0V9VVM+cjqs1PUYgTCJigEI6E5xtxttB6RVdmHwPTp/Vyl7Y2llCL22zLdlqtNVeFuq/voDVXGaxSa/7iWRKgd8+ZoJaOkVusbvHzr7j3G8Swwhpyt49FsTRGZXHyeqCIqMVkzZoMfDH9EWPQfbJqDojBW070Dus7JXqqgyG4XR1Niy0Ho0f/Lsew3J+8K/KllltNZFiL8wSoXBVGBcpZH7U6IqK/26Dpc/ssKTMpPrRfUWLVuH0YH99XCTYK7iCkUifZwP25IcfKDfVpjZ/XmZfabpXWdrVQ6zM59qW1Ey+L4AZVXpHXoYtcPzVIAJ3uDFizNPlxIcOVIrYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WhegZps1GvwBN9JBNm4GtwfYiV3aHgaDGOveINy+oYg=;
 b=q5aoG8a+0/aAPMGhTtRM/vI8mBx/59SHJfIroFRZR2lUxAYXZ/G0o8Q4Md3VSuSVC3KQnR1Q9Gbu6+cF1bnG3jtr1IAbCGmWqJ2XqtTedKDEaLPd1w2XZfIALY/LUDqvCpGgXPGcB6a9C00fkHPRh30q7BKmXcQMegffPcVb5L83bjQowQ4+W4otSTb27Cr3+NIiQ4dgC0EdZ7BAskauPhbxy6FpskeW8QYvZ7UezbeKTVOhyfQ2eQSiZebteMbY2JcLCjdhiXao4BltLvHTAZwqbLJFE36oBurL3Zb8LAabsw0FhGP6HH6EVZc4XnOnop2MJJXUlbIHvh0uLYtCVw==
Received: from DM6PR03CA0011.namprd03.prod.outlook.com (2603:10b6:5:40::24) by
 SA0PR12MB4382.namprd12.prod.outlook.com (2603:10b6:806:9a::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4544.14; Thu, 23 Sep 2021 01:51:18 +0000
Received: from DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:40:cafe::e6) by DM6PR03CA0011.outlook.office365.com
 (2603:10b6:5:40::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend
 Transport; Thu, 23 Sep 2021 01:51:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT018.mail.protection.outlook.com (10.13.172.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4544.13 via Frontend Transport; Thu, 23 Sep 2021 01:51:18 +0000
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 23 Sep
 2021 01:51:18 +0000
Received: from dev.nvidia.com (172.20.187.6) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 23 Sep
 2021 01:51:17 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     <linux-block@vger.kernel.org>
CC:     Chaitanya Kulkarni <kch@nvidia.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: [PATCH V2 8/8] loop: allow user to set the queue depth
Date:   Wed, 22 Sep 2021 18:49:45 -0700
Message-ID: <20210923014945.6229-9-chaitanyak@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20210923014945.6229-1-chaitanyak@nvidia.com>
References: <20210923014945.6229-1-chaitanyak@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 18dde720-d8cf-4258-6c13-08d97e34a303
X-MS-TrafficTypeDiagnostic: SA0PR12MB4382:
X-Microsoft-Antispam-PRVS: <SA0PR12MB438249B3AB8BE8FFAFDA0C2CA3A39@SA0PR12MB4382.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kCDNt6sb17dInhcX8anWwi1Yg2BmelvX/hm7FkP13zqWQBhO1RpJ7ZnNOyWQ8/8n544ysX9BBet4Zv8sfjsiBmgiTVenlgzfyQsdQnDeLCehZ2+VV4MMiXPHiCKkyx99wVXkrXSw9sdRjiMn/YAmW73rqyFxzNQc4gstubzRqoNFNMEDH10HMBPz/XJUEodNu326KjWpFE37c8ajdEW68XexDY5kNYHXC2YdtgZlTjEW/JpIyN7lgc4nEgO4+aB9nqK5BLvve+c/RU5NgTdVu+6N8X7i60hizI3wdQ30euTjlPo27ZAnLHiafGtTkHodaT/qp38ktVjexhHVG3ipOsSk4kFDWTFDKiM7e10fqAeeGF9zl+9UEaMqSXQQqB38OTZt1+d1/SElgeoaK/Vs/Lq1t6NLmL9NjHwmJsF5g/9ZMNHKkhNY2CbaL/0oKsc5b8A3JVFJc4r1w79H5JNmlZqndWUUxvwXYuqPTuUIx2Ou1ii85Jc/9N/l91K+Q2pAauh5D0apAjuAQK38aC3ZtJLZjO8F3+NellV95ktA2p5Rp9eXdoOekrCMVtYFW8+NvF91L2FiFyx+vw0yPi68zADX6CHgNPLOwAW0LG86ffL1u/5yP1dC5a4c9tWxAXerdIBiJu/wFyc8KphvF/t8QDqPa3QcopljDLOnt99fj8PKPiNh4F8CFuRCK2Lu79+NOmm/eKomxmwdOCRbfbTdAw==
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(82310400003)(426003)(2616005)(356005)(7636003)(36756003)(336012)(86362001)(83380400001)(5660300002)(7696005)(1076003)(8676002)(6916009)(36906005)(8936002)(70206006)(316002)(54906003)(6666004)(70586007)(16526019)(186003)(26005)(36860700001)(47076005)(508600001)(4326008)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2021 01:51:18.6836
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18dde720-d8cf-4258-6c13-08d97e34a303
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4382
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Chaitanya Kulkarni <kch@nvidia.com>

Instead of hardcoding queue depth allow user to set the hw queue depth
using module parameter. Set default value to 128 to retain the existing
behavior.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
---
 drivers/block/loop.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 6478d3b0dd2a..aeba72b5dd2d 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -2096,6 +2096,9 @@ module_param(max_loop, int, 0444);
 MODULE_PARM_DESC(max_loop, "Maximum number of loop devices");
 module_param(max_part, int, 0444);
 MODULE_PARM_DESC(max_part, "Maximum number of partitions per loop device");
+static int hw_queue_depth = 128;
+module_param_named(hw_queue_depth, hw_queue_depth, int, 0444);
+MODULE_PARM_DESC(hw_queue_depth, "Queue depth for each hardware queue. Default: 128");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS_BLOCKDEV_MAJOR(LOOP_MAJOR);
 
@@ -2328,7 +2331,7 @@ static int loop_add(int i)
 	err = -ENOMEM;
 	lo->tag_set.ops = &loop_mq_ops;
 	lo->tag_set.nr_hw_queues = 1;
-	lo->tag_set.queue_depth = 128;
+	lo->tag_set.queue_depth = hw_queue_depth;
 	lo->tag_set.numa_node = NUMA_NO_NODE;
 	lo->tag_set.cmd_size = sizeof(struct loop_cmd);
 	lo->tag_set.flags = BLK_MQ_F_SHOULD_MERGE | BLK_MQ_F_STACKING |
-- 
2.29.0

