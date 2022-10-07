Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18D09C433F5
	for <linux-block@archiver.kernel.org>; Fri,  7 Oct 2022 06:32:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbiJGGcW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Oct 2022 02:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiJGGcU (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 Oct 2022 02:32:20 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2046.outbound.protection.outlook.com [40.107.220.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3734CC4594
        for <linux-block@vger.kernel.org>; Thu,  6 Oct 2022 23:32:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kDWC/t/4dmslbJ81Q0/ze1xll6Nc16uIayWeyE7igVCfLLwliYAwhy5Hd/di9Irn7PYXWLuJrHZVJsEWK6N+RDNc3RLrYq00lMYGFFcDZozvuKbEyGAixPM7urlwSMznqTZXobwUgqCmE59LryQpKZsTMsGwwvZLqgclTf3kHMcDf7Ir4nPgArJW4+CSUzLux+ATrWSUVVH1p2ZaJ/BtMDTEBY7Kxd9m++7/8SXhpexiqcTRQnamuozAl3A8XuibXV4smo/2QthmgB5ALDnjKKtNRXEGGq8CqTVqLy+870D7CtVKK78cuy27kFPM6dM3m1rkrbLIpGA2oMsF2N9H3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ffz/m9EapRYdEuNUhQr4hjGXmUzzPF8SQq+c3j8nnq0=;
 b=NgkyRCLqWiscoPxIjQkGpLimWf9/nLts+G9p6YsIExuYsk3Xips5u60lN74PY3RJ46dYkI05PVTn3Lb3tkf4m889W0ptIfqF6aG0NTh93TuaGEHbCMR3G11XRD7LIKdTMRExwPfTp1SY8WKVej3LwNGE24EP9GdZDmsBgNgPOmAqLvwK/na7AJG1Rs9oRjy49oNO2vEUiiG7E66lIO077O7Je0LK7oV8sYaqhwcoa5UAn+Kn3Wgw35Dwy088fxlbrcw7rn5y4rAxRTC1hN/CvnYqjjzsUsbQfzbdRWDRODg5dUegs1e+DqyX9dEfhT5cYw/zWLpqi1ZDwiMSkQLxwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ffz/m9EapRYdEuNUhQr4hjGXmUzzPF8SQq+c3j8nnq0=;
 b=VDdSiZqWSNF/betBQq5+IoXl5tIE8dkRUxaR4weAJKGZ3Tokwis8r1LWDhnZ8rPSHt8QsiW1ZFBkx7trnXcb1nvjYFW52Fb57QstCeyMiZnm02Sqem/Ebl/rx1+hK0gM5rzeJjzjhKR61+x7vgDqB+kzILhtsYnXIYppaMXpc99CZTqxi8A3v/yIaRvTt1a64msAymhsTUC+dohd9qWX11bT5Msfq78YtbIqVrniadodNyTRjSqgYNnXJ/dYZKAZ8dulfV77h103IKqOh06LUV7Z8XGFyhKt6M4r86bisS1MXs+edb2HxhxbL1cEwaieJDcn2kIaOPyCcdZoc01Zaw==
Received: from BN9PR03CA0523.namprd03.prod.outlook.com (2603:10b6:408:131::18)
 by CH2PR12MB4890.namprd12.prod.outlook.com (2603:10b6:610:63::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Fri, 7 Oct
 2022 06:32:18 +0000
Received: from BN8NAM11FT092.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:131:cafe::be) by BN9PR03CA0523.outlook.office365.com
 (2603:10b6:408:131::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24 via Frontend
 Transport; Fri, 7 Oct 2022 06:32:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT092.mail.protection.outlook.com (10.13.176.180) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.10 via Frontend Transport; Fri, 7 Oct 2022 06:32:18 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Thu, 6 Oct 2022
 23:32:01 -0700
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 6 Oct 2022
 23:32:00 -0700
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-block@vger.kernel.org>
CC:     <axboe@kernel.dk>, <kch@nvidia.com>,
        <damien.lemoal@opensource.wdc.com>, <johannes.thumshirn@wdc.com>,
        <ming.lei@redhat.com>, <bvanassche@acm.org>,
        <shinichiro.kawasaki@wdc.com>, <vincent.fu@samsung.com>
Subject: [PATCH 6/6] null_blk: check for valid queue depth value
Date:   Thu, 6 Oct 2022 23:30:36 -0700
Message-ID: <20221007063036.13428-7-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20221007063036.13428-1-kch@nvidia.com>
References: <20221007063036.13428-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT092:EE_|CH2PR12MB4890:EE_
X-MS-Office365-Filtering-Correlation-Id: 7dd0d718-b952-4840-1c8b-08daa82daef0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DpCKQua//mJCOfWYPR8t13++Eyw6bK4OgvTs9UfGZ6fKHS3RoZxRtZCOc+B7oXrSqjUD+fdR6b5Mu9tQ5lW2O6NBFSzjVXv+tAF/7ZPjx9TgAn07Vts/9/R7KBz8NyxhoZ7HXdnUMA2OokxYY1GylQjJZLq9zMbyYNjU3Vb8u30I+Cd0JY1QmPCTA4tsldy6N5GzQh5IOwQ8T3YpN+rEQRvIMsKYqYQm3bOToLCAfeLdRgfX++jjqSPx818DhrwFFsWwH6Eeug0yn0jS9ojevm653zskfteMaIb1vW31t6zySW5nbtJU87s9a/7V1XmvxNjmRBBrerBqx6mUum1ix34/yRqCPQNWgHhkzO9fBu+FlGRMlCbrtMyo6Ras0WXBWisacNw9Ng7/np6fz1eAtqu/+sr1vpY/cPcSx73lt7HyhvGWERj8eu774ddrBhXC8yQILQUXxrEHRAqASKghZOQyK+daAIDBcoQ4vIAQRN+LsfQNYPrHs175MFPP8TuGgJX9WtiDSIWxjtSe785cd7Oof81qx4D9rEWPNMOBMe9R7yGDtWvlJa4peQbaBh+ytBBV1M39+lUJMr6a8xhm9qSRqTVRuMCCOn312gpFmL+lZHGkPJLPl0tfuoWviEEds8Vc+1XldlRRAdmzsVUj4hKkHykSaWzz9BI/D0562CChMvMI4mgyOvcFOkcLZp24PhqE4b5yt7Bvb8zoGK2McihRmlvLCQm93VGdK0e3cuW2ftGauFsCmVllXDxQRAHdcgL2LqZP+UySMEWCCTBxyw==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(346002)(396003)(136003)(451199015)(46966006)(36840700001)(40470700004)(336012)(47076005)(7636003)(478600001)(2906002)(54906003)(356005)(82310400005)(6916009)(70586007)(2616005)(36756003)(16526019)(1076003)(186003)(26005)(82740400003)(70206006)(4326008)(5660300002)(8936002)(426003)(8676002)(316002)(41300700001)(83380400001)(6666004)(40480700001)(7696005)(40460700003)(36860700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2022 06:32:18.6281
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dd0d718-b952-4840-1c8b-08daa82daef0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT092.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4890
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Right now we don't check for valid module parameter value for
queue depth, that allows user to set negative values.

Add a callback to error out when queue depth value is set < 1 before
module is loaded.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/block/null_blk/main.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 1b9fa5af02d5..ae339376f112 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -246,7 +246,18 @@ module_param_named(completion_nsec, g_completion_nsec, ulong, 0444);
 MODULE_PARM_DESC(completion_nsec, "Time in ns to complete a request in hardware. Default: 10,000ns");
 
 static int g_hw_queue_depth = 64;
-module_param_named(hw_queue_depth, g_hw_queue_depth, int, 0444);
+
+static int null_set_hw_queue_depth(const char *s, const struct kernel_param *p)
+{
+	return null_param_store_val(s, &g_hw_queue_depth, 1, INT_MAX);
+}
+
+static const struct kernel_param_ops null_hw_qdepth_param_ops = {
+	.set	= null_set_hw_queue_depth,
+	.get	= param_get_int,
+};
+
+device_param_cb(hw_queue_depth, &null_hw_qdepth_param_ops, &g_hw_queue_depth, 0444);
 MODULE_PARM_DESC(hw_queue_depth, "Queue depth for each hardware queue. Default: 64");
 
 static bool g_use_per_node_hctx;
-- 
2.29.0

