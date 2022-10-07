Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B50CC433FE
	for <linux-block@archiver.kernel.org>; Fri,  7 Oct 2022 06:31:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbiJGGbf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Oct 2022 02:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiJGGbd (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 Oct 2022 02:31:33 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2060.outbound.protection.outlook.com [40.107.95.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8129FC4596
        for <linux-block@vger.kernel.org>; Thu,  6 Oct 2022 23:31:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dOwerxenXwjMRhYL0PT9ETwHcLio96mQx9E3ig2Tb6PU+nNEqJO9MTStzh2ZsTyGpJGm2PHZBWd3woTlbf61uOPJ3PUB3aWGVsAoTHkogDhJBmeMyQqydkL8rJhuRWwEXZG5UtBACCgK+rUBIuU3Ef+UqikCnWosgHmETLeahz1nzsGwgSSQ61YBi/VFwD5EMnIrA9j7SorST1b6bcOVxXqPwKBXw/t9nlKdyPuyav4gj2hSJ5T3gDOKkY02YLiUSdc3RvBGCHjQUQsh3pTXGQeqtUlLJJzES6BcqUSYmY7hAFWr29Ae7DNTCtrqUb0pRzZR9ydZCPEBYmYMOXU+RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gkJgnMAhvE/GYEbPeGlpe+60NAIzCeDKkPPGcDEWCgQ=;
 b=BYaXQudU1wxCGUIHnjAKppJYWRCJEWB058+CrOxW8bQ7suCxQZKQ3p0sNiJfbA6SEoi5TsAcnMGIdfLCrNspB2A5WhfCxABfff+66IqKRpOknjwWroUFYjncyYSPW6Psc4VH+W9It2VC9ysUCMW2fagpQfJZE1LnC8kDpfgJs53IRv36ZeYCck6nuDIhZWnh0y3FFt+EXqlqdoD569vFtQ3MHNqS2k3onQLVT70UrlBGYNehQhTT8YDSAPiZ+doL/wT383Ro2dGmFVzKCpit6yIrosIdlNC9yI+yFxSbvgT60uJ1o2vM6mTAaQ1Z7FLPyCz26pTBWaEbIWHlw+90vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gkJgnMAhvE/GYEbPeGlpe+60NAIzCeDKkPPGcDEWCgQ=;
 b=R9lIhJV8AyuzNJ+TSoWjpZ9KSIU8OhNLMiU61mdo7yl/eazFRgbmqtNWypbEka+L/5yyQp1aCnzm6nfxP7K+GUEfMnGtyF9NhJM5a4b/kin0zNSo+olKuUAMXR9b+NvkaSDrdGkE2acUdNYCLZjtKjEUS2zAGACM9I6gkME7iNUHyQU41gtIHt66n4s9Rxv2UG/raik0bSzcM3TpM8nLEkz1yCglx8FTMxfRnQJHKvUoKc2p9UW6yXbvYiBZGGPmegkj9Vr9xuocmFtE1Ofe9lO1XQVcjmvvGpcMiz9UcHUmj07+VhVmoY85dOn61G3sLMEHwMzFcJUd9y5KQbF1UA==
Received: from BN9PR03CA0141.namprd03.prod.outlook.com (2603:10b6:408:fe::26)
 by CH2PR12MB4261.namprd12.prod.outlook.com (2603:10b6:610:a9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Fri, 7 Oct
 2022 06:31:31 +0000
Received: from BN8NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fe:cafe::b7) by BN9PR03CA0141.outlook.office365.com
 (2603:10b6:408:fe::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.26 via Frontend
 Transport; Fri, 7 Oct 2022 06:31:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT044.mail.protection.outlook.com (10.13.177.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.10 via Frontend Transport; Fri, 7 Oct 2022 06:31:30 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Thu, 6 Oct 2022
 23:31:15 -0700
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 6 Oct 2022
 23:31:14 -0700
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-block@vger.kernel.org>
CC:     <axboe@kernel.dk>, <kch@nvidia.com>,
        <damien.lemoal@opensource.wdc.com>, <johannes.thumshirn@wdc.com>,
        <ming.lei@redhat.com>, <bvanassche@acm.org>,
        <shinichiro.kawasaki@wdc.com>, <vincent.fu@samsung.com>
Subject: [PATCH 2/6] null_blk: check for valid poll_queue value
Date:   Thu, 6 Oct 2022 23:30:32 -0700
Message-ID: <20221007063036.13428-3-kch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT044:EE_|CH2PR12MB4261:EE_
X-MS-Office365-Filtering-Correlation-Id: 60cff45b-a112-442d-201e-08daa82d9255
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OxA0dM9Nq6+GwDI+xxfKXMLRyIzZNGogn/SKvFTOHSiHZL7w4pnSl6Q/5XfSDz87ArWQq8kmN2ZollR5AT8rdXEgH491nsLT6+SnWXSkAQh0dnz7I3EZZekJedtRkuVKkapn2J2zYEQT6IiXjdw9KQP3k9AWr/KdRpOIFE5UwU+8N77gGozV4GRPbJMtGw4VUXlNnn38oCuUKYB6QzJLop7sRTLmKWqaBqFd2qZZm2Uo3fR8uH5i2VqL8Ttjzpuocq2C6Pk8PqIaxAEJQGo8L76RTyl5cqbQwg2VfPndQkgry/W6lwDC6D1DE+wlTHAJJG6fRZHzfjH2NN9scOCXMMwG9TE7G9MRATmaOQgyOKaVw5ZDzYV/POtHk/sIxmNyrow4dwh3yOhKBF5TxpN3gLNxSbKvCsDPMEr3XmFqYTFQgl0H8UxjZn6Pmh7ifU3eS0QraPPU8aUyitx7aqRwvWky269eV0y9Bwwcwp/ELAe0Su3pVVAMKN2H0PuvR3dVuy4NNQp6K7GW69oy271pQ+3PSX5hHXf/28cO7lfBEy6/U9G+EO4nBHxnIBCR0nqhb18UO6s+qHQl7em7RGC8kvHAOJPv+dK2ASjOeLeRWdolcKn+9YyI4CKEOLmkGEycuwJxNGpXezKZjNthjIN/3mBK7924gTwfyj/QBkTxtxs7YUt+sOGoMlDFrRzJgrMWTeg/tbhpBawWxS2A0qskF9UEWMv88ewUUypoIqfdc4gn0dWVVpDMQYUZGCnZfL7wyNkD7q7JWK4ySC+zfTE7Uw==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(136003)(376002)(39860400002)(451199015)(40470700004)(36840700001)(46966006)(2616005)(70206006)(70586007)(316002)(4326008)(1076003)(8676002)(7636003)(478600001)(336012)(40460700003)(82740400003)(2906002)(83380400001)(16526019)(36756003)(41300700001)(186003)(6666004)(7696005)(356005)(26005)(54906003)(6916009)(40480700001)(36860700001)(47076005)(8936002)(426003)(82310400005)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2022 06:31:30.6362
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60cff45b-a112-442d-201e-08daa82d9255
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4261
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Right now we don't check for valid module parameter value for
poll_queue, that allows user to set negative values.

Add a callback to error out when poll_queue value is set < 1 before
module is loaded.

This fixes OOPs with invalid poll_queue value of -2 :-

Entering kdb (current=0xffff88817eaed100, pid 5624) on processor 12 Oops: (null)
due to oops @ 0xffffffff8165093f
CPU: 12 PID: 5624 Comm: modprobe Tainted: G           OE      6.0.0-rc7blk+ #53
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
RIP: 0010:blk_mq_alloc_tag_set+0x14f/0x380
Code: 83 c5 01 3b 6b 40 0f 83 9a 01 00 00 48 8b 43 68 4c 63 e5 4e 8d 34 e0 f6 43 58 08 75 d7 8b 53 44 89 ee 48 89 df e8 d1 ed ff ff <49> 89 06 48 8b 43 68 4a 83 3c e0 00 75 c3 83 ed 01 78 0f 89 ee 48
RSP: 0018:ffffc90002eefd70 EFLAGS: 00010282
RAX: ffff888112b155c0 RBX: ffff88811069dc38 RCX: 0000000000000003
RDX: ffff88811069d000 RSI: ffff88810ed60000 RDI: 00000000000001f8
RBP: 0000000000000000 R08: 0000000000000003 R09: ffff888112b15650
R10: 000000000010ed60 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000040 R14: 0000000000000000 R15: 0000000000000000
FS:  00007f71e4147b80(0000) GS:ffff888fff500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000014d81c000 CR4: 0000000000350ee0
Call Trace:
 <TASK>
 null_add_dev+0x7a7/0x870 [null_blk]
 null_init+0x1de/0x1000 [null_blk]
 ? 0xffffffffc03a9000
 do_one_initcall+0x44/0x210
 ? kmem_cache_alloc_trace+0x15b/0x2b0
 do_init_module+0x4c/0x1f0
 __do_sys_finit_module+0xb4/0x130
 do_syscall_64+0x3b/0x90
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f71e426e15d
Code: c5 0c 00 0f 05 eb a9 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d e3 7c 0c 00 f7 d8 64 89 01 48
RSP: 002b:00007fffb29f27a8 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
RAX: ffffffffffffffda RBX: 0000564b29d78b90 RCX: 00007f71e426e15d
RDX: 0000000000000000 RSI: 0000564b29d78f00 RDI: 0000000000000003
RBP: 0000000000040000 R08: 0000000000000000 R09: 0000000000000020
R10: 0000000000000003 R11: 0000000000000246 R12: 0000564b29d78f00
R13: 0000564b29d78cc0 R14: 0000564b29d78b90 R15: 0000564b29d78f20
 </TASK>

[12]kdb>

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/block/null_blk/main.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index c8dbff120c65..29e43444cf66 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -114,7 +114,18 @@ device_param_cb(submit_queues, &null_submit_queues_param_ops, &g_submit_queues,
 MODULE_PARM_DESC(submit_queues, "Number of submission queues");
 
 static int g_poll_queues = 1;
-module_param_named(poll_queues, g_poll_queues, int, 0444);
+
+static int null_set_poll_queues(const char *s, const struct kernel_param *p)
+{
+	return null_param_store_val(s, &g_poll_queues, 1, INT_MAX);
+}
+
+static const struct kernel_param_ops null_poll_queues_param_ops = {
+	.set	= null_set_poll_queues,
+	.get	= param_get_int,
+};
+
+device_param_cb(poll_queues, &null_poll_queues_param_ops, &g_poll_queues, 0444);
 MODULE_PARM_DESC(poll_queues, "Number of IOPOLL submission queues");
 
 static int g_home_node = NUMA_NO_NODE;
-- 
2.29.0

