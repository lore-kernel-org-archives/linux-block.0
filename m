Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B527C77B61
	for <linux-block@archiver.kernel.org>; Thu, 13 Apr 2023 09:14:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbjDMJOq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Apr 2023 05:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbjDMJOp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Apr 2023 05:14:45 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E384410FC
        for <linux-block@vger.kernel.org>; Thu, 13 Apr 2023 02:14:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LVKMj/JDBXqSgrNFxHTGmY15Y/4iwLui47/6mTnU3DaJ9urjkYkm1zsUhAYUyu4h0SekaL0BnPGc66Cene2GAEDeWog8+NO2FoRWIIhq1nUQVEtL9kzZIbpq7TpzawgSDRVIgshagX8Rca2keoDpOnQACX9JE0Sc6858aNwr40qbU8AOude9f9BMg3GwMRk/SVh71Z2HsHri1CsJ01ITcsEOs5yu9D2lhHSpU1rS+zORS9SqqEDZy4lRlh12zjFvB2a08cB9sJMsjaP0wJAeCPfEN2AzdxKGSjGR2s+KSKaItrhU4Yq3uK1aZqRBP2ZSg4zwNDXQz7sT06w9J46klg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tvqK8Amc56Q/7pIav4PO+H4pIJvo2fEp4SEdKW8o8iA=;
 b=HVbSKiKpZLjE/VB87c2dbSP61XEujd/2tMdC4LloXYYSFnZNpCKV0NShohT3QRAUyrSSjgQPwriw7EMlch1Aso90d/RXYmoDt+SlAjbz8brw8GDsHFwMj+b4PxQcL1JAuEElNetCHdRW25/aBThyJ+McveAqWTEZB3M4bGVkopt3PMJzKcHAbMCvfcr1PsqD/IUtwuG4xJVRuu63gxB+etd53G/j+GLQ7U591+nYyAYoEvd+RUkgl0jDAAPubEVLUnikn7Bi/CpLaF/tfO0WZFGkBKic7gOUBCe7njNX7NqIffMsYSwBAWk1FOhyobzfnG7+0XroKX/iSLSUpIq13A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tvqK8Amc56Q/7pIav4PO+H4pIJvo2fEp4SEdKW8o8iA=;
 b=G48qv9REGXjsS09NPG32uyyONNy6rrwG9qDcBxQL05jL82dEGqHbVH9qb+x+m/u/CpL2zDURQrc1KlPiCmO1lv4fy6b4X9WzkgMrJ0KrLOyVoZ0PGOIiEu97TUcnVqfledeodUZR9TuEVY5xSmdGIm4rS8Iq90bv75EnUyIvHgGDlaKHm+jhL60dRh+b7bxukR7twepk7z04Fb2iio0RHUb5BIU8Y6KySZ8+q57IoMWunOIp5nbTBSJEG4poyM7YFJbe3ikLHx+LL7G74BPQcBd1VSU4PkymJb1bViRSKKn/1P/jAUK2CUmVe1h5Ha5nPJ8DKtU5u+WAyj6EimG7jg==
Received: from BN8PR16CA0016.namprd16.prod.outlook.com (2603:10b6:408:4c::29)
 by CY8PR12MB7098.namprd12.prod.outlook.com (2603:10b6:930:62::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Thu, 13 Apr
 2023 09:14:42 +0000
Received: from BN8NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:4c:cafe::1e) by BN8PR16CA0016.outlook.office365.com
 (2603:10b6:408:4c::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.33 via Frontend
 Transport; Thu, 13 Apr 2023 09:14:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT020.mail.protection.outlook.com (10.13.176.223) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6298.32 via Frontend Transport; Thu, 13 Apr 2023 09:14:41 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 13 Apr 2023
 02:14:29 -0700
Received: from dev.nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 13 Apr
 2023 02:14:28 -0700
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-block@vger.kernel.org>
CC:     <axboe@kernel.dk>, <hch@lst.de>, <sagi@grimberg.me>,
        <kbusch@kernel.org>, <linux-nvme@lists.infradead.org>,
        Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH] block: fix Oops in blk_rq_poll_completion()
