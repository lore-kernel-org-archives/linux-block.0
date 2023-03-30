Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EEB7C74A5B
	for <linux-block@archiver.kernel.org>; Thu, 30 Mar 2023 05:53:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbjC3Fx2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 Mar 2023 01:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjC3Fx2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Mar 2023 01:53:28 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2076.outbound.protection.outlook.com [40.107.220.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 039D0110
        for <linux-block@vger.kernel.org>; Wed, 29 Mar 2023 22:53:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gVrHMoN4aHD96g2U2yJ59on5VpCRk+XSDfOIgNZnPBoSR+Nc5ss+zFDAuxIJCwij6wlHKndTyJkW5dZelkgn+mFJEhwp7gU+dGZXpfh/jbDEr7+hp+Q2qeF+oM6Hui5/3aJyL+C6gRn60ChNOyEuimXZVwHCqBgYFaNqNg2+jFxIKwuQpVT9f9anzH514UH0SgHpvOj5IC8+CCzTE2o0/66Mqeh8nmbPtAht+DeE94PKuUW4eV+hIdXmooDIRKaZiIxI6zxwT7KpCi6KyWxy2MwqUx8UbofhcLcWF3iJbIKA6WB52Ev1rwUKbk3nehH1xlMd3iHSWdKQ4TNgNsz7Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/G4oWHzfWdkCLjry2SufGbdC/qY6JdAgZVgdGbhmB0Y=;
 b=Zg5945JiMFfhbHMnCuy/YWr/yjEbfPkxgttqkzO57l283DeMgtQCuAVDZ88RgV2uQp92shkhekB4hfbcrtaQDxnGKfsdLE9BCjzhgUkP6aB4mZlsMHpa6R5gTFbdW4XJAVLiitDoXPwqin4YKy/SbMHWkI7sw5JXeiZ1BLh1iwlOjZVvAobybEZBTyh8N5yRkUUSBLeTqR686IxvCGJejyd/e9rS7YJHCFWC/wRhxHns9oGqVW67pOJp+Vac1WnxfEi5swjYqFMdPUOxHlHYsNnbeR3Ss+ORP3i+QMXdrv2pMGmrf4+1rvfw2qE6C8aXLBWsZw5Pf4DlC0DGr0JuUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/G4oWHzfWdkCLjry2SufGbdC/qY6JdAgZVgdGbhmB0Y=;
 b=VOfcM2448hm4pFzPMe/QJP3WNZPesoeRFVEsfdmUO7EFwp9Py9hyOqcXwmpyQCW6/KrI+YwdqvYVfXd+oGdhpvb0K6kMZnuKt3dUy9bL97pryEssss/hci5sCW1X1+jdPHQLhXpoHAxn8l92F7ez0K121hji2CrO0C8ilAOCc02ehTt8yx/H/YCbrMxBnjwKxIpAPLHDev7qapscrwBqqLoTdKcLeWSJinlFqoAyaKt5LVNnm1QqT4kdJdvTpPjD2Z1ZVSxo5EEjh1urF0ebFH36xBQWIRC+brPEU2H+TTTZWBzs/8NzU3o5Xf/fgwAUZdQX9Z49lO4UCQ4pWgDI/w==
Received: from BN9PR03CA0802.namprd03.prod.outlook.com (2603:10b6:408:13f::27)
 by CH2PR12MB4200.namprd12.prod.outlook.com (2603:10b6:610:ac::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.35; Thu, 30 Mar
 2023 05:53:24 +0000
Received: from BL02EPF00010208.namprd05.prod.outlook.com
 (2603:10b6:408:13f:cafe::3f) by BN9PR03CA0802.outlook.office365.com
 (2603:10b6:408:13f::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22 via Frontend
 Transport; Thu, 30 Mar 2023 05:53:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF00010208.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.30 via Frontend Transport; Thu, 30 Mar 2023 05:53:24 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 29 Mar 2023
 22:53:08 -0700
Received: from dev.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 29 Mar
 2023 22:53:07 -0700
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-block@vger.kernel.org>
CC:     <axboe@kernel.dk>, <kch@nvidia.com>,
        <damien.lemoal@opensource.wdc.com>, <johannes.thumshirn@wdc.com>,
        <ming.lei@redhat.com>, <bvanassche@acm.org>,
        <shinichiro.kawasaki@wdc.com>, <vincent.fu@samsung.com>
Subject: [PATCH 5/9] null_blk: check for valid block size value
Date:   Wed, 29 Mar 2023 22:51:59 -0700
Message-ID: <20230330055203.43064-6-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20230330055203.43064-1-kch@nvidia.com>
References: <20230330055203.43064-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00010208:EE_|CH2PR12MB4200:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fea967d-8658-42aa-4a6d-08db30e31351
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XuDL5qjJOcnR5Y2qrYWusJ9YJQNutRNBInSb4S1D9tEGmPQ5hDA2YKZ7ZL+IThVX3yAmLuVSiVDZChsgnXFP/MqaLj+gCC9+uip68dTo5f6J8aHrAAuJYUJB0nRGdC9sNjusb4nsGee+x30qwyCZj1Bpe+Tlz3scnFhv9rrnscIvrH4oaxljYjEXblCaWuOMMAEFCaabD3nHXpk5lBy+VYeMdRx1wWgoudlPAsHlxZL39d4cV7t9NI1l5ME44YOoysCd7x6aoS9stHfsB1gOA2KgQ8E+PQYukm+FAHYL8qp59lkr3y1sUBiON5wiv4+8uMY3rWeS8yLE+7kE760iWjoRWxyyMZ21gNVgn4BL7ApjCfKP2Ar85pszDWAyXATb3WL3u9X/qTA6dUUCUdPwWj4VXrKmvjeuZwKveqYSjaKBi1eb6ttPHoNIvgrMSaOSN//BRZqZqupYJCiR9TvS0kYiAwQ6f5D3UOhmeutyWghruc8vZSQ1ieos5g4G8IL5k0zKYBh7eEYZ1L2MVOScjCYNtZGDCs3Ae11C1KJqQui79xcoVJKP3sSgbJoTL1vW65oYTBA/j4JlURqJgH/WMDt0ZSULnLTH1nnpWR/kYBV4QtKFs5SuVUaP023koj8cnewBlaPFRORSPGI49yd04JFVHDKhxAcXlplGTzxzDbtG4rz3UX6zlqDF7dM0992XhYO9VtRzbbqQJP0wHMKDgdez2TcpSem/L7MBDJpS7wj71jBeFFDvxwKW+CuUFN0V
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(346002)(39860400002)(136003)(451199021)(46966006)(36840700001)(40470700004)(6916009)(26005)(1076003)(6666004)(356005)(82740400003)(7636003)(336012)(2616005)(47076005)(36860700001)(16526019)(186003)(426003)(5660300002)(8936002)(2906002)(40460700003)(54906003)(36756003)(82310400005)(478600001)(316002)(40480700001)(41300700001)(4326008)(8676002)(70206006)(70586007)(7696005)(83380400001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 05:53:24.0829
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fea967d-8658-42aa-4a6d-08db30e31351
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00010208.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4200
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Right now we don't check for valid module parameter value for
block size, that allows user to set negative values.

Add a callback to error out when block size value is set < 1 before
module is loaded.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/block/null_blk/main.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 51aa202159cb..8f7c6f8c2132 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -179,8 +179,18 @@ static int g_gb = 250;
 device_param_cb(gb, &null_gb_param_ops, &g_gb, 0444);
 MODULE_PARM_DESC(gb, "Size in GB");
 
+static int null_set_bs(const char *s, const struct kernel_param *kp)
+{
+	return null_param_store_int(s, kp->arg, 512, INT_MAX);
+}
+
+static const struct kernel_param_ops null_bs_param_ops = {
+	.set	= null_set_bs,
+	.get	= param_get_int,
+};
+
 static int g_bs = 512;
-module_param_named(bs, g_bs, int, 0444);
+device_param_cb(bs, &null_bs_param_ops, &g_bs, 0444);
 MODULE_PARM_DESC(bs, "Block size (in bytes)");
 
 static int g_max_sectors;
-- 
2.29.0

