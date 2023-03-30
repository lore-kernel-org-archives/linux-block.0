Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84C69C6FD1D
	for <linux-block@archiver.kernel.org>; Thu, 30 Mar 2023 21:32:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbjC3Vcw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 Mar 2023 17:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjC3Vcv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Mar 2023 17:32:51 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on20601.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eae::601])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 615E3CA26
        for <linux-block@vger.kernel.org>; Thu, 30 Mar 2023 14:32:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XaZOyvx3lC2KSUc/gxfOR/oZCkoOJgu1OO5limemxJYMKc5+YzyPpwmNdpXOBk7pXolZrPH3p/fEPVWIURa2PVavJnePtqe5AFQ7qlhrNocchiKKcCi/H+GVkWxKfCbV5KoFvL22tC/gxbGV86IQtHosJWzDJYlNOJLsJeV+v5iaQRyU/TGJkLO577r/WUcUY03M3xaZcCNtnnGYaWrKKtL9dC9mG7HWrWouckKZXNHcdF3KwHeijYqYjGZ9Oes+aW9S1/CI5L3+lpygAEKmt0lPt4Ws8GuqjLDeDTOzIPei7WTa43E0sojXgkSySAEfm/Bj/Pi6dRA4QpNKDlaUBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e/Tfg0W2RLBd86B5HfF9hIp9S8HIJaCsipdxWlaUfzA=;
 b=h67j5FYxidPQEIH5hRhc4e6UfKyNEYWfUX7o5HOANqYVe3VhWgoCYIQQq2755Vgb2MspFuHCeh0VTkAHVK78dXhk/l22UwAXzFy146OjWRgnHhwswunJ8WofGN7nvueWuXreHVqesRVgo/lXymO8VXVK/Tcccf1K0IPlBEYri+dbPBJ5pVlO8fQ3gXbwk93rzEVSEX7lKV6kf0J/qNPdWvVeeVjHxDPb6pBFynFuSZceulNnKbU0+/mgV+guSQYEXDQGyibrQdl/wEOamZ0koQoWcSqknPbShuGI8suI1vuX38gF3xovixS31yRxV4ZIMioH14Ix0j80iZxQ8Z6pzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e/Tfg0W2RLBd86B5HfF9hIp9S8HIJaCsipdxWlaUfzA=;
 b=BG78O6pgOCLR6to/xBjMzcQbouL1BkJVh23ImIl0vkOox4ikf71ZIGnMqdIvVuzvCAuRnOlt9DWLCVvlgTQQbS/G99E2KmCeq4uxs/6r2lGMiE//3Nijd9BdcvTnQurAiVVCZh7DWJS29/e8nbDa9M+Y9SHJu/8J8DrDz6546HXjOIfFBFoiSsYwAQv2di277J1lcM29KDKjsDDlb5K9erLmDDJqmWKy83FuvSx7zAZdvPd3LoP8vDuOqB4KnW43+7Z2SkOQ9dYs9SVGXyWsypogemkKyD6565m9coNJ1IxWs/W87SWELq4fbEPSkf/VksIlFzHP8D4GIiNVMyzVdQ==
