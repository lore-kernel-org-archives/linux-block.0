Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C40B2C761AF
	for <linux-block@archiver.kernel.org>; Thu, 30 Mar 2023 21:33:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbjC3Vd3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 Mar 2023 17:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjC3Vd2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Mar 2023 17:33:28 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23F37EFAD
        for <linux-block@vger.kernel.org>; Thu, 30 Mar 2023 14:33:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cT/7s2P59Y/GK/dux3ybpIzQECGzovezmRjxHuvWRlklKg0pnARyegt8Txt6/8vzGQbVdeoMG2fA0zMsnc+DVtAto7L3WJkwa5FUZ/X4uNxzWt0Mt8bahdU0D6s3CDxf1noRlDhOC4hu3/75AqvrUQtwY8b/j57idwDu74H/PkxJlHQpIBGUrqDksagCPnfp5rGPmjfVLl+FYPPMb3S1YMpFG8t+IahUhE19eAS0/Rc+J5Nm0rSUx283H+qqxoZWAPWsGDYkpzFADXNENF8oj6AoaP/F+dFmqmE3qOB8qXxXfKt3aHDOqRfKqAiG3d2w/2V6v9lUBiaL1prcqcOMDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MadCxwS9c+RauycmyBdgmNdtCtt4D6xzoC+/leRBIMc=;
 b=X8zb45O1j4dv0fNcTAskDRwUHH2/TPO9Kvz6YqSgnQKH5q12HsEgdgDbH7BkkjzKVTnssBFWwl3PasQqruMCd9XcVDlnSNSqgfQColxI+t31qwSQZBn94SL4dptVBsBpa7yVDkgmEdCpJkezj14XWAOjzGij/BxnJP2aIEUMsTVyXYqjrOD4fRbLD9UB0IVHlwO6bIrXGgllYxks1M+Ot03hVv+E5YmaF394T7pZi8jc2jUYnD3+1hULH7P9JSTqaOjwa2KZwrWqj75jEDWTK39sL8/5CvzDXJO/GnfhR8NGfOsIre1Eb2EvT/1bjL1cqUpvsiLmNsgzilH4U4euWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MadCxwS9c+RauycmyBdgmNdtCtt4D6xzoC+/leRBIMc=;
 b=Ixu22Lx0kZSQYMNvmx47DpFaIjQxFzgRxFA2m8yNet8o/WfAvSKxO65apV0iHmA3nH7F/nUapnMH8Bnrj/aUSq2MYc2B6wXXJR561S2uv4wzSBRvgz16pO+gLYwdQf8k+X/54tgteyrNpe98PgBWKE/9HmxROoswvc8ooWMExabr8jG0uqYCjmkzaPGFCxIHrWGta92GvYeScb6QBnEK/N8xgxyUeMIMiCOPqGJUiAZhlJZncV3cZql2hMn5LFu2qH+Yz+xRhg9yK5epIllfth4zDJFnLTitZ5WNe/M0F7TsogeFHvSWkaytOQ0tG9Z5irkADw5KYw/W5sI1KIbFew==
