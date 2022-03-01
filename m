Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E2CFC433EF
	for <linux-block@archiver.kernel.org>; Tue,  1 Mar 2022 02:23:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbiCACYP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Feb 2022 21:24:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbiCACYN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Feb 2022 21:24:13 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2078.outbound.protection.outlook.com [40.107.212.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9987028990
        for <linux-block@vger.kernel.org>; Mon, 28 Feb 2022 18:23:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jHgu+BVZQfXZvkj3XFcvZ4I2T7bKLv/zVLG5xDE4Eg2plslAqnukOy7SwnUbWJGZ9nEGmTtm60TPrud5Dn0t+k9yHmMzIuBokFUc4o4opkV6FBiD0I1jpEfngUIYjvQT+KI6s4wjxE11TzxTNg+wTPcTBAN4sqbSHBxiKrC57gYd8MNcNh7VzLpGtBaqP0j0lrATNvhlfzCYSAEfP/DP4OAxoQM18CBoZbz7GwQlBvvOUlhsICe24K/9lRZ9tMAhzBKtcPaHDkzoarCCWVPNUwru10YYs9xunBUE+Pxgwp1zyRlyGGjkDuYJEJhnNFjntaMasYFLcwY/a00ZB2jRWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K4asHiqBQoiDCBC01dwLBLlNdF7T67pGJY+92BkN1eo=;
 b=cm+L102n3QXNynrRis5uyoDJXt/AOYzhup5Di0oef2ipJ68E25XazMWKntebIqFOmKqxSK3cHL22ot8MCJwms7o1i9Xhbao/x0dCNW+zHb673pU/QX0DDbeuXpDy6noxcLtJxH8XikRMQRfC9DfuyYRVNKDHAgiBJrC1NL63Hbj7Kk/xMr9xLuEPGPz9/jeIYL0HD9V95Ke55G6L3fumJ9xSJAU5TUOmsR7doIJozoXM4bq7FqFmrmx7aBoPFeYQ6FWPnWnyah9Xj+gaL642yA/wvrmTir23cTmrqrhpirnsi0tc8CjmtrULucMprnil+bPV05UXRrdz0aQIU+m1Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=kernel.dk smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K4asHiqBQoiDCBC01dwLBLlNdF7T67pGJY+92BkN1eo=;
 b=Blrps3StbffMWi+Qodh2pBMZSa9b5O6Y4W3qgaBuqB3nmaAOrzpVBsvx2GPiqzk/igbXA81ctfKKehboeYrBu5d531qyHZLG8nDAgleKxV3PNjTORYBulCFoCEmZJLvuDWw1RkFPCMNAP/z2NofiF5CzdQ39eN3/3q5dyZDJ/wT3Hm2kGYQMiPcnSapkqdmf6eXDxdp8Q2tIp25hVMWfwo7ejEEgy0Nn6Jox0V2ip2DfItkpvewiRvOHR80f06ZnZt82SQeTwG/0bCOQljKZ1tbuNuR52NVtg6JMVxwuO/uynlRkzcU3OO72gnTNwsWWX8uG9fZVnhzX8JnTUNgM2w==
Received: from BN9PR03CA0310.namprd03.prod.outlook.com (2603:10b6:408:112::15)
 by BY5PR12MB4242.namprd12.prod.outlook.com (2603:10b6:a03:203::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.24; Tue, 1 Mar
 2022 02:23:25 +0000
Received: from BN8NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:112:cafe::e3) by BN9PR03CA0310.outlook.office365.com
 (2603:10b6:408:112::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.24 via Frontend
 Transport; Tue, 1 Mar 2022 02:23:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 BN8NAM11FT006.mail.protection.outlook.com (10.13.177.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5017.22 via Frontend Transport; Tue, 1 Mar 2022 02:23:24 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 1 Mar
 2022 02:23:22 +0000
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Mon, 28 Feb 2022
 18:23:21 -0800
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>
CC:     <damien.lemoal@wdc.com>, <axboe@kernel.dk>, <hch@lst.de>,
        <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 0/1] block: move sector bio member into blk_next_bio()
Date:   Mon, 28 Feb 2022 18:23:09 -0800
Message-ID: <20220301022310.8579-1-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c6b300bd-5b12-46a4-0374-08d9fb2a76e7
X-MS-TrafficTypeDiagnostic: BY5PR12MB4242:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB4242595D194D0E2E7CEC0F6CA3029@BY5PR12MB4242.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BYWaDbVYtsWn8HqX6Ck65DUE4OpkmFSMT8pMfGMBjRNabSOwKvdVC1nLoPIe+7pc7QoxEU6BrALPRp2ku/CjC+w1YPAgrj4YMkdts4ZvLsKFkaNMnk8naK76N95Y6q0yBPK3KnGy/wX3Cvmn+G6QA38hnc6q2h6U1cA1xy1u9FOqAsUJnqi+F716cGiijATM7gj0WlMsaHd33H2C8gsBKWJA6cpwB0fYapUGqvJWpula2PHd/NSse73UPJ32wrP+jHo5tnxSGfvwusuAHBGjoG6p2Z/09l2/rBvqxpRDenHZdkkdoYTEBcYwX5MhPQzdJ6y3n0XuTK1ssCanLda1QgtLEaYS+4tahgNhwN0WvwkgJy6gOWU3Y3Nu4g5LF5o2igy35AkF5ACeM629wvhS6Nsb+F5T//PZPM3qdYawtHLGHxIf/Rd2Gus49WsAwsPDmOk2JJ127hI3rTMz83yHqt5Poh+jip4q1a0zSkq0jjzKIXwJz+wGtFxAYteeRsWAqaolxj2FQUhiNUQUfHGXVqUq9xV/Lln9aqJvvMo55ORNq3Ie2zaHvekJp5RkpGDhrQes+znXTPK3jqpwLZPWFAJaCPiGjxbNq24P9aSxgz+mvdlsADg+Mzd+qmnTweOn83DpqGAqXPQC1TLOJwLDz0ofIEOQFTdvwoUMK0qa4zw/45r8iS1jmO98bZxyWVqbqPsrT94FkZIqsMbnqc30gUQABKzf7NEAlJuNVQ6FtFE=
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(81166007)(356005)(6666004)(8936002)(36756003)(7696005)(36860700001)(47076005)(508600001)(83380400001)(54906003)(110136005)(336012)(426003)(2616005)(40460700003)(1076003)(316002)(5660300002)(30864003)(16526019)(26005)(186003)(82310400004)(8676002)(70586007)(70206006)(2906002)(4326008)(107886003)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2022 02:23:24.9810
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6b300bd-5b12-46a4-0374-08d9fb2a76e7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4242
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

blk_next_bio() is the central function which allocates bios for
discard, write-same, write-zeroes and zone-mgmt. The initialization of
sector bio member is duplicated in disacrd, write-same, write-zeores
etc. Move sector member to the blk_next_bio() just like we have moved
other members to blk_next_bio().

-ck

Chaitanya Kulkarni (1):
  block: move sector bio member into blk_next_bio()

 block/bio.c               |  5 ++++-
 block/blk-lib.c           | 20 +++++++++-----------
 block/blk-zoned.c         |  9 ++++-----
 drivers/nvme/target/zns.c |  3 +--
 include/linux/bio.h       |  3 ++-
 5 files changed, 20 insertions(+), 20 deletions(-)

dev linux-block-broken (for-next) # sh test-discard-wz.sh 
+ git diff block drivers/block/null_blk
diff --git a/block/blk-lib.c b/block/blk-lib.c
index 3407b1afc079..afb2d471bbe7 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -79,6 +79,8 @@ int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
 
                WARN_ON_ONCE((req_sects << 9) > UINT_MAX);
 
+               pr_info("%s %d sector %llu nr_sects %llu\n",
+                               __func__, __LINE__, sector, nr_sects);
                bio = blk_next_bio(bio, bdev, sector, 0, op, gfp_mask);
                bio->bi_iter.bi_size = req_sects << 9;
                sector += req_sects;
@@ -166,6 +168,8 @@ static int __blkdev_issue_write_same(struct block_device *bdev, sector_t sector,
        max_write_same_sectors = bio_allowed_max_sectors(q);
 
        while (nr_sects) {
+               pr_info("%s %d sector %llu nr_sects %llu\n",
+                               __func__, __LINE__, sector, nr_sects);
                bio = blk_next_bio(bio, bdev, sector, 1, REQ_OP_WRITE_SAME,
                                   gfp_mask);
                bio->bi_vcnt = 1;
@@ -238,6 +242,8 @@ static int __blkdev_issue_write_zeroes(struct block_device *bdev,
                return -EOPNOTSUPP;
 
        while (nr_sects) {
+               pr_info("%s %d sector %llu nr_sects %llu\n",
+                               __func__, __LINE__, sector, nr_sects);
                bio = blk_next_bio(bio, bdev, sector, 0, op | opf, gfp_mask);
 
                if (nr_sects > max_write_zeroes_sectors) {
@@ -281,6 +287,8 @@ static int __blkdev_issue_zero_pages(struct block_device *bdev,
                return -EPERM;
 
        while (nr_sects != 0) {
+               pr_info("%s %d sector %llu nr_sects %llu\n",
+                               __func__, __LINE__, sector, nr_sects);
                bio = blk_next_bio(bio, bdev, sector, nr_pages, REQ_OP_WRITE,
                                   gfp_mask);
 
diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 0a8680df3f1c..78fca69b7b28 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -215,6 +215,8 @@ static int blkdev_zone_reset_all_emulated(struct block_device *bdev,
                        continue;
                }
 
+               pr_info("%s %d sector %llu nr_sects 0\n",
+                               __func__, __LINE__, sector);
                bio = blk_next_bio(bio, bdev, sector, 0,
                                   REQ_OP_ZONE_RESET | REQ_SYNC, gfp_mask);
                sector += zone_sectors;
@@ -301,6 +303,8 @@ int blkdev_zone_mgmt(struct block_device *bdev, enum req_opf op,
        }
 
        while (sector < end_sector) {
+               pr_info("%s %d sector %llu nr_sects 0\n",
+                               __func__, __LINE__, sector);
                bio = blk_next_bio(bio, bdev, sector, 0, op | REQ_SYNC,
                                   gfp_mask);
                sector += zone_sectors;
diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 05b1120e6623..9f7be46c6549 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -80,6 +80,12 @@ enum {
        NULL_Q_MQ               = 2,
 };
 
+static bool g_write_zeroes = false;
+module_param_named(write_zeroes, g_write_zeroes, bool, 0444);
+
+static bool g_reset_all = false;
+module_param_named(reset_all, g_reset_all, bool, 0444);
+
 static bool g_virt_boundary = false;
 module_param_named(virt_boundary, g_virt_boundary, bool, 0444);
 MODULE_PARM_DESC(virt_boundary, "Require a virtual boundary for the device. Default: False");
@@ -656,6 +662,7 @@ static struct nullb_device *null_alloc_dev(void)
        dev->zone_nr_conv = g_zone_nr_conv;
        dev->zone_max_open = g_zone_max_open;
        dev->zone_max_active = g_zone_max_active;
+       dev->reset_all = g_reset_all;
        dev->virt_boundary = g_virt_boundary;
        return dev;
 }
@@ -1749,25 +1756,12 @@ static void null_del_dev(struct nullb *nullb)
 
 static void null_config_discard(struct nullb *nullb)
 {
-       if (nullb->dev->discard == false)
-               return;
-
-       if (!nullb->dev->memory_backed) {
-               nullb->dev->discard = false;
-               pr_info("discard option is ignored without memory backing\n");
-               return;
-       }
-
-       if (nullb->dev->zoned) {
-               nullb->dev->discard = false;
-               pr_info("discard option is ignored in zoned mode\n");
-               return;
-       }
-
        nullb->q->limits.discard_granularity = nullb->dev->blocksize;
        nullb->q->limits.discard_alignment = nullb->dev->blocksize;
        blk_queue_max_discard_sectors(nullb->q, UINT_MAX >> 9);
        blk_queue_flag_set(QUEUE_FLAG_DISCARD, nullb->q);
+       if (g_write_zeroes)
+               blk_queue_max_write_zeroes_sectors(nullb->q, UINT_MAX >> 9);
 }
 
 static const struct block_device_operations null_bio_ops = {
diff --git a/drivers/block/null_blk/null_blk.h b/drivers/block/null_blk/null_blk.h
index 78eb56b0ca55..619433f2d599 100644
--- a/drivers/block/null_blk/null_blk.h
+++ b/drivers/block/null_blk/null_blk.h
@@ -102,6 +102,7 @@ struct nullb_device {
        bool power; /* power on/off the device */
        bool memory_backed; /* if data is stored in memory */
        bool discard; /* if support discard */
+       bool reset_all; /* if support reset_all */
        bool zoned; /* if device is zoned */
        bool virt_boundary; /* virtual boundary on/off for the device */
 };
diff --git a/drivers/block/null_blk/zoned.c b/drivers/block/null_blk/zoned.c
index dae54dd1aeac..7ed032e43131 100644
--- a/drivers/block/null_blk/zoned.c
+++ b/drivers/block/null_blk/zoned.c
@@ -157,7 +157,8 @@ int null_register_zoned_dev(struct nullb *nullb)
        struct request_queue *q = nullb->q;
 
        blk_queue_set_zoned(nullb->disk, BLK_ZONED_HM);
-       blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, q);
+       if (dev->reset_all)
+               blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, q);
        blk_queue_required_elevator_features(q, ELEVATOR_F_ZBD_SEQ_WRITE);
 
        if (queue_is_mq(q)) {
+ modprobe -r null_blk
+ modprobe null_blk
+ blkdiscard -o 0 -l 40960 /dev/nullb0
+ blkdiscard -o 1024 -l 10240 /dev/nullb0
+ dmesg -c
[21846.094314] null_blk: module loaded
[21846.097714] __blkdev_issue_discard 82 sector 0 nr_sects 80
[21846.100089] __blkdev_issue_discard 82 sector 2 nr_sects 20
+ blkdiscard -z -o 0 -l 40960 /dev/nullb0
+ blkdiscard -z -o 1024 -l 10240 /dev/nullb0
+ dmesg -c
[21846.104408] __blkdev_issue_zero_pages 290 sector 0 nr_sects 80
[21846.106771] __blkdev_issue_zero_pages 290 sector 2 nr_sects 20
+ modprobe -r null_blk
+ modprobe null_blk write_zeroes=1
+ blkdiscard -z -o 0 -l 40960 /dev/nullb0
+ blkdiscard -z -o 1024 -l 10240 /dev/nullb0
+ dmesg -c
[21846.144751] null_blk: module loaded
[21846.147315] __blkdev_issue_write_zeroes 245 sector 0 nr_sects 80
[21846.149549] __blkdev_issue_write_zeroes 245 sector 2 nr_sects 20
+ modprobe -r null_blk
+ modprobe null_blk zoned=1 gb=1 zone_size=128
+ dd if=/dev/zero of=/dev/nullb0 bs=4k oflag=direct
dd: error writing '/dev/nullb0': No space left on device
262145+0 records in
262144+0 records out
1073741824 bytes (1.1 GB, 1.0 GiB) copied, 5.17173 s, 208 MB/s
+ blkzone report /dev/nullb0
  start: 0x000000000, len 0x040000, wptr 0x040000 reset:0 non-seq:0, zcond:14(fu)
  start: 0x000040000, len 0x040000, wptr 0x040000 reset:0 non-seq:0, zcond:14(fu)
  start: 0x000080000, len 0x040000, wptr 0x040000 reset:0 non-seq:0, zcond:14(fu)
  start: 0x0000c0000, len 0x040000, wptr 0x040000 reset:0 non-seq:0, zcond:14(fu)
  start: 0x000100000, len 0x040000, wptr 0x040000 reset:0 non-seq:0, zcond:14(fu)
  start: 0x000140000, len 0x040000, wptr 0x040000 reset:0 non-seq:0, zcond:14(fu)
  start: 0x000180000, len 0x040000, wptr 0x040000 reset:0 non-seq:0, zcond:14(fu)
  start: 0x0001c0000, len 0x040000, wptr 0x040000 reset:0 non-seq:0, zcond:14(fu)
+ for i in 7 6 5 4 3 2 1 0
++ echo '(134217728*7)/512'
++ bc
+ offset=1835008
+ blkzone reset -o 1835008 -l 262144 /dev/nullb0
+ echo -----------------------------------------
-----------------------------------------
+ blkzone report /dev/nullb0
  start: 0x000000000, len 0x040000, wptr 0x040000 reset:0 non-seq:0, zcond:14(fu)
  start: 0x000040000, len 0x040000, wptr 0x040000 reset:0 non-seq:0, zcond:14(fu)
  start: 0x000080000, len 0x040000, wptr 0x040000 reset:0 non-seq:0, zcond:14(fu)
  start: 0x0000c0000, len 0x040000, wptr 0x040000 reset:0 non-seq:0, zcond:14(fu)
  start: 0x000100000, len 0x040000, wptr 0x040000 reset:0 non-seq:0, zcond:14(fu)
  start: 0x000140000, len 0x040000, wptr 0x040000 reset:0 non-seq:0, zcond:14(fu)
  start: 0x000180000, len 0x040000, wptr 0x040000 reset:0 non-seq:0, zcond:14(fu)
  start: 0x0001c0000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond: 1(em)
+ for i in 7 6 5 4 3 2 1 0
++ echo '(134217728*6)/512'
++ bc
+ offset=1572864
+ blkzone reset -o 1572864 -l 262144 /dev/nullb0
+ echo -----------------------------------------
-----------------------------------------
+ blkzone report /dev/nullb0
  start: 0x000000000, len 0x040000, wptr 0x040000 reset:0 non-seq:0, zcond:14(fu)
  start: 0x000040000, len 0x040000, wptr 0x040000 reset:0 non-seq:0, zcond:14(fu)
  start: 0x000080000, len 0x040000, wptr 0x040000 reset:0 non-seq:0, zcond:14(fu)
  start: 0x0000c0000, len 0x040000, wptr 0x040000 reset:0 non-seq:0, zcond:14(fu)
  start: 0x000100000, len 0x040000, wptr 0x040000 reset:0 non-seq:0, zcond:14(fu)
  start: 0x000140000, len 0x040000, wptr 0x040000 reset:0 non-seq:0, zcond:14(fu)
  start: 0x000180000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond: 1(em)
  start: 0x0001c0000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond: 1(em)
+ for i in 7 6 5 4 3 2 1 0
++ echo '(134217728*5)/512'
++ bc
+ offset=1310720
+ blkzone reset -o 1310720 -l 262144 /dev/nullb0
+ echo -----------------------------------------
-----------------------------------------
+ blkzone report /dev/nullb0
  start: 0x000000000, len 0x040000, wptr 0x040000 reset:0 non-seq:0, zcond:14(fu)
  start: 0x000040000, len 0x040000, wptr 0x040000 reset:0 non-seq:0, zcond:14(fu)
  start: 0x000080000, len 0x040000, wptr 0x040000 reset:0 non-seq:0, zcond:14(fu)
  start: 0x0000c0000, len 0x040000, wptr 0x040000 reset:0 non-seq:0, zcond:14(fu)
  start: 0x000100000, len 0x040000, wptr 0x040000 reset:0 non-seq:0, zcond:14(fu)
  start: 0x000140000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond: 1(em)
  start: 0x000180000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond: 1(em)
  start: 0x0001c0000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond: 1(em)
+ for i in 7 6 5 4 3 2 1 0
++ echo '(134217728*4)/512'
++ bc
+ offset=1048576
+ blkzone reset -o 1048576 -l 262144 /dev/nullb0
+ echo -----------------------------------------
-----------------------------------------
+ blkzone report /dev/nullb0
  start: 0x000000000, len 0x040000, wptr 0x040000 reset:0 non-seq:0, zcond:14(fu)
  start: 0x000040000, len 0x040000, wptr 0x040000 reset:0 non-seq:0, zcond:14(fu)
  start: 0x000080000, len 0x040000, wptr 0x040000 reset:0 non-seq:0, zcond:14(fu)
  start: 0x0000c0000, len 0x040000, wptr 0x040000 reset:0 non-seq:0, zcond:14(fu)
  start: 0x000100000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond: 1(em)
  start: 0x000140000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond: 1(em)
  start: 0x000180000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond: 1(em)
  start: 0x0001c0000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond: 1(em)
+ for i in 7 6 5 4 3 2 1 0
++ echo '(134217728*3)/512'
++ bc
+ offset=786432
+ blkzone reset -o 786432 -l 262144 /dev/nullb0
+ echo -----------------------------------------
-----------------------------------------
+ blkzone report /dev/nullb0
  start: 0x000000000, len 0x040000, wptr 0x040000 reset:0 non-seq:0, zcond:14(fu)
  start: 0x000040000, len 0x040000, wptr 0x040000 reset:0 non-seq:0, zcond:14(fu)
  start: 0x000080000, len 0x040000, wptr 0x040000 reset:0 non-seq:0, zcond:14(fu)
  start: 0x0000c0000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond: 1(em)
  start: 0x000100000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond: 1(em)
  start: 0x000140000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond: 1(em)
  start: 0x000180000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond: 1(em)
  start: 0x0001c0000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond: 1(em)
+ for i in 7 6 5 4 3 2 1 0
++ echo '(134217728*2)/512'
++ bc
+ offset=524288
+ blkzone reset -o 524288 -l 262144 /dev/nullb0
+ echo -----------------------------------------
-----------------------------------------
+ blkzone report /dev/nullb0
  start: 0x000000000, len 0x040000, wptr 0x040000 reset:0 non-seq:0, zcond:14(fu)
  start: 0x000040000, len 0x040000, wptr 0x040000 reset:0 non-seq:0, zcond:14(fu)
  start: 0x000080000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond: 1(em)
  start: 0x0000c0000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond: 1(em)
  start: 0x000100000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond: 1(em)
  start: 0x000140000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond: 1(em)
  start: 0x000180000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond: 1(em)
  start: 0x0001c0000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond: 1(em)
+ for i in 7 6 5 4 3 2 1 0
++ echo '(134217728*1)/512'
++ bc
+ offset=262144
+ blkzone reset -o 262144 -l 262144 /dev/nullb0
+ echo -----------------------------------------
-----------------------------------------
+ blkzone report /dev/nullb0
  start: 0x000000000, len 0x040000, wptr 0x040000 reset:0 non-seq:0, zcond:14(fu)
  start: 0x000040000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond: 1(em)
  start: 0x000080000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond: 1(em)
  start: 0x0000c0000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond: 1(em)
  start: 0x000100000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond: 1(em)
  start: 0x000140000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond: 1(em)
  start: 0x000180000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond: 1(em)
  start: 0x0001c0000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond: 1(em)
+ for i in 7 6 5 4 3 2 1 0
++ echo '(134217728*0)/512'
++ bc
+ offset=0
+ blkzone reset -o 0 -l 262144 /dev/nullb0
+ echo -----------------------------------------
-----------------------------------------
+ blkzone report /dev/nullb0
  start: 0x000000000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond: 1(em)
  start: 0x000040000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond: 1(em)
  start: 0x000080000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond: 1(em)
  start: 0x0000c0000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond: 1(em)
  start: 0x000100000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond: 1(em)
  start: 0x000140000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond: 1(em)
  start: 0x000180000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond: 1(em)
  start: 0x0001c0000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond: 1(em)
+ dmesg -c
[21846.186170] null_blk: module loaded
[21851.363766] blkdev_zone_mgmt 306 sector 1835008 nr_sects 0
[21851.368268] blkdev_zone_mgmt 306 sector 1572864 nr_sects 0
[21851.372565] blkdev_zone_mgmt 306 sector 1310720 nr_sects 0
[21851.377126] blkdev_zone_mgmt 306 sector 1048576 nr_sects 0
[21851.381438] blkdev_zone_mgmt 306 sector 786432 nr_sects 0
[21851.385542] blkdev_zone_mgmt 306 sector 524288 nr_sects 0
[21851.389727] blkdev_zone_mgmt 306 sector 262144 nr_sects 0
[21851.394340] blkdev_zone_mgmt 306 sector 0 nr_sects 0
+ echo ---------------------------------------------------
---------------------------------------------------
+ modprobe -r null_blk
+ modprobe null_blk zoned=1 gb=1 zone_size=128 reset_all=0
+ dd if=/dev/zero of=/dev/nullb0 bs=4k oflag=direct
dd: error writing '/dev/nullb0': No space left on device
262145+0 records in
262144+0 records out
1073741824 bytes (1.1 GB, 1.0 GiB) copied, 5.12941 s, 209 MB/s
+ blkzone report /dev/nullb0
  start: 0x000000000, len 0x040000, wptr 0x040000 reset:0 non-seq:0, zcond:14(fu)
  start: 0x000040000, len 0x040000, wptr 0x040000 reset:0 non-seq:0, zcond:14(fu)
  start: 0x000080000, len 0x040000, wptr 0x040000 reset:0 non-seq:0, zcond:14(fu)
  start: 0x0000c0000, len 0x040000, wptr 0x040000 reset:0 non-seq:0, zcond:14(fu)
  start: 0x000100000, len 0x040000, wptr 0x040000 reset:0 non-seq:0, zcond:14(fu)
  start: 0x000140000, len 0x040000, wptr 0x040000 reset:0 non-seq:0, zcond:14(fu)
  start: 0x000180000, len 0x040000, wptr 0x040000 reset:0 non-seq:0, zcond:14(fu)
  start: 0x0001c0000, len 0x040000, wptr 0x040000 reset:0 non-seq:0, zcond:14(fu)
+ blkzone reset /dev/nullb0
+ blkzone report /dev/nullb0
  start: 0x000000000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond: 1(em)
  start: 0x000040000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond: 1(em)
  start: 0x000080000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond: 1(em)
  start: 0x0000c0000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond: 1(em)
  start: 0x000100000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond: 1(em)
  start: 0x000140000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond: 1(em)
  start: 0x000180000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond: 1(em)
  start: 0x0001c0000, len 0x040000, wptr 0x000000 reset:0 non-seq:0, zcond: 1(em)
+ modprobe -r null_blk
+ rm -fr /dev/nullb0
+ dmesg -c
[21851.434632] null_blk: module loaded
[21856.567436] blkdev_zone_reset_all_emulated 218 sector 0 nr_sects 0
[21856.567441] blkdev_zone_reset_all_emulated 218 sector 262144 nr_sects 0
[21856.567449] blkdev_zone_reset_all_emulated 218 sector 524288 nr_sects 0
[21856.567451] blkdev_zone_reset_all_emulated 218 sector 786432 nr_sects 0
[21856.567452] blkdev_zone_reset_all_emulated 218 sector 1048576 nr_sects 0
[21856.567454] blkdev_zone_reset_all_emulated 218 sector 1310720 nr_sects 0
[21856.567455] blkdev_zone_reset_all_emulated 218 sector 1572864 nr_sects 0
[21856.567459] blkdev_zone_reset_all_emulated 218 sector 1835008 nr_sects 0
+ set +x

