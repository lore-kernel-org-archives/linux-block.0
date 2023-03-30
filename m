Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 527AFC6FD1D
	for <linux-block@archiver.kernel.org>; Thu, 30 Mar 2023 05:52:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbjC3Fwx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 Mar 2023 01:52:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjC3Fww (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Mar 2023 01:52:52 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 273965259
        for <linux-block@vger.kernel.org>; Wed, 29 Mar 2023 22:52:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LfcmObH18gnjQighvpDeNbbokZD9pvh4hSvOoeWtRyXVW0MOD7FRp0YJFvtSQQ/H2SzIqvVDn4BXLnbZrxfrx031Gw/xjKMD+k8wQf2dzC/i4Kb7K9tracoTl+R5QE7Z9+7h+JUqD2jFSsTvFIhmjR7dtEf8TGLSgzVqb39ADU9IUhEhSqRSU3niOKd0clrk/lzSt15Lm8Di3/ADDGNoXDTjD4rEF2qH3uM7Cl9mzXLre8OZxn8loBcy9IZQvUKdm6WyCNgWyYZHTWVRmZuAH8JYes5YpcLUIZQvz+0mN0bTFrzZj8JAYNgiXr3agrr/SUdpjU+FsbiKKbNN733TlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MnHEwVtX6rCM1SbFLyM3eeEcPiEfV00FTzVpdzdnlvg=;
 b=Pcmw5AZrJL3cSU1cLXhmU4IGnJsX4e1gCrvZQSlT3k6OtWDvOdxKfb4vSVTUZvBzAAdTxO5DDpdCF8y0qp4QcqpwWwTylfpqX6FrKQ/4W1iO/+jjuuyqoQgCrQIDeSfZg8zcFIqp899cYY7nbFktblNAAtLtZwwTwSO7h+C2Hv1M5Zx5O3S4hy2ZSsMDUr6oiQg2vgk7UuVEI5fLZZL4WEUgZfU60Uz7Yo4YOxpb4eBMY2OGvhVXd0q1IbOeGEr8Vx1hatlKtKOarbfd2xhJd7wS60/DlD6uvBYPb4Qo0Q237jGo489P7h04tbuwpS75OS2+mDtippgono12f/t/+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MnHEwVtX6rCM1SbFLyM3eeEcPiEfV00FTzVpdzdnlvg=;
 b=KKBTFVNW/5YR+wbSaln0e5vatKGif2KsoLmXANCXeaRSfHhRwvv55uu/0ctNsTINNQkRNuzbqaeWsKtCRv4ick/oH2J9WTYpDMFvX6XSxLExhqopJlkGUCApaOaPvSWGdeRGo+ZUQejJC2MLjhezr3xHChgfZaIZ4YJ+6eMnpLy1sWJjCL9HK0fIcN5WHjsg2l6W+G2yQavuaGVSUNzJ5bg7O/HkuGKGgPfS8mgUsq5CNmbNLq0eSDhGBpcHmxDbzGXCaicJM/puHGikBgmKCEvhwtewnTmRnsvHuBdUkf+7I2FSRGBwXyhLkIj/xeVLT1f5VE7f4tiXK8u6tFaByg==
Received: from MN2PR19CA0022.namprd19.prod.outlook.com (2603:10b6:208:178::35)
 by IA0PR12MB8351.namprd12.prod.outlook.com (2603:10b6:208:40e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.21; Thu, 30 Mar
 2023 05:52:47 +0000
Received: from BL02EPF00010206.namprd05.prod.outlook.com
 (2603:10b6:208:178:cafe::f6) by MN2PR19CA0022.outlook.office365.com
 (2603:10b6:208:178::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22 via Frontend
 Transport; Thu, 30 Mar 2023 05:52:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF00010206.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.30 via Frontend Transport; Thu, 30 Mar 2023 05:52:42 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 29 Mar 2023
 22:52:23 -0700
Received: from dev.nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 29 Mar
 2023 22:52:22 -0700
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-block@vger.kernel.org>
CC:     <axboe@kernel.dk>, <kch@nvidia.com>,
        <damien.lemoal@opensource.wdc.com>, <johannes.thumshirn@wdc.com>,
        <ming.lei@redhat.com>, <bvanassche@acm.org>,
        <shinichiro.kawasaki@wdc.com>, <vincent.fu@samsung.com>
Subject: [PATCH 1/9] null_blk: adjust null_param_store_val()
Date:   Wed, 29 Mar 2023 22:51:55 -0700
Message-ID: <20230330055203.43064-2-kch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00010206:EE_|IA0PR12MB8351:EE_
X-MS-Office365-Filtering-Correlation-Id: 26ded4d8-4d26-4f89-8590-08db30e2fa97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6Hu6zX58FgRZ/UrmELWjybwljN3MpU0h87tXWmdNT7RNlExmkRxhVNTCDpBPWVqldsq6DhVO+wRDsEXOc/Ov61sAWPB/WdWDHlXVE03rIfxIFZFbPcsEOgMpLEmRiers2fQ27AAvnzRSZiF9kjv5aI6d2cB2b1nDIk4K0VuZ8uA4a3e0NciW7pbBi/pHelhXtRu4sZaNHWBj4lgljsMXL5Gtvp3aK+7op2VYUzzzTFDuV0WFNPwfWeXcV0KkmptNtrb9dJgZcx4xwflA41ts6B0d+EP0C9shEzcGb4o5AteB6w/L7ZCuej1o5wRPjQ0ZSooykZ+Crqr925KRNepp1g1AGRsjMXlOVjXv/ISx90UT6aT/TZcZ9Wf/z9XqGOaODHAEOCECW46bpQqqtPrL120wvhOFvo43eFxVjZx9JZWjBeNEVUcZWWBZq8sFoGreY07ofmuZF6AtqFxzwwXf88rezSIfKhYbYUXU9IA/dlRtn428M+dSI35q1eTgEoP8jfLiQsy5Kf2M4wz/8mvqVM83bGO9zDz/ol8dCRNuzh7Cer9bYHGG0AokMAgZwkUqdQd4WOkV2Z9o9LXxDtAXa3ssqxZVPlbmWMmF1uzREASTz7DlVBasA+JErrbwDAxzmvKIwZ4uOdd85CufI7JohnIgSa0uXU+Q/gFqaJOvXsBAO4LrRTWsC36yj/ChFkfOnL9XibAY6PkU7S/ON67ZX/B7E8z0+sPXZF7xZm/dXfn0rDck6WwXV3kfoyHZ6z1J
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(346002)(39860400002)(136003)(451199021)(40470700004)(46966006)(36840700001)(356005)(7636003)(8676002)(478600001)(6666004)(8936002)(40480700001)(70206006)(70586007)(6916009)(4326008)(54906003)(82310400005)(36860700001)(82740400003)(41300700001)(40460700003)(316002)(186003)(16526019)(1076003)(26005)(36756003)(47076005)(2616005)(426003)(336012)(83380400001)(2906002)(5660300002)(7696005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 05:52:42.6003
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26ded4d8-4d26-4f89-8590-08db30e2fa97
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00010206.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8351
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Move null_param_store_val() top of all the module parameter decalrations
so it can be used by next patches in this series, also while at it
rename this function to null_param_store_int() since it is only
validating values of type int and not generic one.

No functional change in this pacth.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/block/null_blk/main.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 9e6b032c8ecc..cf6937f4cfa1 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -77,6 +77,21 @@ enum {
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
 static bool g_virt_boundary = false;
 module_param_named(virt_boundary, g_virt_boundary, bool, 0444);
 MODULE_PARM_DESC(virt_boundary, "Require a virtual boundary for the device. Default: False");
@@ -117,24 +132,9 @@ MODULE_PARM_DESC(init_hctx, "Fault injection to fail hctx init. init_hctx=<inter
 
 static int g_queue_mode = NULL_Q_MQ;
 
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
-	return null_param_store_val(str, &g_queue_mode, NULL_Q_BIO, NULL_Q_MQ);
+	return null_param_store_int(str, &g_queue_mode, NULL_Q_BIO, NULL_Q_MQ);
 }
 
 static const struct kernel_param_ops null_queue_mode_param_ops = {
@@ -177,7 +177,7 @@ static int g_irqmode = NULL_IRQ_SOFTIRQ;
 
 static int null_set_irqmode(const char *str, const struct kernel_param *kp)
 {
-	return null_param_store_val(str, &g_irqmode, NULL_IRQ_NONE,
+	return null_param_store_int(str, &g_irqmode, NULL_IRQ_NONE,
 					NULL_IRQ_TIMER);
 }
 
-- 
2.29.0

