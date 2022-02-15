Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FC1BC433F5
	for <linux-block@archiver.kernel.org>; Tue, 15 Feb 2022 11:53:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237256AbiBOLxK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Feb 2022 06:53:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235055AbiBOLxJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Feb 2022 06:53:09 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 785F4A145E
        for <linux-block@vger.kernel.org>; Tue, 15 Feb 2022 03:52:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oQZGu8IOihDG5KICYMpenUmZVAoOpZM1cAVYw7tVxhAvqfTW7b4K24vn3q+Z+MdjKjlrwbr6XKL6EFU0WPXemntVLFvSyKAlvKcWfB7r9WLDVs26M2mw0UmCY/1bl8387qzjijl7WW85g6pRSIe7MvZkpnrKvI7jJ2GbuNsSO5a3U2B6xhqRgc4G/F6U4kykVKddqJxwBBAaDAdjDGt3T6+1ijhr1xsDXosOXV6t1xtPD/69+uahlqC64WQattzPR3t1TuEPFkak+fCXBouNzNQt4lkA9A7ZJKH8Zwmjf5JhLH+cOoEVwtJu26VFj/x8c7XD3wmJI6mxUnLwRXZIew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dIuyYjcPA8uBsT+fK4lV/jZZkXhAWsI8fFwa4DshTs4=;
 b=YsBA+ES3+Ae+8rfQmZYzsR5iF+y0IWh70eFy9gW9PoNQCBoGOd2Xe/TXvrr7qMxXCUNqSHBRwfCiGdMB2/oYqbafS8gW6iRAJ0VlC4pAcZdjQ2/X7WSiznUtQxF1DW442/1DZOxwOXtWoHPg+k+SL4Z/EoEVknoexq6gzNE7vgSju6f0nrnRFyoHzL/29E0NMYhDFr+jvYW4Nt8YmbvJc0foujkbM8wYzN+QT+6w2KFywUlZf+3b3PG0BQCVd7mKUFIjTeDCiZk8QXWWlfF3DyZzxRFQgub2663v0UjP0p5MNZAsY/ZoyoM+oLp7fsiN0MUKkJJDXTo2a9JcGLinuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=wdc.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dIuyYjcPA8uBsT+fK4lV/jZZkXhAWsI8fFwa4DshTs4=;
 b=YbMljZHqS9n2raif59yYHFXEmDs46Cj9sXRKMiEUkJOd0mo6YDdwiFOPuZ0QT3zkoE1APOy64kD5j3HUAncOfJv2EtYkj7FGzqwEMYQ82zKdfAGjzAIHyKL/UOmdlhVJyYC4cOAiFN5sEI1bBm7scuvZzYAZesFAHYnODquR37NIROnrq460UfVSJJWBkLhvJH6aRpLDjXYbKR0uo5JATn9nNvai8Y6hO0djwU9BQThxmX0Ep4b+sFpSAAoi2y7kIj4UvKg7SOxwa1IwnLXJNQZYdQxG7fw3CX1HzYIk7voMJd2Y4pADu4PaHSql2DUiPVfMS6AlKbKkT+TuqlXmPg==
