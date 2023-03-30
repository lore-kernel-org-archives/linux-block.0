Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47F8DC761AF
	for <linux-block@archiver.kernel.org>; Thu, 30 Mar 2023 21:32:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbjC3VcN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 Mar 2023 17:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjC3VcM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Mar 2023 17:32:12 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2048.outbound.protection.outlook.com [40.107.92.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A780CC0C
        for <linux-block@vger.kernel.org>; Thu, 30 Mar 2023 14:32:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SJ+Pq/bfVvBN0YrpNk9p9t8ykybt1nGtRA39alm2Q9q4RF9wKo4M3Y+1mkEPIoGjBjUwmwzGv1iddMF78CytKyv0sqHLqjaL8AnSBZT1hz/xeBL6pd6V2NZK5XkrPS9HzYs/tZq7FO3SpiBJyKTqXfPt0YjSAVvlVMZQF1OvrgPzTHFhRBRoF2Qu4aj8fPg+55S2iod4WcOkQZBMo0xrJXUNvNw34e/HQFUorZ8dyrNkGHCSNDQqmAgjd+AgAI2GfosLU2OgrShsiD2SIpL31MVGVan+kYrWDZP84x8c6dnpNJPhf1AuuvcR4qXIJ4iyIAf0UVarwHZzwJVcSW6gqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MnHEwVtX6rCM1SbFLyM3eeEcPiEfV00FTzVpdzdnlvg=;
 b=nKvf+sPzp5jG90Tm0LRZ/zf6T9ILGyXwnF7McL5CkKaSVGvP0rZF0nzTIq8y23cdDPsqC2wNz8wU0QE7iOe+ACivrh48MR8zkQBAiAHZgdSRNji7Gu3ojsFJeyfusxkvmJx8cItnh1o7YpXTt07oCbd99vfc7k/NNasRgjbSCEzGiFspRVnJQ96v8bkFZeo4+x42FrKpWx6+/ZhrjYupC/n9qIwNarGlbGL6k7rH3Pr1DBUFPEXiXks5It1rEyXbfAQVGasgQSnZ214MTwEZ5oexLia5cVV4VEMigqG1T5ug8qsXPEO5KH+dmWxCGxO3b85hdfmBdhWQRCuAYNvopw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MnHEwVtX6rCM1SbFLyM3eeEcPiEfV00FTzVpdzdnlvg=;
 b=px7XbvWMx2HLsfZD8MNizJFMAuRYhFk0g7MJWS/qQE9dEnIzkGjqxGGbBX/NQSYfqdfrTmMndEOCsIu1Bd4IMBG7Sl0fwd7HoxMVjTJVsWcN97JNqEtwPf0cL40PEKqXTGHsSYCzqHclHaqmquy2nI5U/iWABphVZwtwIAs5rvN5QgUY9v74OsUN4DFBGVZi5BT+j1EhQnms3ptYDIWQ/2qXeUJMQ3e81qGOTt6Y1qxOlGx9aqitoFqAARCL+MGfKmwq8PAoGpF4fCA5zOiDGr+kV7PccGJhCIfVBllGElirqZ/fNY/cBa6DjiUgsSt+nJWwYybHSKZBgo/cTD1/jg==
Received: from MW4PR04CA0298.namprd04.prod.outlook.com (2603:10b6:303:89::33)
 by SA1PR12MB8917.namprd12.prod.outlook.com (2603:10b6:806:386::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Thu, 30 Mar
 2023 21:32:09 +0000
Received: from CO1NAM11FT079.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:89:cafe::5a) by MW4PR04CA0298.outlook.office365.com
 (2603:10b6:303:89::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22 via Frontend
 Transport; Thu, 30 Mar 2023 21:32:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1NAM11FT079.mail.protection.outlook.com (10.13.175.134) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.17 via Frontend Transport; Thu, 30 Mar 2023 21:32:09 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 30 Mar 2023
 14:31:56 -0700
Received: from dev.nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 30 Mar
 2023 14:31:55 -0700
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-block@vger.kernel.org>
CC:     <axboe@kernel.dk>, <kch@nvidia.com>,
        <damien.lemoal@opensource.wdc.com>, <johannes.thumshirn@wdc.com>,
        <ming.lei@redhat.com>, <bvanassche@acm.org>,
        <shinichiro.kawasaki@wdc.com>, <vincent.fu@samsung.com>
Subject: [PATCH V2 1/9] null_blk: adjust null_param_store_val()
Date:   Thu, 30 Mar 2023 14:31:26 -0700
Message-ID: <20230330213134.131298-2-kch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT079:EE_|SA1PR12MB8917:EE_
X-MS-Office365-Filtering-Correlation-Id: 74378f0d-e9a1-4fd0-5d22-08db316637a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wHiMUurpbWwilRymtt0FF3MyPj9/01ycEgYrqklS1LrqAXKMUkTpqZQb2Ax7iWVoMMkPxJ/C+X1Trzjp5BxRNlQ/yUuHy4NaFjWu3hxaS/pXB/Lt23FwEznnsFZdC0ZUT+FrKmG/St1L2N5qSTzb4IWCsrS5eMR0X6W7Ge+LoMBEHvrupxlY0OYTZlbx4bE4CJyN/iMcZsZ36hcEUZYbuorAjBaJNP0A3iwZc9FPVKORShQmiUXRi+5X6BbCgE3/111fauVLNJkhH9atdPYzdcPg4aXwU144D68el4OntDNUXL72VCBToLwXumqD+/RvHTV0zWr2IS3Tv1MamvTNa1UMcnHdqMmZu2kpPUeDaSx2PePmsv9Mt0LHSuvX/I+N5K1J1upipIcgnxoWbHWNRqegCfCae6RUfr8PJKKgDttLUHM2oNV+YTxS1UB4srKpud3/vDxNsqVaMLacxMRE6WtMGSDmahs5VruWQ16wrw837rmIgvNpkbJ75aEAdLgA/i4KURk04VKjEBVTebhrSGVt7FXV/3tZ9G7PuyeTitcAIRrN9lrkSGbjy7jjYFcLiLoQOQ5b6PO62c5OKzrvhaHyg1xLTTv8/fnkyqK/5PyLmU7tYejOC0/v7av31XgkdyK55h35QrQIwKX2OB4ZExKJfvBzskO/t2ggbcp32qLOMvVkbved5r5/Ij/wqocCbfu7noNAo9vFUlWC94jSnIgpS5eDDX3CMMRxtgKa+k8KfTCeWcjJQe1h3ge2NryWR6il7jyIItQ6K7MfPGRExg==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(39860400002)(396003)(346002)(451199021)(40470700004)(46966006)(36840700001)(16526019)(2906002)(5660300002)(316002)(82310400005)(7696005)(40460700003)(8676002)(70586007)(36756003)(6916009)(70206006)(54906003)(36860700001)(4326008)(34020700004)(478600001)(40480700001)(82740400003)(41300700001)(356005)(83380400001)(7636003)(2616005)(186003)(6666004)(8936002)(1076003)(26005)(426003)(336012)(47076005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 21:32:09.1972
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74378f0d-e9a1-4fd0-5d22-08db316637a5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT079.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8917
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

