Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84474C433E0
	for <linux-block@archiver.kernel.org>; Thu, 11 Mar 2021 12:12:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 336D564EFD
	for <linux-block@archiver.kernel.org>; Thu, 11 Mar 2021 12:12:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232781AbhCKMMY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Mar 2021 07:12:24 -0500
Received: from mail-bn7nam10on2087.outbound.protection.outlook.com ([40.107.92.87]:23776
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233025AbhCKMMC (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Mar 2021 07:12:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PRw0fuAjN8gHw2y2zoS3TKETz1eu42YlQVSOVklDmoM9A3W68HzQBpdxqbIMLld7rk/h562LNyiryW92Dstr7aCC0BVk3iX7ddwUZmzKTjidC4PGzmb2MhvX61pJ8OFUC46YbxIa4Ao4TLuBEXfxKFOap6+WwJjU2HSu/BBsG/9AJ3J7D/VmF0Qbdxju+Bt1lF5f472sQAPamk0bbwmSwLzj0pCZY8i8Awdtm1sZ/hnJ0R5eZwv1moC8WubfelvjOjjFCFM2v9B/Fo6ISELTjzdHSLeWMwwM+evCfDuGxsvhuzPKu7eckjkXz6qu0DGuxQ3ecmw+a/1KLaLSdpbp2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TRJP69CtQYu6cDxLh1oAw1Yq2S+E2NUl3F+EV8j+epc=;
 b=a20fIdR/J5cERhb6i3xnmJjTZQ1ivUl/fA62oud3IxlFuS8uqHLELmucTEQ4/nWMRKdbKBdMsfd2rj9EFSI4ke+PJqaS5/PmkYw45GQM/xWgeGvCplmJhT2Q+QSD6e1ISaaaKr0xTkOuHnnljA0T3szz4b10Ve4iOlATIoW0ssqGw6l7t0M4kNvJ9P9lk98CEHdertodR2kyJskDCqkwgqautd5pcN85XhlI2inRM9HzdU7y/YSBVk80JYNTo50xc6HhMuacBBC51e/53ADD32wXBEo1yzXxqo0qGMkAxymNyhIMCx3pp+/kCZ2aX48Ta4V9AgaXv/ztGkguMLz6cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TRJP69CtQYu6cDxLh1oAw1Yq2S+E2NUl3F+EV8j+epc=;
 b=n7BM00EW8RpdQwF59NKPDD8n1SWhK4qmp5I5KYx0uEvK7c4zdkDxr420dx1D8z3pEzmn5oWVKIwkMXaubgWZFxAxOTojAab8R+uKeV06b1XquaA+mw2OTNkbmCh8fWwcVLrZzD1odisY6GubZFBxJ3Aj6wmecHBtDgX1RPIJXKU=
Authentication-Results: kernel.dk; dkim=none (message not signed)
 header.d=none;kernel.dk; dmarc=none action=none header.from=windriver.com;
Received: from BY5PR11MB4241.namprd11.prod.outlook.com (2603:10b6:a03:1ca::13)
 by BY5PR11MB4226.namprd11.prod.outlook.com (2603:10b6:a03:1bf::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.27; Thu, 11 Mar
 2021 12:11:54 +0000
Received: from BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::95a3:653e:2078:fb4]) by BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::95a3:653e:2078:fb4%6]) with mapi id 15.20.3912.031; Thu, 11 Mar 2021
 12:11:53 +0000
