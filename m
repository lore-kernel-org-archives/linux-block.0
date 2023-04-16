Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB0F6C77B73
	for <linux-block@archiver.kernel.org>; Sun, 16 Apr 2023 22:04:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbjDPWEB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 16 Apr 2023 18:04:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjDPWEA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 16 Apr 2023 18:04:00 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04hn2206.outbound.protection.outlook.com [52.100.163.206])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A5DD2123
        for <linux-block@vger.kernel.org>; Sun, 16 Apr 2023 15:03:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mEjDD36kWJTrhTpoUihxWuOGiWX/BbSikDxLrtD61z7XW5lI/HGV9n62xB1vRX9pSWeEuwX0CMefqIJF8jC9PxVuvrOYTrfx/ElMm2FYwe5HkWKCSe8pJGRqpG9FD7dycshlxamgHMWgVRTDDzKfhrNnrz6fOe0ecDtpSpMd1Fdw/bjSOJbgok1LT76oT8XCKBILQQwSrhBk87WHRKMXzlQoFvJv2RQr7K0OGYB0D/MbYyUf4O3DRSyVYxd1GWRcgohPEFE0AVAkaLDQwIcRz7v2mPRAHfp0Vc1cHYCE+gMwenteJhued+O9Z777x5YGYHuG5s4Nq9lhysyLgJivrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=52iypZSuAIBJNkk3Cbw4UEAsqYZZozRc462e/OcgAas=;
 b=S3BRBC1grlZxyt8O2p6xKQNIJ0PPr3Wng2IpoAjDxmgykzM3U0FPjpUMwdYhv74+gCSFh1GT/QAd29imR6ph8KDILFHTPw2aPhqsvSdtEP0wOTCv2BIzYaNNX+6+aiKRK1qC8rydLYy/BGdSN443Stp1aiyjj5F+Zjyn2IDJd0GjppUWdihHAH/UbSorST8vwUfS6FXFnExr8sfUBI1wpLnhBEiSusvNy51MVMAEI0fYcackY7FivSCKhw8jFC0ACToXej+kYwt71pPoQ55ZIos9QAqAq/1deqaGUVV0mUUa7Efko7orEdqVP9kTSYmcveXkVpIWlTYrUef+JtRa3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=52iypZSuAIBJNkk3Cbw4UEAsqYZZozRc462e/OcgAas=;
 b=najg5mhsTg2DuSJCHx89RByiVjVgZiYzSse16PAUfGQQmEg/bWxrnM7HMZN2DVtAuOlMJemiKfBUYN4YufsJERbaTeNRDGoMibV8TYrc54ugWJBMl2tW2zagQtJdO9BFlErwYAuHDFwsKEcnIiPLUmoDyGyxy+GnAr0s2NFNUI4jTx9FUThw6aBimUNnYXmnkCdFNZrmakVGWI9fgcGJOaN6GC867/ut/abX+r0O6v1AKO0oLhVqIAH94RiXm70wGNGKfuHExZBrXyDUdvodqLeKzj4jL3MW1dr3MHcRKAxOBSJGWRZk46/zp2ogjuFudEWJR4FpRMkNvtjG46K41Q==
Received: from DS7PR03CA0100.namprd03.prod.outlook.com (2603:10b6:5:3b7::15)
 by CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Sun, 16 Apr
 2023 22:03:56 +0000
