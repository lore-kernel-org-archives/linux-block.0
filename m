Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A74BC04A94
	for <linux-block@archiver.kernel.org>; Tue,  1 Aug 2023 02:30:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232094AbjHACaN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 31 Jul 2023 22:30:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232110AbjHACaK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 31 Jul 2023 22:30:10 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2046.outbound.protection.outlook.com [40.107.237.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F1871BF6
        for <linux-block@vger.kernel.org>; Mon, 31 Jul 2023 19:30:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ctVE8iqtLEt8CY5JshmrkmrcTygIkj2jmJj1eoerPThlGeDGzuEx3Vdkvz8MUaPuq6nvMS87nipwEwp89ZCcUTO+21/XfcDsOEGSF+GNLbC6ZSmvZOSFeZtX7kBHM/pjvBmw3MCDEaw/xIk51YSEeXZPwEZnRCgGu371PEfdlmW0s1t/ybITdYJdYlp5dF0Lz0uWpzUB73JPaKvWH3Tw2totjGNMlYWazW4Ux21P7oRXQkjbuOldiK1Qx5HZVF8osizCtmgv1l0bdYidSyiLMasYpe8q3lpsWzwNFAkqagCXSJ1oBTqdBFTXB/luADT41nXuFWCBzGVKkahCzUvE9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HwR5HQTwfjmKIpXFARLUCH8D4pz1yHtqhl5x2o/FX9E=;
 b=YyWqCPehtYiVTXKmNErUIe26wMHPWczenfj1UmRt0tcILgLuAOweVzt2cSvs3X0xKod3gQ8CclUlJmpl5BKzCc/eZV2nEtmSi3dZby+KJdnOPFu9ij7NcwoYEdNCQ77j4S38w4O/D9VqAHNlC5FM8yXG/KU0RUkndFDWTI+O2RpacshVvXdNhBY9KMgeKTP0fb4tNxPd/Q04vpgu3aV14rbAAM+x/KWgQFkihEpC2EUgYxk7Rifd7q6nHT2Imld6A8oA3221drtW6N2ClCQSqEwHIQvZ7AgE+Pv40/kh2Cjf1kUS/lcv9yMdtRWdVyX1ZHk49fy9J2yDMl6bMV7qqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HwR5HQTwfjmKIpXFARLUCH8D4pz1yHtqhl5x2o/FX9E=;
 b=eKZVjz4nAAit/BfDEZ2qagdaJLy+J3mp0QT+lzsysFkOSyGOF5fSU0eFAcSvTBqlAZ1GVUey5Xb0TByKJR4GrV6RErHPwhiumrdzEIw+hFmMDhi1SQlwuSnBb/fm6+NJL2lPE04NsP5WYxjcscCcP1x+JKPeo5MWZUuo2F5iTMf0rXxXeBvLaiDtiOjsHgpwSAYvXOCvFBb+YSud8+GFfOvG5M7sfuba6MSp/klwQ9Oc5QEfKJnJKAi2acAtbwSmFMXRMUB+35sqXbopzTQMEIvWMfBJw44K+OdAOez1FgK2QU8CUvLzh3yxb/r4o4hsv6SNT3MnJEHN7S9jlvg25A==
Received: from SA1PR02CA0002.namprd02.prod.outlook.com (2603:10b6:806:2cf::6)
 by PH0PR12MB7814.namprd12.prod.outlook.com (2603:10b6:510:288::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Tue, 1 Aug
 2023 02:30:07 +0000
Received: from SN1PEPF000252A1.namprd05.prod.outlook.com
 (2603:10b6:806:2cf:cafe::3) by SA1PR02CA0002.outlook.office365.com
 (2603:10b6:806:2cf::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44 via Frontend
 Transport; Tue, 1 Aug 2023 02:30:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF000252A1.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.22 via Frontend Transport; Tue, 1 Aug 2023 02:30:07 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 31 Jul 2023
 19:29:58 -0700
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 31 Jul
 2023 19:29:58 -0700
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-block@vger.kernel.org>
CC:     <axboe@kernel.dk>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 2/2] brd: remove redundent prefix with pr_fmt macro
Date:   Mon, 31 Jul 2023 19:29:29 -0700
Message-ID: <20230801022929.8972-3-kch@nvidia.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230801022929.8972-1-kch@nvidia.com>
References: <20230801022929.8972-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A1:EE_|PH0PR12MB7814:EE_
X-MS-Office365-Filtering-Correlation-Id: 53163846-18fe-4125-06f8-08db923738b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FqBSDxH6UqIklj7y0tYos2iccj86P0WMbVgAw9CBpqcQpQ7Vqqo9fGtuhjRmikNLT+hni7vWNHMYun7gQGRx7qpgjsYEtTwPnc20Rh6LL8DlvXHmL4bB0FAgrOWzHySiIU0VBcbDZ6ptEaWFcwfwEdmyZyppNY6Pp/PLeZSCsqCNawdIXKXVIOpMh+qqwm4s8sw9ptE/6fMCD8ZtJBml8zRmZG+XcGXJiMW0Vf6K/aHHcdAJBsQQjWAaMITyjtzKSuCZbHnet5NHgUuywp3rt8yRzukasgiIfIGvdXvCgHHia+wuF3GplFQsnGUsCn33juWsm48Ld9vRyKwgFtsG0YBE8/Y7UFiwUYDk/WFHMb/TxakZmgDhBTblWiLJatPsOkZkoiNB7opTgKwRuoJeQMH61RndgzmR7XXNl4KD4sNP3IxVV1tyy5v2QOCzeZATy90bYEHuUrOuoNjFV0YCLnEAyZFqYkipUpDBXglTTBzeKHz00/ug+vfXeUasg4sb2BXL7R1iXoT7KKA3yTsDtAtzZ8Z7Yq2DFWTX1s/OJ8C/lQD9poF5d/QnPavNBMjyHzCIwT+iHB0usVJemDeKsGGvN1jLaK0lYUR6WDfehfvQGgbdooBnYbVzKWW9MnuyzXCd3AMmc0XyZhLtHLGxUtICl7JDK7cOUD58fDQ4K/xHrFkqrq35g9KelZTb76YljsaibEu0Jq9gpJlQtq0EsWp6+PCZfRNI1wobzwWjAzIjSehd7cFy7VhluT21F2XNPJjaTBramNYUsLWLECyC5A==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(396003)(376002)(136003)(82310400008)(451199021)(36840700001)(46966006)(40470700004)(47076005)(36860700001)(7696005)(36756003)(16526019)(40480700001)(2616005)(40460700003)(26005)(1076003)(83380400001)(107886003)(336012)(186003)(426003)(70586007)(70206006)(7636003)(41300700001)(356005)(54906003)(82740400003)(316002)(4326008)(5660300002)(8936002)(6916009)(8676002)(2906002)(6666004)(478600001)(21314003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2023 02:30:07.4026
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53163846-18fe-4125-06f8-08db923738b7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7814
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Define pr_fmt to "brd: " in order to remove the duplicate brd prefix
that makes pr_xxx() longer than it's needed. Note that this practice
is been followed in most of the kernel module for the consistency of
the driver messages so they become easy to grep/debug and not duplicate
driver name in the pr_xxx() messages,

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/block/brd.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/block/brd.c b/drivers/block/brd.c
index d878a7dc616b..23eea3a35438 100644
--- a/drivers/block/brd.c
+++ b/drivers/block/brd.c
@@ -27,6 +27,9 @@
 
 #include <linux/uaccess.h>
 
+#undef pr_fmt
+#define pr_fmt(fmt)	"brd: " fmt
+
 /*
  * Each block ramdisk device has a xarray brd_pages of pages that stores
  * the pages containing the block device's contents. A brd page's ->index is
@@ -397,7 +400,7 @@ static inline void brd_check_and_reset_par(void)
 		max_part = 1UL << fls(max_part);
 
 	if (max_part > DISK_MAX_PARTS) {
-		pr_info("brd: max_part can't be larger than %d, reset max_part = %d.\n",
+		pr_info("max_part can't be larger than %d, reset max_part = %d.\n",
 			DISK_MAX_PARTS, DISK_MAX_PARTS);
 		max_part = DISK_MAX_PARTS;
 	}
@@ -437,13 +440,13 @@ static int __init brd_init(void)
 		goto out_free;
 	}
 
-	pr_info("brd: module loaded\n");
+	pr_info("module loaded\n");
 	return 0;
 
 out_free:
 	brd_cleanup();
 
-	pr_info("brd: module NOT loaded !!!\n");
+	pr_info("module NOT loaded !!!\n");
 	return err;
 }
 
@@ -453,7 +456,7 @@ static void __exit brd_exit(void)
 	unregister_blkdev(RAMDISK_MAJOR, "ramdisk");
 	brd_cleanup();
 
-	pr_info("brd: module unloaded\n");
+	pr_info("module unloaded\n");
 }
 
 module_init(brd_init);
-- 
2.40.0

