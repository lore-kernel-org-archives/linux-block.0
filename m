Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FF5AC77B61
	for <linux-block@archiver.kernel.org>; Mon, 10 Apr 2023 05:14:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbjDJFO3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Apr 2023 01:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjDJFO1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Apr 2023 01:14:27 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2068.outbound.protection.outlook.com [40.107.237.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F1933C1E
        for <linux-block@vger.kernel.org>; Sun,  9 Apr 2023 22:14:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f8BOLArbdIRYF14+f7nI/HHVYf4d4SA7IoypJmkt9WG9GcQjqzoxWIL13ouwGhsF26AVYJptAmHLlOHrCV9oo0EDQDZPrDScPF3akNiFthDwDNVApeHxMqlEbClOiSxmRFLvqSPeswQRE9CgsDLH5CmFnXioPEnktZSAQ60r59zQ59H2c5MatpMUrE80MWER/2nlERcKtQRTxtN/tjrT4+65XYzpr+kSjxSy6No/ayBxk6KnrAayZbPY+amPPdvC9plRtp9IQv9V8P3patzqUsaDsQxCUWKsJaXOiUsg43PkcNOobdWeyS/yTQ1PhG1r2jzjAhFv5iIQNbA8jpSOMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zcFJ1eBCB+Dl53Js7Efz8rz7dEuzboPEFiBtTP5fKD8=;
 b=PTJGMG/fxZV/3T9fn8gJA77G1b8UaoCRgqJ0qWtUbmIRqdesyktfOkAC2U3fOAUilzdTO7Cfm5CEy3kzBWQhghIrOyubA+DipElG8uYJfq03u47izGjbARPRdp+IbYPLOtyQdghF+YvxDBvPjy4qgG+SRu9WCrvTjRcEGM7clrDcD/yIa/euTenXzvU1y30edqvWix3EbZzo7IMqH4TcdLvdk0kXN/U/UvJQG1A8UxvBXROgaVFKe5ohslNYt6bcLI4BRplWB0xbRjRfYdZm40CMz6gv8HAncElDmF+bZadgE5xLWnCw7HQEBKhpLEFuuV1SUUW3armFwzoPhNoLRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zcFJ1eBCB+Dl53Js7Efz8rz7dEuzboPEFiBtTP5fKD8=;
 b=PA6GNsvClq/ifO2zHi4BXn7aE6NBY2vfqRBz4tvuXN5BpZ20dISgRomrocumc/20RpQuNR81BQhXkAqD4OUIIdlhjkGQkNRhTpb/g2vLJnegpUFOw0y2qEMvCg/OKRYfKnGbitLUoHj0hJj+wJaXrCRMipNMnh2FLWa+i3AboMgFumRVEQMxS6UAhFMJZGlAsGdGAQh+KGbLw+uH0x6IV0j3Jui8kYxwH3+cUtRcAT0KRo1rKXmdhFM8YgabWWVPe2UMYmirhJbb5o7BS1FD5c3edKedcDdNgeqZ7IeKw6k0qy8opZ3Ea+FHRzotSi36fv/YQrrJciXMlG/YWOJmCQ==
Received: from MW3PR05CA0023.namprd05.prod.outlook.com (2603:10b6:303:2b::28)
 by SN7PR12MB7322.namprd12.prod.outlook.com (2603:10b6:806:299::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Mon, 10 Apr
 2023 05:14:24 +0000
Received: from CO1NAM11FT043.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2b:cafe::48) by MW3PR05CA0023.outlook.office365.com
 (2603:10b6:303:2b::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.27 via Frontend
 Transport; Mon, 10 Apr 2023 05:14:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT043.mail.protection.outlook.com (10.13.174.193) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6298.25 via Frontend Transport; Mon, 10 Apr 2023 05:14:23 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Sun, 9 Apr 2023
 22:14:11 -0700
Received: from dev.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Sun, 9 Apr 2023
 22:14:10 -0700
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-block@vger.kernel.org>
CC:     <axboe@kernel.dk>, <kch@nvidia.com>,
        <damien.lemoal@opensource.wdc.com>, <johannes.thumshirn@wdc.com>,
        <ming.lei@redhat.com>, <bvanassche@acm.org>,
        <shinichiro.kawasaki@wdc.com>, <vincent.fu@samsung.com>
Subject: [PATCH V2 1/1] null_blk: add moddule parameter check
Date:   Sun, 9 Apr 2023 22:13:52 -0700
Message-ID: <20230410051352.36856-2-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20230410051352.36856-1-kch@nvidia.com>
References: <20230410051352.36856-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT043:EE_|SN7PR12MB7322:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d96ec88-fbf0-4f06-ae15-08db398272f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: waLZTzxS6lGwosdMDKtY0dRytBQNXsjK+YQtnPPr2bQ6ahuYi0zkfqyLjrQR93M5QCZNJQzt4wz9ML4rvRA7jt67bkAgeX4ryYp40tsKZPwyVjPgW8r+BMo1+nrDRP5MaU7fwKyCr8CCWxqje6fKDWtolqcf8FEd/Ky8QDBxWa1+MBEd338Et4Pk13TwTluWNAHAsldoG0ywSziKFLwucnuvPwmJHIiv0K/6sCLuWnGg/jtk2bUibkRwDa/yXKKonF+sYdxWdfppGHTd8t65PCBrI2/cIwz16bAGH1r6OGqUH2WM/PwsbLIvrCJP6KrABqgX7zALSKvbrHOKEbXFqqLRaByf5kI9sGvIUpU/wuB0CLIjbsiRT0QwUs1OGxC5iHKsI86yjxl5lXpAPC9xWjYGTfegjsKRoSx4lfhog4gW84L/qJSb8JRrZcX5FlOscq0azIRWNj3Ih5Ul8GY9Sz7owK8004662EFhk8EFjj4YS3COkBjNTtcA4Th/C+4acbyuR4jjc/KkKs9DbbqKfu/jgCB8TJGB87JjrkY+GzwLMZhIryWf5kDx4SaERxWhyEBZCu3gnMRum9aNSMOs3lIlv93BO273PyhHho/5jjwZARF17rDdzEKfE326kPFbHSDtq2lWKZpqjwDlRFWsk5S2p/GMsowS0aXLY880RvMN/9CGx87ZNbGfRR3EhFMBE9mSITCyVNIqn7HBRPyCdHjnxCTbZm8brs3NVdVtclmqCNc2rHS7+mEj7e5jDqnl
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(376002)(136003)(396003)(451199021)(46966006)(40470700004)(36840700001)(478600001)(7696005)(6666004)(54906003)(316002)(1076003)(26005)(16526019)(186003)(2906002)(70586007)(70206006)(6916009)(4326008)(41300700001)(8936002)(8676002)(5660300002)(82310400005)(356005)(7636003)(82740400003)(40480700001)(36756003)(40460700003)(47076005)(83380400001)(2616005)(426003)(336012)(36860700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2023 05:14:23.8467
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d96ec88-fbf0-4f06-ae15-08db398272f1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT043.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7322
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Move null_param_store_int() function to the top of the code so that
it can be accessed by the new NULL_PARAM() macro. The macro takes
name of the module parameter, minimum value, and maximum value as
input, then creates specific callback functions and kernel_param
ops for each module parameter. This macro ultimately calls the
null_param_store_int() function, which returns an error if the
user-provided value is out of bounds(min,max).

To prevent negative values from being set by the user for following
list of module parameters, uses NULL_PARM() macro to add user input
validation:
	submit_queues
	poll_queues
	queue_mode
	gb
	max_sectors
	irqmode
	hw_qdepth
	bs

This commit improves the organization and safety of the code, making
it easier to maintain and preventing users from accidentally setting
negative values for the specified parameters.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/block/null_blk/main.c | 85 +++++++++++++++++------------------
 1 file changed, 41 insertions(+), 44 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index bc2c58724df3..fcb2ce4f9dc8 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -77,6 +77,33 @@ enum {
 	NULL_IRQ_TIMER		= 2,
 };
 
+static int null_param_store_int(const char *str, int *val, int min, int max)
+{
+	int ret, new_val;
+
+	ret = kstrtoint(str, 10, &new_val);
+	if (ret)
+		return -EINVAL;
+
+	if (new_val < min || new_val > max)
+		return -EINVAL;
+
+	*val = new_val;
+	return 0;
+}
+
+#define NULL_PARAM(_name, _min, _max)					\
+static int null_param_##_name##_set(const char *s,			\
+				     const struct kernel_param *kp)	\
+{									\
+	return null_param_store_int(s, kp->arg, _min, _max);		\
+}									\
+									\
+static const struct kernel_param_ops null_##_name##_param_ops = {	\
+	.set = null_param_##_name##_set,				\
+	.get = param_get_int,						\
+}
+
 static bool g_virt_boundary = false;
 module_param_named(virt_boundary, g_virt_boundary, bool, 0444);
 MODULE_PARM_DESC(virt_boundary, "Require a virtual boundary for the device. Default: False");
@@ -86,11 +113,13 @@ module_param_named(no_sched, g_no_sched, int, 0444);
 MODULE_PARM_DESC(no_sched, "No io scheduler");
 
 static int g_submit_queues = 1;
-module_param_named(submit_queues, g_submit_queues, int, 0444);
+NULL_PARAM(submit_queues, 1, INT_MAX);
+device_param_cb(submit_queues, &null_submit_queues_param_ops, &g_submit_queues, 0444);
 MODULE_PARM_DESC(submit_queues, "Number of submission queues");
 
 static int g_poll_queues = 1;
-module_param_named(poll_queues, g_poll_queues, int, 0444);
+NULL_PARAM(poll_queues, 1, num_online_cpus());
+device_param_cb(poll_queues, &null_poll_queues_param_ops, &g_poll_queues, 0444);
 MODULE_PARM_DESC(poll_queues, "Number of IOPOLL submission queues");
 
 static int g_home_node = NUMA_NO_NODE;
@@ -116,45 +145,23 @@ MODULE_PARM_DESC(init_hctx, "Fault injection to fail hctx init. init_hctx=<inter
 #endif
 
 static int g_queue_mode = NULL_Q_MQ;
-
-static int null_param_store_val(const char *str, int *val, int min, int max)
-{
-	int ret, new_val;
-
-	ret = kstrtoint(str, 10, &new_val);
-	if (ret)
-		return -EINVAL;
-
-	if (new_val < min || new_val > max)
-		return -EINVAL;
-
-	*val = new_val;
-	return 0;
-}
-
-static int null_set_queue_mode(const char *str, const struct kernel_param *kp)
-{
-	return null_param_store_val(str, &g_queue_mode, NULL_Q_BIO, NULL_Q_MQ);
-}
-
-static const struct kernel_param_ops null_queue_mode_param_ops = {
-	.set	= null_set_queue_mode,
-	.get	= param_get_int,
-};
-
+NULL_PARAM(queue_mode, NULL_Q_BIO, NULL_Q_MQ);
 device_param_cb(queue_mode, &null_queue_mode_param_ops, &g_queue_mode, 0444);
 MODULE_PARM_DESC(queue_mode, "Block interface to use (0=bio,1=rq,2=multiqueue)");
 
 static int g_gb = 250;
-module_param_named(gb, g_gb, int, 0444);
+NULL_PARAM(gb, 1, INT_MAX);
+device_param_cb(gb, &null_gb_param_ops, &g_gb, 0444);
 MODULE_PARM_DESC(gb, "Size in GB");
 
 static int g_bs = 512;
-module_param_named(bs, g_bs, int, 0444);
+NULL_PARAM(bs, 1, PAGE_SIZE);
+device_param_cb(bs, &null_bs_param_ops, &g_bs, 0444);
 MODULE_PARM_DESC(bs, "Block size (in bytes)");
 
 static int g_max_sectors;
-module_param_named(max_sectors, g_max_sectors, int, 0444);
+NULL_PARAM(max_sectors, 1, INT_MAX);
+device_param_cb(max_sectors, &null_max_sectors_param_ops, &g_max_sectors, 0444);
 MODULE_PARM_DESC(max_sectors, "Maximum size of a command (in 512B sectors)");
 
 static unsigned int nr_devices = 1;
@@ -174,18 +181,7 @@ module_param_named(shared_tag_bitmap, g_shared_tag_bitmap, bool, 0444);
 MODULE_PARM_DESC(shared_tag_bitmap, "Use shared tag bitmap for all submission queues for blk-mq");
 
 static int g_irqmode = NULL_IRQ_SOFTIRQ;
-
-static int null_set_irqmode(const char *str, const struct kernel_param *kp)
-{
-	return null_param_store_val(str, &g_irqmode, NULL_IRQ_NONE,
-					NULL_IRQ_TIMER);
-}
-
-static const struct kernel_param_ops null_irqmode_param_ops = {
-	.set	= null_set_irqmode,
-	.get	= param_get_int,
-};
-
+NULL_PARAM(irqmode, NULL_IRQ_NONE, NULL_IRQ_TIMER);
 device_param_cb(irqmode, &null_irqmode_param_ops, &g_irqmode, 0444);
 MODULE_PARM_DESC(irqmode, "IRQ completion handler. 0-none, 1-softirq, 2-timer");
 
@@ -194,7 +190,8 @@ module_param_named(completion_nsec, g_completion_nsec, ulong, 0444);
 MODULE_PARM_DESC(completion_nsec, "Time in ns to complete a request in hardware. Default: 10,000ns");
 
 static int g_hw_queue_depth = 64;
-module_param_named(hw_queue_depth, g_hw_queue_depth, int, 0444);
+NULL_PARAM(hw_qdepth, 1, INT_MAX);
+device_param_cb(hw_queue_depth, &null_hw_qdepth_param_ops, &g_hw_queue_depth, 0444);
 MODULE_PARM_DESC(hw_queue_depth, "Queue depth for each hardware queue. Default: 64");
 
 static bool g_use_per_node_hctx;
-- 
2.29.0