From:   yanfei.xu@windriver.com
To:     axboe@kernel.dk, damien.lemoal@wdc.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] block: fix possible bd_size_lock deadlock
Date:   Thu, 11 Mar 2021 20:11:39 +0800
Message-Id: <20210311121139.205222-1-yanfei.xu@windriver.com>
X-Mailer: git-send-email 2.27.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: HKAPR04CA0011.apcprd04.prod.outlook.com
 (2603:1096:203:d0::21) To BY5PR11MB4241.namprd11.prod.outlook.com
 (2603:10b6:a03:1ca::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pek-lpggp1.wrs.com (60.247.85.82) by HKAPR04CA0011.apcprd04.prod.outlook.com (2603:1096:203:d0::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Thu, 11 Mar 2021 12:11:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fd11f6fb-4ba2-4b5d-f8f4-08d8e486db9a
X-MS-TrafficTypeDiagnostic: BY5PR11MB4226:
X-Microsoft-Antispam-PRVS: <BY5PR11MB4226941315D75DBEAD36EB26E4909@BY5PR11MB4226.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vkDACQ7eruz9kyrlqXUx/IcIOFQI66Agr8N1ecDMAxnz34+3fWTe0MVIyxAtcQP8WOP2tppgplj1XaiMwQbf2vBFw6VnVXQW7/TZUdIKYaDkHHx54ewjd0vVG6+tHuMgtOpkM82apHKikuHek18czK8s3winJMVz6H8CoOHI6gwnISiQHsGgEfkhTkcKkd/iuZy4TExlXeE31koAH2e8HGdZ0tMhLdDtKOoKprVxAmpn3RV4U9lQ3Zv6bqOYxBbXAeaS0fHDudgxe6lKe7tTqHCbnT3q66rpV4HuKqyhWhz0O2w2UJmNDNrIVPFBAWlXzxaaY3EO8jrOj6tkoTwPwlFAV2t/Cs0znew4PRaivxD6SxkwZtFmGBlL7octMZgtCPAeat35lUsqpi4arSJW5w9T3X7xJ7FDybB6lwidGwM3Kck6Tu/6owGay0MBqi6fO6swblqpKODRwGddKhfsfZ/SvA1RB8AyxygJ9HO6Ojcr6Yi1P16A1fyWK6YDUjgGD5XGkEhgEsei3/3ki244pg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(376002)(346002)(366004)(136003)(396003)(52116002)(66556008)(8936002)(316002)(66476007)(16526019)(6486002)(186003)(956004)(86362001)(478600001)(2906002)(6666004)(1076003)(4326008)(26005)(5660300002)(8676002)(36756003)(9686003)(66946007)(83380400001)(6512007)(6506007)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?mBIlnUN0ztDkSrchl8zruRzsr6DDgzM6tq9FtyNTxCvX6C1LgHKnUSIBaD6w?=
 =?us-ascii?Q?qozPoxaRTI7CvCiBxtUdlf+PaNwuMpVbG19Ugc+MAyu1Cpv2jaqaKK5BoUlZ?=
 =?us-ascii?Q?g+nXNvjs52rnzwPAa0V8LkcFVpwNDncg7azicR6ZBYOL7Rta+DqujODI0VJo?=
 =?us-ascii?Q?I0XxBmGTcsARLl2YI9nQroJc+rwot05ranYdmMUsQOlq2i+WtxCAKYkbhFLD?=
 =?us-ascii?Q?JmRjvKdoXLoh3qa9ufAUGfMpNkj4H4ElgySyJ7I4QyIN88i6NgARo8QC364Q?=
 =?us-ascii?Q?ckMQ3Y5XF+gQzORqc6VSRVFKmwAgbzcwzSDBLawORBBsFZr6SUFbG9id/NKi?=
 =?us-ascii?Q?BhI1t2F0kIOJU7/Wx48YETFXxE9SWoP51GnFtaU6DrB04Ujca3CY+5Dg1TRH?=
 =?us-ascii?Q?qkUWjmYGEINJheD+Shm/TqrKGYgq64zG8GMhaT2bD9/IZSsqO4+EZWCGN/WH?=
 =?us-ascii?Q?64VrSpVuFv0SkFcGA8XKDm4AY/qd7dwhSPwQMXM0d17nmAXe9XKjsAiDPqFT?=
 =?us-ascii?Q?d1NJfnq/gnlS3flSKzfPEavNTV7KFZGVk/Qh0Gs5adX18OjrDFO3JjqHqdK8?=
 =?us-ascii?Q?DdfUGYdB58SILAjzBOHn3yEU4jv2nFCuIT14QI8JdWRZpYLZwEs1TBXSCxgB?=
 =?us-ascii?Q?J3R+Lu1jxz75TLJLcvTu7H62RQtuhK5LPex9Qnwc5mP/3pCK+O5dTyFaWxZp?=
 =?us-ascii?Q?0afxDDg71lQPtEr34Sa2IAKFcoLgegJkNt7QkfcbQo9JV4oBck9TnyAGp+bT?=
 =?us-ascii?Q?0R615W1fFIcs3GOVghfA+d8THX9Q1R5UB8AXXg3EQr0l/QUR6s+7xq7mP0Tj?=
 =?us-ascii?Q?HcGew0JuWzVPc/tgv6U+2TZrIcVOs9v8Vho1gp+nK3FTPHrw5TlZA7PfrkmG?=
 =?us-ascii?Q?YQeKNSAWQSlladyzW/68USgx3UwMCyPb6BYAOPxecwVNOgH9zIEUvud5M3gl?=
 =?us-ascii?Q?k7bvOqDj0ccIqr3sSacgg4pD9gows4e2hQm2HnOe8+8mKylb22ANoL4M+Har?=
 =?us-ascii?Q?9P2+4hv7mc4jWgJ4Bq6eZ3Sqf1q5nqoqDTdOjLC3HTXjfvWsMWX/6+pTM1v0?=
 =?us-ascii?Q?/6agk2uUww0eQ4SION3qMhGRP35ibwhwklsNDEVBZo3vdwM4uOZj83I3gI8h?=
 =?us-ascii?Q?I6gFC1t6+rPXqpuHRE67a0ILZLh4r7OX/OJf7akgv9RgH2K8SFQ0qX2CtOrd?=
 =?us-ascii?Q?wZSI2JeFKyJar8Ety2QddP5hLEI815/oiXLNSo0m/SJAwAxP0RDSpo9nzR0F?=
 =?us-ascii?Q?oBMTHaXfko4Zqql6ZMk/XKNphKFd/BVnmvLikjx6In8oNOlXkFuksf0kWZVZ?=
 =?us-ascii?Q?Cwg4jqV0flJoqbxAqdvcJyQf?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd11f6fb-4ba2-4b5d-f8f4-08d8e486db9a
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2021 12:11:53.8099
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yTWAuPVIJKb3Xj6VpYc8kH7MfdPdjJXSPV1YxROFXZGGf11ESx6hmCk46L9JY2cn0oAUx0DoBawNc2EBP4tlqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4226
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Yanfei Xu <yanfei.xu@windriver.com>

bd_size_lock spinlock could be taken in block softirq, thus we should
disable the softirq before taking the lock.

WARNING: inconsistent lock state
5.12.0-rc2-syzkaller #0 Not tainted
--------------------------------
inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-R} usage.
kworker/u4:0/7 [HC0[0]:SC1[1]:HE0:SE0] takes:
8f87826c (&inode->i_size_seqcount){+.+-}-{0:0}, at:
end_bio_bh_io_sync+0x38/0x54 fs/buffer.c:3006
{SOFTIRQ-ON-W} state was registered at:
  lock_acquire.part.0+0xf0/0x41c kernel/locking/lockdep.c:5510
  lock_acquire+0x6c/0x74 kernel/locking/lockdep.c:5483
  do_write_seqcount_begin_nested include/linux/seqlock.h:520 [inline]
  do_write_seqcount_begin include/linux/seqlock.h:545 [inline]
  i_size_write include/linux/fs.h:863 [inline]
  set_capacity+0x13c/0x1f8 block/genhd.c:50
  brd_alloc+0x130/0x180 drivers/block/brd.c:401
  brd_init+0xcc/0x1e0 drivers/block/brd.c:500
  do_one_initcall+0x8c/0x59c init/main.c:1226
  do_initcall_level init/main.c:1299 [inline]
  do_initcalls init/main.c:1315 [inline]
  do_basic_setup init/main.c:1335 [inline]
  kernel_init_freeable+0x2cc/0x330 init/main.c:1537
  kernel_init+0x10/0x120 init/main.c:1424
  ret_from_fork+0x14/0x20 arch/arm/kernel/entry-common.S:158
  0x0
irq event stamp: 2783413
hardirqs last  enabled at (2783412): [<802011ec>]
__do_softirq+0xf4/0x7ac kernel/softirq.c:329
hardirqs last disabled at (2783413): [<8277d260>]
__raw_read_lock_irqsave include/linux/rwlock_api_smp.h:157 [inline]
hardirqs last disabled at (2783413): [<8277d260>]
_raw_read_lock_irqsave+0x84/0x88 kernel/locking/spinlock.c:231
softirqs last  enabled at (2783410): [<826b5050>] spin_unlock_bh
include/linux/spinlock.h:399 [inline]
softirqs last  enabled at (2783410): [<826b5050>]
batadv_nc_purge_paths+0x10c/0x148 net/batman-adv/network-coding.c:467
softirqs last disabled at (2783411): [<8024ddfc>] do_softirq_own_stack
include/asm-generic/softirq_stack.h:10 [inline]
softirqs last disabled at (2783411): [<8024ddfc>] do_softirq
kernel/softirq.c:248 [inline]
softirqs last disabled at (2783411): [<8024ddfc>] do_softirq+0xd8/0xe4
kernel/softirq.c:235

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&inode->i_size_seqcount);
  <Interrupt>
    lock(&inode->i_size_seqcount);

 *** DEADLOCK ***