Date:   Thu, 13 Apr 2023 02:14:19 -0700
Message-ID: <20230413091419.6124-1-kch@nvidia.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT020:EE_|CY8PR12MB7098:EE_
X-MS-Office365-Filtering-Correlation-Id: eb5395bb-7704-4879-1fe6-08db3bff83ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UfjfaH3UqOt34704Zdo6Mg7qlLH3xNIRdLUIf9BvbqgBRhFGmU0DlkzQrunMFBqhA3B8V9cW3d6hMI7at0BdIE1irb3WxaeQ5B6v2gsxLqRuxtC9C1sXDI0W2EcVQRucLQmubJefEZwJCIR+soAMZ4pKgiiLLnMHrWREhZ9yncKcA15wgYuNSheur5lzFq+TmaiEMv4DAPLI9rkg054RHS0Cg9MLDbDFkOSF333LhA9QR806M6IEM95fpuMIjQRA94zRFutoSESxuerSINc4w8VQL6BTKXaPLjorbq2lDxHLMC11ZizZ0PxzznlO6IesqZzsFaspKECzGT3tKSdU4EhCC4bZfkAEpg4c9Ra9ChmUqRuoirChyUqG1AqPMMBZUI94UgqyoxoY97zwHHW/nRNERMDTXhZa77jXPHBRFioV2kGMk234ez4+KgaV7tsW6Ccv+LJ5RlIyuuQ6QhNHvkMBVM5DfY29HQajBrY+6YlzXrA66gwZMPznzdT9NQ1T5SYP/xohPZH/+37fCKfHS1MuA4aeJ1x6jq9KVIPysQsUKDmcZUZH9ZlDuzPouc3MVUnDZnT6R8VI/nIh30+j4t0Jxh73p3VVi4WQcXwA7twmKoXgnfgCi5qXgXfbNs6EpJLD8uIpKR3iwMND0jDyoGyv7B/+K6FvhV7FTbk5gQJSTbidb7JjpA/HfEEi5EfOVRCljnUP4gSRvIBxTTYWRE4YjFqxCCn7FNkW9Kw/Gw/FC3CheoFAYwn/omfnisghK90AdHr1pewjh0IfTJ93eJsQvIWUvbVWkILCjkUGQLA=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(136003)(39860400002)(376002)(451199021)(46966006)(36840700001)(40470700004)(2906002)(8676002)(70206006)(70586007)(8936002)(5660300002)(478600001)(6666004)(41300700001)(40460700003)(316002)(36756003)(82740400003)(336012)(426003)(83380400001)(54906003)(40480700001)(4326008)(186003)(6916009)(7696005)(16526019)(1076003)(26005)(2616005)(36860700001)(82310400005)(107886003)(34020700004)(7636003)(356005)(47076005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2023 09:14:41.5049
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb5395bb-7704-4879-1fe6-08db3bff83ce
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7098
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add a NULL check before we poll on req->bio in blk_rq_poll_completion().
Without this patch blktests/nvme/047 fails :-

* Debug-diff:-

linux-block (for-next) # git diff
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 1b304f66f4e8..31473f55b374 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1335,6 +1335,8 @@ EXPORT_SYMBOL_GPL(blk_rq_is_poll);
 static void blk_rq_poll_completion(struct request *rq, struct completion *wait)
 {
        do {
+               if (!rq->bio)
+                       BUG_ON(1);
                bio_poll(rq->bio, NULL, 0);
                cond_resched();
        } while (!completion_done(wait));

* Terminal:-

linux-block (for-next) # cdblktests
blktests (master) # nvme_trtype=tcp ./check nvme/047
nvme/047 (test different queue types for fabric transports)
client_loop: send disconnect: Broken pipe

* Oops:-

[   42.354149] kernel BUG at block/blk-mq.c:1339! <------

Entering kdb (current=0xffff88814c70a840, pid 2460) on processor 21 Oops: (null)
due to oops @ 0xffffffff816ee9cf
CPU: 21 PID: 2460 Comm: nvme Tainted: G                 N 6.3.0-rc5lblk+ #5
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
RIP: 0010:blk_execute_rq+0x11f/0x1c0
Code: ff 0f 84 ad 00 00 00 31 d2 31 f6 e8 8b 4c ff ff e8 46 27 74 00 48 89 ef e8 1e 80 a6 ff 84 c0 75 b3 48 8b 7b 38 48 85 ff 75 dd <0f> 0b 0f 0b 48 c7 83 f0 00 00 00 50 bd 6e 81 48 89 e5 48 89 ab f8
RSP: 0018:ffffc9000172fbc8 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff88814d910000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc9000172fbc8 R08: 00000009dc7ed61b R09: 0000000000000001
R10: ffff888166c36c78 R11: 0000000000000000 R12: 0000000000000001
R13: ffff88810a06d000 R14: 0000000000000400 R15: ffffc9000172fc68
FS:  00007f59b5d35b80(0000) GS:ffff8897df740000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f59b5e78d50 CR3: 000000010a9f2000 CR4: 0000000000350ee0
DR0: ffffffff8437a434 DR1: ffffffff8437a435 DR2: ffffffff8437a436
DR3: ffffffff8437a437 DR6: 00000000ffff0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __nvme_submit_sync_cmd+0xa6/0x170 [nvme_core]
 nvmf_connect_io_queue+0x11c/0x220 [nvme_fabrics]
 ? nvme_tcp_start_queue+0x12e/0x1a0 [nvme_tcp]
 ? __local_bh_enable_ip+0x37/0x90
 nvme_tcp_start_queue+0x12e/0x1a0 [nvme_tcp]
 nvme_tcp_setup_ctrl+0x439/0x800 [nvme_tcp]
 nvme_tcp_create_ctrl+0x34b/0x450 [nvme_tcp]
 nvmf_dev_write+0x5db/0xe80 [nvme_fabrics]
 ? inode_security+0x22/0x60
 ? selinux_file_permission+0x108/0x150
 vfs_write+0xc5/0x3c0
 ? _raw_spin_unlock+0x15/0x30
 ? preempt_count_add+0x4d/0xa0
 ? fd_install+0x5c/0xe0
 ksys_write+0x5f/0xe0
 do_syscall_64+0x3b/0x90
 entry_SYSCALL_64_after_hwframe+0x72/0xdc
RIP: 0033:0x7f59b5e4b7a7
Code: 0d 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 48 89 54 24 18 48 89 74 24
RSP: 002b:00007fff145e5938 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000001bbad00 RCX: 00007f59b5e4b7a7
RDX: 00000000000000b9 RSI: 0000000001bbad00 RDI: 0000000000000004
RBP: 0000000000000004 R08: 00000000000000b9 R09: 0000000001bbad00
R10: 00007f59b5d6f118 R11: 0000000000000246 R12: 0000000001bb97e0
R13: 00000000000000b9 R14: 00007f59b5f7811d R15: 00007f59b5f7802b
 </TASK>

[21]kdb>

Please note that this fix is generated purely based on tracing I/O path
with BUG_ON().

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 block/blk-mq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 1b304f66f4e8..9cd5e890c9c9 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1335,7 +1335,8 @@ EXPORT_SYMBOL_GPL(blk_rq_is_poll);
 static void blk_rq_poll_completion(struct request *rq, struct completion *wait)
 {
 	do {
-		bio_poll(rq->bio, NULL, 0);
+		if (rq->bio)
+			bio_poll(rq->bio, NULL, 0);
 		cond_resched();
 	} while (!completion_done(wait));
 }
-- 
2.40.0

