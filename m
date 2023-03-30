Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A11B7C74A5B
	for <linux-block@archiver.kernel.org>; Thu, 30 Mar 2023 05:54:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbjC3FyD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 Mar 2023 01:54:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbjC3FyC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Mar 2023 01:54:02 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2076.outbound.protection.outlook.com [40.107.92.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C329255AA
        for <linux-block@vger.kernel.org>; Wed, 29 Mar 2023 22:54:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HU0M0d2JdTIdMVoBmaovMydACy3+jj4XUc76b2EsoxK6dGZZvbwRyT+fr850MWXErW2pyCW5oMUSbc+EXbFixKPU3lyQJQhP7IbiGBqqEJbmbokryRmAJnrwOTE+2IGUZTCMSqQKjFyQ8BqIg84WTdfd+pd91mMyLzfasRB5Dl3NI3Q11WSdot/U2SfKHIxtZWf3WI0Bo3ijbhVZxszTOJrgdlMu+CuBBWtBn6Y3701jA8opVe7VJ1FQYEIj1uMwtIkb1lk6JigzoU1pIxvePRzTmFISLcAvhx7YPGBXMxpXiqhOa1iu5AhfCjjGbN0ugAqPzgkRppOlA57TDt4BLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BZoICB0NuNWZGylQ8pVNv9jlFfjiN8k+DzzM4tk2+XI=;
 b=Zzb6L3hnbJvg87NtjTh3wTGOmEuHmVJEku+54X2YliI8CwEPNQjevfXfoPcaKtpfV3ii9LNtLfVg1SfUwYkTYphFimi5kVWwc0skr78xMSxcSiCYUSig9SbO6aznbtqDZRAAxTKDTV6PGo7yosGV4B+v/3MLiSTKpX7/0Q85yBFg0Na5JgrS9HA+ICyyex3kqR47EwQZwu9iZB5z45ZmnrLJN3k41l2wCGqWdwWPSS8YogKR7aJc/4q8WCK09aZ3xKJIlFXu4xRWB43F1/hnAnG5Qo86HuUkZSYH7eoyWOl6PSB1HG3PZWfGBc4EYmc7vaINR2Jlmcb6tNRVPI3maA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BZoICB0NuNWZGylQ8pVNv9jlFfjiN8k+DzzM4tk2+XI=;
 b=RwOG84ia+YBrRw2A1fJyMf7wWzPd0GZ+IMvf3We4yOoI3p8daqdix3xAoJRdu3kyI31458un5fWLtdLVOcZSV4VxngFFLbV1k5ZlRVMNDkqgfV8F2TjeZLMHHAsg1EmOkZ62QOPzUHq1ZyKbb3Iq7q8by2M21XCgwjipan7RA2VozVv7h+0Je7yI7qqYR42Cw28I2B7E7Lcdw18f+pFkXfRtiPZ4W9Ev4TL7EA6w5md/3UMFrc44TmLU6HS8GHKkO/HIDwbUeS9O97L3VpAPEY+5ddor+CdYPPiwXrIy7a03BkAY75qIAB36gGWOlYCApQJaf8YfI38k/gDyJC8Xtw==
Received: from BN9PR03CA0721.namprd03.prod.outlook.com (2603:10b6:408:110::6)
 by SJ0PR12MB7458.namprd12.prod.outlook.com (2603:10b6:a03:48d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20; Thu, 30 Mar
 2023 05:53:59 +0000
Received: from BL02EPF000108EB.namprd05.prod.outlook.com
 (2603:10b6:408:110:cafe::73) by BN9PR03CA0721.outlook.office365.com
 (2603:10b6:408:110::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.39 via Frontend
 Transport; Thu, 30 Mar 2023 05:53:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF000108EB.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.30 via Frontend Transport; Thu, 30 Mar 2023 05:53:59 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 29 Mar 2023
 22:53:42 -0700
Received: from dev.nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 29 Mar
 2023 22:53:41 -0700
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-block@vger.kernel.org>
CC:     <axboe@kernel.dk>, <kch@nvidia.com>,
        <damien.lemoal@opensource.wdc.com>, <johannes.thumshirn@wdc.com>,
        <ming.lei@redhat.com>, <bvanassche@acm.org>,
        <shinichiro.kawasaki@wdc.com>, <vincent.fu@samsung.com>
Subject: [PATCH 8/9] null_blk: avoid use global modparam g_queue_mode
Date:   Wed, 29 Mar 2023 22:52:02 -0700
Message-ID: <20230330055203.43064-9-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20230330055203.43064-1-kch@nvidia.com>
References: <20230330055203.43064-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000108EB:EE_|SJ0PR12MB7458:EE_
X-MS-Office365-Filtering-Correlation-Id: e8c92889-6308-4a55-3f07-08db30e3285e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EvYe4jZ0rXP+O2B7VmclEVyaPGsnsVO+oPlhxqMfWiinxLAvDEMYdxhibvy8gg/KzaQwfHlgW2/jJYqmhpyanzVVZ6goEXYJ3UoLUJ5q82m/hrt/u066xGRlsYVJgvEcxRCsvLg1i61ELETwith1u7kZ19npi0mKoSxDH8djrRnOHOBKKxi4IgZewN/X+JZkcegyEUMP8Vp2sAX6vB+FedrmHGdpAJbiOmLsh/Ji21YIpQYVyi+hFIbvpCj7tq0UZsnWfBIEchagT2Btnzqso9hVmKdy8CdRH+hsD2rAhQORaWUlXSurqf46dqc8yIDEcKKNZUz/af6+6dop8rPAVIMR5FIT8niE2CcwOCoIMu/gTP3W3iRER+01tpaJw6ZcI0zX3HGE+sWlxcMP6XhPV0JRXXjS/TQy9c6kXcszF1b2lMTzx+lNk3HGGhsW2dS5OH2FZTmX7lfBOA4lsi2Gwc8ntPaiiBfohhv1/evMamBph+dTWC8tDH92TzzErN17WNgx4ttRhx5t75EN2PPwNRyGMpDZXzTB2WQPYdOG7Tdq8oEWbXDDDhz9cJPAmdqJAE/ryYcD4wiI490ZJ6RMMYMv+oFEERSmSCX7jex637Beb4Bz0P1ieEOJnCBeOb2sCzJt3TdbUsxto0lnV2RgLvi8R5sTHVVakKvEDlRVrawZXs9kxfiOW7J6xTuziSel9UV8jQp4kAyRHwPr+Fj8lXJ5bpQcdGRAdU14KqZbfaYZQQVAMcGasMn82Mv3w6jO
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(396003)(346002)(376002)(451199021)(36840700001)(40470700004)(46966006)(83380400001)(426003)(47076005)(336012)(2616005)(1076003)(186003)(26005)(16526019)(6666004)(478600001)(7696005)(4326008)(36860700001)(70586007)(70206006)(41300700001)(316002)(8676002)(356005)(7636003)(6916009)(82740400003)(5660300002)(2906002)(8936002)(36756003)(82310400005)(40460700003)(40480700001)(54906003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 05:53:59.4001
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8c92889-6308-4a55-3f07-08db30e3285e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000108EB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7458
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

Replace global reference to the g_queue_mode in null_set_queue_mode()
with the function parameter kp-arg and rearrage code that matches
nicely with this patch series.

No functional change in this patch.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/block/null_blk/main.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 2834036f89c1..69f2d68ba14f 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -150,11 +150,9 @@ module_param_string(init_hctx, g_init_hctx_str, sizeof(g_init_hctx_str), 0444);
 MODULE_PARM_DESC(init_hctx, "Fault injection to fail hctx init. init_hctx=<interval>,<probability>,<space>,<times>");
 #endif
 
-static int g_queue_mode = NULL_Q_MQ;
-
 static int null_set_queue_mode(const char *str, const struct kernel_param *kp)
 {
-	return null_param_store_int(str, &g_queue_mode, NULL_Q_BIO, NULL_Q_MQ);
+	return null_param_store_int(str, kp->arg, NULL_Q_BIO, NULL_Q_MQ);
 }
 
 static const struct kernel_param_ops null_queue_mode_param_ops = {
@@ -162,6 +160,7 @@ static const struct kernel_param_ops null_queue_mode_param_ops = {
 	.get	= param_get_int,
 };
 
+static int g_queue_mode = NULL_Q_MQ;
 device_param_cb(queue_mode, &null_queue_mode_param_ops, &g_queue_mode, 0444);
 MODULE_PARM_DESC(queue_mode, "Block interface to use (0=bio,1=rq,2=multiqueue)");
 
-- 
2.29.0