3 locks held by kworker/u4:0/7:
 #0: 88c622a8 ((wq_completion)bat_events){+.+.}-{0:0}, at: set_work_data
kernel/workqueue.c:615 [inline]
 #0: 88c622a8 ((wq_completion)bat_events){+.+.}-{0:0}, at:
set_work_pool_and_clear_pending kernel/workqueue.c:643 [inline]
 #0: 88c622a8 ((wq_completion)bat_events){+.+.}-{0:0}, at:
process_one_work+0x214/0x998 kernel/workqueue.c:2246
 #1: 85147ef8
((work_completion)(&(&bat_priv->nc.work)->work)){+.+.}-{0:0}, at:
set_work_data kernel/workqueue.c:615 [inline]
 #1: 85147ef8
((work_completion)(&(&bat_priv->nc.work)->work)){+.+.}-{0:0}, at:
set_work_pool_and_clear_pending kernel/workqueue.c:643 [inline]
 #1: 85147ef8
((work_completion)(&(&bat_priv->nc.work)->work)){+.+.}-{0:0}, at:
process_one_work+0x214/0x998 kernel/workqueue.c:2246
 #2: 8f878010 (&ni->size_lock){...-}-{2:2}, at:
ntfs_end_buffer_async_read+0x6c/0x558 fs/ntfs/aops.c:66