Received: from DM6NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b7:cafe::4c) by DS7PR03CA0100.outlook.office365.com
 (2603:10b6:5:3b7::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45 via Frontend
 Transport; Sun, 16 Apr 2023 22:03:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT023.mail.protection.outlook.com (10.13.173.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6319.19 via Frontend Transport; Sun, 16 Apr 2023 22:03:56 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Sun, 16 Apr 2023
 15:03:52 -0700
Received: from dev.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Sun, 16 Apr
 2023 15:03:51 -0700
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-block@vger.kernel.org>
CC:     <johannes.thumshirn@wdc.com>, <bvanassche@acm.org>,
        <axboe@kernel.dk>, <vincent.fu@samsung.com>,
        <akinobu.mita@gmail.com>, <dlemoal@kernel.org>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Ming Lei <ming.lei@redhat.com>,
        "Nitesh Shetty" <nj.shetty@samsung.com>
Subject: [PATCH V2] null_blk: Always check queue mode setting from configfs
Date:   Sun, 16 Apr 2023 15:03:39 -0700
Message-ID: <20230416220339.43845-1-kch@nvidia.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT023:EE_|CH3PR12MB7763:EE_
X-MS-Office365-Filtering-Correlation-Id: 03cf1e57-0b3b-4161-db21-08db3ec67959
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nNyOtIkaWW+h0w8G7r2+CIJYbq1RE6TGX+Fy3GqnZ6USFjp27Q6rKOA8Gpo1azWq520eh62/urH7zGR2kByv+QSPaO+NU4Ozie80nB+31tKMuFuf5wZ8VQSclrOh5rsG/Rk8uqxlG9QHf6zylLBMGq1DaALqSRftYCZclyAxL38BC9X0NpDASwQJ4rtinmFNr3PyI/iu9DZT5OXiIw6HXFX/qBOsBaLELssMmGcrBsYbFWgU0X2355oco0STIKNvjZF1Dws01my6zwNBq5FbJxKKluqO0Ibrc1UJcF5v3BwgwmxOQssAfQisN5Q7zOkcqKfQa33pSl89DQfiQMg+tLPDWt1XcSPIwYLIY4RoryGhMJJ3UP147JugBkek0DF9pV/Kf13tQgjPXHv+fuLTI1ngrvVRH4T+uhF/gh8dHPpjOL4PK9d6J5SDe55uzZbDY7Wv1pO8Kzmf+9Cwzj4brZ1sCz4GBE4185cL32+anWBP6LRGc1THrEfUI0hljlOmXiD6Gln2EtL01haAKWpkjLzPWvfad2xCbjuz3rKJmIUgld9OkKpozS+28oS8t80fMkbP4hFtMEbkO1BdDsG+pv+ws0+FwmaiULFSuEeKgva0Tgi6S/OclmAWlTZ7EWNVVvf6IFoVnTN84A+GUqYw17qMgUI0J3AcTc15N+EZcB9KRMtL7Ac7iLsDOgUqALSWo4EdjjDWAH70X52T9uPfVGstbeQ4WnhFjDYQCxTm6M2ToFKPEMAe8xcHFYxKODDCR9JgP1bWB350ANJ8L1aTx/6XZI3dvk097BpN1PV2ROp9n4GpaLE2fa0poAmAUgfG
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(396003)(39860400002)(451199021)(5400799015)(40470700004)(36840700001)(46966006)(40460700003)(316002)(16526019)(186003)(7696005)(1076003)(6666004)(26005)(47076005)(36860700001)(34020700004)(356005)(82310400005)(2616005)(7636003)(426003)(82740400003)(83380400001)(36756003)(40480700001)(6916009)(4326008)(54906003)(41300700001)(336012)(8936002)(8676002)(70586007)(70206006)(5660300002)(2906002)(478600001)(12100799027);DIR:OUT;SFP:1501;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2023 22:03:56.1873
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03cf1e57-0b3b-4161-db21-08db3ec67959
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7763
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Make sure to check device queue mode in the null_validate_conf() and
return error for NULL_Q_RQ as we don't allow legacy I/O path, without
this patch we get OOPs when queue mode is set to 1 from configfs,
following are repro steps :-

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
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Reviewed-by: Nitesh Shetty <nj.shetty@samsung.com>
---
 drivers/block/null_blk/main.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 5d54834d8690..b195b8b9fe32 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -2000,6 +2000,11 @@ static int null_init_tag_set(struct nullb *nullb, struct blk_mq_tag_set *set)
 
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
2.40.0

