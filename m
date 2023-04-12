Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4AC4C77B6E
	for <linux-block@archiver.kernel.org>; Wed, 12 Apr 2023 08:49:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbjDLItf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Apr 2023 04:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231312AbjDLIt3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Apr 2023 04:49:29 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2045.outbound.protection.outlook.com [40.107.244.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 610E97A9F
        for <linux-block@vger.kernel.org>; Wed, 12 Apr 2023 01:49:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L0CRKjPzchAJiFm0YhD/kSPDIxztxjq8di/BYvVy8OfJqv5HFsMPGaUEw/+fDOptXLts2rpPlN0qLkYWEjDBf7suph0NRLTvp2Ze8/6e5kho8I6qEtsr55inuik6YFSwACw56otDs/ilg62DUT9Oe8xZBK61K+/ALCmtvnl2hbRaX1ybuMPEazxDcDOVZDT5glpauPn2sfXvWcEWW8Bf0ijWpIf7kl+JIzQliFEk45jr/GGU7sv6ANsZ5+JiFRbS1ULbS7TQfNiUP28mv/PL3GCktm46x5s2SQy3kk30PWjnA2Gpdx3zQpPyK9bu/CqY2BURIvo3Ls+eOjtH2EEFrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WN5jJPyF9/eggErG1YJ8AEVI+WEioovmqd52hOGizmg=;
 b=E1kCu2lvbwV7jd6TMhseWUTQhm4VLegBSGBClb6M7NLjV7kk2ZIYmG4ugf8lwfrvwWU7Kscha052gX86JAcuRANbGl8K1F1pxImuMCo45u4JOop6k3JTKcAhXeoSBGUCnp1Sc08U9aWY2YjzPaC4vJrJMaQF63AMna7nzviENjSlX1BCaM+DW9FpiiVN0ncyDZ8imnZjz8l6jzV8ipsZlVPVrXv/Z6SBDn8Mq/FTU5YWqfrtqGBotDRlaKXOxSq+mATuVLYcMEj6yyS15GuNqM11Fe3X5YRAaIY5IrWpZFoHGT8tu51oGgmP01zKQHdYOGhJfDJzuHUUl5ybTWfUvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WN5jJPyF9/eggErG1YJ8AEVI+WEioovmqd52hOGizmg=;
 b=POngJKIbfO+RQpulka45DyrslshpBSo2oFF1opuw1jEeNAk1rVU0729eTASLhsquxFe2SBxZkEi2ydetZSPzduQT108OozXv8pTu4+XZfDN7vMC1ckN0x42LAURvXawszL0x7NCMvVR+00x38v/PWk58XFjCecomu3mTrnn1WgvEGchGAyJr0EaHQlVYn9qQeDRkDpRsAwWL0JekfRtOSXr8oR4MhuS6H3+vwu/qFpJVob4Yxeg74opsGiHSzBcbYf+A9xdF+YZdbqomB2oivLDC5bLnzwBlJBJhSysFhjcm4ltFD0gZaE/NLrtlE0I1qB8ywoVn3ZSCJJJmFvWtkg==
Received: from DM6PR12CA0017.namprd12.prod.outlook.com (2603:10b6:5:1c0::30)
 by CH2PR12MB4938.namprd12.prod.outlook.com (2603:10b6:610:34::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Wed, 12 Apr
 2023 08:48:07 +0000
Received: from DM6NAM11FT077.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1c0:cafe::66) by DM6PR12CA0017.outlook.office365.com
 (2603:10b6:5:1c0::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30 via Frontend
 Transport; Wed, 12 Apr 2023 08:48:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT077.mail.protection.outlook.com (10.13.173.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6298.30 via Frontend Transport; Wed, 12 Apr 2023 08:48:07 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 12 Apr 2023
 01:47:54 -0700
Received: from dev.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 12 Apr
 2023 01:47:53 -0700
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-block@vger.kernel.org>
CC:     <axboe@kernel.dk>, <damien.lemoal@opensource.wdc.com>,
        <kch@nvidia.com>, <johannes.thumshirn@wdc.com>,
        <bvanassche@acm.org>, <vincent.fu@samsung.com>,
        <shinichiro.kawasaki@wdc.com>, <yukuai3@huawei.com>
Subject: [PATCH 1/1] null_blk: allow user to set QUEUE_FLAG_NOWAIT
Date:   Wed, 12 Apr 2023 01:47:30 -0700
Message-ID: <20230412084730.51694-2-kch@nvidia.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230412084730.51694-1-kch@nvidia.com>
References: <20230412084730.51694-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT077:EE_|CH2PR12MB4938:EE_
X-MS-Office365-Filtering-Correlation-Id: 7166baf4-4adc-4916-21bc-08db3b32a337
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L0BDLe3kJos6yipUPI+kcQUiqnZNl8w+iHPyMoBJnQKjIygXLHwhDnWpdFaMrEfblO9kEBGeC8SjWJ5TC0i0P9leUOOM5vTSsm5I9IFCMCdFevruyd0jt7bUAInbYYvCkQ8uunYBmdBynKbclUBs6OjItw47aFqkXD2Vj1jTYcylmSaPWJteOd0N7fRisFkzFI7Qah81njA2V/Ydypbb5VwD7RWIox3VIoDBfY61IBSbbmglIfjO2AQUFWSkYDCbxitJlOspZ+RnZEqdNpocvP30Zv3nVSPkef7clcNkVH/I7oJrBneva7F9asvBkOTcmy0vbw0ZRnhELKsn5i1QFHiQuNkBcvzbxh8blprO2e4hmhanLdybVTmGm93194JqdfJfmZEPjozjPiqWuxpSOqdYa84YYi8bT381OU5eRgL+1F4lTZF3uL32aAnTr2uhYcs9jyoceR6F7fZvRgV+Ig1crSsQNSPXvbTPVLAOC4okCISzyIV6OLcQ7JrBJTvVDlTfTHYagkEp40d9EC2RfQG60X1KAFD4UD3cLczXlrHNAWvDOu0EhJDrhsAiPjbW9WfSXEBV9E+rdH1FgljydE2ruoJjhBuh0b6nXsmcUqzafyZ0Qc2MxeDDyn2j1FKS0gANNlRIdvhxtlPEf56OIRb19T2CMqDcjd/h1nXfG9ADTieG8JCQT/GYLS29fdosR0tvagdEg4OpTwjP7VxKWibO22M46rRDOd+JHzFdjIlOdFsUgSqc6E4nYUZ5VcWNxYumr2G+mwD84OUXzJD1H/P/yjes8oozgIWFSm5G+3A=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(376002)(136003)(39860400002)(451199021)(46966006)(36840700001)(40470700004)(2906002)(8676002)(478600001)(70206006)(70586007)(8936002)(5660300002)(66899021)(41300700001)(40460700003)(316002)(82740400003)(336012)(426003)(83380400001)(36756003)(40480700001)(54906003)(4326008)(6916009)(186003)(7696005)(6666004)(26005)(1076003)(16526019)(2616005)(356005)(36860700001)(82310400005)(7636003)(34070700002)(47076005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2023 08:48:07.4041
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7166baf4-4adc-4916-21bc-08db3b32a337
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT077.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4938
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

QUEUE_FLAG_NOWAIT is set by default to mq drivers such null_blk when
it is used with NULL_Q_MQ mode as a part of QUEUE_FLAG_MQ_DEFAULT that
gets assigned in following code path see blk_mq_init_allocated_queue():-

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
null_add_dev() irrespective of the queue mode, by default keep it
enabled to retain the original behaviour for the NULL_Q_MQ mode.

Depending on nowait value use GFP_NOWAIT or GFP_NOIO for the alloction
in the null_alloc_page() for alloc_pages() and in null_insert_page()
for radix_tree_preload().   

Observed performance difference with this patch for fio iouring with
configfs and non configfs null_blk with queue modes NULL_Q_BIO and
NULL_Q_MQ:-

* Configfs Membacked mode:-

NULL_Q_BIO mode QUEUE_FLAG_NOWAIT disabled :-
---------------------------------------------
configfs-qmode-0-nowait-0-fio-1.log:  read: IOPS=1295k, BW=5058MiB/s
configfs-qmode-0-nowait-0-fio-2.log:  read: IOPS=1362k, BW=5318MiB/s
configfs-qmode-0-nowait-0-fio-3.log:  read: IOPS=1332k, BW=5201MiB/s

NULL_Q_BIO mode QUEUE_FLAG_NOWAIT enabled :-
---------------------------------------------
configfs-qmode-0-nowait-1-fio-1.log:  read: IOPS=2095k, BW=8183MiB/s
configfs-qmode-0-nowait-1-fio-2.log:  read: IOPS=2085k, BW=8145MiB/s
configfs-qmode-0-nowait-1-fio-3.log:  read: IOPS=2036k, BW=7955MiB/s

NULL_Q_MQ mode QUEUE_FLAG_NOWAIT disabled :-
---------------------------------------------
configfs-qmode-2-nowait-0-fio-1.log:  read: IOPS=1288k, BW=5031MiB/s
configfs-qmode-2-nowait-0-fio-2.log:  read: IOPS=1239k, BW=4839MiB/s
configfs-qmode-2-nowait-0-fio-3.log:  read: IOPS=1252k, BW=4889MiB/s

NULL_Q_MQ mode QUEUE_FLAG_NOWAIT enabled :-
---------------------------------------------
configfs-qmode-2-nowait-1-fio-1.log:  read: IOPS=2101k, BW=8208MiB/s
configfs-qmode-2-nowait-1-fio-2.log:  read: IOPS=2091k, BW=8169MiB/s
configfs-qmode-2-nowait-1-fio-3.log:  read: IOPS=2088k, BW=8155MiB/s

* Non Configfs non-membacked mode:-

NULL_Q_BIO mode QUEUE_FLAG_NOWAIT disabled :-
---------------------------------------------
qmode-0-nowait-0-fio-1.log:  read: IOPS=1362k, BW=5321MiB/s
qmode-0-nowait-0-fio-2.log:  read: IOPS=1334k, BW=5210MiB/s
qmode-0-nowait-0-fio-3.log:  read: IOPS=1386k, BW=5416MiB/s

NULL_Q_BIO mode QUEUE_FLAG_NOWAIT enabled :-
---------------------------------------------
qmode-0-nowait-1-fio-1.log:  read: IOPS=5405k, BW=20.6GiB/s
qmode-0-nowait-1-fio-2.log:  read: IOPS=5502k, BW=21.0GiB/s
qmode-0-nowait-1-fio-3.log:  read: IOPS=5518k, BW=21.0GiB/s

NULL_Q_MQ mode QUEUE_FLAG_NOWAIT disabled :-
---------------------------------------------
qmode-2-nowait-0-fio-1.log:  read: IOPS=1356k, BW=5296MiB/s
qmode-2-nowait-0-fio-2.log:  read: IOPS=1318k, BW=5148MiB/s
qmode-2-nowait-0-fio-3.log:  read: IOPS=1252k, BW=4891MiB/s

NULL_Q_MQ mode QUEUE_FLAG_NOWAIT enabled :-
---------------------------------------------
qmode-2-nowait-1-fio-1.log:  read: IOPS=5466k, BW=20.9GiB/s
qmode-2-nowait-1-fio-2.log:  read: IOPS=5446k, BW=20.8GiB/s
qmode-2-nowait-1-fio-3.log:  read: IOPS=5482k, BW=20.9GiB/s

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---

In caes prep patch is needed (ideally it should be) for adding
gfp args to null_alloc_page() please let me know.

-ck

 drivers/block/null_blk/main.c     | 22 +++++++++++++++++-----
 drivers/block/null_blk/null_blk.h |  1 +
 2 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index bc2c58724df3..67683f2fd6e1 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -77,6 +77,10 @@ enum {
 	NULL_IRQ_TIMER		= 2,
 };
 
+static bool g_nowait = true;
+module_param_named(nowait, g_nowait, bool, 0444);
+MODULE_PARM_DESC(virt_boundary, "Set QUEUE_FLAG_NOWAIT irrespective of queue mode. Default: True");
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
@@ -628,7 +634,7 @@ nullb_group_drop_item(struct config_group *group, struct config_item *item)
 static ssize_t memb_group_features_show(struct config_item *item, char *page)
 {
 	return snprintf(page, PAGE_SIZE,
-			"badblocks,blocking,blocksize,cache_size,"
+			"badblocks,blocking,nowait,blocksize,cache_size,"
 			"completion_nsec,discard,home_node,hw_queue_depth,"
 			"irqmode,max_sectors,mbps,memory_backed,no_sched,"
 			"poll_queues,power,queue_mode,shared_tag_bitmap,size,"
@@ -696,6 +702,7 @@ static struct nullb_device *null_alloc_dev(void)
 	dev->irqmode = g_irqmode;
 	dev->hw_queue_depth = g_hw_queue_depth;
 	dev->blocking = g_blocking;
+	dev->nowait = g_nowait;
 	dev->memory_backed = g_memory_backed;
 	dev->discard = g_discard;
 	dev->cache_size = g_cache_size;
@@ -830,7 +837,7 @@ static void null_complete_rq(struct request *rq)
 	end_cmd(blk_mq_rq_to_pdu(rq));
 }
 
-static struct nullb_page *null_alloc_page(void)
+static struct nullb_page *null_alloc_page(gfp_t gfp)
 {
 	struct nullb_page *t_page;
 
@@ -838,7 +845,7 @@ static struct nullb_page *null_alloc_page(void)
 	if (!t_page)
 		return NULL;
 
-	t_page->page = alloc_pages(GFP_NOIO, 0);
+	t_page->page = alloc_pages(gfp, 0);
 	if (!t_page->page) {
 		kfree(t_page);
 		return NULL;
@@ -983,11 +990,11 @@ static struct nullb_page *null_insert_page(struct nullb *nullb,
 
 	spin_unlock_irq(&nullb->lock);
 
-	t_page = null_alloc_page();
+	t_page = null_alloc_page(nullb->dev->nowait ? GFP_NOWAIT : GFP_NOIO);
 	if (!t_page)
 		goto out_lock;
 
-	if (radix_tree_preload(GFP_NOIO))
+	if (radix_tree_preload(nullb->dev->nowait ? GFP_NOWAIT : GFP_NOIO))
 		goto out_freepage;
 
 	spin_lock_irq(&nullb->lock);
@@ -2093,6 +2100,11 @@ static int null_add_dev(struct nullb_device *dev)
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
index eb5972c50be8..1d7af446d728 100644
--- a/drivers/block/null_blk/null_blk.h
+++ b/drivers/block/null_blk/null_blk.h
@@ -107,6 +107,7 @@ struct nullb_device {
 	unsigned int index; /* index of the disk, only valid with a disk */
 	unsigned int mbps; /* Bandwidth throttle cap (in MB/s) */
 	bool blocking; /* blocking blk-mq device */
+	bool nowait; /* to set QUEUE_FLAG_NOWAIT on device queue */
 	bool use_per_node_hctx; /* use per-node allocation for hardware context */
 	bool power; /* power on/off the device */
 	bool memory_backed; /* if data is stored in memory */
-- 
2.29.0

