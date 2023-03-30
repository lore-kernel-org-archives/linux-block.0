Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9B31C74A5B
	for <linux-block@archiver.kernel.org>; Thu, 30 Mar 2023 05:54:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbjC3FyM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 Mar 2023 01:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbjC3FyL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Mar 2023 01:54:11 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01BEC12E
        for <linux-block@vger.kernel.org>; Wed, 29 Mar 2023 22:54:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BIwG5F0+HwGXdWMU2TEk/BLNqkj3C+6l1yvzIe8W6ETcg8KQ9vhdJvFtnlsZPYiJrp5TM7IeoiI+U2QiLVgtjSNBDSn5hq9PQUbo8WsAbSDSoc2fW6LnHk7NEoGIzWcM4WhRmDpsH20R78qePXSyj2vkqZvB489yO9GjBBmsnQnFEfg8CDhgEhnTbddn5k3X9YO/IqvTGhCIFi/fWNcd+RulUmaRB9c8mvwcGtYJYCR9p5+Lvk1cF4CvQFJhIYVrDqJozdMYhWG1H01nhb2b3T6ntHNBSBFSqhH/DHBIatebjQvdMbbEGVC4bzxYR3YXqasttKthugom86CtfAGshQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GDhgR9ciMwYN5p6yHq5NBEP+4xQJparSApHfdZbJnws=;
 b=UzbcMfmAbE9+A/aG0LKZIVekghRDe33g0J6cbakt0KpOt4GoDUJdG6yHwmvOYeTe2NuScOQQT8/tepya+Ua7HQgFpDGulxRvcyHVUTI51qkF+v+DUI4ZGnuT3YUi2lpBuZA50k1dS5daATiS++WPSV9/CTJWgwNyruxPCOfDUjl96dAeotZm48Ghb0cVh3GvWjI71gqHfbYVI0HZ17rdtsBYHW5/04EwkdU+Js8F+QgDWP49e4ZsvqyCHV2ICUaOli3lnrpsBnhmbpfIF6mFkLxIi1iNgqXtOCq3P23LW/w875kl5uCDWILAuqXdQHzRRd9QZrJgtgaDFmakDvKClA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GDhgR9ciMwYN5p6yHq5NBEP+4xQJparSApHfdZbJnws=;
 b=NgTEsymHUWP4zWyUMpP1Qbuy7oP/huX5ONn9blO7qCR4iO2yx5J0FhTHVpGtCVqk08cDiSrHnomK/5USZlJ33afD9VetAwZqPzj0CWKhqzL7RgKHJrVY7jWtYPOx8QKiwUK/Gui8S2HmN39KPK+Mo6HfXLx7j2FSoQ0Mx/49VDFAn7WQDsplWquoRYx+66gzKdJ2WRVjuioDVQv+DCrwPozIAWY66N/ojwGvM/Gm4nDVaDI/MumIkNuof2Z0fU3E2SnBkcujjJ13TeOLkuwZAQjgjWJumshgECBa1f9o+b5GQTOAKxDLm+vBIDT4vXdWGKP8zT7kBQVZSRMx/tUYdQ==
