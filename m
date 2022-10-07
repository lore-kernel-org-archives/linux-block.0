Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C763C433FE
	for <linux-block@archiver.kernel.org>; Fri,  7 Oct 2022 06:32:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbiJGGb7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Oct 2022 02:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbiJGGbz (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 Oct 2022 02:31:55 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F060115C11
        for <linux-block@vger.kernel.org>; Thu,  6 Oct 2022 23:31:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eQIi3dQxBaWadzUfSJrNzgGJMmLL/HRfhYn25oPBCuOPftChkcErcFwS46C+7iyUYpYxMyEhPA7wDiWF2anJd/1yORfLee98Za+wmqOUin4opdGk5s0Tl6oqsJOg3Xf41j3yAfBKUnTnQLuCmFFU0tX8SuBEhdjK57zKR71EMSml/EK0fKIABndlwPJuxPEag+rO7U92OidgC/NoeSLZOvD1QFPzHyrnkT8NRb6UccKpUIC7njmPQpn5TgV0yEudZ71X3yhdMjUZBRIgqKMgC4pwVk8rda4OF7DCVRqg94uLYb1uGpiRMria2Dhk9fe/QmiZw1g1CxIQ0iiBh8+iaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6cJTmDi1q1+r8ju23ipeqrbOanoIov9Sf/VrRL3TonQ=;
 b=RIFxMX2/2PZU56W4kglB945Ndq/Y+spHKPY0Khnik7xs0xb9gnXI/e8db05dF58kwU5hUpntPhR9TMbZ9VPIajVxiAoNDPvQHRiSJZ03vOlrZGXwtQdB4TXYPChaJRuNr0fKgjywNZo+ZCMEbNGjU9K7b1Le12BVSIjTabqfFFpvHGKmrCFn/kiDoShjftKutRUkB26Qy6mbD+rmormBdK8H0noGCaR/PtaDnCgSQtU38zP60xlEmXykfxjnDJ14EyhcCvLgb7IcuTd/0fUcnfsHydWzy61HXlerHxW8B3njJVl/+qUBGFsqHwyfRWGMKGSG8Zem044e5m1nKkZTdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6cJTmDi1q1+r8ju23ipeqrbOanoIov9Sf/VrRL3TonQ=;
 b=NLBOb/44MyjKWV3z/kqLxcV4dXgJJ2ormq/a4cr1Xk9ZZTXPGUb3TUeBsaAj9cn3jUIn8v5+xsV3D5WL4cRQhcCNuUHiZSjmY3tu12c/yBwKA2KddKk6iz69qGAGLmxmtX+zoBHR/PMDIA/NbvaCigm9sZHjqde8L6neYGyz+42KNPTvzK/1QjKeNlscYHBgOFc5M6P6njiY7BgGyyN+qK3GPR1y5Vch8vXgsTLoPUhDgST14DkItnXB2DOggi9aZuEizLV5keCgkga0XKVex4gazUwaJcq2MyaPTIr8ZAiYlYFQrURSH6+HZLPxbrExKp4ODNlI8SKkzWVI9ixsdw==
Received: from DS7PR03CA0137.namprd03.prod.outlook.com (2603:10b6:5:3b4::22)
 by MW4PR12MB7384.namprd12.prod.outlook.com (2603:10b6:303:22b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.19; Fri, 7 Oct
 2022 06:31:52 +0000
Received: from DM6NAM11FT098.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b4:cafe::f1) by DS7PR03CA0137.outlook.office365.com
 (2603:10b6:5:3b4::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23 via Frontend
 Transport; Fri, 7 Oct 2022 06:31:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT098.mail.protection.outlook.com (10.13.173.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.10 via Frontend Transport; Fri, 7 Oct 2022 06:31:52 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Thu, 6 Oct 2022
 23:31:38 -0700
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 6 Oct 2022
 23:31:37 -0700
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-block@vger.kernel.org>
CC:     <axboe@kernel.dk>, <kch@nvidia.com>,
        <damien.lemoal@opensource.wdc.com>, <johannes.thumshirn@wdc.com>,
        <ming.lei@redhat.com>, <bvanassche@acm.org>,
        <shinichiro.kawasaki@wdc.com>, <vincent.fu@samsung.com>
Subject: [PATCH 4/6] null_blk: check for valid block size value
Date:   Thu, 6 Oct 2022 23:30:34 -0700
Message-ID: <20221007063036.13428-5-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20221007063036.13428-1-kch@nvidia.com>
References: <20221007063036.13428-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT098:EE_|MW4PR12MB7384:EE_
X-MS-Office365-Filtering-Correlation-Id: 81ce81d7-dd95-43a4-df92-08daa82d9f44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: itIkB9mfZ39PvlhQsfshYRVms0LoOs9OT5W723LvKeMU0ti5W6fJpl7iKMeOHbZGD1fI+ByOtvQiSA/6TE9OrcWPe0PgIqzJq9SxcWler+3RgdyvM+LznXxyxp6Xv3mQ0DrwxpesB1Uo2Cc57oAJT7z2NCPxQl+efb9y7kCMzAFdRFdsNwKbjlq22tYHl0NADgYbAIi1BfvnCkgQqGOOvgv8sg6Fn3X+jpM/wIpQdWDFS7XiqqIgywyULpvXrf2q3JRfgupxBc4sQ3P9BENw261ERCx1C23lqt5sSGiQLhy0C3pxq3pCR9JsR42BKEuqUvvi694w50de0187mx5vqFQ7/nzxLFu3FpJr2RA6nUjRDVfBnnu7l8BpicwZ33jc7gZucfouFx60DInSCSjUbAgvj7MMV4k4mTuz3Zg2u3cq+p0mJGRSDIZnDtYR8y/95D7srAN0+kPQRBrDXKfC0Q38mlde8xaIllFexKKOPzI4c1qKn1Xtg/LzEMp/cwuUuCal97i6fkfUedbDbEd7WMcoCi2cVj6avmXEMZ2ZNVU4OVacgUxAsKUJd6WFxy1V0dZAkAUla44RkSjaqg1aC+iDN2ophV0Ilgxwz6n9ay9thDPlMRPgzvvU6AKj2N2VDt7Nbr9TVUkZiK72IhdYzyRK05dVTIt6l593cIpfjc3DyER/CDsJs7ceqt1C9iWUK7Fj+4JUiuklXhWj0zFvWGeuIH4F/B8k7Hr6N7oY8elMTCdjp+kpqjqJtqgyGVTkriSixE0Nl3hnGMIC2EDRQg==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(396003)(39860400002)(376002)(451199015)(36840700001)(46966006)(40470700004)(8936002)(336012)(426003)(82740400003)(70206006)(186003)(70586007)(47076005)(83380400001)(36756003)(40480700001)(8676002)(4326008)(6666004)(478600001)(16526019)(6916009)(54906003)(40460700003)(356005)(1076003)(7636003)(316002)(7696005)(2616005)(41300700001)(26005)(36860700001)(2906002)(5660300002)(82310400005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2022 06:31:52.3557
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81ce81d7-dd95-43a4-df92-08daa82d9f44
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT098.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7384
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Right now we don't check for valid module parameter value for
block size, that allows user to set negative values.

Add a callback to error out when block size value is set < 1 before
module is loaded.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/block/null_blk/main.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 83bf9065831a..7cfc1eaa5e3c 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -180,7 +180,18 @@ device_param_cb(gb, &null_gb_param_ops, &g_gb, 0444);
 MODULE_PARM_DESC(gb, "Size in GB");
 
 static int g_bs = 512;
-module_param_named(bs, g_bs, int, 0444);
+
+static int null_set_bs(const char *s, const struct kernel_param *p)
+{
+	return null_param_store_val(s, &g_bs, 512, INT_MAX);
+}
+
+static const struct kernel_param_ops null_bs_param_ops = {
+	.set	= null_set_bs,
+	.get	= param_get_int,
+};
+
+device_param_cb(bs, &null_bs_param_ops, &g_bs, 0444);
 MODULE_PARM_DESC(bs, "Block size (in bytes)");
 
 static int g_max_sectors;
-- 
2.29.0

