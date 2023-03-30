Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1320BC6FD1D
	for <linux-block@archiver.kernel.org>; Thu, 30 Mar 2023 05:53:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbjC3Fxx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 Mar 2023 01:53:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbjC3Fxw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Mar 2023 01:53:52 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04CDD1BE1
        for <linux-block@vger.kernel.org>; Wed, 29 Mar 2023 22:53:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NGZTDoL1i6CMM9hrE8g+WMqD3XiOQ7W5Izse+16/grUZHDLazWROXbc83f6AOnDv1DYv34Moay6UJHYUNoFLqZK57FpUNy2FgHIPfJIIkMkkojs7Okw23h8F1xDdvYm/I3Ki6Gi21ysYKMDtd2rctf+BaspMXosxKBSVGkeWug7a4jHk5o92MgXXYJpTQglCwMYEwv6Tg9xVz1MkXD/SwzhWzWPi5KPRdMcI7GZz6ghns+80lP8XeBMvub6zbCU80LwQ/OQzqPJkAgi3MWon6DkMPxhZQXGTT1nGfrTFqz1SakJGPlGMP/WYJDKICMDRxtpc/4rlnMrpeb2IePPNKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LV8H7MvdtRyt0gDumkRj+qTKRPYCxqSd1SvXnDw1Mj4=;
 b=O1x8LUVMX4txHhSIzzKHSmq0mVzEOXUr+fqLN4LvofhuKvBQpij/53eCn+ZNOGLeoA5Pnu2/spX0oVwbpVjnLKgLSTnXwOa7+wJGI2B2buGkCEmRTJYiwZnOkc8+JVdKaNcqFwp5mjtiuD9dfOInplkvIJMBw4OzBJg84BSldgeGrkNhPSyUkox5EEB4axeIS6vHsdcJYQAnCjNhJOH5loEgTP9+Y12aky2RMhrdTOfM8n/EPBUCfFyROpBE1DvtbmyIpaoutn9OuuYBtG5kzPOzjtC2zzGzUutVEhYpTvhtWH4/15MxK/w26079Lhl0QdK2MH68ZJ2uEwVI7VHFWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LV8H7MvdtRyt0gDumkRj+qTKRPYCxqSd1SvXnDw1Mj4=;
 b=eLIDqozCqWukQXchi6bIRlKn5UVnQhVXda3j58OEu7KcJWmUk3yFpeUcFEdcWVtJhs3y3iNC62LCBQCZ8RJy/knIc+CqdJEPttDCfx7inAr/YzVaW3aiEwkLJm+4GSO8wcnjF16GPb6JRixGCs4JmgDCOgIXkwKvaMs65CO0CzGJILBI3Myv5q6xVN4o1SNvXi7Lr7whmSGTRZrjV0XtcZUpKomBVjcRrFtXgAtnymk6z9S9zmuWCNEbblNgIVgioNg9zt1UL/aECBomhhV/mPyS6NlsB8zC5ATdCoVyR3apuUs/e/AXauqaFpLov5SPuP/nz57hfaR9DXeAYyCzGw==
