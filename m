Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F128CC6FD1D
	for <linux-block@archiver.kernel.org>; Thu, 30 Mar 2023 21:33:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjC3Vdk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 Mar 2023 17:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjC3Vdj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Mar 2023 17:33:39 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A6D9F76B
        for <linux-block@vger.kernel.org>; Thu, 30 Mar 2023 14:33:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kAOkvydzQOMOOhaIOm2e4Ir0f0livstVRWsVlIOZTc3ZtGJDIl1kOLILUWQ04q6DJmHN22ZX4HDH40opWRE/TwtxGSTZIPu0QVDFIJWEe4BGHKth8yPZeJdsLrtNhaFwMrHYOetYi0r173TMd43x3G+c/YSZbJK2f2PhPRktZKDBAzYj+qfkSuLRPP0kxucjikiZJ0NZL/5VlyjfO38KlT6//2CwuSN3HxwJoIGiDJfFUZLUu1Tj6y3w0MD2mrZPJpyZ3mrabZPpjHyaHS/kyq72KSSxWoah0/0MRePhZedIc2V0YC9ArbaULgXXJQO0h+M4s14DdjA+igjvVhMXgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ew1X+UlUO6EJRTQODJdgPIrcr6WdzqakGA6TD7Ha0MY=;
 b=azhk2kJl6jhVzmnsgdmPzOK/vHp0yLg/uH6KUY0u8LPS0atsIuXNEW/HSGIw3nkdKGb8Y1uY3oTyOWjyerW3+/6qSQKzDqtlipjZEntU0d81sgQLHzrh1LJLBiHne+ZEapJavFmxpFCc72CnEFOwPfIeAAif7sRUkDPjctBm2osOhIzVRyYPWuXWyngk5F0L82VL/81uVu66RGkAXBSuAeJy1oz0P1EBv7bkP7WzCr3oKGBVcQ5GV/TWFz4nqLlPB9DK8/jXv8gfK0LvNqKoKr2CAcogPcASJC6NgKPSP7Lk+7iPLpg2kp/ryNvA8C9Soav9+oBhdZKxg0LYmUI/jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ew1X+UlUO6EJRTQODJdgPIrcr6WdzqakGA6TD7Ha0MY=;
 b=hyiDdCtrrRXcld683Umpx2jao/NejtieKnxLR4odRZeKrjPdV0z8ibDlZ9QmAvazMa/Np3VWydTIXDog4Nv/0Q+bbmiTcdok/e6IWA++Sp2/Rs/8b6Im8e9RSenkZ0Bi+Wbh1dbKdvhOdyo/wAS7IV/AV+wNHOFkCPPj1La8l/9eiczwC4zsZ2wR+Ooz53WqOf3I1XItDkmODiI5YLRe+nN8eTfBK8NiSOEGPtxjWtCpGXsJ6tFetFIrIKvl6v79+cfOhwSWCt62EZLjUaYOrf8XStKAIymv8FjiYY5BhIX3qaBlu1kMDMbUoCLtnca01pVDy8V8zRLduwGSTv8q3Q==
