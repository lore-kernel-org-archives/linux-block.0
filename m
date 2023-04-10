Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DEA1C77B6F
	for <linux-block@archiver.kernel.org>; Mon, 10 Apr 2023 22:14:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbjDJWO0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Apr 2023 18:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbjDJWO0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Apr 2023 18:14:26 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2055.outbound.protection.outlook.com [40.107.243.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 302591BCE
        for <linux-block@vger.kernel.org>; Mon, 10 Apr 2023 15:14:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DRQV+8KAZqm0YyFuf2Uil+f21HWDbGEfqEUR2a3C4ZpKNN4vrg2sTEibYN665aoJmdT3nW8Q3bVhbhD/PwNzGkBVI5gYYWEzBHKt2GM1DtaF4xlGrMi7ZuzvgwjtFS9bdTboaOXsfkPVOzt0d6MhcKcYfUUkREBx300NASOJ1fV/KAMwZcMevRs19A1g5T6DWZbuLg2wThtise9gH3Q1twm1rK+cHevEiIeV5R7U11syaR7vJTY/Cjw5aGuahDwB2J4CsCkZ0OHpV5lg3RVAfRXETEEWqyV+j4izh32IuTE8uXFwKgdMBZHqDRuBTqaB3R7jwwAHTHJsKdO/L751dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=csjTieGA2APZOtDTBJCuxZ4a/WC0TW2l0c9PV2vPzDM=;
 b=i4Ox8u/iyjOrD/w19f34VZu7UPmBPL8XogssDuWGHBPXgDKe6F4YVJ9i3f/HHOrhgT7KCbIxsneXOXW2p62VaDqG54csUgVXq2xGPJ41DSugUfEwRM439uR8fF1ePOR6QXQIZ91lDczrRKt43tjiXjlhA+iQZxvYhwgzHQLepCz95wLouc9gmbAMx4n8DaTkl9y1YajA35r8XsKhCJpsolOiHVKrLWFHX5zOog3HsaWqi/ADFsA17N37sSy8bLfXcfcYmg30VgvqZxuSlXTCUuOZeuTuP6z6IYiZRhZHXbNQwoNGATxGRl+dhFKbxsJAQaKOTAHcYvI//8Hz8RPvng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=csjTieGA2APZOtDTBJCuxZ4a/WC0TW2l0c9PV2vPzDM=;
 b=KdirsGwY6s7O84B2W3Tsg1cBEHP6xLgAkC+ihijSld/9fhT/dVNb00MS/DP0BP24+RndsF9u/fN4V5dKa3UV+DwFyEpY4q2mkO8IJvKnZjfkM1NF1Ssq5or3uO82oEM13xnwvWlFYXarrJ8C9Yk+UaGuHcdtOoNdCAPAMNU2C2ierYv1IhgCRz63AaZKT166wv1VYd1Apl3UTFcg7XMTCsLJI+WrLoIJ6G2H+OihavYcqGF8uVJOj/gyqZd+Z99+O2i8mek4d+TH028CEHz+4s5zaAwzJ2AjY2OpPDX9Y4Vt74ifEMPIsa9YM9Kjfpo+swNmbWRMHsHjq4PH9KrnKA==
Received: from DS7PR05CA0083.namprd05.prod.outlook.com (2603:10b6:8:57::29) by
 DS7PR12MB6240.namprd12.prod.outlook.com (2603:10b6:8:94::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6277.35; Mon, 10 Apr 2023 22:14:23 +0000
Received: from DM6NAM11FT095.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:57:cafe::7f) by DS7PR05CA0083.outlook.office365.com
 (2603:10b6:8:57::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.25 via Frontend
 Transport; Mon, 10 Apr 2023 22:14:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT095.mail.protection.outlook.com (10.13.172.180) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6298.24 via Frontend Transport; Mon, 10 Apr 2023 22:14:23 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 10 Apr 2023
 15:14:11 -0700
Received: from dev.nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 10 Apr
 2023 15:14:11 -0700
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-block@vger.kernel.org>
CC:     <axboe@kernel.dk>, <kch@nvidia.com>,
        <damien.lemoal@opensource.wdc.com>, <johannes.thumshirn@wdc.com>,
        <ming.lei@redhat.com>, <bvanassche@acm.org>,
        <shinichiro.kawasaki@wdc.com>, <vincent.fu@samsung.com>
Subject: [PATCH V3 1/1] null_blk: add moddule parameter check
Date:   Mon, 10 Apr 2023 15:13:53 -0700
Message-ID: <20230410221353.76261-2-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20230410221353.76261-1-kch@nvidia.com>
References: <20230410221353.76261-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT095:EE_|DS7PR12MB6240:EE_
X-MS-Office365-Filtering-Correlation-Id: f197c280-8c0c-47f6-3cdd-08db3a10f086
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BLrMlDnxH0piud3bWzm3LpOXKDKU5MzKkJvx74GKj6+iZ/M9obFbIQfm5h19Jpk+faOBjQsouewi0HYzKBV1KA+/WM0X2NxReI9q/lGIKQgAEVcUsYSxjlnJgyKpzIeOunV3UnC0dWAJ1c4g3q4KVuP7rgPqZFurbDA179sichTPbBZdPGt77/laGcC554t2qoCVGVW3pzLJDpYYKq3GCt3+4t1Ve73/buBkiORlUeLi5O2MaPu+vsB2lSE3XFEmP1h6iesrCU3rp0lhytCxLH1HMvtTZQN6Wm3ob92ZHvFyzjV619Fsj8p7h47IzyYZpzJFy2/Vw8VxG/fMfkEnI05u+n74zRqTIJ7auoTTVk71iwOJ0RE6f/rGK/QuwkyHprCklgAYFyGirgFVe1N1oKtoFAEa+dlS/JtPWFSTooZohCuGyBXzYGzTyQFcbg+5CcwJZZzzKRDG69jz0kBZbAb5IeRioZ/RpSB77ASebdY2vfSW0LSzw1vQSTl1MYCD0ETKZw7DuAyIIl06WVIs2LTfdwPdX5rjAxvMiMquiU9ctMaB7oqbIWB1NzuY9vXHaf/qt9yPHU6drt2SBAjEQa3ZtCusbd4GPKugckKHEeBIvOmGzrmpp8JTfR5HDOKO39gxBqXN9vw+pWEzeKkUrKU7JanmPjgLxRTnRULU/j45NJcQOs358EIEVaC1B2qH7XUdpxcg834ZDlg3MakjIWCziA8MZVI3HhUKdtQnFbRSlaoqNClnAzdr5rgBuD7b
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(376002)(136003)(346002)(451199021)(46966006)(36840700001)(40470700004)(316002)(82310400005)(54906003)(356005)(7636003)(36860700001)(82740400003)(70586007)(8676002)(70206006)(6916009)(478600001)(4326008)(336012)(426003)(47076005)(2616005)(186003)(26005)(16526019)(41300700001)(36756003)(1076003)(83380400001)(2906002)(7696005)(40460700003)(40480700001)(8936002)(6666004)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2023 22:14:23.0867
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f197c280-8c0c-47f6-3cdd-08db3a10f086
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT095.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6240
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
 drivers/block/null_blk/main.c | 89 ++++++++++++++++++-----------------
 1 file changed, 45 insertions(+), 44 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index bc2c58724df3..2682d3c6067a 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -77,6 +77,37 @@ enum {
 	NULL_IRQ_TIMER		= 2,
 };
 
+static int null_param_store_int(const char *str, int *val, int min, int max,
+				bool check_power_of_2)
+{
+	int ret, new_val;
+
+	ret = kstrtoint(str, 10, &new_val);
+	if (ret)
+		return -EINVAL;
+
+	if (check_power_of_2 && !is_power_of_2(new_val))
+		return -EINVAL;
+
+	if (new_val < min || new_val > max)
+		return -EINVAL;
+
+	*val = new_val;
+	return 0;
+}
+
+#define NULL_PARAM(_name, _min, _max, is_power_of_2)			\
+static int null_param_##_name##_set(const char *s,			\
+				    const struct kernel_param *kp)	\
+{									\
+	return null_param_store_int(s, kp->arg, _min, _max, is_power_of_2); \
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
@@ -86,11 +117,13 @@ module_param_named(no_sched, g_no_sched, int, 0444);
 MODULE_PARM_DESC(no_sched, "No io scheduler");
 
 static int g_submit_queues = 1;
-module_param_named(submit_queues, g_submit_queues, int, 0444);
+NULL_PARAM(submit_queues, 1, CONFIG_NR_CPUS * 2, false);
+device_param_cb(submit_queues, &null_submit_queues_param_ops, &g_submit_queues, 0444);
 MODULE_PARM_DESC(submit_queues, "Number of submission queues");
 
 static int g_poll_queues = 1;
-module_param_named(poll_queues, g_poll_queues, int, 0444);
+NULL_PARAM(poll_queues, 1, num_online_cpus(), false);
+device_param_cb(poll_queues, &null_poll_queues_param_ops, &g_poll_queues, 0444);
 MODULE_PARM_DESC(poll_queues, "Number of IOPOLL submission queues");
 
 static int g_home_node = NUMA_NO_NODE;
@@ -116,45 +149,23 @@ MODULE_PARM_DESC(init_hctx, "Fault injection to fail hctx init. init_hctx=<inter
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
+NULL_PARAM(queue_mode, NULL_Q_BIO, NULL_Q_MQ, false);
 device_param_cb(queue_mode, &null_queue_mode_param_ops, &g_queue_mode, 0444);
 MODULE_PARM_DESC(queue_mode, "Block interface to use (0=bio,1=rq,2=multiqueue)");
 
 static int g_gb = 250;
-module_param_named(gb, g_gb, int, 0444);
+NULL_PARAM(gb, 1, INT_MAX, false);
+device_param_cb(gb, &null_gb_param_ops, &g_gb, 0444);
 MODULE_PARM_DESC(gb, "Size in GB");
 
 static int g_bs = 512;
-module_param_named(bs, g_bs, int, 0444);
+NULL_PARAM(bs, 512, PAGE_SIZE, true);
+device_param_cb(bs, &null_bs_param_ops, &g_bs, 0444);
 MODULE_PARM_DESC(bs, "Block size (in bytes)");
 
 static int g_max_sectors;
-module_param_named(max_sectors, g_max_sectors, int, 0444);
+NULL_PARAM(max_sectors, 1, INT_MAX, false);
+device_param_cb(max_sectors, &null_max_sectors_param_ops, &g_max_sectors, 0444);
 MODULE_PARM_DESC(max_sectors, "Maximum size of a command (in 512B sectors)");
 
 static unsigned int nr_devices = 1;
@@ -174,18 +185,7 @@ module_param_named(shared_tag_bitmap, g_shared_tag_bitmap, bool, 0444);
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
+NULL_PARAM(irqmode, NULL_IRQ_NONE, NULL_IRQ_TIMER, false);
 device_param_cb(irqmode, &null_irqmode_param_ops, &g_irqmode, 0444);
 MODULE_PARM_DESC(irqmode, "IRQ completion handler. 0-none, 1-softirq, 2-timer");
 
@@ -194,7 +194,8 @@ module_param_named(completion_nsec, g_completion_nsec, ulong, 0444);
 MODULE_PARM_DESC(completion_nsec, "Time in ns to complete a request in hardware. Default: 10,000ns");
 
 static int g_hw_queue_depth = 64;
-module_param_named(hw_queue_depth, g_hw_queue_depth, int, 0444);
+NULL_PARAM(hw_qdepth, 1, 65536, false);
+device_param_cb(hw_queue_depth, &null_hw_qdepth_param_ops, &g_hw_queue_depth, 0444);
 MODULE_PARM_DESC(hw_queue_depth, "Queue depth for each hardware queue. Default: 64");
 
 static bool g_use_per_node_hctx;
-- 
2.29.0

