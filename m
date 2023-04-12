Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B60FC77B6E
	for <linux-block@archiver.kernel.org>; Wed, 12 Apr 2023 04:09:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbjDLEJi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Apr 2023 00:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjDLEJf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Apr 2023 00:09:35 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10hn2239.outbound.protection.outlook.com [52.100.155.239])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E57145257
        for <linux-block@vger.kernel.org>; Tue, 11 Apr 2023 21:08:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=coKY5alv6Tid1qVGsnTDB+fGpdDDsZXjmW4wfJY2eSObcvvdRZkjnpQOQ+yrFTfzjtT0n2eg+S3Pyc/uuBajYlrL+5DSfQ0jN/yRG0Is07d/51ru/U4K1XIeO9+Z+7XN9q0n10rBbs7n+lpECQ5nvg0o59HasBYGvGFXzgtgV3dAuMHRq/nIpS2s1KyKVhqEXHr3jQTkKHMEWMtoeIv6vllL5Cbpm/JF+r08PXfDaFWbyjZpC+kCQ5gOICGr+hLRNEDmsUflJZwTDOa2u7zhrmpg24q+9Sg8LE/w7Q1chcF2o9r7r0N/mfRdwSCtb8jUbp81BT0e1OJ3Q9+DhIVFzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HXB5b+2SbzokrAeYsv3ISOffaV7n9v9SlEJKq2GbMgw=;
 b=WJlzglXrsch/cwWCntiow0dawiDGOCaqGZpYp6BqnheXlUaf7+616j+CLFT/DI5Yv2bQVfD4hTIS+q99tRcAY0OMy491a9tmniYgeIn/v1YgZiuvuyh+lh2DZgUGmR4GZHLAafSTXQeHZGNNQriid1dw9tRSNVgScvHbaSvmpX6OEUw8b8V0RgrM7tF0rblGXSy69uYtMkaKdJRFmyZ8jwNgbqs67vhXY6jWb0R27Gd/t5DGHzqleJ3y825DX/4nvsPgHuJwTmbzYolHHA1fuV2K2iqnk9vu+2lUmR+nfuwvOKrOfbzH0Qx/EtinutHF5Z8i5me1Fs5Mjn8BnTbyVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HXB5b+2SbzokrAeYsv3ISOffaV7n9v9SlEJKq2GbMgw=;
 b=KTsx8HoLqk6eeD++eARLMV5CVcnHQLIG3XinbjUuaLyfaIletIP1MxPu3ETsdsBkDj+uHY5gcWJg1jNSi4KOaoRteUfhgHxM5L28U9kV2pZtx/RKb0KhfJy1NW8cose32iWMcAaJDfF5oL9/t2pg2ij6AIHgHLeGKLwppetNsYVCL8Qz03tTH1BaIB4XRS23uFPcXsVdBADjy4LwxHNBNZ4bQfU9CAVSvd+0qTd+IHbauqKLfPRjHjkSEs5euDwin5YylBYK/GzEAcr9CuIVkt4HRHYG+CjXife3DLtXo2V/BhTsydUdaZUskbrJlurM4lCUPTOROwplpznaLo1X4A==