Received: from MW4P220CA0002.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::7)
 by MW3PR12MB4554.namprd12.prod.outlook.com (2603:10b6:303:55::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22; Thu, 30 Mar
 2023 21:32:47 +0000
Received: from CO1NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:115:cafe::86) by MW4P220CA0002.outlook.office365.com
 (2603:10b6:303:115::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Thu, 30 Mar 2023 21:32:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT005.mail.protection.outlook.com (10.13.174.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6254.21 via Frontend Transport; Thu, 30 Mar 2023 21:32:47 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 30 Mar 2023
 14:32:41 -0700
Received: from dev.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 30 Mar
 2023 14:32:40 -0700
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-block@vger.kernel.org>
CC:     <axboe@kernel.dk>, <kch@nvidia.com>,
        <damien.lemoal@opensource.wdc.com>, <johannes.thumshirn@wdc.com>,
        <ming.lei@redhat.com>, <bvanassche@acm.org>,
        <shinichiro.kawasaki@wdc.com>, <vincent.fu@samsung.com>
Subject: [PATCH V2 5/9] null_blk: check for valid block size value
Date:   Thu, 30 Mar 2023 14:31:30 -0700
Message-ID: <20230330213134.131298-6-kch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT005:EE_|MW3PR12MB4554:EE_
X-MS-Office365-Filtering-Correlation-Id: 76c52c26-6e66-4fc5-3a2b-08db31664e37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s2R4sjtewK8wmQAesCLYFQhTF9jrSPNy15GMyLgMr/5VR8cKrRic2w2B4w/iJU1N6qQ65R0Cw1K8u8qe8bfl09nb6Tc5hW0Y4Cm8O2/Hmz6zm/fldW5G3UMLs7zOZlOPCm4M3EtVKsBF8y+vESgYl2nCs2jXttLuSJgpcmh72LgqGbsZA6pRBkxsqtgnWDDHXha66W7wXUNPG1q8aaJFfZmrXs8G3d9WC6/ssWysgZUs3iONMsu/IHJDcKHVlujtZSf/jrD9CglVcBT9k/tIsGa+SU4PJ608nkoVHkrLRTv/6o5gD3xKOoBWr7NG4hST/0WcueJFY90dGdix6khyU/Y1XJ39AFlx1eU1v7WakFcx4LwYml0dIAMVS2YsKc2F5vJ67XLpixfK6yihslE2tqprfqW/r1zS5UsYa09I5I0ElKGuWcPoH8vvnoO10VwmoB59wgvHx/sa08sVNadzl2Ea0q7M/fLw0seoQGpwXlap6eyMbQir/eF+H1QZIvd0uV7jO4JgMFvfREjpZFy/jBqHuZUw/bUfhsS6ofANY/AgM1S4ge2JhcyG3EKGsYhUDQ45xpcesyDkyRMi9Rpc4depm1o12zvmeOTaqUX/PPyuUafk7O45KLwuAmpPYNx2ut5+dLV+4lCC5hNwgl9oH4P1KapUUxWJNyei8H+mDbiVBTV9ZyvZf2nyUpd0ywTKY2+yUHNVXuW9rt/i8M/Yka0X/Yr1sV1n0TlIGQ11kNnLsS2F+kCS7fTxnw8lLxvD8r2YAKPBBoa++KBdxpMcfYXbbqoJzA2AKvU5l0J4Dvk=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(396003)(136003)(346002)(451199021)(36840700001)(46966006)(40470700004)(41300700001)(1076003)(34020700004)(36860700001)(2616005)(478600001)(82740400003)(54906003)(356005)(7636003)(40480700001)(36756003)(426003)(336012)(82310400005)(316002)(186003)(26005)(6666004)(16526019)(7696005)(4326008)(40460700003)(6916009)(47076005)(70206006)(83380400001)(70586007)(8676002)(8936002)(5660300002)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 21:32:47.0787
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76c52c26-6e66-4fc5-3a2b-08db31664e37
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4554
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Right now we don't check for valid module parameter value for
block size, that allows user to set negative values.

Add a callback to error out when block size value is set < 1 before
module is loaded.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/block/null_blk/main.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index f55d88ebd7e6..d8d79c66a7aa 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -190,8 +190,23 @@ static int g_gb = 250;
 device_param_cb(gb, &null_gb_param_ops, &g_gb, 0444);
 MODULE_PARM_DESC(gb, "Size in GB");
 
+static int null_set_bs(const char *s, const struct kernel_param *kp)
+{
+	int ret;
+
+	ret = null_param_store_int(s, kp->arg, 512, INT_MAX);
+	if (ret)
+		pr_err("valid range for bs value [512 ... %d]\n", INT_MAX);
+	return ret;
+}
+
+static const struct kernel_param_ops null_bs_param_ops = {
+	.set	= null_set_bs,
+	.get	= param_get_int,
+};
+
 static int g_bs = 512;
-module_param_named(bs, g_bs, int, 0444);
+device_param_cb(bs, &null_bs_param_ops, &g_bs, 0444);
 MODULE_PARM_DESC(bs, "Block size (in bytes)");
 
 static int g_max_sectors;
-- 
2.29.0

