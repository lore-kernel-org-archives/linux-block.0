Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EBE9C43461
	for <linux-block@archiver.kernel.org>; Mon, 12 Apr 2021 09:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5EE56121E
	for <linux-block@archiver.kernel.org>; Mon, 12 Apr 2021 09:57:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242779AbhDLJ5i (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 12 Apr 2021 05:57:38 -0400
Received: from mail-dm6nam11on2040.outbound.protection.outlook.com ([40.107.223.40]:7169
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S244585AbhDLJzr (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Apr 2021 05:55:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WX1MzRr74/GhwIbB4ufeDHTSPWqQ+C3nUMYiShXZ0Il08TLnWF8l5/XoJIGFuQWhkKOD8ltAxJ6pRNXCUPZuaRpcAEg/mFG8sa1Gdjzvnv4hRkKbYv1k0iZ/gqb7eW9B9rSrld17Ex5YjxgtcZ2yZzy/8Hqtzpe1SweeZ7FRUO//h3O8Xn/4rExR1kmLg+pWojXkAPDc7zOqYkb9sUZPexom8jSLsZ6Yu2mM0gz4eww2WmVTRLOkFTGT3npmzuRn8zHu5HwlSd84XQZh/LCkHgJtSMSKjz8IJxorqaOiOVhMpzulTQagBQHyXK2iF7MIB1zwrWpEKYCWYmVh6V1hfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=17y96m88+Ydr8VJtmOczthTmyJCp7Bzo3reBto3Co+4=;
 b=MrAxV+TllG93q437Qd4/DUennXKyfyQ8Qj/3rZlezFPvoY1glCpjjYWdOZqzU4Qn1l5iWDh6FY0Qg4JBLgXh1gi+VKbwxNS2/JCXJQP24jIJVi6l9pjr8YkfZWd0ym+X5+sRrUWxhJgCPGsIS5lHA9bepk7VW2aebF7dvofB5kZMETmDOn9PqzrqFeOI7KH6AKzFfP0Z6ON3O4uRW2yzGJMvmMl54qa1WXr4TRRprs0cu78OjPFvZvzTPyWUcukJdKDQzS9pJhcJg0ZXvY3uHuju/Qf/6bdOkRnFMftizrckdg3UUN4gfup9FZuvOI80aj7EHMdWL4B/y0M6u7wxwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.35) smtp.rcpttodomain=wdc.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=17y96m88+Ydr8VJtmOczthTmyJCp7Bzo3reBto3Co+4=;
 b=rt9xIps1dNKXUsUEGNZDfXOqyyuUbz+1k8LLvnSPre/tWn5woO4u/yimxvr9/mywUSIb7mVFsBiI2Xj2BS2E5PCMUnYEg2KAdn+copkfZrVraVTFpLMAf5/918JFpcF6Z7SfVOJHWw5pSOqLJEeahoxAMKedbtxYZ6X+amr7U9pL19b/EXMdSpYXIMLSSYhbyyXHktchUdB/Xlo3KcZEeQXpbzbIPUcGtX6cqgycrTLeEvjDmujKFnOZ9whktuhZt5atdRFTklR9xQC6x8/qjFZGF9LsSAulJSLJCTFEFSQ2XVB0vi5zaqpNZ1QcN4Z1/48xpNSJIB+Kkl3dQSwU4Q==
Received: from BN9PR12CA0015.namprd12.prod.outlook.com (2603:10b6:408:10c::9)
 by BY5PR12MB4180.namprd12.prod.outlook.com (2603:10b6:a03:213::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.22; Mon, 12 Apr
 2021 09:55:28 +0000
Received: from BN8NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10c:cafe::42) by BN9PR12CA0015.outlook.office365.com
 (2603:10b6:408:10c::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16 via Frontend
 Transport; Mon, 12 Apr 2021 09:55:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.35)
 smtp.mailfrom=nvidia.com; wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.35 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.35; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.35) by
 BN8NAM11FT010.mail.protection.outlook.com (10.13.177.53) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4020.17 via Frontend Transport; Mon, 12 Apr 2021 09:55:28 +0000
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 12 Apr
 2021 09:55:27 +0000
Received: from r-nvmx02.mtr.labs.mlnx (172.20.145.6) by mail.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 12 Apr 2021 09:55:25 +0000
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
To:     <linux-block@vger.kernel.org>, <martin.petersen@oracle.com>,
        <axboe@kernel.dk>
CC:     <oren@nvidia.com>, <idanb@nvidia.com>, <yossike@nvidia.com>,
        <Damien.LeMoal@wdc.com>, <Chaitanya.Kulkarni@wdc.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH v2 1/1] null_blk: add option for managing virtual boundary
