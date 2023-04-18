Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC4CEC77B75
	for <linux-block@archiver.kernel.org>; Tue, 18 Apr 2023 04:25:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbjDREZA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Apr 2023 00:25:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjDREY7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Apr 2023 00:24:59 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2051.outbound.protection.outlook.com [40.107.93.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 664B9C9
        for <linux-block@vger.kernel.org>; Mon, 17 Apr 2023 21:24:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mRyQnjk4Kntre4MuweZLe3IBygI1GfpgGhax3W8IKTehNTHYxrd3EW6qxBBHuzOP2ICu1N7H/x1CI5fBJykx2ymgGPYdRrUUr0kqIbPcl1eSxhGmZhGR1aYt9PkiEOPAHwxVPtezNfhJYyjueZaVDTGIgTyCoTVzppaDK37Bl8ZCxJAXeA+bvd7Fz974soc/eQCTkxijKIV3JBPE5Htg9wm/9vvF/rUcMuMynMe9jXETdY5QXvn1acJl2pM6UT3sSeZlxey9dhYrEAwYGmcvoMHlNzo1KBfQ+Zjhxh8WIa6YjydWZ4Kij+ar/0yxbauXYHWRtQPGi70AEGTUPcukRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kG/uHlfBa3B55v0Fum/OIpsLE7OShSyeNqf73PqkOV8=;
 b=kxGOqBuj8aFxO8AenGKnF2NllBxvNG32ehF2LVJJBhLYSbmzaFQTWXxoIi0s/p7i/XYvxMWy1MyeXdrcwpd1ZWrOzqdhs/K5gdl4myAZLQupL07yOHzb+7tal3niv5B38H8AHG2eg15htsG4H8dPy/8jUQpJmS7G8zHKx/CoNlKA6UcIVTcAU0kU+IXAx2thRv76q76c0H9/AbY2Y+XEBfR7tFLDieOkgR3P90bFlrCp2u8bBvb+UtTsDVv8O8CrzlXnpI3xjLnpR4Nc6Cr/62HxXQT39Hvn0oQhGXmwq8bd4+zkVn/1zzU5FsLdQ5zQ7jeX8PAwsWuIh4+cY1WrSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kG/uHlfBa3B55v0Fum/OIpsLE7OShSyeNqf73PqkOV8=;
 b=rj1TIH5jaqiMSX+5zIXGMk61GwBMopEtzoj3QtwabmpycViZbV0NLZavsHWaKIg2CptqtwhDtBCugqjVj3bqwD9T/xVjr+fTHT+LkyPAFDReXqE1fLCK1XALL0ol7qCcyRdv4p/kENXV/Ps1EUvbjdKert3MxOOrdJ/FYYhOjXG4Nspvr3nogNdafT+CHayEXu+peExDYPlWOpp5FRCq5tRLbPywgREVZno6UluBNtnWH9wdheG/Zn0pYi6phoPDPrjnZ/PadBzw2OernT5L9VdyneK6gYDvKyYM2rUful1gzxEn4XJhWKWnZH6qg/pvvB0uxA3A7VFud4m6cJth/w==
Received: from DM6PR02CA0164.namprd02.prod.outlook.com (2603:10b6:5:332::31)
 by DS0PR12MB8504.namprd12.prod.outlook.com (2603:10b6:8:155::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Tue, 18 Apr
 2023 04:24:54 +0000
Received: from DM6NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:332:cafe::da) by DM6PR02CA0164.outlook.office365.com
 (2603:10b6:5:332::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.47 via Frontend
 Transport; Tue, 18 Apr 2023 04:24:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT025.mail.protection.outlook.com (10.13.172.197) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6319.20 via Frontend Transport; Tue, 18 Apr 2023 04:24:54 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 17 Apr 2023
 21:24:43 -0700
Received: from dev.nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 17 Apr
 2023 21:24:42 -0700
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-block@vger.kernel.org>
CC:     <axboe@kernel.dk>, <dlemoal@kernel.org>, <kch@nvidia.com>,
        <johannes.thumshirn@wdc.com>, <bvanassche@acm.org>,
        <vincent.fu@samsung.com>, <shinichiro.kawasaki@wdc.com>,
        <yukuai3@huawei.com>
Subject: [PATCH V2 1/1] null_blk: allow user to set QUEUE_FLAG_NOWAIT
Date:   Mon, 17 Apr 2023 21:24:20 -0700
Message-ID: <20230418042420.93629-2-kch@nvidia.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230418042420.93629-1-kch@nvidia.com>
References: <20230418042420.93629-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT025:EE_|DS0PR12MB8504:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ded8ab7-3191-4604-db5a-08db3fc4dc51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3VKMVjyG5+RN6f55Yp42V7wFhQBRPTG+4YnO7EC/4j6BF34TgFc8R6YTujO3AO6HG36Sx+VV4CXvmgaoPBJ2rIomGhfFuUBk8liM9OV3ev/l6BzmJ6h+M0HF0kTBTfAZQW8Q4u1muaUl8Xl2yao9YZWyI6+qWEDsHobov7tX9acx1o1PXKzLQRGZupAffM0SaqMiTnbqMhYD4qYj9q9FEIcToVka84+eZqTxXfAY8BKxaYhvqnwdYxKVxNMBCp40n1qFBQ8TYQjZyr9JkFiJ8kY/dhmgB3wchsCqeIQB/tsAUjwz+eTINXqRUMjE5abyw3Slu+QE3wLLG+SEk4Ai/UpPFKu3s8tWlDfPl3UcdHiMAqLvK7ClzXSxbfnSQtrrTwocOsxV42aUKA/ygGsO6nyiRgDsNdS8sH6w2QbpeRsu/j46Jl14FQsxItksAxBuNWQu+sOJX5qO0NT/a/YxK//AjCMObz0Cdd7DXkuzLyEUVaS7Uey8gisOu2vm96rPnmKLrcl5vwh3vv2IyT8ZPtEiBECmsHYJwFvicYMUOQPIB7nd07LZbYy5hYmlrCxYTZiOtHnatQ97AH3Hw/0w0wFsivZh6lAwOLuCnT7NT4JhgEwpXdbwwoYqDO5yUT2nsNlS+kCugXgWeG9X8/JE2ynAwbznnMy37H6ZGibjRiRb7sxaEljlzCYXDGKeFsj3zDPUjOiY1W3XLsbkUex40r2B8Id1mJvYGiavr4xUdzZRGVSy2CdglXMtZSZcoLeCYSsSWqUOAVA7py/bLoUv7olOcz3D+gbI1XAq6vL8oHU=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(136003)(376002)(346002)(451199021)(46966006)(36840700001)(40470700004)(478600001)(6666004)(34020700004)(8936002)(8676002)(316002)(41300700001)(82740400003)(6916009)(4326008)(70586007)(70206006)(40480700001)(54906003)(7636003)(356005)(40460700003)(16526019)(186003)(2906002)(1076003)(336012)(426003)(26005)(83380400001)(36756003)(47076005)(82310400005)(2616005)(36860700001)(5660300002)(7696005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2023 04:24:54.4142
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ded8ab7-3191-4604-db5a-08db3fc4dc51
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8504
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

One of the default flags used to define QUEUE_FLAG_MQ_DEFAULT is
QUEUE_FLAG_NOWAIT. For null_blk QUEUE_FLAG_NOWAIT is set by default when
it is used with NULL_Q_MQ mode as a part of following call chain see
blk_mq_init_allocated_queue() :-

null_add_dev()
if (dev->queue_mode == NULL_Q_MQ) {
        blk_mq_alloc_disk()
          __blk_mq_alloc_disk()
	    blk_mq_init_queue_data()
              blk_mq_init_allocated_queue()
                q->queue_flags |= QUEUE_FLAG_MQ_DEFAULT;
}

But it is not set when null_blk is loaded with NULL_Q_BIO mode in following
code path like other bio drivers do e.g. nvme-multipath :-

if (dev->queue_mode == NULL_Q_BIO) {
        nullb->disk = blk_alloc_disk(nullb->dev->home_node);
        	blk_alloc_disk()
        	  blk_alloc_queue()
        	  __alloc_disk_nodw()
}

Add a new module parameter nowait and respective configfs attr that will
set or clear the QUEUE_FLAG_NOWAIT based on a value set by user in
null_add_dev() when queue_mode is set to NULL_Q_BIO, by default keep it
disabled to retain the original behaviour for the NULL_Q_BIO mode.

Only when queue_mode is NULL_Q_BIO, depending on nowait value use
GFP_NOWAIT or GFP_NOIO for the alloction in the null_alloc_page() for
alloc_pages() and in null_insert_page() for radix_tree_preload().

Observed performance difference with this patch for fio iouring with
configfs and non configfs null_blk when queue_mode=NULL_Q_BIO:-

* Configfs non-membacked mode:-

QUEUE_FLAG_NOWAIT disabled :-
---------------------------------------------
configfs-qmode-0-nowait-0-fio-1.log:  read: IOPS=1299k, BW=5076MiB/s
configfs-qmode-0-nowait-0-fio-2.log:  read: IOPS=1250k, BW=4884MiB/s
configfs-qmode-0-nowait-0-fio-3.log:  read: IOPS=1251k, BW=4888MiB/s


QUEUE_FLAG_NOWAIT enabled :-
---------------------------------------------
configfs-qmode-0-nowait-1-fio-1.log:  read: IOPS=5469k, BW=20.9GiB/s
configfs-qmode-0-nowait-1-fio-2.log:  read: IOPS=5525k, BW=21.1GiB/s
configfs-qmode-0-nowait-1-fio-3.log:  read: IOPS=5561k, BW=21.2GiB/s

* Non Configfs non-membacked mode:-

QUEUE_FLAG_NOWAIT disabled :-
---------------------------------------------
qmode-0-nowait-0-fio-1.log:  read: IOPS=1261k, BW=4924MiB/s
qmode-0-nowait-0-fio-2.log:  read: IOPS=1295k, BW=5060MiB/s
qmode-0-nowait-0-fio-3.log:  read: IOPS=1280k, BW=4999MiB/s

QUEUE_FLAG_NOWAIT enabled :-
---------------------------------------------
qmode-0-nowait-1-fio-1.log:  read: IOPS=5521k, BW=21.1GiB/s
qmode-0-nowait-1-fio-2.log:  read: IOPS=5524k, BW=21.1GiB/s
qmode-0-nowait-1-fio-3.log:  read: IOPS=5541k, BW=21.1GiB/s

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/block/null_blk/main.c     | 33 ++++++++++++++++++++++++++-----
 drivers/block/null_blk/null_blk.h |  1 +
 2 files changed, 29 insertions(+), 5 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index b195b8b9fe32..afffe48f5cb1 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -77,6 +77,10 @@ enum {
 	NULL_IRQ_TIMER		= 2,
 };
 
+static bool g_nowait = false;
+module_param_named(nowait, g_nowait, bool, 0444);
+MODULE_PARM_DESC(virt_boundary, "Set QUEUE_FLAG_NOWAIT for qmode=BIO. Default: False");
+
 static bool g_virt_boundary = false;
 module_param_named(virt_boundary, g_virt_boundary, bool, 0444);
 MODULE_PARM_DESC(virt_boundary, "Require a virtual boundary for the device. Default: False");
@@ -413,6 +417,7 @@ NULLB_DEVICE_ATTR(irqmode, uint, NULL);
 NULLB_DEVICE_ATTR(hw_queue_depth, uint, NULL);
 NULLB_DEVICE_ATTR(index, uint, NULL);
 NULLB_DEVICE_ATTR(blocking, bool, NULL);
+NULLB_DEVICE_ATTR(nowait, bool, NULL);
 NULLB_DEVICE_ATTR(use_per_node_hctx, bool, NULL);
 NULLB_DEVICE_ATTR(memory_backed, bool, NULL);
 NULLB_DEVICE_ATTR(discard, bool, NULL);
@@ -554,6 +559,7 @@ static struct configfs_attribute *nullb_device_attrs[] = {
 	&nullb_device_attr_hw_queue_depth,
 	&nullb_device_attr_index,
 	&nullb_device_attr_blocking,
+	&nullb_device_attr_nowait,
 	&nullb_device_attr_use_per_node_hctx,
 	&nullb_device_attr_power,
 	&nullb_device_attr_memory_backed,
@@ -650,7 +656,7 @@ nullb_group_drop_item(struct config_group *group, struct config_item *item)
 static ssize_t memb_group_features_show(struct config_item *item, char *page)
 {
 	return snprintf(page, PAGE_SIZE,
-			"badblocks,blocking,blocksize,cache_size,"
+			"badblocks,blocking,nowait,blocksize,cache_size,"
 			"completion_nsec,discard,home_node,hw_queue_depth,"
 			"irqmode,max_sectors,mbps,memory_backed,no_sched,"
 			"poll_queues,power,queue_mode,shared_tag_bitmap,size,"
@@ -725,6 +731,7 @@ static struct nullb_device *null_alloc_dev(void)
 	dev->irqmode = g_irqmode;
 	dev->hw_queue_depth = g_hw_queue_depth;
 	dev->blocking = g_blocking;
+	dev->nowait = g_nowait;
 	dev->memory_backed = g_memory_backed;
 	dev->discard = g_discard;
 	dev->cache_size = g_cache_size;
@@ -859,7 +866,7 @@ static void null_complete_rq(struct request *rq)
 	end_cmd(blk_mq_rq_to_pdu(rq));
 }
 
-static struct nullb_page *null_alloc_page(void)
+static struct nullb_page *null_alloc_page(gfp_t gfp)
 {
 	struct nullb_page *t_page;
 
@@ -867,7 +874,7 @@ static struct nullb_page *null_alloc_page(void)
 	if (!t_page)
 		return NULL;
 
-	t_page->page = alloc_pages(GFP_NOIO, 0);
+	t_page->page = alloc_pages(gfp, 0);
 	if (!t_page->page) {
 		kfree(t_page);
 		return NULL;
@@ -1005,6 +1012,12 @@ static struct nullb_page *null_insert_page(struct nullb *nullb,
 {
 	u64 idx;
 	struct nullb_page *t_page;
+	gfp_t gfp;
+
+	if (nullb->dev->nowait && nullb->dev->queue_mode == NULL_Q_BIO)
+		gfp = GFP_NOWAIT;
+	else
+		gfp = GFP_NOIO;
 
 	t_page = null_lookup_page(nullb, sector, true, ignore_cache);
 	if (t_page)
@@ -1012,11 +1025,11 @@ static struct nullb_page *null_insert_page(struct nullb *nullb,
 
 	spin_unlock_irq(&nullb->lock);
 
-	t_page = null_alloc_page();
+	t_page = null_alloc_page(gfp);
 	if (!t_page)
 		goto out_lock;
 
-	if (radix_tree_preload(GFP_NOIO))
+	if (radix_tree_preload(gfp))
 		goto out_freepage;
 
 	spin_lock_irq(&nullb->lock);
@@ -2005,6 +2018,11 @@ static int null_validate_conf(struct nullb_device *dev)
 		return -EINVAL;
 	}
 
+	if (dev->nowait && dev->queue_mode != NULL_Q_BIO) {
+		pr_err("nowait is only allowed with queue_mode=BIO\n");
+		return -EINVAL;
+	}
+
 	dev->blocksize = round_down(dev->blocksize, 512);
 	dev->blocksize = clamp_t(unsigned int, dev->blocksize, 512, 4096);
 
@@ -2146,6 +2164,11 @@ static int null_add_dev(struct nullb_device *dev)
 	blk_queue_flag_set(QUEUE_FLAG_NONROT, nullb->q);
 	blk_queue_flag_clear(QUEUE_FLAG_ADD_RANDOM, nullb->q);
 
+	if (dev->nowait)
+		blk_queue_flag_set(QUEUE_FLAG_NOWAIT, nullb->q);
+	else
+		blk_queue_flag_clear(QUEUE_FLAG_NOWAIT, nullb->q);
+
 	mutex_lock(&lock);
 	rv = ida_simple_get(&nullb_indexes, 0, 0, GFP_KERNEL);
 	if (rv < 0) {
diff --git a/drivers/block/null_blk/null_blk.h b/drivers/block/null_blk/null_blk.h
index 929f659dd255..c52aa018657b 100644
--- a/drivers/block/null_blk/null_blk.h
+++ b/drivers/block/null_blk/null_blk.h
@@ -112,6 +112,7 @@ struct nullb_device {
 	unsigned int index; /* index of the disk, only valid with a disk */
 	unsigned int mbps; /* Bandwidth throttle cap (in MB/s) */
 	bool blocking; /* blocking blk-mq device */
+	bool nowait; /* to set QUEUE_FLAG_NOWAIT on device queue */
 	bool use_per_node_hctx; /* use per-node allocation for hardware context */
 	bool power; /* power on/off the device */
 	bool memory_backed; /* if data is stored in memory */
-- 
2.40.0

