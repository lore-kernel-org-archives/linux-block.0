Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCD95C433B4
	for <linux-block@archiver.kernel.org>; Sun, 11 Apr 2021 16:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86F5261029
	for <linux-block@archiver.kernel.org>; Sun, 11 Apr 2021 16:27:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236416AbhDKQ1U (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 11 Apr 2021 12:27:20 -0400
Received: from mail-dm6nam11on2058.outbound.protection.outlook.com ([40.107.223.58]:3424
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236406AbhDKQ1T (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 11 Apr 2021 12:27:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kq/EmJ5igcrSG0mIF2YWhPdp0wU5+PkEh01yooWcRY02kGDEnUgDOuYATW9al5vdw/sUYY7ykNz06Wah1jpBd61LNSdCLnhxIMqkXEGIolcBfrMKPeYkfCukhAwnHA6Z7rZW5gbnFkCTWM/+aNKaduWTzbxhEKHThIzQzSc86PDb03kKTlvmFVrcbEFS43MSPahYrCZD6T1AyXQGfkHJmfjvYnZVVM7icEaAnfD5iaQ9kd7i+7IkPKBKww2oNmA+mEwc3iMGSjWqFAQWPkrkwaxbL2YbpFbrDEkPXFZJ3zgmdytuY7w/RdcMkc9QGAje4Ucveg3djYltHRdA4Avr6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y+/Gd7uJ8ewmeSY9rZBuSXKMZhqG6uCs3bagHRLygoc=;
 b=DvFqtkToi7L1iGmS0QJ9BWphvOzFgboWl7Rbc0QfDLivN+U0PSHgfQlbTXWterZDL+m482EHg/z0CF3lScEpfyyg7aRWDgfF25fCYfRopkpp0X+8oqCtw6vySd0NTTY0k9Gkx3YuZY1rtcoyhwYK3GNxxwdhU32aMCOVmty/QGvSUQqJRGcw+8htdiorSVV3aOGPgaVPd54msnWQ/vPXJDqp6aUSXbJpXzkp+ISm2887HEcCBkAMrigxEe+70ALdmACyNYxVfuJ9RoxfSnHVLX3jTDBhlSCkNMncFOxG4y/VlnO7Iy+U5FxcNlG3VdjSre9E7vFaVTgaxqMq+njGeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.32) smtp.rcpttodomain=kernel.dk smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y+/Gd7uJ8ewmeSY9rZBuSXKMZhqG6uCs3bagHRLygoc=;
 b=AlfiysJQHgGC6IjGRXB71KNfh4v1J8EJBg/NBPztXUIPqKEzZdH5KiABhlhDC9Ho2f2/ak1DFfWl5Rszr3Ol+ZPainRfdCcHk12T7B8uKr/SteAyHSMVpbwPyMyuiWtzzsAJ0hD1jJJNNZTO+E2PiDUeL6oyBkx1ecRMpNmcr2/VZ08avhRXwzGdyipOEJ4ec4t11gNH8Y57dwUMHM5q5fIT9ENM69c4fADbq8v34q61AoXm0XL3W6TQck5ixDVTNHjySJoPVzxz32xsGF736m34INcv2gbpLR4yQNe0o25W7YnOQ3eIs44VAYiCO0vDeY6PgUr88BMGovZlOczJ+g==
Received: from BN9PR03CA0043.namprd03.prod.outlook.com (2603:10b6:408:fb::18)
 by DM6PR12MB4861.namprd12.prod.outlook.com (2603:10b6:5:1bd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17; Sun, 11 Apr
 2021 16:27:02 +0000
Received: from BN8NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fb:cafe::48) by BN9PR03CA0043.outlook.office365.com
 (2603:10b6:408:fb::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.19 via Frontend
 Transport; Sun, 11 Apr 2021 16:27:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.32)
 smtp.mailfrom=nvidia.com; kernel.dk; dkim=none (message not signed)
 header.d=none;kernel.dk; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.32 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.32; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.32) by
 BN8NAM11FT055.mail.protection.outlook.com (10.13.177.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4020.17 via Frontend Transport; Sun, 11 Apr 2021 16:27:01 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sun, 11 Apr
 2021 09:27:00 -0700
Received: from r-nvmx02.mtr.labs.mlnx (172.20.145.6) by mail.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 11 Apr 2021 09:26:58 -0700
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
To:     <linux-block@vger.kernel.org>, <martin.petersen@oracle.com>,
        <axboe@kernel.dk>
CC:     <oren@nvidia.com>, <idanb@nvidia.com>, <yossike@nvidia.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH 1/1] null_blk: add option for managing virtual boundary
Date:   Sun, 11 Apr 2021 16:26:58 +0000
Message-ID: <20210411162658.251456-1-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 331c26d0-070d-44b9-971f-08d8fd06a302
X-MS-TrafficTypeDiagnostic: DM6PR12MB4861:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4861AC68B707EDCA0725E822DE719@DM6PR12MB4861.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Tjz+aoyJYHCxGcrXLhUIjYW8GS821LaSh0m4QoeZqjDqPImaKz2A38rmviT3HY5QQoIzkbIf6n151BANjIDkvrcVKd+pwRx+7sG1RBdL2fep0xnOOCZNKSsV8b5iwWKOlSB5wtzDegw0RkdWiIBwvtSRJO4h+pEAAEBzpuWpLybbvC2TgPA1gdoMmLIu4e+VYn6XclDPqwh+my+RGaLfNnVSjKZwm5tuyno0rVpvor542fi2lwaK/mf1gLMIrWVWhOhslm5OjS3XGE9X+dpDwdL0lTwaviOoS/ciPgkq0JoWTH0dnlEhdqFNfT4I8ZtTkq5CjpDGsb9JUk//OOJrVPEoFofcNd0xhW4zmEw4INmCf9GW4FLs3M4pndSCbOMhiHWEAtR1qn7jfcc9dgIqHlYsmCp4cGD1gyf+FNqjgtlBYpHEXNYvu8XDa0I1JOAf6jd8auoEJaXw7nbWjkNPGDm9J7tozkmAA30Lm9AB+4QmicdPa5WAMaro1j1LWmrse+EErocrqov5Mu3Z0UEnT/NJRzBoZDQdMxzWD36OxnL6HKwi+q0YnGAzzUJuTVl5RIwVaYDWKCwJ2uTfRQNUPilmEfwDNOKzNRVBY/Z0WjTLo1RldrCrVHZvLSf3P6dXH8LvPGlnKELO2ggdBqY/tdJzbNsjKoAWPAmTkkWTHM8=
X-Forefront-Antispam-Report: CIP:216.228.112.32;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid01.nvidia.com;CAT:NONE;SFS:(4636009)(39860400002)(376002)(396003)(346002)(136003)(36840700001)(46966006)(1076003)(82310400003)(8936002)(8676002)(2616005)(36860700001)(5660300002)(47076005)(336012)(426003)(70206006)(4326008)(478600001)(2906002)(316002)(110136005)(186003)(356005)(83380400001)(26005)(107886003)(70586007)(86362001)(36756003)(54906003)(7636003)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2021 16:27:01.6753
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 331c26d0-070d-44b9-971f-08d8fd06a302
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.32];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4861
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This will enable changing the virtual boundary of null blk devices. For
now, null blk devices didn't have any restriction on the scatter/gather
elements received from the block layer. Add a module parameter that will
control the virtual boundary. This will enable testing the efficiency of
the block layer bounce buffer in case a suitable application will send
discontiguous IO to the given device.