Received: from DM6PR02CA0047.namprd02.prod.outlook.com (2603:10b6:5:177::24)
 by SA0PR12MB4574.namprd12.prod.outlook.com (2603:10b6:806:94::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22; Thu, 30 Mar
 2023 21:33:36 +0000
Received: from DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:177:cafe::f9) by DM6PR02CA0047.outlook.office365.com
 (2603:10b6:5:177::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Thu, 30 Mar 2023 21:33:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT054.mail.protection.outlook.com (10.13.173.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6254.22 via Frontend Transport; Thu, 30 Mar 2023 21:33:36 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 30 Mar 2023
 14:33:27 -0700
Received: from dev.nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 30 Mar
 2023 14:33:26 -0700
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-block@vger.kernel.org>
CC:     <axboe@kernel.dk>, <kch@nvidia.com>,
        <damien.lemoal@opensource.wdc.com>, <johannes.thumshirn@wdc.com>,
        <ming.lei@redhat.com>, <bvanassche@acm.org>,
        <shinichiro.kawasaki@wdc.com>, <vincent.fu@samsung.com>
Subject: [PATCH V2 9/9] null_blk: avoid use global modparam g_irq_mode
Date:   Thu, 30 Mar 2023 14:31:34 -0700
Message-ID: <20230330213134.131298-10-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20230330213134.131298-1-kch@nvidia.com>
References: <20230330213134.131298-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT054:EE_|SA0PR12MB4574:EE_
X-MS-Office365-Filtering-Correlation-Id: 45e6b818-7d09-4aec-4a67-08db31666bba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H8YegNhg9W3GzDAeN3+XZZg9iinlBxryMrkPEy3jAypBRPlycwA7wGBv241z1/R1Lyu8LTJwblbyDoSE+yMvTcD7z5S6ZxJTBUrnT+yhq19i0oYO/nw0pDbWV0Z/nwmM5Fl7i4/yH0BKJrtaPObJU0DrB6VRsBVyPQPrLovLgW+ttublmDeBcq+2C1DO+Yf4D6DItTDzPJSwTTK3hTt+8zXzIM99I6v7FH7JA522afbfxB230mTF2/sOnvcQ5ezM+8dJp3AoOfwfs7bSFroq6ipo/BpakLu2p/MnC0pImGedqBoVqQmrmlBlGKZ/3eIZnN1bf8ogwkyxpjg1mdUPWK+LEjAuCdaAClcrmSbdKBuSuUp3UNV5G2IyZSYaIvMFES0Sz0msrZbWiDlbvnF+lV59R9PJuTCDkezbOztEMSSh6I16Hfm+n8OLcwnrsF8I6oAoJ2LaT4oko9jWWQncHBQkDqixDMIcXLFDgqKaZWrd7CZORbsCdZozyK92xeY+fENmWiSPyVAYXImBKDvWD4BcSShp5XHqcPqrux8tMgDOA426E4T6vKuLvpUjkin5EdGwH/Iia3D82hPXe/r+slcWBXcSphLbcGfzsFub1sUxdeVUT1jeBa7atuOVfri4xscyod01HUGNEFlTf+qcdmqlRjPOF6cAnB0inOCnB1v2JV9ZhPomnckDzxXESe4LtUZQgCnMJR2osUB197kiTSWcUQtw/w7X8u03ac38k1jLd791pLKfrOwkAaVO5yq0vhdu4OyfwniJZu1hXgebrIyEAbeBy03OFphkT3aV3yg=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(376002)(39860400002)(136003)(451199021)(46966006)(40470700004)(36840700001)(356005)(41300700001)(40460700003)(5660300002)(7636003)(2906002)(82740400003)(8936002)(82310400005)(36756003)(40480700001)(36860700001)(34020700004)(316002)(54906003)(1076003)(26005)(6666004)(2616005)(426003)(47076005)(478600001)(7696005)(8676002)(6916009)(4326008)(336012)(70206006)(70586007)(186003)(83380400001)(16526019);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 21:33:36.5290
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45e6b818-7d09-4aec-4a67-08db31666bba
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4574
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

Also, use this opportunity to print the error message with valid range.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/block/null_blk/main.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 5325ec57287d..f34a147e0fa7 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -249,12 +249,14 @@ static bool g_shared_tag_bitmap;
 module_param_named(shared_tag_bitmap, g_shared_tag_bitmap, bool, 0444);
 MODULE_PARM_DESC(shared_tag_bitmap, "Use shared tag bitmap for all submission queues for blk-mq");
 
-static int g_irqmode = NULL_IRQ_SOFTIRQ;
-
 static int null_set_irqmode(const char *str, const struct kernel_param *kp)
 {
-	return null_param_store_int(str, &g_irqmode, NULL_IRQ_NONE,
-					NULL_IRQ_TIMER);
+	int ret;
+
+	ret = null_param_store_int(str, kp->arg, NULL_IRQ_NONE, NULL_IRQ_TIMER);
+	if (ret)
+		pr_err("irqmode valid values 0-none, 1-softirq, 2-timer\n");
+	return ret;
 }
 
 static const struct kernel_param_ops null_irqmode_param_ops = {
@@ -262,6 +264,7 @@ static const struct kernel_param_ops null_irqmode_param_ops = {
 	.get	= param_get_int,
 };
 
+static int g_irqmode = NULL_IRQ_SOFTIRQ;
 device_param_cb(irqmode, &null_irqmode_param_ops, &g_irqmode, 0444);
 MODULE_PARM_DESC(irqmode, "IRQ completion handler. 0-none, 1-softirq, 2-timer");
 
-- 
2.29.0

