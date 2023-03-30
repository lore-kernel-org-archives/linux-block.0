Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2158FC761AF
	for <linux-block@archiver.kernel.org>; Thu, 30 Mar 2023 21:32:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbjC3Vcf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 Mar 2023 17:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbjC3Vce (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Mar 2023 17:32:34 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2055.outbound.protection.outlook.com [40.107.243.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E2DDC17F
        for <linux-block@vger.kernel.org>; Thu, 30 Mar 2023 14:32:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vv3Ym9Nt8TW+DiAHu35EbHyFEDryqfaNWuej/qEa3z/WvdbrUjnz8DVBvv44AgCAj6Su27DkqRWSV+1DKWX1dQTn4Aj6uxshOpWOJIro+1/iUmshgnel5RFR8qmxJbUiV27begFWGEgk22OC0/pnEl9dHYG+HJBGt01vE8a2xGcF+gO5ZBVTyF6VHI41Ge8nS2l1507RnRGdf36K96dfLC+Nnz+0fOFidN3L4MjljDnu5nW6CDDb3W0zvqCfQ2pGexVCKAOOte71oXFqQCpEKRFPjUkUdHwnrn2PXWHG2Y+w7GW/X03XYFw/ghI/J23E+1eMJbPW566zeHPBHelofg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W7aqTgXCusz2603X+GMtML6EwUJHH/9ANUdGNqbud8c=;
 b=h8APj1yBxxzHGwNsu8uBe44Ul8dVrkBEaQmMb2gEZA4NdshCpRyOjE5eS9IoXJk9g2jnJk0h+ohI+gbvq6DZUwT+QGSeX1t7i05j6prewapy3TwmdmBzupq7A9EllOc6OsyzEiIbWxOfgmtGWOk1CtSyFrhIXgjAxaS8bpC/aZsgJlK7MALkh5ZleubAYqBYcAixed/6MDsd0/j+JIL/DCI/zynkbSjYtJYN0HcUWJz9ZHdt76f4HJrxi1AsQ1I4DP/rRn1xnhOMPhIK34iwOZSSvjXwxBv/UpEAJp3KsbIjFfcM0DWgmCXGELUpG4P6kiagvzC5zYoBz7i801d9uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W7aqTgXCusz2603X+GMtML6EwUJHH/9ANUdGNqbud8c=;
 b=TvdZ+EtRGgQpZBQKh9lWDwoiH31LU9OkZTI+UtyvWJq4NaKyCBw1CxqXsmUb/7Uh+bzv2uS7XwnrRuA04eqBOiOkCjobL7CYl/NafvyxpFyDPU3k4AHX5h8K3MsG/sQOJUmjj5HYeCiPuQ0B5PUChav/kLVOpKWcOXlQwFpaICi9sWL0FiSRLpdlsuv4ZEK5KZ7OH2bz5+ReaHshK84x4/uNwSDYHfoHdycoI8v+R5A2dyMzuFPmGJMGQ5uiDRn97M/4Htv4t4vlQPyPXI2bvhe1HclnHcy6Blmxnu5qYnyLyOywsO+ksay6gVe2CIiZzkbtqIGnFl4a0OqX9eszzw==
Received: from DS7PR05CA0075.namprd05.prod.outlook.com (2603:10b6:8:57::16) by
 MW6PR12MB8734.namprd12.prod.outlook.com (2603:10b6:303:249::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.35; Thu, 30 Mar
 2023 21:32:31 +0000
Received: from DM6NAM11FT075.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:57:cafe::74) by DS7PR05CA0075.outlook.office365.com
 (2603:10b6:8:57::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.13 via Frontend
 Transport; Thu, 30 Mar 2023 21:32:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT075.mail.protection.outlook.com (10.13.173.42) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6254.23 via Frontend Transport; Thu, 30 Mar 2023 21:32:30 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 30 Mar 2023
 14:32:18 -0700
Received: from dev.nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 30 Mar
 2023 14:32:17 -0700
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-block@vger.kernel.org>
CC:     <axboe@kernel.dk>, <kch@nvidia.com>,
        <damien.lemoal@opensource.wdc.com>, <johannes.thumshirn@wdc.com>,
        <ming.lei@redhat.com>, <bvanassche@acm.org>,
        <shinichiro.kawasaki@wdc.com>, <vincent.fu@samsung.com>
Subject: [PATCH V2 3/9] null_blk: check for valid poll_queue value
Date:   Thu, 30 Mar 2023 14:31:28 -0700
Message-ID: <20230330213134.131298-4-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20230330213134.131298-1-kch@nvidia.com>
References: <20230330213134.131298-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT075:EE_|MW6PR12MB8734:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ae90318-926e-4f12-df29-08db3166449b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HuzAVLa0PKanxvMTaHHwVNzR2QJbjyTsuNWINWftBIXC6bNDv/7pQeg8p4H8Dfy0SeFk4gUlsVyKMtXS3y3qWMuLmedmxUEljJq+6QiLaAPsly4D6Sm1SlQwetNdD+ZNV6TFZPqdERAWIDO7lgoa/eVslyvMr4c9OqBbDLrxY4LR6Sx1zGh5xksaHrx4jpUgBAh0qLSO9A5pLaf5BpypvGht33RDwg7co0wPa5e+AdGChUoG/B2gUHNvbmpcf+YXJFid4UnFrdJT4xnlqHA87JWZolomiz5PKZF2WeFaUTqw8Hpt82TohCFkMa4R5LnR3dMFICIJCKZxRaKySWzESO5bhoLsZOm/QhesFQwHdothVuFDjaYcK6OP7D1UKA+U9KQUs0q0L1ELmk4xN1IF9yHATUn8/B2iferDYWo8uCPmoLtaoq1YA8RQQClP8Ck6oOS0ix+RW4vtB5r1Z7lvwephEaCN0Nue+9VnnCc550Z1ELQ6/j+J13u3Jp1dBLcxbn2EaXc5fe3pDbAAnzPLr9PnI62T0hNVUTxYtn9gz33kMKVKgt97QRT19VW2ys8JmR0W8ht0USbgjWc/+qm0e9QjQc043MHZ6y/nX/5unEDwZRqZkAtLCFHl9B/EL2vvFGLjWswW6yI/q4WlcnIFvNQzQZ17Xlh2I9sKmJJQwnAsbtRO4iUUb7n/SUEEMziXU2RCPFEibZZ+cAa/NZhOYT0rXWgC4ITOqyyazym1rdd/hzAdJyCaOMPeLBRzL511K4uhe2n0+y6FjHxNLFN9hMP4nPff752svZ230c0wC8KeC57N9rRgVrNmq/o4L/cm
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(396003)(136003)(39860400002)(451199021)(36840700001)(46966006)(40470700004)(70586007)(2616005)(83380400001)(36756003)(7636003)(5660300002)(40460700003)(8936002)(82310400005)(356005)(8676002)(40480700001)(41300700001)(82740400003)(70206006)(4326008)(47076005)(2906002)(6916009)(478600001)(426003)(34020700004)(336012)(6666004)(186003)(36860700001)(16526019)(316002)(26005)(7696005)(1076003)(54906003)(473944003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2023 21:32:30.8985
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ae90318-926e-4f12-df29-08db3166449b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT075.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8734
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
 drivers/block/null_blk/main.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 9e3df92d0b98..29bc4b5720c1 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -114,8 +114,24 @@ static int g_submit_queues = 1;
 device_param_cb(submit_queues, &null_submit_queues_param_ops, &g_submit_queues, 0444);
 MODULE_PARM_DESC(submit_queues, "Number of submission queues");
 
+static int null_set_poll_queues(const char *s, const struct kernel_param *kp)
+{
+	int ret;
+
+	ret = null_param_store_int(s, kp->arg, 1, num_online_cpus());
+	if (ret)
+		pr_err("out of bound poll_queues [1 .. %u]\n",
+		       num_online_cpus());
+	return ret;
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

