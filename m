Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03C56C433F5
	for <linux-block@archiver.kernel.org>; Tue, 15 Feb 2022 11:51:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236138AbiBOLvu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Feb 2022 06:51:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237360AbiBOLvt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Feb 2022 06:51:49 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam08on2068.outbound.protection.outlook.com [40.107.101.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08AEE69CFF
        for <linux-block@vger.kernel.org>; Tue, 15 Feb 2022 03:51:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hz8JkgSKM8gdLnLf6OFYXgpI6Wxd3zFoBnjD0Msvc+lgEPMDybu0aYhlcN0ERdvFeEuFmah4qa8WXNiQZmqtXLAaoRTzkVSjwvzO7pNIUJ1R4XnQq5RiJD/VDilRZgaVNOxixI1qCg2pnDRsyY5MGYkm7vQj9F9IjoSxP4uYTVR/W6WTerpPxXd+3JpSyaPUiqNupEWSslcwco1nU/hdI7cIuO+EBLc+xp0C6mQeog6XdNDFGVTCHse6nx6ysx6tV7Y+YYT9Nh43X1UbLjazQ2AkFSAgWqn6ah7cgxqKToPYxMFFNx1FY4ocK9WkltHp0vT6WXCgnTxVvQ31KSdLjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tPRL8HISYCbWUWa86yzKyPNqFQr5skJ1vmQY5DJJ4s4=;
 b=BsAZjOHLt03EprLr/N6PHi7S33kEXbYYvF43cD9MPdXj1rbqhaiJ2R8TKIbvg3cO2OlsATOL24tRrHHNkP24SRPBiRmW+Qx6yaG8Wd6TETFOuF63rLn5n5xNqit3ooMzCHCKP/DzKlqxwKwyF5xLBEAHykWVtAi++C8MohKVl5BnZiX3jwzGNuHqx4EPQ396uNMGHYALZpYGO3nok7cJD1sKZSSANIMGVTESzuCRU47mxZ4q7+NP9OSJTDN9PBPOvLIYEOlFNx8l4K3kOChrsM6t93/gAFbB/p0DVtlY6k1m7faIsgAyjK+Rh0vquBBXvauu8JTMjdQIwTdPwXTE3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=oracle.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tPRL8HISYCbWUWa86yzKyPNqFQr5skJ1vmQY5DJJ4s4=;
 b=uGVs9s6OxPNM5ufBnRq9KavB8gG2UclDx6e4Ef3wQqS/t1dZl5ZdTj/GMe4DMM6Im7Ag1pPlnBer4m7QkpMtvKZbsfTJesEYWmC0BsTzm9PxWj4SIaC+XkpB1Ep88+QPjBvKdVY9YNEWiwS7dCzK87Qf/k8bTFuQrV3UoVQQNyM3B6xiGDUIQ6H8uYeu8IM+T5Q49xwn0Swn8hyOSIDY6JMkST3QnTi96DcfvsJ5LMLBw6DbSLltiENzfoRHArT1RIOif9ABsmjnT/DWPv/sXnzCk1yMY7+Ln1UAknBOxugqj4li28B06DSbT/+o9U37Fvm5hVbQpBH8JVwWcH7i7Q==
Received: from BN1PR14CA0013.namprd14.prod.outlook.com (2603:10b6:408:e3::18)
 by DM4PR12MB5794.namprd12.prod.outlook.com (2603:10b6:8:61::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Tue, 15 Feb
 2022 11:51:38 +0000
Received: from BN8NAM11FT066.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e3:cafe::de) by BN1PR14CA0013.outlook.office365.com
 (2603:10b6:408:e3::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14 via Frontend
 Transport; Tue, 15 Feb 2022 11:51:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 BN8NAM11FT066.mail.protection.outlook.com (10.13.177.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4975.11 via Frontend Transport; Tue, 15 Feb 2022 11:51:38 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 15 Feb
 2022 11:51:37 +0000
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Tue, 15 Feb 2022
 03:51:36 -0800
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-block@vger.kernel.org>
CC:     <axboe@kernel.dk>, Chaitanya Kulkarni <kch@nvidia.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: [PATCH V2 2/4] loop: remove extra variable in lo_fallocate()
Date:   Tue, 15 Feb 2022 03:51:02 -0800
Message-ID: <20220215115104.11429-3-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20220215115104.11429-1-kch@nvidia.com>
References: <20220215115104.11429-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7b319606-6b32-4bb5-9a11-08d9f0798643
X-MS-TrafficTypeDiagnostic: DM4PR12MB5794:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB57940BA7B1BD1C25FA3AD195A3349@DM4PR12MB5794.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tHJuKWjQhiIRT+h018CgXbs320aP0rorVTuHQ5EKeqCbkLYvZuv1cEFZtqakjDFxEK4ntL4/GZ+F9PZTc0A6xfTBvTknj0gaQSnRJmZ5RewG0RZcfjgxCwjx5IqE0nCugLDplm6LCc53J1dLMhvRKLhCk97SwIBHM9ss2PMbjVfm0M+ApoCQQskVBf/IvxWoVaS9GfqKv+zIEDSIjrrmAxXaM/C+CDfjYSUCg+NagsZEsfv850LWMarfY99EXhGOEQZOlDCuNG1v1KIrZ8RqLObIvJeeXH2AZlC0GE8v0LQStLvJOjgtK6qIoHaXa0I7a3ygy1dVOkaOpIi6Ll3stROnXvcYS3ClgF2jyqyrZ3ePlkiepsHxp3dS7XE52fBfj9X/lKBQeg5CQU2ParmBrOeuINP2+G0L5j0UN6ESHxQeka0s8UuB8702pAuBZ2nLkBpOjltc9CC3nQIx8LJDlnDzKmN4PZKhBhBG1gTjDJ6laiwRbACIwjHkYuube3nTa+1ZIIPrPxV0UaGet7/NBuKHq7G6rLkEf6sgSmQfgAQDJmCYOcQ+vQbBirDoDVHna4H+lspfgGLdYdyMPQdfp49UgEE2kJEVTSR7OhwRZFbZsXtMDQckkDEaWgoFuI2WdLcbm8ffBGg6JsduCVmyOy+Gc0/864n91yMaTgSNzX0h7oJbqjhJNqRerekcu4RI9KcVlSHY4ZM8kHh+G+yyZg==
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(7696005)(6666004)(36756003)(508600001)(40460700003)(6916009)(81166007)(4326008)(8676002)(70206006)(70586007)(356005)(54906003)(316002)(47076005)(1076003)(16526019)(82310400004)(426003)(26005)(2616005)(4744005)(83380400001)(186003)(2906002)(8936002)(5660300002)(336012)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 11:51:38.2203
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b319606-6b32-4bb5-9a11-08d9f0798643
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT066.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5794
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The local variable q is used to pass it to the blk_queue_discard(). We
can get away with using lo->lo_queue instead of storing in a local
variable which is not used anywhere else.

No functional change in this patch.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
---
 drivers/block/loop.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index a55e5eda1d17..77c61eaaa6e4 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -308,12 +308,11 @@ static int lo_fallocate(struct loop_device *lo, struct request *rq, loff_t pos,
 	 * a.k.a. discard/zerorange.
 	 */
 	struct file *file = lo->lo_backing_file;
-	struct request_queue *q = lo->lo_queue;
 	int ret;
 
 	mode |= FALLOC_FL_KEEP_SIZE;
 
-	if (!blk_queue_discard(q)) {
+	if (!blk_queue_discard(lo->lo_queue)) {
 		ret = -EOPNOTSUPP;
 		goto out;
 	}
-- 
2.29.0

