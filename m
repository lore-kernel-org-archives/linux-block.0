Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E6B8C433F5
	for <linux-block@archiver.kernel.org>; Tue, 15 Feb 2022 21:34:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231561AbiBOVeS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Feb 2022 16:34:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241795AbiBOVeR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Feb 2022 16:34:17 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 950E8FABEF
        for <linux-block@vger.kernel.org>; Tue, 15 Feb 2022 13:34:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ijAeyG7DU74i54CVPTi4jRdeW4p4IuQceSgMKSzqXF9rCqvKP0y6jQmMDz7Bnmv/Gv1xDaYXA85NbnBI65xGGPaDrqRzxc3Nqgc83uihJHO7b9UYv4NeljNp+DFfDkDr97ftrUfBoq/LofDWQgzLM0zOfZtkIgrs+WBilQ/fHfVHNxxNxWNiJHSMKF3ytWuxuF3EfbjwrdS3/zTK3msWmvqyrzp4Xmg0RNygjpSB0ncUJSUVsW6W3IkfzhOI7ryuJSlBIEH891B5l26NDHYyjw9U6OHWWZVi6Ot/Ld1ok0wDYY6W7B1oMfmEJg3eM6Qlb7CUAf1olYE2Y4a87GLu2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s9u3XF3wiAIYV3Ut+Ec8ykfdNogvmp6E9IteWwTDl5U=;
 b=INLE7f5Utmsz5fZaRGmhoOW8hwXU/sST3b4mzbc68vQAnP7ZyDVNY9ynU/IG4rjJVv5Dq7qUxl5JIulr8Poa8RVWEr3jNlMZqbNSs2S3b9UGmxnAvQ16ORJ1LV9N1bSV/uN8TNqGyUL4Zkab1VVAJsbUGXa45vQKSl/Ytpd2HX6qkZ8NcGnHmA6MAoy9JP7f349f+uexskl+zShG8GHSJzqxCQxScjyjyu+7uqJ5aOp27OV6KVg04y8qEWwiZBQULd83HpBZeARw1ZSVKTVI7VFniLPBoWETCdyOInzasH85QmxK13kOtZWsDAycT2htzBtUBzPD4SYBDc1GAMVNEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=oracle.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s9u3XF3wiAIYV3Ut+Ec8ykfdNogvmp6E9IteWwTDl5U=;
 b=h1SwIr4HoiLbjSlW8uLd3o7sQfgksyUqRzRYsexRGrPJ/FMr3jGUuELjw9MAFU88QJdOaTLMtqOll+ry8vKSKqqY6dFzoGSWKSLjkd+zuqANKa79wHCH9m3bm1hjil3JMBjvfq66+8UM802bB+W5qSF5MCHUd56+oj+n/9WqBEJKoLsqCphgvw6BdXzK6M0G5P+aX0BLf6I96egDOSPUzO+ahsapkQClGShF5j6qQTPhRZ2ozuNTEHilias+q8PP2ZthSSXRuIpLoTECukFoi1gM79koB4Z6zGKh6g75Cm6N6R/oNlDuIOfWkx9k69hR8lGzQZiwkl2hpyAkpYgUxw==