Received: from BN0PR02CA0036.namprd02.prod.outlook.com (2603:10b6:408:e5::11)
 by DM6PR12MB4896.namprd12.prod.outlook.com (2603:10b6:5:1b6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.12; Tue, 15 Feb
 2022 11:52:57 +0000
Received: from BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e5:cafe::f1) by BN0PR02CA0036.outlook.office365.com
 (2603:10b6:408:e5::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.15 via Frontend
 Transport; Tue, 15 Feb 2022 11:52:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 BN8NAM11FT025.mail.protection.outlook.com (10.13.177.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4975.11 via Frontend Transport; Tue, 15 Feb 2022 11:52:57 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Tue, 15 Feb
 2022 11:52:55 +0000
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Tue, 15 Feb 2022
 03:52:54 -0800
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-block@vger.kernel.org>
CC:     <axboe@kernel.dk>, <ming.lei@redhat.com>, <damien.lemoal@wdc.com>,
        <jiangguoqing@kylinos.cn>, <shinichiro.kawasaki@wdc.com>,
        Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH V2 0/1] blk-lib: cleanup bdev_get_queue()
Date:   Tue, 15 Feb 2022 03:52:46 -0800
Message-ID: <20220215115247.11717-1-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9cbc332e-4a01-4921-84ad-08d9f079b53e
X-MS-TrafficTypeDiagnostic: DM6PR12MB4896:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB4896961DBDF490FD1708373BA3349@DM6PR12MB4896.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mU93pSGwa7nD9XM11KDeN0ZQohKj773THl/Yh5ATD4vcxqKnLR3ozbEkt3P27C5lAPhDdXcFmZRLmFqOmweCMtlQpe0Bsanhb/uRlEydSGxnEss7LtVhqPXjbmGqXLXjC6uFD+PR8fwJ6D98dK7QlaXPX82c+XlmeB7wFmT0G31MwEO8m/sQ55KpF/kA80dwmz0CQDgyWaqeaVIAva+v4IO3CZQzORoEWDEfnU6/idr4SNTWDrNZQOcSw0VquDwxkzSQyEaY7Enc0hJwSggAshtWmbFD9C4JQogSmBqmxMKRLud2YdskHTls5DxcrjmY6TSV5rsNQqZH/NFz5ZcdCTrgQo0Pt9Hk+QfpJM5sqLXx8Tt31XR9F1G/f3QH3I3JRRAskfGI8eRJFtjD1uldCqZn55H8Gw9D43QPICg3rMKnzcbOSDk9mvqvdeel9qhGLeGj3diKg6CaQ5To8C8Nr8ybhIMg08ucEqbI48KbZp6gJ+JxRF31ATj0jkyza5u5Cp9h1uoiU2gObqRQbSCxKxg7ZtcntA1a3ExBxCGP2LbdWhqO+tV8Z/BhCvu9MT9PMpjrTcqkzgxebiuYPlgenBvJJ2AVdRpf0wrNteTIQanLaKU915P+ztpz9VZlQEZXU3m2XGs6xNoAZV81g8vOu6JXMPBIlxgqWH+b2xbkxlgnjaqCQO71kboFWEWeIgQVLV/mc7ZdN0TpwXwWonw4fA==
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(47076005)(36756003)(36860700001)(8936002)(316002)(26005)(4326008)(8676002)(70206006)(70586007)(1076003)(186003)(426003)(336012)(16526019)(83380400001)(107886003)(2616005)(54906003)(81166007)(82310400004)(5660300002)(2906002)(6666004)(6916009)(40460700003)(7696005)(356005)(508600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2022 11:52:57.0399
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cbc332e-4a01-4921-84ad-08d9f079b53e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4896
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

Based on the comment in the include/linux/blkdev.h:bdev_get_queue()
the return value of the function will never be NULL. This patch series
removes those checks present in the blk-lib.c, also removes the not
needed local variable pointer to request_queue from the write_zeroes
helpers.

Below is the test log for  discard (__blkdev_issue_disacrd()) and
write-zeroes (__blkdev_issue_write_zeroes/__blkdev_issue_zero_pages()).

-ck

changes from V1:-

1. squash all patches into single patch. (Jens)

Chaitanya Kulkarni (1):
  blk-lib: don't check bdev_get_queue() NULL check

 block/blk-lib.c | 14 --------------
 1 file changed, 14 deletions(-)

1. Execute discard (__blkdev_issue_disacrd()) and write-zeroes
   (__blkdev_issue_write_zeroes, __blkdev_issue_zero_pages())

+ git diff block drivers/block/null_blk
diff --git a/block/blk-lib.c b/block/blk-lib.c
index fc6ea52e7482..84e5f31436d7 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -79,6 +79,8 @@ int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,

                WARN_ON_ONCE((req_sects << 9) > UINT_MAX);

+               pr_info("%s %d sector %llu nr_sects %llu\n",
+                               __func__, __LINE__, sector, nr_sects);
                bio = blk_next_bio(bio, bdev, 0, op, gfp_mask);
                bio->bi_iter.bi_sector = sector;
                bio->bi_iter.bi_size = req_sects << 9;
@@ -237,6 +239,8 @@ static int __blkdev_issue_write_zeroes(struct block_device *bdev,
                return -EOPNOTSUPP;

        while (nr_sects) {
+               pr_info("%s %d sector %llu nr_sects %llu\n",
+                               __func__, __LINE__, sector, nr_sects);
                bio = blk_next_bio(bio, bdev, 0, REQ_OP_WRITE_ZEROES, gfp_mask);
                bio->bi_iter.bi_sector = sector;
                if (flags & BLKDEV_ZERO_NOUNMAP)
@@ -282,6 +286,8 @@ static int __blkdev_issue_zero_pages(struct block_device *bdev,
                return -EPERM;

        while (nr_sects != 0) {
+               pr_info("%s %d sector %llu nr_sects %llu\n",
+                               __func__, __LINE__, sector, nr_sects);
                bio = blk_next_bio(bio, bdev, __blkdev_sectors_to_bio_pages(nr_sects),
                                   REQ_OP_WRITE, gfp_mask);
                bio->bi_iter.bi_sector = sector;
diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 13004beb48ca..584ac0519c3e 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -84,6 +84,9 @@ static bool g_virt_boundary = false;
 module_param_named(virt_boundary, g_virt_boundary, bool, 0444);
 MODULE_PARM_DESC(virt_boundary, "Require a virtual boundary for the device. Default: False");

+static bool g_write_zeroes = false;
+module_param_named(write_zeroes, g_write_zeroes, bool, 0444);
+
 static int g_no_sched;
 module_param_named(no_sched, g_no_sched, int, 0444);
 MODULE_PARM_DESC(no_sched, "No io scheduler");
@@ -1755,25 +1758,12 @@ static void null_del_dev(struct nullb *nullb)

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
+ modprobe -r null_blk
+ modprobe null_blk
+ blkdiscard -o 0 -l 40960 /dev/nullb0
+ dmesg -c
[  261.219011] null_blk: module loaded
*[  261.232872] __blkdev_issue_discard 82 sector 0 nr_sects 80*
+ blkdiscard -z -o 0 -l 40960 /dev/nullb0
+ dmesg -c
*[  261.245818] __blkdev_issue_zero_pages 289 sector 0 nr_sects 80*
+ modprobe -r null_blk
+ modprobe null_blk write_zeroes=1
+ blkdiscard -z -o 0 -l 40960 /dev/nullb0
+ dmesg -c
[  261.328251] null_blk: module loaded
*[  261.337313] __blkdev_issue_write_zeroes 242 sector 0 nr_sects 80*
+ modprobe -r null_blk
+ set +x

-- 
2.29.0

