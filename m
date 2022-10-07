Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A55FC433F5
	for <linux-block@archiver.kernel.org>; Fri,  7 Oct 2022 06:31:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbiJGGbZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Oct 2022 02:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiJGGbY (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 Oct 2022 02:31:24 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2087.outbound.protection.outlook.com [40.107.243.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B7D5E319D
        for <linux-block@vger.kernel.org>; Thu,  6 Oct 2022 23:31:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LMwy/RC8n4J+e4sWWk7McmOwKiVju0oeXO9KFrig4WI/J9mbge+KkukCdcNmuLPW6xw5OuW3ggVmjgkZqi10tDZwIMeS20pCjtSkE1qjFMNUBmb62yf36X53TNRSQoAba40DL2xRopAlyQi4lxUD50xCzxJ4zuKqESvNK6q0XAGuKaWGqjIi94yzpFDIHLd8+NlMOJIfXAVNpjzZmf9nglh+q83I5wPp0psd2Hm89o5yAr3CqcEPF0MdVwuG2PC+maq4RCe9ewKLf+YcnVaytaV5PbB84NSGL9aYnvlzjvdlPNTY8+dKjYRur+BPRFZxZ5RYhYhpKln/ZyCA5rFVRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DSVaPpVQWWC2wfvjU3mMWpESVILb/hT2nHhrbRVE2p0=;
 b=FVQW9bo57aL77vNENj+dvvifNNf+F7/R6sDZec+KGE9qwAa3A7sjs0senpI8k6Mv3YhFGA3J0OLi6z292F1AJzIGAE/2VYY3BdAM10d+ylai30aA1ON/sGn/dqirDUGOVDqWbGxyuWmQI9MSU9OHG6kYD1MXTA24J0Fp7j+XK5zRb8OclAWbpESUepfD+5lu29UIjjJ/JP7zFBMUJZC0O3iXlUzZllF4CgmEIgT+lb7p8Fo4fSCAabsYtoPL+I4rQ0hijZKi0LaWuwLC9SyHxrcxnZccArChe0Acw3CLXfykC+xhRlRskDjuIoRlmyn8n1+rlTrrZyBS6c8uTYbL/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DSVaPpVQWWC2wfvjU3mMWpESVILb/hT2nHhrbRVE2p0=;
 b=fZaS/mrKCzC3CqEj/WhefYBJcC2JVkqYH1QBxjeFFWsGc7CQRjUZHFWA8f0LRTejr+Yz+5dHQoF/in+RkdKWiwAgidps3JXIwFl1LIcsxwIvp9dh14uS3GXiITcrKDh6YxDW9JPcP2qEYepJcUWUwNerg6QX9/zoYMD//xIQBwH17sxFb2HfMaUXqA4h/ZBZ40MXYoyxJHasZGfrw/PKGir726nvf5nIQzUoAMVZtZeiCZvK2mKablE4KRXuVivF+0GT1tGKnZWJS6w9/Yo0nO2r/Q0uHcqUAOhpql1GEgppok+NfhUwxVLa/xYjGszVva1AEaOrjJI0F7l0UU+8Kw==
Received: from BN0PR04CA0189.namprd04.prod.outlook.com (2603:10b6:408:e9::14)
 by CY8PR12MB7588.namprd12.prod.outlook.com (2603:10b6:930:9b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.19; Fri, 7 Oct
 2022 06:31:20 +0000
Received: from BN8NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e9:cafe::84) by BN0PR04CA0189.outlook.office365.com
 (2603:10b6:408:e9::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23 via Frontend
 Transport; Fri, 7 Oct 2022 06:31:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT067.mail.protection.outlook.com (10.13.177.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.10 via Frontend Transport; Fri, 7 Oct 2022 06:31:20 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Thu, 6 Oct 2022
 23:31:04 -0700
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 6 Oct 2022
 23:31:03 -0700
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-block@vger.kernel.org>
CC:     <axboe@kernel.dk>, <kch@nvidia.com>,
        <damien.lemoal@opensource.wdc.com>, <johannes.thumshirn@wdc.com>,
        <ming.lei@redhat.com>, <bvanassche@acm.org>,
        <shinichiro.kawasaki@wdc.com>, <vincent.fu@samsung.com>
Subject: [PATCH 1/6] null_blk: check for valid submit_queue value
Date:   Thu, 6 Oct 2022 23:30:31 -0700
Message-ID: <20221007063036.13428-2-kch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT067:EE_|CY8PR12MB7588:EE_
X-MS-Office365-Filtering-Correlation-Id: 321f04f1-0e65-4bb5-88f0-08daa82d8c21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ez5uDB5mTq2kmOGJpcsJ0BGtVTggzdiOxxJDnkmAVjOBHhlvXovB4XzYBPQ5G7n7Ef67UEjrsu1E7U3Hc3FeaJTM5paOHG/9N2LC9P1f3d9gb8gSj+wszQKg8Ol9u61zU1HeHyPAUuoKsJ3Vz5JxUpEh1DvjdtLpdRoE6EEO5avU53a/4yP1AwPdebSe+S+YE6VnxuABNFYDOflBiJ9AVJn8sC0Hsb4vJyCM81m6iUzEmVy3wxnJp7x+7X3hg48WM63hv7P35UcHSE53Lm99GHC4fzhFe+SoEj9nAjKQQfvNZYHJJqHKkhL7vmfU8K21f8CwgQ5wKg8GgFRre/wXkMp8HQFF99IyP4V+MoeHK1s4/kbofUSiDjQeft15qe5/SElh3Av1sxJOBKgH5Kydse4iyZLiRbWuRt0Tp1a8czTZX6HJm6QHpTWlQ9fAA9ZSM5sOpc/zWX32qJn2IWkZAB6K97XXv7oF6VHOssQdMQk7ubCT+MdDXXVoeG9xDG08VcKUpL4zJqUxFNDRr1Cp+mlVSob5ApwuWKj+TPypOL31+6O9FDhOkhs4tb9RKfhS8+UOm1xPKLrtk9SGMTDQogp4OCMXNIO6kdS2ADzuZPlRE7/SXI3tSdvVBdZCEAq1tZxigTO7IxxAYQ5AKqW52S6O+XEqGllkFfqJFMwJBSbFb/XEvEoKyhLHkpBFOutHTFuJazTutkuwqwH4HkNE9KWzy5BRyiiwwzW7Wo2Qgy/mbA2D8j5ofMf63gw3LobqVxQpngLuqdH8GB6dQ37w+g==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(376002)(39860400002)(396003)(451199015)(40470700004)(46966006)(36840700001)(8676002)(26005)(6666004)(82740400003)(70206006)(356005)(40460700003)(478600001)(7696005)(70586007)(7636003)(4326008)(36756003)(2616005)(36860700001)(54906003)(1076003)(426003)(82310400005)(186003)(336012)(83380400001)(6916009)(16526019)(316002)(47076005)(41300700001)(8936002)(2906002)(5660300002)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2022 06:31:20.2318
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 321f04f1-0e65-4bb5-88f0-08daa82d8c21
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7588
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Right now we don't check for valid module parameter value for
submit_queue, that allows user to set negative values.

Move null_param_store_val() at the top so we can reuse that code in
module param ops.

Add a callback null_set_submit_queues() to error out when submit_queue
value is < 1 before module is loaded.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/block/null_blk/main.c | 42 +++++++++++++++++++++--------------
 1 file changed, 25 insertions(+), 17 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 1f154f92f4c2..c8dbff120c65 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -77,6 +77,21 @@ enum {
 	NULL_IRQ_TIMER		= 2,
 };
 
+static int null_param_store_val(const char *str, int *val, int min, int max)
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
 static bool g_virt_boundary = false;
 module_param_named(virt_boundary, g_virt_boundary, bool, 0444);
 MODULE_PARM_DESC(virt_boundary, "Require a virtual boundary for the device. Default: False");
@@ -86,7 +101,16 @@ module_param_named(no_sched, g_no_sched, int, 0444);
 MODULE_PARM_DESC(no_sched, "No io scheduler");
 
 static int g_submit_queues = 1;
-module_param_named(submit_queues, g_submit_queues, int, 0444);
+static int null_set_submit_queues(const char *s, const struct kernel_param *p)
+{
+	return null_param_store_val(s, &g_submit_queues, 1, INT_MAX);
+}
+
+static const struct kernel_param_ops null_submit_queues_param_ops = {
+	.set	= null_set_submit_queues,
+	.get	= param_get_int,
+};
+device_param_cb(submit_queues, &null_submit_queues_param_ops, &g_submit_queues, 0444);
 MODULE_PARM_DESC(submit_queues, "Number of submission queues");
 
 static int g_poll_queues = 1;
@@ -116,22 +140,6 @@ MODULE_PARM_DESC(init_hctx, "Fault injection to fail hctx init. init_hctx=<inter
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
 static int null_set_queue_mode(const char *str, const struct kernel_param *kp)
 {
 	return null_param_store_val(str, &g_queue_mode, NULL_Q_BIO, NULL_Q_MQ);
-- 
2.29.0