Fixes: 0f47227705d8 (block: revert "block: fix bd_size_lock use")
Reported-by: syzbot+a464ba0296692a4d2692@syzkaller.appspotmail.com
Signed-off-by: Yanfei Xu <yanfei.xu@windriver.com>
---
 block/genhd.c           | 4 ++--
 block/partitions/core.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index c55e8f0fced1..a246fcbd6fc5 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -46,9 +46,9 @@ void set_capacity(struct gendisk *disk, sector_t sectors)
 {
 	struct block_device *bdev = disk->part0;
 
-	spin_lock(&bdev->bd_size_lock);
+	spin_lock_bh(&bdev->bd_size_lock);
 	i_size_write(bdev->bd_inode, (loff_t)sectors << SECTOR_SHIFT);
-	spin_unlock(&bdev->bd_size_lock);
+	spin_unlock_bh(&bdev->bd_size_lock);
 }
 EXPORT_SYMBOL(set_capacity);
 
diff --git a/block/partitions/core.c b/block/partitions/core.c
index 1a7558917c47..777db55debce 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -88,9 +88,9 @@ static int (*check_part[])(struct parsed_partitions *) = {
 
 static void bdev_set_nr_sectors(struct block_device *bdev, sector_t sectors)
 {
-	spin_lock(&bdev->bd_size_lock);
+	spin_lock_bh(&bdev->bd_size_lock);
 	i_size_write(bdev->bd_inode, (loff_t)sectors << SECTOR_SHIFT);
-	spin_unlock(&bdev->bd_size_lock);
+	spin_unlock_bh(&bdev->bd_size_lock);
 }
 
 static struct parsed_partitions *allocate_partitions(struct gendisk *hd)
-- 
2.27.0

