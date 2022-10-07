Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DA03C433FE
	for <linux-block@archiver.kernel.org>; Fri,  7 Oct 2022 06:32:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbiJGGcL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Oct 2022 02:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229636AbiJGGcK (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 Oct 2022 02:32:10 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A2DBF2528
        for <linux-block@vger.kernel.org>; Thu,  6 Oct 2022 23:32:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VNLJhBw2FK57UoDjTwXSlNHRqgIe45sHWV5IiQAPYqXVRt45+LPNnfn9KE4Cu1tJ7rMW9PQGID16cGwVUhExjgQXbfriDP50cu2FWYXL/RGrcVf9GIeDefM0xnSUooleYUiHb6YFiGNoatO65br7PCJEZXfKtRZYqfReuS5kOv8mJLtYt3FqDEc7/Oc9FR5UcT0MUBrTFB2zv1qFVBNCU2nTZ7psC4OcL0VMnnnWA1R05dLMqGlPfcztSicM5ZNAq2iP5WNv6iPfLEQoX2yFHKnKR7raRbKmw9CzSH5nHVcCdAa3ZpO+rfVf5v1LeiR+hIwMKUWFLa5T/4e+/IuAzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lWEb/hALhtdYFGUjTq0CWn9EDOs0shJvZ0y8GbOm7To=;
 b=lmGnuc5M71C0HfkGpUQxu7LqqmgXuZGkNVHlLMOmGKBR7UMypoY+j0YFVG+MlQFjhufftzNtThr/lS9Mxm5UlVTbZgiAMGTUFS711ReE44JvdZsV/QN2jEWQG/VBqZtmhpIbmNSbQ9QxWV8UvYKZXSUqHrBbU7wbxRKoI/6AklDvKkfJ9QYcGbVtdkF3TJcMefiNIk/L/e4714kqS9S5H98EtODlA4jzLUjFXRBmIt8sevPGvrWGvfJUOIqCA9jZ7d9XY4eoHP4pMOMhK7fQ2pfVO5tyMJcoodNUkILdYKusDoUOiL/bMMLmlrFgcyaooIb11Nk/3WPjLHxUzmOF3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lWEb/hALhtdYFGUjTq0CWn9EDOs0shJvZ0y8GbOm7To=;
 b=St6h6Y8LLB0/2b7ncNJ6MLkz6kEI/AukRQg+yY6FGdF94C61PoDMGlLRCCTExRItNM9onyR/sZMHX7VlZO89hTFwPNSRkUv92W4somG/Qr7Wi6axxrL+mAiioXVcF+1QbaYnJG6xPvJUaXoWVSAnWPn//pXc4CpghO/E2ljfbKutLZpP7mtRSPMH2wc/mOojjK5XgKYJZrny8pvq5cDn6RWvQr8uEIMk3AS3UzPH3MAXUojJa7tTldjcjqm05zGsTMqgmS4ASvnINsDKIkUgzTAnl4SQNtPcn3nM7SKh18zSBhE5Z5lfqeEnYUBVUwRRVcjd9fjw4dDzRKu3I7I+mg==
Received: from BN0PR03CA0028.namprd03.prod.outlook.com (2603:10b6:408:e6::33)
 by CH0PR12MB5027.namprd12.prod.outlook.com (2603:10b6:610:e2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Fri, 7 Oct
 2022 06:32:07 +0000
Received: from BN8NAM11FT092.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e6:cafe::11) by BN0PR03CA0028.outlook.office365.com
 (2603:10b6:408:e6::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.26 via Frontend
 Transport; Fri, 7 Oct 2022 06:32:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT092.mail.protection.outlook.com (10.13.176.180) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.10 via Frontend Transport; Fri, 7 Oct 2022 06:32:07 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Thu, 6 Oct 2022
 23:31:50 -0700
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Thu, 6 Oct 2022
 23:31:49 -0700
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-block@vger.kernel.org>
CC:     <axboe@kernel.dk>, <kch@nvidia.com>,
        <damien.lemoal@opensource.wdc.com>, <johannes.thumshirn@wdc.com>,
        <ming.lei@redhat.com>, <bvanassche@acm.org>,
        <shinichiro.kawasaki@wdc.com>, <vincent.fu@samsung.com>
Subject: [PATCH 5/6] null_blk: check for valid max_sectors value
Date:   Thu, 6 Oct 2022 23:30:35 -0700
Message-ID: <20221007063036.13428-6-kch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT092:EE_|CH0PR12MB5027:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e3acd9a-b2c2-4f1e-5f02-08daa82da840
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: raZAoFf31kA2T9g5nFEg3RUqMFGrHXh54cc4mfWhjdPLqH10xGkiXWFmqno6Izs/DvwJfRvBtAobkCY1uaAezDGSbPaV340POD0yuyb1mb2u9gbdrdD+6ApSnh0TDhVx7pE84k0QR1V/3GEmtVy7RSH3Gg1TUfM/rCw19cmVxIvjRlOrrZXoxn+Nf0zUuzA+mVhYQcE4dBtJuK5JeKBXFNTjCBfP4zKv7344d37Xl4OoRvAjMBopYtpJ0pClPvSIzS4RxL9/CV8VWVR8499lttet8h/TOq6ur29D+KIE/IXaxOv/06QkktJugfr5ptaFF3l5pMLebW2Cx2JNrLbqJwH88UJMMBr0NJvfJOCc9mmR1KRRlVIy18QpZXJSquA+kA8GnypbeemRYA7aZ5ORjjPB+QLr/x3qujyjBDmWKFytWSautI7kVfrISI6Y+fladdFsiv54aCgqyZwjfeX2gyVuPzHRDXKHklKnSul7RDFNuFi5p+ILRl1/ZWbAfXEfXOgcQ3uXWCLXxpgdhRP0UKRoFURWAZOxDEt9FYsGwsDBQNVTnB3rAcaxLJOGU577FBdAldDrWw8lBvfCgKBfHyDYxq38HjbmAN8bTqNlbB9mACF2HsIk3JRd7VMIfqmrLou3yNi7esvErEfXEJSZjEHMgikoIXfgGLcZmAiwzDPLDlfwZstzo3IdzKBPaDQT651N1gr2wcS9zzV2VFNSmB9uHUCANBdaaBHB3WPPeZP2cJfZJwiqHkiXi41eZl/mZ5r1Y+8/8ZuiAamW93U99g==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(136003)(396003)(376002)(346002)(39860400002)(451199015)(40470700004)(46966006)(36840700001)(8936002)(5660300002)(41300700001)(2906002)(7636003)(40480700001)(26005)(70586007)(356005)(40460700003)(426003)(4326008)(70206006)(8676002)(6666004)(82740400003)(2616005)(82310400005)(16526019)(47076005)(336012)(6916009)(36860700001)(186003)(7696005)(316002)(83380400001)(36756003)(478600001)(1076003)(54906003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2022 06:32:07.3944
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e3acd9a-b2c2-4f1e-5f02-08daa82da840
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT092.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5027
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Right now we don't check for valid module parameter value for
max_sectors, that allows user to set negative values.

Add a callback to error out when max_sectors value is set < 1 before
module is loaded.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/block/null_blk/main.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 7cfc1eaa5e3c..1b9fa5af02d5 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -195,7 +195,18 @@ device_param_cb(bs, &null_bs_param_ops, &g_bs, 0444);
 MODULE_PARM_DESC(bs, "Block size (in bytes)");
 
 static int g_max_sectors;
-module_param_named(max_sectors, g_max_sectors, int, 0444);
+
+static int null_set_max_sects(const char *s, const struct kernel_param *p)
+{
+	return null_param_store_val(s, &g_max_sectors, 1, INT_MAX);
+}
+
+static const struct kernel_param_ops null_max_sects_param_ops = {
+	.set	= null_set_max_sects,
+	.get	= param_get_int,
+};
+
+device_param_cb(max_sectors, &null_max_sects_param_ops, &g_max_sectors, 0444);
 MODULE_PARM_DESC(max_sectors, "Maximum size of a command (in 512B sectors)");
 
 static unsigned int nr_devices = 1;
-- 
2.29.0

