Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82519C6FD1D
	for <linux-block@archiver.kernel.org>; Thu, 30 Mar 2023 21:32:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbjC3Vcn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 Mar 2023 17:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjC3Vcm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Mar 2023 17:32:42 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2060.outbound.protection.outlook.com [40.107.220.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82358CA26
        for <linux-block@vger.kernel.org>; Thu, 30 Mar 2023 14:32:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nEy23+5EIXMKonByHpbm10ytvMEmuCNeMEobHlan9zQKmkHIZzxkz4+jKwN2iKZJHF6ALzkBEJn3jKQIUVM4sklU2BY6U5d08G8pWghCDgaHkYO/jmOd/edzmVLF1YI2VbCeDewHHu9azhm3cRogjZr3PG0OtthW/W9aIB9xevI+Fv4WTfND1VijOLF790O4H5u7krCKZPXs31LJBzbtoY2PYP0odzbrNNElE7h79JDtIvcqaNmm0xkKT8Ap5xqqRNWf9PSr/L5uqaLJ1D9PYVS4ePYU5MS0+dILTCqy7/3l5pQcG49VSYRIiwMGNWJUslyuc1ZdVeNdoc5KsSCNZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bLGEFvAD3iYIPweXY9TYHtGQB3SOQ++9SjP8ThxJ9MU=;
 b=XIR8x59G98sOlERt67eZ4/XJszxNRc4LTAfn10n3Fh4PchU2KBZ1DtZ3dsahJoD5lIpEAqH5ZfFPTOVZj86N9NmFJoRy+fWm3fKlItAOahugspAIv6aIk/446G9eTAin0ZhqcrJ9PbVSl/EcELKC4Itw67cXo0oeDjnkiMeC0/jYwgUopW/yQBC53ZN5x4komAh6/lL+mONy99ScrSzYaaieBpxmkUHuDui8Zti2m8425skNVkY+C8fJ1jeq8mIWGipzgn5jM5cGW1kwmJoCRtbSiJdidirIRkjrQN3XlG9ACDU4jorMhiv/iYj3oBrLD+ceTF3IZCrLGSkzMGxc0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bLGEFvAD3iYIPweXY9TYHtGQB3SOQ++9SjP8ThxJ9MU=;
 b=gzaA1pj+VExjxsGazo/IF94MypymGVqJV9Juso7flbM2TZ+iIod7WWKRF7wXn7FMkX3XxPTFpJffu6kIRt/cKECk4/auvuh9Gbm4ZYp2A/FFYEyiEBR4D/21IO23dYnLUQD6lenfkT0wPt0hgobkiL/mr9JWqnc/T4vTf8KcIkc+0yLR88qnIcpYWw5A0Y2kGSaqKR+O4tmU+JsaHWrGbxXyoLcUHdMQzr/zNUK5FGEVOYBgzInQ+HNOBvz1qNAdlPyV5fe3nw01UViLctg+qe738gnU1Kg5hqGvnWplRGgu/KAR8Z0aHts/fzClqGiH1QsELLiGPKGAD60Mc5pFxw==
Received: from DS7PR07CA0018.namprd07.prod.outlook.com (2603:10b6:5:3af::27)
 by DM8PR12MB5446.namprd12.prod.outlook.com (2603:10b6:8:3c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22; Thu, 30 Mar
 2023 21:32:39 +0000
Received: from DM6NAM11FT081.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3af:cafe::bb) by DS7PR07CA0018.outlook.office365.com
 (2603:10b6:5:3af::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Thu, 30 Mar 2023 21:32:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT081.mail.protection.outlook.com (10.13.172.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.22 via Frontend Transport; Thu, 30 Mar 2023 21:32:39 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 30 Mar 2023
 14:32:29 -0700
Received: from dev.nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 30 Mar
 2023 14:32:29 -0700
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-block@vger.kernel.org>
CC:     <axboe@kernel.dk>, <kch@nvidia.com>,
        <damien.lemoal@opensource.wdc.com>, <johannes.thumshirn@wdc.com>,
        <ming.lei@redhat.com>, <bvanassche@acm.org>,
        <shinichiro.kawasaki@wdc.com>, <vincent.fu@samsung.com>
Subject: [PATCH V2 4/9] null_blk: check for valid gb value
Date:   Thu, 30 Mar 2023 14:31:29 -0700
Message-ID: <20230330213134.131298-5-kch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT081:EE_|DM8PR12MB5446:EE_
X-MS-Office365-Filtering-Correlation-Id: dafba594-1382-4db2-5585-08db316649a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TpYqx5TdrnEv3/xmh/Ya92BPxU4jezZ7d1gvvT48J2HqefypYqYfkvsrwaoLm1yWRPdBShf3ghckDumZzuFSoGE6ZayH3NsaN8yCgA48oWUHPAga76EcUxAJMoeLhTEbg6O3aFYmPf8uGvc63m5rbQE4V2kual8/fiv2VaiL7z69agI1o0CMrwI+8Kjzm17WtyvOPOyCv0gP9/WxwBAiNBB5R6Lwlt1Venwdu0TXqjVWLPEbveKYKWNEoMWQI1EWyhzVXcj8KNmC3/oBX4gCs7uWVy32Al3AWEHLUGREANsYJz3W6EIzigmZ7b25LeufuOeufKiVqqCBJbjQP9LvA6Y+1ETm5VDdta5De3iaxowmWs816gTlwLyrSINhHgTjepCqcQNfHoUZJhapHIy+fADyy8iZS4J5FkTg8eVy0woT0Y6hKvpwT9Me/viNwSrQcwpNcI98nc4+4Psw3pdNwXagS6mrFoCloT0GSjjfKKTXbXkrkPlqHoy73xuP/FXANWYoY9EE3mn8Z8aNb8irnVRrLQRoPZwuTf4BQ/Pbx5lmyP3ewlgx2oUcVbUHvO0lKIjjgNe9cDUSCKlPbW4matrHZJsL6s4lD0wS0302N1Ymm4ZaoWnn2QPKKptNRSFFUTTHWb/srqgj7NsYjfANDXmpBZyMaWM5OCRrrVVrb8A0rfqcKFbBwcb9M+l3Usixwfd+5hjQrm5aY3yR5CU0Am/AIqA2FgqLpFC893zArPWUxcgIObaOzdbSYmzsxExZMEr5nHGZkmG8r2UrIPqvIoQXt4+tgxloFxv5pJU0iMQ=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(396003)(136003)(39860400002)(451199021)(40470700004)(36840700001)(46966006)(40480700001)(83380400001)(40460700003)(2616005)(2906002)(5660300002)(7696005)(1076003)(26005)(316002)(7636003)(54906003)(478600001)(36860700001)(34020700004)(8936002)(356005)(8676002)(41300700001)(6916009)(4326008)(70586007)(70206006)(82740400003)(36756003)(186003)(82310400005)(16526019)(47076005)(336012)(426003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 21:32:39.3386
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dafba594-1382-4db2-5585-08db316649a1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT081.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5446
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Right now we don't check for valid module parameter value for gb, that
allows user to set negative values.

Add a callback to error out when gb value is set < 1 before module is
loaded.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/block/null_blk/main.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 29bc4b5720c1..f55d88ebd7e6 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -171,8 +171,23 @@ static const struct kernel_param_ops null_queue_mode_param_ops = {
 device_param_cb(queue_mode, &null_queue_mode_param_ops, &g_queue_mode, 0444);
 MODULE_PARM_DESC(queue_mode, "Block interface to use (0=bio,1=rq,2=multiqueue)");
 
+static int null_set_gb(const char *s, const struct kernel_param *kp)
+{
+	int ret;
+
+	ret = null_param_store_int(s, kp->arg, NULL_Q_BIO, NULL_Q_MQ);
+	if (ret)
+		pr_err("only positive values are allowed for gb\n");
+	return ret;
+}
+
+static const struct kernel_param_ops null_gb_param_ops = {
+	.set	= null_set_gb,
+	.get	= param_get_int,
+};
+
 static int g_gb = 250;
-module_param_named(gb, g_gb, int, 0444);
+device_param_cb(gb, &null_gb_param_ops, &g_gb, 0444);
 MODULE_PARM_DESC(gb, "Size in GB");
 
 static int g_bs = 512;
-- 
2.29.0