Date:   Mon, 12 Apr 2021 09:55:23 +0000
Message-ID: <20210412095523.278632-1-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7802af54-eb20-4d3f-1a04-08d8fd991a1c
X-MS-TrafficTypeDiagnostic: BY5PR12MB4180:
X-Microsoft-Antispam-PRVS: <BY5PR12MB4180273251EEAF9DC83C2F49DE709@BY5PR12MB4180.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yN4hd+/IMJXBg7225BhwktPT35DpufOpXG83jI9TlqyNvdvpDjwhlZ3A9gajmpaPh4BRqm7s0ZwZNhY60K85lhln9P4GRU/mW3unDnKO2U+/VRLgRl1ApF7btG/hA5DUqfJLmpu9tAe69d8k5+0+DTNvcJ4W7rMc0mphJiKCbU1WJggU8A7tadhbjuwP14JNcGQCbtVzO4itnnhNpeoPurbo8eMRB2N3Yr2s0n4nckGESTFphxYv/XVFjTZ4oeItvL+nFDu2eEt/uN4tT3M4FAJYlC1f9byyij6pFONvBWYnpvAQh7l0JbrU3zK5wCJe7DLuEydm9n24ka6+Jo4TVT/8XVJWVEX/RmD6eUNiY+0dvklJE3EC7EE8ZYcD36MOqi5NWsBlRNJDamNpCsW3e30vGLNQfP8u4h3lCcabB/+ALgM1P2QZZ+a9hRlaZczVud9i7RvWIcvGobyacZYYxWieS/LQiLphpM8ZHy94wFcO3rrYAxocS+hLBkoU43miNa/Ir3dteljaBd8pWLjTFJ6JwqUed18ybph92chqCtk96ET8LRHXZH06rPnsLJ376uXIBeJYJHo43uTIFF2ureIrdzrG+afa0K+e1pXQpuA21UalTQPepaUQ6GRRl0/mrjnHBWBMLdy1ahdhnx3MJfXOUO+nxzKd7PpXmD6mfSM=
X-Forefront-Antispam-Report: CIP:216.228.112.35;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid02.nvidia.com;CAT:NONE;SFS:(4636009)(39860400002)(376002)(346002)(136003)(396003)(46966006)(36840700001)(83380400001)(47076005)(86362001)(356005)(478600001)(316002)(186003)(36906005)(110136005)(8936002)(7636003)(336012)(70586007)(5660300002)(70206006)(26005)(82740400003)(2906002)(107886003)(36860700001)(426003)(82310400003)(1076003)(8676002)(54906003)(2616005)(4326008)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2021 09:55:28.0979
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7802af54-eb20-4d3f-1a04-08d8fd991a1c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.35];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4180
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This will enable changing the virtual boundary of null blk devices. For
now, null blk devices didn't have any restriction on the scatter/gather
elements received from the block layer. Add a module parameter and a
configfs option that will control the virtual boundary. This will
enable testing the efficiency of the block layer bounce buffer in case
a suitable application will send discontiguous IO to the given device.

Initial testing with patched FIO showed the following results (64 jobs,
128 iodepth, 1 nullb device):
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

changes from v1:
 - added configfs option (Chaitanya and Damien)
 - added virt_boundary to feature list

---
 drivers/block/null_blk/main.c     | 12 +++++++++++-
 drivers/block/null_blk/null_blk.h |  1 +
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index d6c821d48090..c35872cc5f37 100644
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
@@ -366,6 +370,7 @@ NULLB_DEVICE_ATTR(zone_capacity, ulong, NULL);
 NULLB_DEVICE_ATTR(zone_nr_conv, uint, NULL);
 NULLB_DEVICE_ATTR(zone_max_open, uint, NULL);
 NULLB_DEVICE_ATTR(zone_max_active, uint, NULL);
+NULLB_DEVICE_ATTR(virt_boundary, bool, NULL);
 
 static ssize_t nullb_device_power_show(struct config_item *item, char *page)
 {
@@ -486,6 +491,7 @@ static struct configfs_attribute *nullb_device_attrs[] = {
 	&nullb_device_attr_zone_nr_conv,
 	&nullb_device_attr_zone_max_open,
 	&nullb_device_attr_zone_max_active,
+	&nullb_device_attr_virt_boundary,
 	NULL,
 };
 
@@ -539,7 +545,7 @@ nullb_group_drop_item(struct config_group *group, struct config_item *item)
 static ssize_t memb_group_features_show(struct config_item *item, char *page)
 {
 	return snprintf(page, PAGE_SIZE,
-			"memory_backed,discard,bandwidth,cache,badblocks,zoned,zone_size,zone_capacity,zone_nr_conv,zone_max_open,zone_max_active,blocksize,max_sectors\n");
+			"memory_backed,discard,bandwidth,cache,badblocks,zoned,zone_size,zone_capacity,zone_nr_conv,zone_max_open,zone_max_active,blocksize,max_sectors,virt_boundary\n");
 }
 
 CONFIGFS_ATTR_RO(memb_group_, features);
@@ -605,6 +611,7 @@ static struct nullb_device *null_alloc_dev(void)
 	dev->zone_nr_conv = g_zone_nr_conv;
 	dev->zone_max_open = g_zone_max_open;
 	dev->zone_max_active = g_zone_max_active;
+	dev->virt_boundary = g_virt_boundary;
 	return dev;
 }
 
@@ -1880,6 +1887,9 @@ static int null_add_dev(struct nullb_device *dev)
 				 BLK_DEF_MAX_SECTORS);
 	blk_queue_max_hw_sectors(nullb->q, dev->max_sectors);
 
+	if (dev->virt_boundary)
+		blk_queue_virt_boundary(nullb->q, PAGE_SIZE - 1);
+
 	null_config_discard(nullb);
 
 	sprintf(nullb->disk_name, "nullb%d", nullb->index);
diff --git a/drivers/block/null_blk/null_blk.h b/drivers/block/null_blk/null_blk.h
index 83504f3cc9d6..5ad5087ebe39 100644
--- a/drivers/block/null_blk/null_blk.h
+++ b/drivers/block/null_blk/null_blk.h
@@ -96,6 +96,7 @@ struct nullb_device {
 	bool memory_backed; /* if data is stored in memory */
 	bool discard; /* if support discard */
 	bool zoned; /* if device is zoned */
+	bool virt_boundary; /* virtual boundary on/off for the device */
 };
 
 struct nullb {
-- 
2.18.1