Received: from MW4PR03CA0349.namprd03.prod.outlook.com (2603:10b6:303:dc::24)
 by SA1PR12MB8700.namprd12.prod.outlook.com (2603:10b6:806:388::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Thu, 30 Mar
 2023 21:33:25 +0000
Received: from CO1NAM11FT114.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dc:cafe::ac) by MW4PR03CA0349.outlook.office365.com
 (2603:10b6:303:dc::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Thu, 30 Mar 2023 21:33:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT114.mail.protection.outlook.com (10.13.174.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6277.14 via Frontend Transport; Thu, 30 Mar 2023 21:33:24 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 30 Mar 2023
 14:33:15 -0700
Received: from dev.nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 30 Mar
 2023 14:33:14 -0700
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-block@vger.kernel.org>
CC:     <axboe@kernel.dk>, <kch@nvidia.com>,
        <damien.lemoal@opensource.wdc.com>, <johannes.thumshirn@wdc.com>,
        <ming.lei@redhat.com>, <bvanassche@acm.org>,
        <shinichiro.kawasaki@wdc.com>, <vincent.fu@samsung.com>
Subject: [PATCH V2 8/9] null_blk: avoid use global modparam g_queue_mode
Date:   Thu, 30 Mar 2023 14:31:33 -0700
Message-ID: <20230330213134.131298-9-kch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT114:EE_|SA1PR12MB8700:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b9fa025-c266-4323-cf89-08db316664c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r0AZ72JWZqfM4K3UtoD4y+ZmFN/Ufd0nPo9vygJS0JS27ptVKgqAEODHIUvltt7TKP+rTIxWyTYHERuAwtZUAyosKMgTCxGmt2lQTNbsSvgDi2x9cG/O6pIWlQBwhzy0ptlBqeYgJmg5LT8zrJX22Jp2a/q2nSDNg/84yAdCliCQumFZgS62KwDJE37VOA/AOVuI6QZaFU713DQfdrnQw0/J5BDrGqBohDKcojEB5gDhgIxjewzDY0gApKlVUFOG659P4udEPUYxe+khi31pZ3ruDT9dXiw+b9jfoGACjN16pHQKZ+cYS42FgYxb598JRUQnKX2WL7ULiBV3W0+UrTz8RP7BO19SN2307QeXn2X/0vsl/R1SF23VgDhta9k/n7SOaa6cbwKvt9JQKIMqzrzjsjrLDifD2UhvodtEl1ChFRVQX+enC3qI4KfZIwlx50aX4xDDLvftUYEpDs5l6Zz4StpkKt8bVCmcOi2bsHL0B0TZgLEwCEG7wuLLuwos16lsfntGIwVKtHUxkABxfKIRNyaMaHum7ZHkQMJixMub6Cd8JNZw6XEGIACgyEtZrRn7Q+E3+k/WD+MqZOvItLaXJyUjmQTaFxGQj8MeD99v1QhV17jyp7lwtWV6RSsqZOOUlAc0ButJT1GtsCTuKao1mbmeslRGcqPVBKmWH8aQrpLYsABPUdj6AQyC8coSlrNUaaevakFl/BNBehkp08JmzMQ/5O5Hcay4NU37wpkB8bJoF39RCwOsKzdtUo6aOswtP3V+7wa/3tjjGENnOyMtTPUayAHbk4Y+XBFQKqI=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(396003)(346002)(136003)(451199021)(46966006)(40470700004)(36840700001)(8936002)(4326008)(2906002)(41300700001)(5660300002)(356005)(426003)(40480700001)(7636003)(36756003)(82310400005)(40460700003)(82740400003)(478600001)(6916009)(1076003)(54906003)(316002)(7696005)(6666004)(26005)(2616005)(70206006)(8676002)(83380400001)(336012)(186003)(70586007)(34020700004)(16526019)(47076005)(36860700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 21:33:24.9074
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b9fa025-c266-4323-cf89-08db316664c5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT114.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8700
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

Also, use this opportunity to print the error message with valid range.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/block/null_blk/main.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 96ced0485e35..5325ec57287d 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -156,11 +156,15 @@ module_param_string(init_hctx, g_init_hctx_str, sizeof(g_init_hctx_str), 0444);
 MODULE_PARM_DESC(init_hctx, "Fault injection to fail hctx init. init_hctx=<interval>,<probability>,<space>,<times>");
 #endif
 
-static int g_queue_mode = NULL_Q_MQ;
-
 static int null_set_queue_mode(const char *str, const struct kernel_param *kp)
 {
-	return null_param_store_int(str, &g_queue_mode, NULL_Q_BIO, NULL_Q_MQ);
+	int ret;
+
+	ret = null_param_store_int(str, kp->arg, NULL_Q_BIO, NULL_Q_MQ);
+	if (ret)
+		pr_err("queue_mode valid values BIO: %u, MQ: %u\n",
+		       NULL_Q_BIO, NULL_Q_MQ);
+	return ret;
 }
 
 static const struct kernel_param_ops null_queue_mode_param_ops = {
@@ -168,6 +172,7 @@ static const struct kernel_param_ops null_queue_mode_param_ops = {
 	.get	= param_get_int,
 };
 
+static int g_queue_mode = NULL_Q_MQ;
 device_param_cb(queue_mode, &null_queue_mode_param_ops, &g_queue_mode, 0444);
 MODULE_PARM_DESC(queue_mode, "Block interface to use (0=bio,1=rq,2=multiqueue)");
 
-- 
2.29.0

