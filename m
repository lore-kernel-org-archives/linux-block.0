Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 604D2C4332F
	for <linux-block@archiver.kernel.org>; Tue, 15 Nov 2022 03:49:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235613AbiKODtA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Nov 2022 22:49:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232129AbiKODs7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Nov 2022 22:48:59 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F16838AC
        for <linux-block@vger.kernel.org>; Mon, 14 Nov 2022 19:48:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nY/jZtYVLVxDPa1QCzX8xgV46DMRKkaGlrMkYQYD3gfou7lOVidBuFWNBlgYabbtOGSrofM1QkyDa1apwoW1arLKxWl4bsmmrQ9e+Eh7veevAN4uk9DnFigET5k9X6eMMaJEUuHL4isQdFzDlp46ErD6wnslDtsHtnvJvvWSsHMzegN0Iorz/18Fl7qzOG1SQRUtaqkb0pFZBmF84tQ/cNSSa+D5CVnCVer9T9htwBwdwYhxjSHLuqe8lSOuNxHfVLT0vy7LhPnFQ2PM/9l6CI4c5KPnKOlQYqwc8KdyoE2/Ml9NJN5YGgWOmme1S45k7qJCaVT5xfdjT6+8ofjmXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4BWOIgHkSL7mPUwk6cyqC54bOj3z+S/B8bI4nF3ByqQ=;
 b=mx7KcwVZE/+cAbuTFH08u53t4jzm7owNI70xBf1iGgax5S+aorOev1hoFc/C51ZJqLi7v00+Yp/V4Og5NL1L+A5OIETL5lVaVfxF1gO25mdjFcFI4+sySQ+2eRNa5ucLM9cUW1qXN3v64iTAU41g+3dtuDMstsV44YO8RaZJpZkxDlqMpxIwKXpETVOkJ5v+E5HPaJuGeZBbVE03zKArFJyoQXgmTaQl2vIfHv2uWQk0zzXUnri0OfH9RSZMf5oh3dEzy8NeJLOljHdibePoWhTzFCCPoq8dyATssrB/4pr98Rp15GcYhlXzFx22Tb5sRu3UnXfWaglThUwryTz2RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4BWOIgHkSL7mPUwk6cyqC54bOj3z+S/B8bI4nF3ByqQ=;
 b=JHqaSyqbfJDkZv+EeYtjd7icna9xJBsd+6WTsxk7vulZk7OLlEpF5fhOyo08R4W6DKJCDAaqJu5TiVWgYhY6tdA6eQLMM1orSvxrIr/IixGAv/N8wI5XYQ0CaXK7M1/+Jvr0jAT3H6d8uB4mBrxz9OLcb9mdRap3EKI1hNsSkJWNN4dC2pCZOS+J+q2IZAhsvWf8QDuUJAg9poDNVCpanxdK66lq4W7jPOwS+SUK8IIeq9rtTC0ahzXWcVikkMsM5FRUf8dlbSK/IIJp+AlO/zxclXU1EKHECoCBIEn6EaEubqX47tPGXLrmdTvFODlY/Sd4hgIxKUG5h4vq/2uCOw==
