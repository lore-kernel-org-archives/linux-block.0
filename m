Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD7DCC433FE
	for <linux-block@archiver.kernel.org>; Fri,  7 Oct 2022 06:31:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbiJGGbw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Oct 2022 02:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbiJGGbp (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 Oct 2022 02:31:45 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2083.outbound.protection.outlook.com [40.107.92.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3245DE319D
        for <linux-block@vger.kernel.org>; Thu,  6 Oct 2022 23:31:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QXLWpG/kFTEPLzR9dpj/+dYU9LG0vnITP204mM7w9Tn94oh5mBSXYmhpiJ2VtB2/mb27QTNuw8G6sT+UhsEqM5GpqJ74jmls7Pt0OfO7mQ0G9wTDWgv/EQMOGgaki39Gj3HYo03ODEImGp5+pewbAa9yJFxnVA2Nn06utDuo+ElLPToryOpgpRPRR1dJ/1p97m1XCAPu4rVWjRJ0zIGGQbNijTCBZMP9/cDas2ffeRbugtC8APMr/UhdZNdxb6lsjIJM+bf8hKpxpOKmA54mc3JoixSar3dX27kzbYOXJ/iFvmG5FF4DVvhkAUVdPciGzsMMda1nlc0nTgLZ5WcxDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HxfqhzuC1gwwygt8nD2oQm5xT7OM/dOrSmCsRHlGBeA=;
 b=XM6oHFP3y+3f6tFTH68tZOJZY47Joqv1xoQDT24uyBht4xB+y+pRqqxZ/LreBwZXp6YFrkxn0wwY0UgdxfUYaYGqr56+UhA9VmNXNk2vPo1u78u2X9ywxYDfu2oFn4/IqvkWVpXY3jm97qc0ZT2YKiiDDe/fnqqgC+Zu/6smkJWo+QhfSj4Vc8rUbpN3VYK8RHK/catyKOR/dPMRBCZEMdNl2eQM5KNVoZAyfo5x3D++VPrGx+BU+wH3PsJEnxy2vHi2621Ei9dfroH1oUSIZlMNfN7EvFC18Bxi7PfW9z4czhreNsnxaxe7QLDfF+VTpFixLJTTOigF1jBaW40Nsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HxfqhzuC1gwwygt8nD2oQm5xT7OM/dOrSmCsRHlGBeA=;
 b=jHD+YrSe/VU8WuNbiThZxNbDAOJ6kESM24O8CIObr7aprr8u14t97wYcMTFgP4kAMyDHghHhYdjHKlJKceiLsbjLECIdpHbAU8/B01t7oIN0o4DPktmjBqJ7EX6lVUKvmYD9h3LbOfj/SF44lFK7qPv8q7jOeJT+6qsdZ4kFrevrYQpDgAXVpgmTg1h5zdLvXqVWve0qqRU6gIhHpXNSu4saOq6pRcRQNOa8lhxTIrU9iYzC3g9fE5Qx/WoFqDzkjwdkvQFvtiamXxFgeIRraZc7b714UIcXsjramP3RPD/YW9Ao15puwbLoYh7nLZyzH7ZofWI9RYdMMo7WT8cVMQ==
Received: from DM6PR12CA0034.namprd12.prod.outlook.com (2603:10b6:5:1c0::47)
 by PH7PR12MB7138.namprd12.prod.outlook.com (2603:10b6:510:1ee::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.20; Fri, 7 Oct
 2022 06:31:40 +0000
Received: from DM6NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1c0:cafe::81) by DM6PR12CA0034.outlook.office365.com
 (2603:10b6:5:1c0::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23 via Frontend
 Transport; Fri, 7 Oct 2022 06:31:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT012.mail.protection.outlook.com (10.13.173.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.10 via Frontend Transport; Fri, 7 Oct 2022 06:31:40 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Thu, 6 Oct 2022
 23:31:27 -0700
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 6 Oct 2022
 23:31:26 -0700
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-block@vger.kernel.org>
CC:     <axboe@kernel.dk>, <kch@nvidia.com>,
        <damien.lemoal@opensource.wdc.com>, <johannes.thumshirn@wdc.com>,
        <ming.lei@redhat.com>, <bvanassche@acm.org>,
        <shinichiro.kawasaki@wdc.com>, <vincent.fu@samsung.com>
Subject: [PATCH 3/6] null_blk: check for valid gb value
Date:   Thu, 6 Oct 2022 23:30:33 -0700
Message-ID: <20221007063036.13428-4-kch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT012:EE_|PH7PR12MB7138:EE_
X-MS-Office365-Filtering-Correlation-Id: 794987e9-c7db-40a8-3627-08daa82d980f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ImZAQoj4HxuLL97BWPhMeEnuqzCo0f5R2IejH+89oQy84WfV97Z/077WEwXpHXiGpRfdB1Zry2YdK9VpF6Zonl0FT8JcfS/a8ZIRba1b5mwCfQ0oyDRdvy6nsSa6hXpgEDcq23w0WVDs5+l7qM8iJmFa+wdXKLsbav747itCNwScNnDn+IAxjiNr23LaCYWXarZzrPoJVna7xLYK3t3ckZMcr1KmFb49IXTofPjG3kIDg9tCbrb00tgWw1UBW5D8lihXxg7Hm8CVxhRreKyKn1DLSFKIVaWKNRs8FpFdBsoN3zygczkMSbsFq0VIStPMjMEm77blUUxR41L/hOkD0ZZgf8V9SF2wk/NqzLpV6C+oP6vNpAE/NyGSISr3kvspMOhYcpmCVu5IpXWGUy/VY8+h+g7ugxokQ3hMudh078d3g5ib6X/4XHtUbu0+pM7rYFY65waQ83XjKIWQoES0Wd83CXbMErjpAQNbBTx0fLbK4LCMT593R7uhpfLdg/sf25mnfTMiRGCqr6vM4quSZasGeknRDiwoamhABV6RS3qzqSgAmN3usyIy3XoqtiCAVLM29nQYbSY6Ka6gxx+HHdRst2asjfDxRA0BltifFs2nEMETwGr8zKlBQ8/d6ayln6UFkno/Y8hTqHNeC0K6bVRsahPdxn8huqgIMzSqqVSNAR9Qsgdal7cDgJo31FkMDOnjn2BN39qUa5zIhcnjfdXd2Z0qDzaY91xsU0OlFf2K1hlaALZAgSBdD0ZcYPByvpEd+9PZMdxDDFpFV+u2Rw==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(376002)(39860400002)(346002)(451199015)(46966006)(36840700001)(40470700004)(8676002)(82740400003)(6666004)(26005)(70206006)(356005)(7696005)(40460700003)(478600001)(4326008)(70586007)(7636003)(36756003)(83380400001)(36860700001)(1076003)(54906003)(2616005)(426003)(82310400005)(186003)(47076005)(336012)(316002)(6916009)(16526019)(41300700001)(8936002)(2906002)(40480700001)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2022 06:31:40.2600
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 794987e9-c7db-40a8-3627-08daa82d980f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7138
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Right now we don't check for valid module parameter value for gb, that
allows user to set negative values.

Add a callback to error out when gb value is set < 1 before module is
loaded.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/block/null_blk/main.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 29e43444cf66..83bf9065831a 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -165,7 +165,18 @@ device_param_cb(queue_mode, &null_queue_mode_param_ops, &g_queue_mode, 0444);
 MODULE_PARM_DESC(queue_mode, "Block interface to use (0=bio,1=rq,2=multiqueue)");
 
 static int g_gb = 250;
-module_param_named(gb, g_gb, int, 0444);
+
+static int null_set_gb(const char *s, const struct kernel_param *p)
+{
+	return null_param_store_val(s, &g_gb, 1, INT_MAX);
+}
+
+static const struct kernel_param_ops null_gb_param_ops = {
+	.set	= null_set_gb,
+	.get	= param_get_int,
+};
+
+device_param_cb(gb, &null_gb_param_ops, &g_gb, 0444);
 MODULE_PARM_DESC(gb, "Size in GB");
 
 static int g_bs = 512;
-- 
2.29.0