Received: from DM6PR06CA0090.namprd06.prod.outlook.com (2603:10b6:5:336::23)
 by SA0PR12MB4463.namprd12.prod.outlook.com (2603:10b6:806:92::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Tue, 15 Feb
 2022 21:34:04 +0000
Received: from DM6NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:336:cafe::17) by DM6PR06CA0090.outlook.office365.com
 (2603:10b6:5:336::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11 via Frontend
 Transport; Tue, 15 Feb 2022 21:34:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 DM6NAM11FT042.mail.protection.outlook.com (10.13.173.165) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4975.11 via Frontend Transport; Tue, 15 Feb 2022 21:34:03 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 15 Feb
 2022 21:34:01 +0000
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Tue, 15 Feb 2022
 13:34:01 -0800
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-block@vger.kernel.org>
CC:     <axboe@kernel.dk>, Chaitanya Kulkarni <kch@nvidia.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: [PATCH V3 4/4] loop: allow user to set the queue depth
Date:   Tue, 15 Feb 2022 13:33:10 -0800
Message-ID: <20220215213310.7264-5-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20220215213310.7264-1-kch@nvidia.com>
References: <20220215213310.7264-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 669fba71-f92c-4663-d4b6-08d9f0cae34b
X-MS-TrafficTypeDiagnostic: SA0PR12MB4463:EE_
X-Microsoft-Antispam-PRVS: <SA0PR12MB4463F9D86E30B95C17BC7F6DA3349@SA0PR12MB4463.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:449;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eGfa488zyAAuXDitOd9ZuZWDf3YLyfWzUXkdogOI32S85xR0shM0sKxhiutUnXK3foxkIOj5b/2CsMID5o9Tm2AUMYqp0O8dht0puvMeCxYmYThVDwLOsF2dVljZhdswwcb9EaQN0IqoMlF8EvYk+qUdBlP4hj8X07GPo2OsdZJ19Rs/hBlPhBES5YdzXRyH+OeUy9UR98tTkWmQi28A2rgEYPjS2i741PklvTxbwFQl5A1mtDDw5l96YJzN3taay8qzB5W9KgcjXohcAYyhYgQJooU7wBULfcmGG6o8pPVmIkI6MSq3K93PDXUSBCVQH3sPcuGscgjoZ5oSqljDHrWUKuACaizPzC7DYTtHCeFkylhD6rSuncb5pl4gUOxR2nZFP8/42TWXEJgMEfu+kgg6OGxIA1mOIhwDEMrAq9DneW15kPHupvYmWfd3vTMZOMU/G91Cz1D7BPqBlFwJCEqgmVWh7c33JAe6AIAgdiogQX4PAyX2l0Y6pOW/9fqo6X7tBdHRhGqPeztjUBeiJ0Y5BKR3pAfLHkpSESlO5tv5YdjOVKrasCwGgfrI7xJhh1nMlvRAeRiPOcl+k/yLO90CgPxd12bxS0g+piOlYSEF23XlyVSMEeR+Jj4lG7/cSFWYm80Vr20tkj/NKz65EXeCbCVPCNAVmNzSJP4uN5f8bLa6nPghYXdgW+/mC6ir/+neJ77q8IP2zNdt/TKeYA==
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(186003)(16526019)(70206006)(4326008)(70586007)(82310400004)(26005)(36860700001)(7696005)(1076003)(8936002)(5660300002)(83380400001)(2616005)(8676002)(6666004)(40460700003)(47076005)(54906003)(6916009)(336012)(426003)(81166007)(316002)(2906002)(36756003)(356005)(508600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 21:34:03.5687
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 669fba71-f92c-4663-d4b6-08d9f0cae34b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4463
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Instead of hardcoding queue depth allow user to set the hw queue depth
using module parameter. Set default value to 128 to retain the existing
behavior.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
---

Detailed test log for this module param is at the end of the
cover-letter.

---
 drivers/block/loop.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 18b30a56bfc4..c9a732a22767 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -85,6 +85,7 @@
 #include <linux/uaccess.h>
 
 #define LOOP_IDLE_WORKER_TIMEOUT (60 * HZ)
+#define LOOP_DEFAULT_HW_Q_DEPTH (128)
 
 static DEFINE_IDR(loop_index_idr);
 static DEFINE_MUTEX(loop_ctl_mutex);
@@ -1785,6 +1786,24 @@ module_param(max_loop, int, 0444);
 MODULE_PARM_DESC(max_loop, "Maximum number of loop devices");
 module_param(max_part, int, 0444);
 MODULE_PARM_DESC(max_part, "Maximum number of partitions per loop device");
+
+static int hw_queue_depth = LOOP_DEFAULT_HW_Q_DEPTH;
+
+static int loop_set_hw_queue_depth(const char *s, const struct kernel_param *p)
+{
+	int ret = kstrtoint(s, 10, &hw_queue_depth);
+
+	return (ret || (hw_queue_depth < 1)) ? -EINVAL : 0;
+}
+
+static const struct kernel_param_ops loop_hw_qdepth_param_ops = {
+	.set	= loop_set_hw_queue_depth,
+	.get	= param_get_int,
+};
+
+device_param_cb(hw_queue_depth, &loop_hw_qdepth_param_ops, &hw_queue_depth, 0444);
+MODULE_PARM_DESC(hw_queue_depth, "Queue depth for each hardware queue. Default: 128");
+
 MODULE_LICENSE("GPL");
 MODULE_ALIAS_BLOCKDEV_MAJOR(LOOP_MAJOR);
 
@@ -1979,7 +1998,7 @@ static int loop_add(int i)
 
 	lo->tag_set.ops = &loop_mq_ops;
 	lo->tag_set.nr_hw_queues = 1;
-	lo->tag_set.queue_depth = 128;
+	lo->tag_set.queue_depth = hw_queue_depth;
 	lo->tag_set.numa_node = NUMA_NO_NODE;
 	lo->tag_set.cmd_size = sizeof(struct loop_cmd);
 	lo->tag_set.flags = BLK_MQ_F_SHOULD_MERGE | BLK_MQ_F_STACKING |
-- 
2.29.0