Received: from DS7PR05CA0064.namprd05.prod.outlook.com (2603:10b6:8:57::26) by
 BY5PR12MB4099.namprd12.prod.outlook.com (2603:10b6:a03:20f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Tue, 15 Nov
 2022 03:48:56 +0000
Received: from DM6NAM11FT084.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:57:cafe::58) by DS7PR05CA0064.outlook.office365.com
 (2603:10b6:8:57::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.8 via Frontend
 Transport; Tue, 15 Nov 2022 03:48:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT084.mail.protection.outlook.com (10.13.172.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5813.12 via Frontend Transport; Tue, 15 Nov 2022 03:48:55 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 14 Nov
 2022 19:48:46 -0800
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 14 Nov
 2022 19:48:46 -0800
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-block@vger.kernel.org>
CC:     <axboe@kernel.dk>, <vincent.fu@samsung.com>,
        <damien.lemoal@opensource.wdc.com>,
        Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH V3] null-blk: allow REQ_OP_ZONE_RESET_ALL to configure
Date:   Mon, 14 Nov 2022 19:48:34 -0800
Message-ID: <20221115034834.44142-1-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT084:EE_|BY5PR12MB4099:EE_
X-MS-Office365-Filtering-Correlation-Id: 75db5e1b-b7ba-4691-74b5-08dac6bc5211
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I+k0EnxGHG1GKxY626LPkbHOgZ10RTXELN14hZQRbJabn5IroasjqfODKMCabPfDPO0G2dG3fOC0N9J38K4RUrW7IzguSQxYO4yiTADN23jW1wN+yL5Xs6s3AQTtBm75T00+T4alyRpXD/JnF3gOlPk8JpuT4RZCXngcKVqS9ZXGLpUMAId/XhveNI3XocMBcyvkdSi2aDGw5AuqqVcbBOQsheRWiGt38fXUDbAM6eWmF4zeSH84AV1XNjf73kqh6hGoSI+F2oEezcsjz95XneHt0mbZKGChdmBb1p92o91NSAQIy3bNS3DVJnnbp0otaEpuy3Ejt/gMGziYIvPxsPO6qG09OnuZwkeQuTfRSJQmC4b61KTIDQDXDNkS8l+pagvsh36L0SN8fkbqlrgUQa6HG1S6pLWXo5ceLAv9MyYMo8Bt3v0s07KpdoEB2jt+gTdZ1qPUkMBpnLs0L2IepTf0IMBcy6Yta2yLgjunSg3PI+1MBXv3AKprxoT9ZLbhabrnMHMqgU6o4skEgZaZnSRZh1JK4gQbgkdDNxUW9PZ5eis/MbPZivljL7YgbhSEe02vHLOgvbKvVPSakasXeF/fhkfWjRlcvFn0VtWfDRDp3csYpR9dqw11VrFzyMslbh2wAj5Q6WM/YgFLLgpBe/KsPh1VolFXtNo3u3S0ERGzxg/tABCGbXwe7m9e3j4rrZa6xBMw6jXNSYrXJW4u7+2JGbBJ+Za3K46pDoA8rYs3SZlRynaPlcjYPJpOlpc6Y08i9DNbj7EZRyZ1WgqYuQ==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(136003)(39860400002)(396003)(451199015)(46966006)(36840700001)(40470700004)(426003)(6916009)(54906003)(316002)(36860700001)(7696005)(40460700003)(2906002)(83380400001)(41300700001)(186003)(8936002)(16526019)(5660300002)(36756003)(47076005)(1076003)(40480700001)(70206006)(8676002)(336012)(4326008)(26005)(70586007)(478600001)(82310400005)(107886003)(82740400003)(6666004)(2616005)(356005)(7636003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2022 03:48:55.7967
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75db5e1b-b7ba-4691-74b5-08dac6bc5211
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT084.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4099
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

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
v2->v3:-

Update the string in memb_group_features_show() with zone_reset_all.

v1->v2:-

Add configfs parameter to set the zone reset all.

 drivers/block/null_blk/main.c     | 9 ++++++++-
 drivers/block/null_blk/null_blk.h | 1 +
 drivers/block/null_blk/zoned.c    | 3 ++-
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 8b7f42024f14..5dc69f42b46c 100644
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
@@ -639,7 +645,7 @@ static ssize_t memb_group_features_show(struct config_item *item, char *page)
 			"poll_queues,power,queue_mode,shared_tag_bitmap,size,"
 			"submit_queues,use_per_node_hctx,virt_boundary,zoned,"
 			"zone_capacity,zone_max_active,zone_max_open,"
-			"zone_nr_conv,zone_size,write_zeroes\n");
+			"zone_nr_conv,zone_size,zone_reset_all,write_zeroes\n");
 }
 
 CONFIGFS_ATTR_RO(memb_group_, features);
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