Initial testing with patched FIO showed the following results (64 jobs,
128 iodepth):
IO size      READ (virt=false)   READ (virt=true)   Write (virt=false)  Write (virt=true)
----------  ------------------- -----------------  ------------------- -------------------
 1k            10.7M                8482k               10.8M              8471k
 2k            10.4M                8266k               10.4M              8271k
 4k            10.4M                8274k               10.3M              8226k
 8k            10.2M                8131k               9800k              7933k
 16k           9567k                7764k               8081k              6828k
 32k           8865k                7309k               5570k              5153k
 64k           7695k                6586k               2682k              2617k
 128k          5346k                5489k               1320k              1296k

Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 drivers/block/null_blk/main.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index d6c821d48090..9ca80e38f7e5 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -84,6 +84,10 @@ enum {
 	NULL_Q_MQ		= 2,
 };
 
+static bool g_virt_boundary = false;
+module_param_named(virt_boundary, g_virt_boundary, bool, 0444);
+MODULE_PARM_DESC(virt_boundary, "Require a virtual boundary for the device. Default: False");
+
 static int g_no_sched;
 module_param_named(no_sched, g_no_sched, int, 0444);
 MODULE_PARM_DESC(no_sched, "No io scheduler");
@@ -1880,6 +1884,9 @@ static int null_add_dev(struct nullb_device *dev)
 				 BLK_DEF_MAX_SECTORS);
 	blk_queue_max_hw_sectors(nullb->q, dev->max_sectors);
 
+	if (g_virt_boundary)
+		blk_queue_virt_boundary(nullb->q, PAGE_SIZE - 1);
+
 	null_config_discard(nullb);
 
 	sprintf(nullb->disk_name, "nullb%d", nullb->index);
-- 
2.18.1

