Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FFCDC433FE
	for <linux-block@archiver.kernel.org>; Tue, 15 Nov 2022 01:11:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbiKOBLU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Nov 2022 20:11:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbiKOBLS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Nov 2022 20:11:18 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2079.outbound.protection.outlook.com [40.107.93.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 041C4FAC4
        for <linux-block@vger.kernel.org>; Mon, 14 Nov 2022 17:11:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PqABxaFdMP6J8b6QRksbThxnHFn1/HiAlaBM7OIdxxdCFJfcyBDLVkn2MDvkzRzG3F4VtyClqXGI5gO5weH5FXeLx8CLqEhQBETFCIcujDaQY4TkU5Q1XCj9DDzHqfAlyjhXkdoP7awdcttiOLZNwroyimr/EOiilO7pejyoFItkOm/wc5oScu5JVNwMkqqFA0B85ev730rBGrpCCPshCM/4yPgk56aDzz+7vs9oSQWRNkZC8osbEK+ee8wjpxwjm1oxjVuGQYVNf1YDLOiLtu7b6PLj15lm487LUCfGRRc0vVOnYL6afPN/n2IBJ1zJVsiJwxl+BhvVU0V9/5xxLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m+CSqsifvCucr4CHu2DQkis1lMITIPEXwxbryq/EpWA=;
 b=RfjQHe6pUv437dAeJpXmnGK0J1xljTSivCDX2K6ukLq8jUztgioQgwSfXQeZuvI4iLZW+i8f8QCmE8OYnxthSYheijqgR5acIbThxWSOFNsP7QfrNlQj+uOdyXqPg5UlCRG33yscRQEAWtsUINTH2XTbP6MAd392dyU+FLsLN5gA+ns0lae4MCFfnytZsm0VrQM4sH4Ki1gdPhVkp2pK5SVcG3oZFVjSFHULjeDPgb48rsXbZ7VQlMBEhKH/riJ8tCJHpjXYRyK6uqYc5iJ+KNGQ0sYNGjdvVrr/DtSMZ2Lvuns9TVArEC2GUJNiVr5ggKogML41w7m3dyDAl7b2/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m+CSqsifvCucr4CHu2DQkis1lMITIPEXwxbryq/EpWA=;
 b=cdfRCUW5Pa7ceWWVo1OSTUcS8W/kAk02JsUgIB60SbBbSWvIcv6q9/lLtMM1Nv2BQNVqYVw7z5+z8io52jrnCAnVftZXqMAZ9bowapi61gnKyVBwjnM14Rl+ygEvZGffUlAVv7K74BRaFdPEh9jb+uuhre6z4DyOo3cInafj2nYsu7TaUu8jd0EwmfKaWl2n6qDXhEUFHobkUkXdEKtUmXA3UatguuD/jsIwIXQbNV0EsmwIv98z8hFMSDvlNmVN0yATM5m7QTOBaEhDkcT/HS7yNcCWWzsTMjFA2QHH7rQ7O06jD6KHjWYCtzFFkNcsWsdmIT7ygurE9l4AvqWjAA==
Received: from BN9PR03CA0712.namprd03.prod.outlook.com (2603:10b6:408:ef::27)
 by MN2PR12MB4565.namprd12.prod.outlook.com (2603:10b6:208:26b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Tue, 15 Nov
 2022 01:11:15 +0000
Received: from BN8NAM11FT099.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ef:cafe::dc) by BN9PR03CA0712.outlook.office365.com
 (2603:10b6:408:ef::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17 via Frontend
 Transport; Tue, 15 Nov 2022 01:11:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT099.mail.protection.outlook.com (10.13.177.197) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.12 via Frontend Transport; Tue, 15 Nov 2022 01:11:15 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 14 Nov
 2022 17:10:47 -0800
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 14 Nov
 2022 17:10:47 -0800
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-block@vger.kernel.org>
CC:     <axboe@kernel.dk>, <vincent.fu@samsung.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
Subject: [PATCH V2] null-blk: allow REQ_OP_ZONE_RESET_ALL to configure
Date:   Mon, 14 Nov 2022 17:10:39 -0800
Message-ID: <20221115011039.5365-1-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT099:EE_|MN2PR12MB4565:EE_
X-MS-Office365-Filtering-Correlation-Id: 23a543f8-68cf-4546-8a78-08dac6a64b2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KJHRqoN3dTx67joAl2fcCnU0MHoPcv2Xnbp11UZyLJ/4NYusMeiD2zUcpZZm6+JIVppnx2fixrfZIqQ8NtcTlyez3ET8vT/2ZOWjVX3pnpC5ycAHJXlz+Hu/LyQbwOTrOrY4o5XtGqbcjWdGzTo9DDHEQ60qsFaGfdsMKkEXzU2czcWOJEBtFK49eCJp1sDFXmSsToMIu9v3Gx74KEzmRndoHSp9H7IbsMmOpMjuXRrzRgVix1duAeJUTevQQGUpDSIVnbY2otpFPjvrwGL0SKhV+EOAeTjrOP6vUIcxbSPYgguA4GhWhdYMjOnJOXZsjY2pqeMjlZ535Tgym5tMg8kay4YDV0wUS5kaym+Qah6htGrBwJ51xgJBxcKP4m6dBPI6pvc+HrqbQ/wbLZxo4eWikCbVqkp/goLSdzrc84RyLjYsNyN05njvbu+FZTxZgkC5thy8YhBnpqeFqM9DZrjanq7HaOlh+X0DdY6wAoiZhUEU+lyOu7YHFr83KkFhXyj1BklygJPpsb768X+PIZ79m/O/HEyGLvsCepMLcmMkg/QVesnzS3bboWjrhw+mFnilOOsve8WF6mMwARWW/VlfDw2gKlk7HF+Ms/gTAde7ejSRJkVZ0IzXy0eg5H9nBMkNPIWnKVabmJxAZHjIjXw+vErV4wt7OqoJ8T/K8rB4jX/WZwQGsTHT/hgdwl78/t6CL79Q9NwasQlEnEaPpIxXWPgx71k1DSlp3GeMdZN/340yTRFlrKVjqT9zP57tUSDcPnNWXvcslE0zbeVR3Q==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(396003)(346002)(136003)(451199015)(40470700004)(36840700001)(46966006)(2906002)(82310400005)(8676002)(36756003)(70206006)(70586007)(54906003)(6916009)(316002)(40460700003)(356005)(83380400001)(7636003)(478600001)(40480700001)(4326008)(5660300002)(8936002)(36860700001)(7696005)(47076005)(336012)(41300700001)(1076003)(186003)(16526019)(2616005)(426003)(26005)(82740400003)(6666004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2022 01:11:15.2265
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23a543f8-68cf-4546-8a78-08dac6a64b2a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT099.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4565
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

For a Zoned Block Device zone reset all is emulated if underlaying
device doesn't support REQ_OP_ZONE_RESET_ALL operation. In null_blk
Zoned mode there is no way to test zone reset all emulation present in
the block layer since we enable it by default :-

blkdev_zone_mgmt()
 blkdev_zone_reset_all_emulation() <---
 blkdev_zone_reset_all()

Add a module parameter zone_reset_all to enable or disable
REQ_OP_ZONE_RESET_ALL, enable it by default to retain the existing
behaviour.

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
v1-v2:-

Add configfs parameter to set the zone reset all.

---
 drivers/block/null_blk/main.c     | 7 +++++++
 drivers/block/null_blk/null_blk.h | 1 +
 drivers/block/null_blk/zoned.c    | 3 ++-
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 8b7f42024f14..995449919d5e 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -260,6 +260,10 @@ static unsigned int g_zone_max_active;
 module_param_named(zone_max_active, g_zone_max_active, uint, 0444);
 MODULE_PARM_DESC(zone_max_active, "Maximum number of active zones when block device is zoned. Default: 0 (no limit)");
 
+static bool g_zone_reset_all = true;
+module_param_named(zone_reset_all, g_zone_reset_all, bool, 0444);
+MODULE_PARM_DESC(zone_reset_all, "Allow REQ_OP_ZONE_RESET_ALL. Default: true");
+
 static struct nullb_device *null_alloc_dev(void);
 static void null_free_dev(struct nullb_device *dev);
 static void null_del_dev(struct nullb *nullb);
@@ -446,6 +450,7 @@ NULLB_DEVICE_ATTR(zone_capacity, ulong, NULL);
 NULLB_DEVICE_ATTR(zone_nr_conv, uint, NULL);
 NULLB_DEVICE_ATTR(zone_max_open, uint, NULL);
 NULLB_DEVICE_ATTR(zone_max_active, uint, NULL);
+NULLB_DEVICE_ATTR(zone_reset_all, bool, NULL);
 NULLB_DEVICE_ATTR(virt_boundary, bool, NULL);
 NULLB_DEVICE_ATTR(no_sched, bool, NULL);
 NULLB_DEVICE_ATTR(shared_tag_bitmap, bool, NULL);
@@ -574,6 +579,7 @@ static struct configfs_attribute *nullb_device_attrs[] = {
 	&nullb_device_attr_zone_nr_conv,
 	&nullb_device_attr_zone_max_open,
 	&nullb_device_attr_zone_max_active,
+	&nullb_device_attr_zone_reset_all,
 	&nullb_device_attr_virt_boundary,
 	&nullb_device_attr_no_sched,
 	&nullb_device_attr_shared_tag_bitmap,
@@ -715,6 +721,7 @@ static struct nullb_device *null_alloc_dev(void)
 	dev->zone_nr_conv = g_zone_nr_conv;
 	dev->zone_max_open = g_zone_max_open;
 	dev->zone_max_active = g_zone_max_active;
+	dev->zone_reset_all = g_zone_reset_all;
 	dev->virt_boundary = g_virt_boundary;
 	dev->no_sched = g_no_sched;
 	dev->shared_tag_bitmap = g_shared_tag_bitmap;
diff --git a/drivers/block/null_blk/null_blk.h b/drivers/block/null_blk/null_blk.h
index e692c2a7369e..e7efe8de4ebf 100644
--- a/drivers/block/null_blk/null_blk.h
+++ b/drivers/block/null_blk/null_blk.h
@@ -115,6 +115,7 @@ struct nullb_device {
 	bool discard; /* if support discard */
 	bool write_zeroes; /* if support write_zeroes */
 	bool zoned; /* if device is zoned */
+	bool zone_reset_all; /* if support REQ_OP_ZONE_RESET_ALL */
 	bool virt_boundary; /* virtual boundary on/off for the device */
 	bool no_sched; /* no IO scheduler for the device */
 	bool shared_tag_bitmap; /* use hostwide shared tags */
diff --git a/drivers/block/null_blk/zoned.c b/drivers/block/null_blk/zoned.c
index 55a69e48ef8b..7310d1c3f9ec 100644
--- a/drivers/block/null_blk/zoned.c
+++ b/drivers/block/null_blk/zoned.c
@@ -160,7 +160,8 @@ int null_register_zoned_dev(struct nullb *nullb)
 	struct request_queue *q = nullb->q;
 
 	disk_set_zoned(nullb->disk, BLK_ZONED_HM);
-	blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, q);
+	if (dev->zone_reset_all)
+		blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, q);
 	blk_queue_required_elevator_features(q, ELEVATOR_F_ZBD_SEQ_WRITE);
 
 	if (queue_is_mq(q)) {
-- 
2.29.0

