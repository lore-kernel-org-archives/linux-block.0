Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 364DDC6FD1D
	for <linux-block@archiver.kernel.org>; Thu, 30 Mar 2023 05:53:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbjC3FxL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 Mar 2023 01:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjC3FxK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Mar 2023 01:53:10 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2081.outbound.protection.outlook.com [40.107.100.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47662110
        for <linux-block@vger.kernel.org>; Wed, 29 Mar 2023 22:53:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h1174KVsEXGoNXGcId5n5OVt7VCqa0XbW8YK7zJvoqvySqSiqAnpD0qk+K3qJ4XWxTkzUAdya/Updh40dgcW0oCVZ2wY/SCQpEua42LMLrWIGGL6tmqmGbMMDpevcM9NjfJE5VuVCKT+US3cgOYdz97a2bblHBc+t4xIyUZ2DmfEuTBiE6VrWf6K/Z8QNuLmBnmR1EoEutdOY1S9JgF4C4oTQMzhMdgQ5+AgEpsmegLSKvCnfvNlUEgXOPFJWGP8XgAZx9GWcqok5mFpxP41U72zRKZNp2DPpywB3+IlyA8BsZngMjqWpxMVIn/1xndCuQEz3b3iliKTUKZj9VWMuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UpKfaU4aUwE561jEP5Yxy99XU3TX9SXG0DMD6WEFJSE=;
 b=S0NtOLVlxBJgGquid/SKZ7fVw4oih8BhZBt/KLheb31jk4tAKyzLst2c3DMw+C8Azgur2RDS3O9mO8RLGWFFoGIld7M5GWxhbbmcmIU2/f5OrPHQJvSW0SF+tm4r4w+D2knUS3GYFswe3C4KMSB29oP+ZkD/4nLTY6L8lBPY83/mGd/FMLTF3piGqz7S4VRKydUMfqAfk5qoalFRjJShSrmcCsM9VrkgS/rMa1aZBJhz0wA7Eo6PP15oBHKoYxYq6W68xuuM34Qu7/pYcU+emAfweEg10JeOf0LXs5iMl3d3tRoLUPw2H568WfJqysECVcdax4c2xyWId+dhVqRLQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UpKfaU4aUwE561jEP5Yxy99XU3TX9SXG0DMD6WEFJSE=;
 b=Qt5KMzqFM4Lw2bnM2gMrQLSJ5TpmuvOfnI2+V7pqigHld4D1B1ctAomUvXHW6EbcAUKDUyG4ZiAfMJkNrO6yg/jkqHhF3TmSW1HBwQWcPfNjgd1860SRAX6fyVegsfrlsqDGn8F39TDFFjuRYMXqERpjrIQHeT7R/7iCT/+v37Z2fpcgfkDTybIEFrrSAiw1C7BrCVKuwUjQD/gFBtFFcXVuJ5I7OBSus/F/d8PHbaGqjFYz40sloc4gQm+Xm0et+kArcrrXKSBOxqczFXImwzctnI1DkiEn6mNj9h1vMC5RWw2I9x5F7w9vepP0R8tvUzl85eJ4jarybrLEn8saxQ==
Received: from BN9P223CA0007.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::12)
 by BL1PR12MB5350.namprd12.prod.outlook.com (2603:10b6:208:31d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Thu, 30 Mar
 2023 05:53:07 +0000
Received: from BL02EPF00010207.namprd05.prod.outlook.com
 (2603:10b6:408:10b:cafe::10) by BN9P223CA0007.outlook.office365.com
 (2603:10b6:408:10b::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.22 via Frontend
 Transport; Thu, 30 Mar 2023 05:53:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF00010207.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.30 via Frontend Transport; Thu, 30 Mar 2023 05:53:07 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 29 Mar 2023
 22:52:45 -0700
Received: from dev.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 29 Mar
 2023 22:52:45 -0700
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-block@vger.kernel.org>
CC:     <axboe@kernel.dk>, <kch@nvidia.com>,
        <damien.lemoal@opensource.wdc.com>, <johannes.thumshirn@wdc.com>,
        <ming.lei@redhat.com>, <bvanassche@acm.org>,
        <shinichiro.kawasaki@wdc.com>, <vincent.fu@samsung.com>
Subject: [PATCH 3/9] null_blk: check for valid poll_queue value
Date:   Wed, 29 Mar 2023 22:51:57 -0700
Message-ID: <20230330055203.43064-4-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20230330055203.43064-1-kch@nvidia.com>
References: <20230330055203.43064-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00010207:EE_|BL1PR12MB5350:EE_
X-MS-Office365-Filtering-Correlation-Id: dd18c635-f8a6-4d63-4c78-08db30e30923
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CTcJRpvmWHe1ajc2duI3d20Fj19S7c1hMhi11ujYLUGWmvK1Ec4Enx3BAcp5GEHb9oQLT5IklBCNXU7EsvI6GfQ5bwEV6yabGg2KwhTQK0hZgR8oClGgJWw44Mx/ByhFw79WQWPRE+xQuqVToZwCvlYRtCGmlUmJ4I/VojrAqSM4mUIEl526t+3yzOdqsNXEhFwTe+PK34rUqkg5C3UbyodY4JiXk6W9iWfhtVxqjKcgUdzI9oIun908BtvJSnCJpdwF5WcHM4hzNDaLGEVjIdlzrcgz/Xu9/W+B6KZ+NCmJ8LKpmYhrqguJpO1vXt3PCK/4kdkkbZTRHtMlLE9Mrb9zRf6uNRnnbMBjvGE8KVoA9GMRtAhdWtuvysokonOF+/JIajEr2clrUlhdVFWaF4sEmxU1FLo/4AbY07kJfNx2qozI4xQj7e60//+frvkB/etCqEXLj4svuR3cmV6hgy5xFZRDXtTW72yZwMTyK/zvDzZMOD8rWGBtRVRf8Ist6DGCZ9TavRn0vKeGcMhQYZis4lae+vC7Ha1zCnQx7OJrcmixRbWlikefYugU0iV7ukIdm5A4zDc1amR2x4j8jXaz7zO9TfgBldkVf26LjvPX6U7NdZ1J9ulLPwCjohn52pRh1QHC8dL11Fvwe5sgN++pjJcWGn6dXgeKNrhfMnMIf58Q+Xe4KC/5Bd1ntyVwsJNj6jqpqUHaPhPxZtwKoesIk7/f57pgv5XyunLCq500/TOKHvWjjR6P/RHYRBQGK23PyEECbKb2JC5pCEYP3Q==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(376002)(136003)(346002)(451199021)(36840700001)(46966006)(40470700004)(41300700001)(16526019)(40460700003)(40480700001)(83380400001)(356005)(5660300002)(54906003)(478600001)(7696005)(336012)(426003)(2906002)(82740400003)(47076005)(7636003)(36860700001)(6916009)(8676002)(4326008)(2616005)(70206006)(186003)(70586007)(36756003)(6666004)(82310400005)(8936002)(316002)(26005)(1076003)(473944003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 05:53:07.0043
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd18c635-f8a6-4d63-4c78-08db30e30923
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00010207.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5350
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Right now we don't check for valid module parameter value for
poll_queue, that allows user to set negative values.

Add a callback to error out when poll_queue value is set < 1 before
module is loaded.

This fixes following message with invalid poll_queues value set more
than num_online_cpus():

$echo $(nproc)
48
$ for i in `seq 45 49`; do
          modprobe -r null_blk
          modprobe null_blk poll_queues=$i
          echo "poll_queues = $i"
          dmesg -c
  done
poll_queues = 45
 blk_queue_max_hw_sectors: set to minimum 8
 null_blk: disk nullb0 created
 null_blk: module loaded
 blk_queue_max_hw_sectors: set to minimum 8
 null_blk: disk nullb0 created
 null_blk: module loaded
46
 blk_queue_max_hw_sectors: set to minimum 8
 null_blk: disk nullb0 created
 null_blk: module loaded
47
 blk_queue_max_hw_sectors: set to minimum 8
 null_blk: disk nullb0 created
 null_blk: module loaded
48
 blk_queue_max_hw_sectors: set to minimum 8
 null_blk: disk nullb0 created
 null_blk: module loaded
49
 ------------[ cut here ]------------
 WARNING: CPU: 23 PID: 36379 at lib/group_cpus.c:400 group_cpus_evenly+0x26e/0x280
 CPU: 23 PID: 36379 Comm: modprobe Tainted: G        W  O     N 6.3.0-rc1lblk+ #2
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
 RIP: 0010:group_cpus_evenly+0x26e/0x280
 Code: b1 ff 48 8b 7c 24 08 e8 20 d1 5d 00 48 8b 3c 24 e8 17 d1 5d 00 45 85 ed 0f 89 01 fe ff ff e9 f1 fd ff ff e8 b4 9d 8d ff eb ac <0f> 0b eb a8 e8 39 c4 60 00 41 bd f4 ff ff ff eb 9b cc 90 90 90 90
 RSP: 0018:ffffc90000723cb8 EFLAGS: 00010297
 RAX: 0000000080000000 RBX: 0000000000000031 RCX: 0000000000000000
 RDX: 0000000000000001 RSI: 0000000000000030 RDI: 00000000ffffffff
 RBP: ffff88884b2204f0 R08: ffff88884b220bd8 R09: ffff8888c31f0000
 R10: ffff88884b220bd8 R11: 0000000000000000 R12: ffff8888c31f0000
 R13: 0000000000000000 R14: 0000000000000030 R15: 0000000000000000
 FS:  00007f5ff6be8b80(0000) GS:ffff888fff7c0000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 00007f5ff6706800 CR3: 0000000849554000 CR4: 0000000000350ee0
 DR0: ffffffff843793e0 DR1: ffffffff843793e1 DR2: ffffffff843793e2
 DR3: ffffffff843793e3 DR6: 00000000ffff0ff0 DR7: 0000000000000600
 Call Trace:
  <TASK>
  blk_mq_map_queues+0x16/0xc0
  null_map_queues+0xa5/0xe0 [null_blk]
  blk_mq_alloc_tag_set+0x14d/0x3f0
  ? __kmalloc+0xbc/0x130
  null_add_dev.part.0+0x601/0x700 [null_blk]
  null_init+0x109/0xff0 [null_blk]
  ? __pfx_init_module+0x10/0x10 [null_blk]
  do_one_initcall+0x44/0x220
  ? kmalloc_trace+0x25/0x90
  do_init_module+0x4c/0x210
  __do_sys_finit_module+0xb4/0x130
  do_syscall_64+0x3b/0x90
  entry_SYSCALL_64_after_hwframe+0x72/0xdc
 RIP: 0033:0x7f5ff672c15d
 Code: c5 0c 00 0f 05 eb a9 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d e3 7c 0c 00 f7 d8 64 89 01 48
 RSP: 002b:00007ffd32ca3148 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
 RAX: ffffffffffffffda RBX: 000056096285db90 RCX: 00007f5ff672c15d
 RDX: 0000000000000000 RSI: 000056096285df00 RDI: 0000000000000003
 RBP: 0000000000040000 R08: 0000000000000000 R09: 0000000000000020
 R10: 0000000000000003 R11: 0000000000000246 R12: 000056096285df00
 R13: 000056096285dcc0 R14: 000056096285db90 R15: 000056096285df20
  </TASK>
 ---[ end trace 0000000000000000 ]---
 blk_queue_max_hw_sectors: set to minimum 8
 null_blk: disk nullb0 created
 null_blk: module loaded

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/block/null_blk/main.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 9e3df92d0b98..2d24c34ec172 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -114,8 +114,18 @@ static int g_submit_queues = 1;
 device_param_cb(submit_queues, &null_submit_queues_param_ops, &g_submit_queues, 0444);
 MODULE_PARM_DESC(submit_queues, "Number of submission queues");
 
+static int null_set_poll_queues(const char *s, const struct kernel_param *kp)
+{
+	return null_param_store_int(s, kp->arg, 1, num_online_cpus());
+}
+
+static const struct kernel_param_ops null_poll_queues_param_ops = {
+	.set	= null_set_poll_queues,
+	.get	= param_get_int,
+};
+
 static int g_poll_queues = 1;
-module_param_named(poll_queues, g_poll_queues, int, 0444);
+device_param_cb(poll_queues, &null_poll_queues_param_ops, &g_poll_queues, 0444);
 MODULE_PARM_DESC(poll_queues, "Number of IOPOLL submission queues");
 
 static int g_home_node = NUMA_NO_NODE;
-- 
2.29.0