Received: from DM6PR06CA0062.namprd06.prod.outlook.com (2603:10b6:5:54::39) by
 BL1PR12MB5779.namprd12.prod.outlook.com (2603:10b6:208:392::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6277.38; Wed, 12 Apr 2023 04:08:48 +0000
Received: from DM6NAM11FT109.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:54:cafe::61) by DM6PR06CA0062.outlook.office365.com
 (2603:10b6:5:54::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38 via Frontend
 Transport; Wed, 12 Apr 2023 04:08:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT109.mail.protection.outlook.com (10.13.173.178) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6298.29 via Frontend Transport; Wed, 12 Apr 2023 04:08:47 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 11 Apr 2023
 21:08:36 -0700
Received: from dev.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 11 Apr
 2023 21:08:35 -0700
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-block@vger.kernel.org>
CC:     <axboe@kernel.dk>, <dlemoal@kernel.org>, <kch@nvidia.com>,
        <johannes.thumshirn@wdc.com>, <bvanassche@acm.org>,
        <vincent.fu@samsung.com>, <shinichiro.kawasaki@wdc.com>,
        <error27@gmail.com>
Subject: [PATCH] null_blk: fix queue mode Oops for membacked
Date:   Tue, 11 Apr 2023 21:08:27 -0700
Message-ID: <20230412040827.8082-1-kch@nvidia.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT109:EE_|BL1PR12MB5779:EE_
X-MS-Office365-Filtering-Correlation-Id: 914e36c4-0b1e-408c-64cf-08db3b0b9dc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W6DVggzvR14gEkntaMMBT1XOvRh0jEMSEeYsaAWXs2X2+K8ulEhTxZ58Mqo19ivy5dDEldTNyDfJ4kjNehlGIryW5LdYytqDE7JQ9Um6tyNgyV5kLjcSJWfk9F59+vlOdrIYeGB+0FiBw9vncSnPpRyKmLr/ue22n1wi5NsSoZmM/+YCbyZC9wRbJP9d+jOGINFdOSKYR3WKzCg6DWLxkL/xWgNP7koUyVcQWNa644WmYvGtAYdFbrqDhiyyPCwe2ylBiV8AUZ7cKDowzEhnp8rvNGECgZOHRb2f6ZyefLwI/akb2u6TOUu2PKATUiaKSJKqnJVvGGhlhENaKXoQ4QgW4INE7ELoAtjDNYnIDcWG712tbFc2mmW94cpWi27iA0UfPu63u6LnucnUmmp27SIVzP/xKqcyPinxbOIInKnQs4gzx5PEbDmVv87zFl5DSkdXd8m3v8LM+j7bxa7vPZJuRzuJ5dfNCLJ1m7HAZ84O5VFFdoZenw6AVtPwu6I9g+6vJ8oLX62bSeexReIgA/AG8ZUZtsg/dQIBGFeQs0itVnBSw/vsS1AV62IwwKm5LBGzCAWFUKR4qTpS1vRmrcx7GhDlWlPqmeg03uqTsOzNeHIkc56oBImYlqpDZVoP7VBRDCRwrVJkdkHcO6nNTWrgtoWzFOZjECHSxMYF4W+gZ9tqHaYIVuw8qGbdAkTSZU8nuDOc2G/TI/pw464kxfLGxXS40G0GrpOkF0oq0VeyRUE3yp9aDuzitF8MTqdUwDb0t9CdtFW6q3RNfDBgaCvJ1BAkd13567w5mzKo0r42E5ZiA/1ZDEIVfuCtaCz9
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(396003)(376002)(136003)(5400799015)(451199021)(46966006)(40470700004)(36840700001)(478600001)(41300700001)(82310400005)(36860700001)(34070700002)(316002)(54906003)(8676002)(70586007)(70206006)(4326008)(6916009)(7696005)(8936002)(40460700003)(5660300002)(336012)(2616005)(426003)(186003)(16526019)(36756003)(7636003)(356005)(82740400003)(1076003)(26005)(83380400001)(2906002)(47076005)(6666004)(40480700001)(12100799027);DIR:OUT;SFP:1501;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2023 04:08:47.8805
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 914e36c4-0b1e-408c-64cf-08db3b0b9dc0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT109.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5779
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Make sure to check device queue mode in the null_validate_conf()
and return error for NULL_Q_RQ as we don't allow legacy I/O path,
without this patch we get OOPs when queue mode is set to 1 from
configfs, following are repro steps :-

modprobe null_blk nr_devices=0
mkdir config/nullb/nullb0
echo 1 > config/nullb/nullb0/memory_backed
echo 4096 > config/nullb/nullb0/blocksize
echo 20480 > config/nullb/nullb0/size
echo 1 > config/nullb/nullb0/queue_mode
echo 1 > config/nullb/nullb0/power

Entering kdb (current=0xffff88810acdd080, pid 2372) on processor 42 Oops: (null)
due to oops @ 0xffffffffc041c329
CPU: 42 PID: 2372 Comm: sh Tainted: G           O     N 6.3.0-rc5lblk+ #5
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
RIP: 0010:null_add_dev.part.0+0xd9/0x720 [null_blk]
Code: 01 00 00 85 d2 0f 85 a1 03 00 00 48 83 bb 08 01 00 00 00 0f 85 f7 03 00 00 80 bb 62 01 00 00 00 48 8b 75 20 0f 85 6d 02 00 00 <48> 89 6e 60 48 8b 75 20 bf 06 00 00 00 e8 f5 37 2c c1 48 8b 75 20
RSP: 0018:ffffc900052cbde0 EFLAGS: 00010246
RAX: 0000000000000001 RBX: ffff88811084d800 RCX: 0000000000000001
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff888100042e00
RBP: ffff8881053d8200 R08: ffffc900052cbd68 R09: ffff888105db2000
R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000002
R13: ffff888104765200 R14: ffff88810eec1748 R15: ffff88810eec1740
FS:  00007fd445fd1740(0000) GS:ffff8897dfc80000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000060 CR3: 0000000166a00000 CR4: 0000000000350ee0
DR0: ffffffff8437a488 DR1: ffffffff8437a489 DR2: ffffffff8437a48a
DR3: ffffffff8437a48b DR6: 00000000ffff0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 nullb_device_power_store+0xd1/0x120 [null_blk]
 configfs_write_iter+0xb4/0x120
 vfs_write+0x2ba/0x3c0
 ksys_write+0x5f/0xe0
 do_syscall_64+0x3b/0x90
 entry_SYSCALL_64_after_hwframe+0x72/0xdc
RIP: 0033:0x7fd4460c57a7
Code: 0d 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 48 89 54 24 18 48 89 74 24
RSP: 002b:00007ffd3792a4a8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007fd4460c57a7
RDX: 0000000000000002 RSI: 000055b43c02e4c0 RDI: 0000000000000001
RBP: 000055b43c02e4c0 R08: 000000000000000a R09: 00007fd44615b4e0
R10: 00007fd44615b3e0 R11: 0000000000000246 R12: 0000000000000002
R13: 00007fd446198520 R14: 0000000000000002 R15: 00007fd446198700
 </TASK>

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/block/null_blk/main.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index bc2c58724df3..2f017969b79f 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -1949,6 +1949,11 @@ static int null_init_tag_set(struct nullb *nullb, struct blk_mq_tag_set *set)
 
 static int null_validate_conf(struct nullb_device *dev)
 {
+	if (dev->queue_mode == NULL_Q_RQ) {
+		pr_err("legacy IO path is no longer available\n");
+		return -EINVAL;
+	}
+
 	dev->blocksize = round_down(dev->blocksize, 512);
 	dev->blocksize = clamp_t(unsigned int, dev->blocksize, 512, 4096);
 
-- 
2.29.0