Received: from BL1PR13CA0125.namprd13.prod.outlook.com (2603:10b6:208:2bb::10)
 by MN2PR12MB4112.namprd12.prod.outlook.com (2603:10b6:208:19a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Thu, 30 Mar
 2023 05:53:47 +0000
Received: from BL02EPF00010209.namprd05.prod.outlook.com
 (2603:10b6:208:2bb:cafe::1e) by BL1PR13CA0125.outlook.office365.com
 (2603:10b6:208:2bb::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.13 via Frontend
 Transport; Thu, 30 Mar 2023 05:53:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF00010209.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.30 via Frontend Transport; Thu, 30 Mar 2023 05:53:46 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 29 Mar 2023
 22:53:30 -0700
Received: from dev.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 29 Mar
 2023 22:53:29 -0700
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-block@vger.kernel.org>
CC:     <axboe@kernel.dk>, <kch@nvidia.com>,
        <damien.lemoal@opensource.wdc.com>, <johannes.thumshirn@wdc.com>,
        <ming.lei@redhat.com>, <bvanassche@acm.org>,
        <shinichiro.kawasaki@wdc.com>, <vincent.fu@samsung.com>
Subject: [PATCH 7/9] null_blk: check for valid queue depth value
Date:   Wed, 29 Mar 2023 22:52:01 -0700
Message-ID: <20230330055203.43064-8-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20230330055203.43064-1-kch@nvidia.com>
References: <20230330055203.43064-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00010209:EE_|MN2PR12MB4112:EE_
X-MS-Office365-Filtering-Correlation-Id: 448122b6-d98d-4417-ef34-08db30e320d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: npoGyIijDPUOS4hIU6Hns6uHZ0Jx6YFC1s/ojTmVSbwFO5aq24qKlwv8RLHySs840j11v9Uo6hYylpPH7fchM2H8GKXGqLbjKYQdNgBK14yDTUprsDSSRkJT6tSYFhDo7uIdY+tafkwNTjBLxYilIoDz6a1fn8FPzQMsNiV4wJCIDNZO+YW1BBX9W01r20Gz/jsf6ZRpG8aThdFeUYGNzZ0eX5VI4Rlv7t8bzOnLlkZBItsIVwhoLrNYN+ekSpB+dllwj43WtxpXDz2R1L6pKyXuk7f5uYtlNGUBtWfyZfj/SY0gxTzeBIAtegqRCM2LsTTUrTSs9U69rluAK2LIW8U3Qt7zgdyK8H9m78ndi5nJaqjoeV7VK6SalyugS//0UHmyQaoJMMFlf11aHfRThnGAU5kAF9XAP+ENV4byi213VJQ4XW5oGlBjrh9BV6UoDXK/UMvBxJhGhR1jN3vUF19mfcuMOoA3EOzoWVc4nNtO//sXZQ+rJlbEh61Rtfb6FkWolX0IV6uZITPCSyr2VerI0I6Mh5ma14p/hBKMlzJeNIBRuh3pSrzzb52CDBRT9CXmHXCcc1pEu/rHzXEUbXpvXABW86smhNEdjAV4ALFIYB4tMQymuY+y2sqB0lXRJoisKlslGmNfaovgZ4e9vqZHOUYqmziMW8mIOIoeJ5zBBLkBos0bCjHaehvqbZafzhJp0Yf05Pnf7DsS9Q2hm7QmtU9gWn8wIa9NN+3ULlcpLrOGliPtQ7lpXXly9wU+
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(39860400002)(396003)(136003)(451199021)(36840700001)(40470700004)(46966006)(186003)(16526019)(54906003)(6666004)(316002)(1076003)(26005)(336012)(426003)(83380400001)(47076005)(2616005)(7696005)(82740400003)(40460700003)(40480700001)(7636003)(82310400005)(8936002)(478600001)(5660300002)(4326008)(70206006)(356005)(41300700001)(6916009)(8676002)(70586007)(36860700001)(2906002)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 05:53:46.7848
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 448122b6-d98d-4417-ef34-08db30e320d6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00010209.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4112
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Right now we don't check for valid module parameter value for
queue depth, that allows user to set negative values.

Add a callback to error out when queue depth value is set < 1 before
module is loaded.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/block/null_blk/main.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 38f2c7c83de0..2834036f89c1 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -243,8 +243,18 @@ static unsigned long g_completion_nsec = 10000;
 module_param_named(completion_nsec, g_completion_nsec, ulong, 0444);
 MODULE_PARM_DESC(completion_nsec, "Time in ns to complete a request in hardware. Default: 10,000ns");
 
+static int null_set_hw_queue_depth(const char *s, const struct kernel_param *kp)
+{
+	return null_param_store_int(s, kp->arg, 1, INT_MAX);
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