Received: from BL1PR13CA0131.namprd13.prod.outlook.com (2603:10b6:208:2bb::16)
 by SN7PR12MB8819.namprd12.prod.outlook.com (2603:10b6:806:32a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.35; Thu, 30 Mar
 2023 05:54:08 +0000
Received: from BL02EPF00010209.namprd05.prod.outlook.com
 (2603:10b6:208:2bb:cafe::f0) by BL1PR13CA0131.outlook.office365.com
 (2603:10b6:208:2bb::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.18 via Frontend
 Transport; Thu, 30 Mar 2023 05:54:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF00010209.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.30 via Frontend Transport; Thu, 30 Mar 2023 05:54:07 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 29 Mar 2023
 22:53:53 -0700
Received: from dev.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 29 Mar
 2023 22:53:52 -0700
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-block@vger.kernel.org>
CC:     <axboe@kernel.dk>, <kch@nvidia.com>,
        <damien.lemoal@opensource.wdc.com>, <johannes.thumshirn@wdc.com>,
        <ming.lei@redhat.com>, <bvanassche@acm.org>,
        <shinichiro.kawasaki@wdc.com>, <vincent.fu@samsung.com>
Subject: [PATCH 9/9] null_blk: avoid use global modparam g_irq_mode
Date:   Wed, 29 Mar 2023 22:52:03 -0700
Message-ID: <20230330055203.43064-10-kch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00010209:EE_|SN7PR12MB8819:EE_
X-MS-Office365-Filtering-Correlation-Id: 3edcdd97-9e1c-4aa5-b1ee-08db30e32d7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Od8BQ8ZhW2p6wv6qSzowVgnhEWC+K62S7m3ClBXS31sGOPTeBnYPRZ4iwgZCSMkMKbo4H5kz/KFVU/rQxUC9yBmdY8naLGhFAk/m7RigC11rAQd8RB5n0+gPnu+0z59DfNLWDitGukO605y8qWJ4PM4A7CF25imoaGIrxzZv5XAtGHxZbJbNfXbsDQxs4tr2F75iS9gdoOnVI6eFhJsy3p3rpGBxTjDSldsgDwZCU6xAZPpMUuVbSpU8v0v12ahIqrnIKzNhJSSSQCa2z6ylXrIeZGrwHu1Hp+GfX4yWSgmKdsreNCJexjtNtuFSCiv6Uh1rQ4o4J/rzM8NycTroy9PHgnB7gsxhGDz80AlaaASrveKL9GgDwUNNwC1bKRvMg89kroyRC/0RD34HzOkCNL5+mUenx7h5dIMK0AR3UdIiKQhZi/Q2tJqlwnq4jgBi1z55XB6DU69IAdFin3FDneWw0/2Xolm1SKjyd4jIJp3qW3lO1Py5y9M+7BjrlR+l9UHB61OsTSiwtMZooX+/y+/dEEfxPZzvy5yumwnqaoqAQfgZ7Kxm06aAbBe414fdvUMQrRpPUWPLeUjrAe5FrBWNoi2oVUUe0BC4xJ6zV8zDmjeDIowT9LX+kb7LWUO2Tudzcr92sm08mE8VXpu61gnWLMt2E7+AAE4XxvZxKS94lh4cFs8XhNjcxo1i3X2KlG6gLfNnDiWzXRLlvYytVJaAo0adLNogBAyfQIJk7Wh3iyCJlMtucVx2Ko2OCejl
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(346002)(39860400002)(136003)(451199021)(40470700004)(46966006)(36840700001)(82740400003)(356005)(26005)(6666004)(1076003)(7636003)(336012)(47076005)(186003)(16526019)(2616005)(426003)(2906002)(36860700001)(8936002)(40460700003)(5660300002)(8676002)(7696005)(478600001)(36756003)(316002)(54906003)(40480700001)(41300700001)(70206006)(4326008)(82310400005)(6916009)(70586007)(83380400001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 05:54:07.9882
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3edcdd97-9e1c-4aa5-b1ee-08db30e32d7c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00010209.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8819
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The reference to module parameter is already present in the
struct kernel_param dp->arg include/linux/moduleparam.h :-

device_param_cb(name, ops, arg, perm)
 level_param_cb(name, ops, arg, perm, level)
   __module_param_call(prefix, name, ops, arg, perm, level, flags)
288         /* Default value instead of permissions? */                     \
289         static const char __param_str_##name[] = prefix #name;          \
290         static struct kernel_param __moduleparam_const __param_##name   \
291         __used __section("__param")                                     \
292         __aligned(__alignof__(struct kernel_param))                     \
293         = { __param_str_##name, THIS_MODULE, ops,                       \
294             VERIFY_OCTAL_PERMISSIONS(perm), level, flags, { arg } }

Replace global reference to the g_irq_mode in null_set_irq_mode()
with the function parameter kp-arg and rearrage code that matches
nicely with this patch series.

No functional change in this patch.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/block/null_blk/main.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 69f2d68ba14f..d0d7c52b0f81 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -222,11 +222,9 @@ static bool g_shared_tag_bitmap;
 module_param_named(shared_tag_bitmap, g_shared_tag_bitmap, bool, 0444);
 MODULE_PARM_DESC(shared_tag_bitmap, "Use shared tag bitmap for all submission queues for blk-mq");
 
-static int g_irqmode = NULL_IRQ_SOFTIRQ;
-
 static int null_set_irqmode(const char *str, const struct kernel_param *kp)
 {
-	return null_param_store_int(str, &g_irqmode, NULL_IRQ_NONE,
+	return null_param_store_int(str, kp->arg, NULL_IRQ_NONE,
 					NULL_IRQ_TIMER);
 }
 
@@ -235,6 +233,7 @@ static const struct kernel_param_ops null_irqmode_param_ops = {
 	.get	= param_get_int,
 };
 
+static int g_irqmode = NULL_IRQ_SOFTIRQ;
 device_param_cb(irqmode, &null_irqmode_param_ops, &g_irqmode, 0444);
 MODULE_PARM_DESC(irqmode, "IRQ completion handler. 0-none, 1-softirq, 2-timer");
 
-- 
2.29.0

