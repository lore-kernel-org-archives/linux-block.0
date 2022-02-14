Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6D76C433EF
	for <linux-block@archiver.kernel.org>; Mon, 14 Feb 2022 10:46:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348973AbiBNKqt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Feb 2022 05:46:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350459AbiBNKq3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Feb 2022 05:46:29 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2068.outbound.protection.outlook.com [40.107.96.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E0AB7168
        for <linux-block@vger.kernel.org>; Mon, 14 Feb 2022 02:09:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PHa+2YBWGdqtF2RsP8AD4/oXWcwpphviStHf+6DQsjINrISRopFO4SlI1MaD/Nl/afZOUx0IT4eEiX8Sd6TnqvRCx8ZxpbcKG13VvK7ZuyQDBeXAf+94mP8YtG0nCs+Epd+xziVd9AROM8B8Krh5ZvaY6GQAc5DFDY1s4AjZr14LUewg3nGDAsSF2oki71W9OO4hAAXXcht12DgP8I6MKh5i9PPtTdpLM5u0XgCw6sQVOqvzja5kd+yGLTbZfkLkMIItmKtoD6VaJ2UNjfRdqWX4tn5ncC2FnC79ouSSN2WGwie+LhPW5H6aFf92z4sIKn1nvedqDP0moy/W4YPHVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p/HzDxwji7dji6QuRlKGhkOA/OEn2lrDZMf29V73wso=;
 b=cPmMWHd9Uz1FvvMpmRp6TGvNyyeuoHXqEMWCLVhxqP7t8sYPZlZ+/4D8NpfApfucYr4yhyN9Q4MWBa89/W6MviuggGItaYSIeE6DfzUbJaud0oBYYuWdXW4a5ka2wk6fWIHNtbwBKDBtetvdw5zZJWGJvtW1uYHgK3TZbEiuy6x3GwHujS1lIAmjwqfJRhQ6kMe5NVeyboapBK1QLhrQmpucYK4aTEV6uc14D7UVqT5Dq3BC1F00eBGYD/BqvQ6rYi73BwdhswhNU3BGjbSLt833+Y2bwLLfMpLpTdPrMFf7CajdmmEY4roHBneGy1dmqr6lpsii3w3RKtvwx1TEyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=wdc.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p/HzDxwji7dji6QuRlKGhkOA/OEn2lrDZMf29V73wso=;
 b=dcFhwbnaUIqfj4AaljpaCXC1V0LWBSUSW0BVibyoWn5s9PxLqUkpjELHWkOM4et/5mOU5Y+vbQA8mlQMT1r6Qq7U9mEG37h2yUIgoFLlrx0cBJkQkwz0BqOVjMywzMdJQoXcdJqhukdzEwKvmJ4sVtcvEZDIxwa4rcW5V7SUrUCmrpyHZ97ZuDYvo/3knpT+MQzigdowdc1ExS7dysQ56sK33vHpVMphSEebeKio1ZrghEW1HUUwJ8czXKs5yHQpu2YH4wDeSIsmIOMy0y6Tc5iwmPvKW6y0AL4klOOffU/kWh6U9D2/WrSubzrVwXywQLBV7V8ffoR38stSxbwscA==
Received: from DM6PR07CA0093.namprd07.prod.outlook.com (2603:10b6:5:337::26)
 by BL0PR12MB2435.namprd12.prod.outlook.com (2603:10b6:207:48::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11; Mon, 14 Feb
 2022 10:09:17 +0000
Received: from DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:337:cafe::f6) by DM6PR07CA0093.outlook.office365.com
 (2603:10b6:5:337::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.11 via Frontend
 Transport; Mon, 14 Feb 2022 10:09:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 DM6NAM11FT037.mail.protection.outlook.com (10.13.172.122) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4975.11 via Frontend Transport; Mon, 14 Feb 2022 10:09:17 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 14 Feb
 2022 10:09:16 +0000
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Mon, 14 Feb 2022
 02:09:15 -0800
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-block@vger.kernel.org>
CC:     <axboe@kernel.dk>, <ming.lei@redhat.com>, <damien.lemoal@wdc.com>,
        <jiangguoqing@kylinos.cn>, <shinichiro.kawasaki@wdc.com>,
        Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 0/4] blk-lib: cleanup bdev_get_queue()
Date:   Mon, 14 Feb 2022 02:08:55 -0800
Message-ID: <20220214100859.9400-1-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0ec00dcb-2553-479f-2679-08d9efa20f7d
X-MS-TrafficTypeDiagnostic: BL0PR12MB2435:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB2435B6F707CBC692D9D3916BA3339@BL0PR12MB2435.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qonthdtQm9+zbLwInk5RjZ66cnqQhlBqLjcSW3Ap5hY3kfawFHks3cEIc84iGMRwJwaW1TVAmMfIUcwMBhX2EZGnKJgj2RqHGWp1PBe1RtYitmGMeLFdr+P2+KriDnudfYyD/SJoU1RoOukANevQMYA1Jr6RMgxOJwY3f58oEfJpxQLLiul7Zv8AQ2nZP/e+5/tJWIKQlLbgdiPs7ay0PfSJxwkN/BqQBwefG2alx69VDzF+KfHO46mCdyX+62tWCZeGmUMpC1OPi+FOs41as6RbaNZxpq92ahB4ggzgItoSiSsA3U1edj6OurSNv6Ct3bgAVoXSwrGlv/tgrwZqnY7c7p0sqRhIRActl91sPo80C0JYcAoN9fSgLVqBYZ03wO3p3QVUXaC6FaFqZ5j+1iMYAKI9fbc68IoimNrOHWVVcHlZiYiXOLUVKhdD2myjdAqLhqhrQwENDgzFb3zENEuu1D7lCDBQOBUZoAoCuBxoExuOBfQp9eFjtw9iUVXYKdIgoLaaxh+/tLZz651Wc5q8+4N0lc/C2Tnf6s6m0PWZE/Xi+wYUDEYn1RyGePbZ6tmUTi8BE7Uatn4ryG2LzVjSuKej1tjs8U2qa9/HYppmqQ6YZEpeePTQGZ4Fm95TEQf560luJt/9O8X3Ev7YfFDG3G2pp72wmZ9Lp6xdM7Z7a+og9ELIlMa5cBp7JtljDA3FwIKZaHr/2j5IxPKwAA==
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(8676002)(4326008)(7696005)(356005)(8936002)(107886003)(36860700001)(5660300002)(2616005)(81166007)(26005)(6666004)(16526019)(1076003)(47076005)(186003)(70586007)(508600001)(70206006)(54906003)(6916009)(426003)(82310400004)(336012)(40460700003)(2906002)(36756003)(83380400001)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2022 10:09:17.2142
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ec00dcb-2553-479f-2679-08d9efa20f7d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2435
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

Chaitanya Kulkarni (4):
  blk-lib: don't check bdev_get_queue() NULL check
  blk-lib: don't check bdev_get_queue() NULL check
  blk-lib: don't check bdev_get_queue() NULL check
  blk-lib: don't check bdev_get_queue() NULL check

 block/blk-lib.c | 14 --------------
 1 file changed, 14 deletions(-)

1. Execute discard (__blkdev_issue_disacrd()) and write-zeroes
   (__blkdev_issue_write_zeroes, __blkdev_issue_zero_pages())

root@dev linux-block (for-next) # sh test-discard-wz.sh 
+ modprobe -r null_blk
+ modprobe null_blk
+ blkdiscard -o 0 -l 40960 /dev/nullb0
+ dmesg -c
[ 1749.411466] null_blk: module loaded
*[ 1749.425918] __blkdev_issue_discard 82 sector 0 nr_sects 80*
+ blkdiscard -z -o 0 -l 40960 /dev/nullb0
+ dmesg -c
*[ 1749.443746] __blkdev_issue_zero_pages 289 sector 0 nr_sects 80*
+ modprobe -r null_blk
+ modprobe null_blk write_zeroes=1
+ blkdiscard -z -o 0 -l 40960 /dev/nullb0
+ dmesg -c
[ 1749.532618] null_blk: module loaded
*[ 1749.542257] __blkdev_issue_write_zeroes 242 sector 0 nr_sects 80*
+ modprobe -r null_blk
+ set +x

2. Debug patch to test disacrd and write-zeroes on the
   null_blk:
root@dev linux-block (for-next) # git diff 
diff --git a/block/blk-lib.c b/block/blk-lib.c
index fc6ea52e7482..a0e7891cae60 100644
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
 


-- 
2.29.0

