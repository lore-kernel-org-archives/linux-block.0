Return-Path: <SRS0=kddI=WE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E4FEC433FF
	for <linux-block@archiver.kernel.org>; Thu,  8 Aug 2019 03:10:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74DF6216C8
	for <linux-block@archiver.kernel.org>; Thu,  8 Aug 2019 03:10:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728060AbfHHDKC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 7 Aug 2019 23:10:02 -0400
Received: from mail.windriver.com ([147.11.1.11]:57463 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727984AbfHHDKC (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 7 Aug 2019 23:10:02 -0400
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
        by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id x7839uuQ020218
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Wed, 7 Aug 2019 20:09:56 -0700 (PDT)
Received: from pek-lpg-core2.corp.ad.wrs.com (128.224.153.41) by
 ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
 14.3.468.0; Wed, 7 Aug 2019 20:09:56 -0700
From:   <zhe.he@windriver.com>
To:     <justin@coraid.com>, <axboe@kernel.dk>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <zhe.he@windriver.com>
Subject: [PATCH] block: aoe: Fix kernel crash due to atomic sleep when exiting
Date:   Thu, 8 Aug 2019 11:09:54 +0800
Message-ID: <1565233794-458496-1-git-send-email-zhe.he@windriver.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: He Zhe <zhe.he@windriver.com>

Since commit 3582dd291788 ("aoe: convert aoeblk to blk-mq"), aoedev_downdev
has had the possibility of sleeping and causing the following crash.

BUG: scheduling while atomic: rmmod/2242/0x00000003
Modules linked in: aoe
Preemption disabled at:
[<ffffffffc01d95e5>] flush+0x95/0x4a0 [aoe]
CPU: 7 PID: 2242 Comm: rmmod Tainted: G          I       5.2.3 #1
Hardware name: Intel Corporation S5520HC/S5520HC, BIOS S5500.86B.01.10.0025.030220091519 03/02/2009
Call Trace:
 dump_stack+0x4f/0x6a
 ? flush+0x95/0x4a0 [aoe]
 __schedule_bug.cold+0x44/0x54
 __schedule+0x44f/0x680
 schedule+0x44/0xd0
 blk_mq_freeze_queue_wait+0x46/0xb0
 ? wait_woken+0x80/0x80
 blk_mq_freeze_queue+0x1b/0x20
 aoedev_downdev+0x111/0x160 [aoe]
 flush+0xff/0x4a0 [aoe]
 aoedev_exit+0x23/0x30 [aoe]
 aoe_exit+0x35/0x948 [aoe]
 __se_sys_delete_module+0x183/0x210
 __x64_sys_delete_module+0x16/0x20
 do_syscall_64+0x4d/0x130
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x7f24e0043b07
Code: 73 01 c3 48 8b 0d 89 73 0b 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f
1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 b0 00 00 00 0f 05 <48> 3d 01 f0 ff
ff 73 01 c3 48 8b 0d 59 73 0b 00 f7 d8 64 89 01 48
RSP: 002b:00007ffe18f7f1e8 EFLAGS: 00000206 ORIG_RAX: 00000000000000b0
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f24e0043b07
RDX: 000000000000000a RSI: 0000000000000800 RDI: 0000555c3ecf87c8
RBP: 00007ffe18f7f1f0 R08: 0000000000000000 R09: 0000000000000000
R10: 00007f24e00b4ac0 R11: 0000000000000206 R12: 00007ffe18f7f238
R13: 00007ffe18f7f410 R14: 00007ffe18f80e73 R15: 0000555c3ecf8760

This patch, handling in the same way of pass two, unlocks the locks and
restart pass one after aoedev_downdev is done.

Fixes: 3582dd291788 ("aoe: convert aoeblk to blk-mq")
Signed-off-by: He Zhe <zhe.he@windriver.com>
---
 drivers/block/aoe/aoedev.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/block/aoe/aoedev.c b/drivers/block/aoe/aoedev.c
index 5b49f1b..e2ea235 100644
--- a/drivers/block/aoe/aoedev.c
+++ b/drivers/block/aoe/aoedev.c
@@ -323,10 +323,14 @@ flush(const char __user *str, size_t cnt, int exiting)
 	}
 
 	flush_scheduled_work();
-	/* pass one: without sleeping, do aoedev_downdev */
+	/* pass one: do aoedev_downdev, which might sleep */
+restart1:
 	spin_lock_irqsave(&devlist_lock, flags);
 	for (d = devlist; d; d = d->next) {
 		spin_lock(&d->lock);
+		if (d->flags & DEVFL_TKILL)
+			goto cont;
+
 		if (exiting) {
 			/* unconditionally take each device down */
 		} else if (specified) {
@@ -338,8 +342,11 @@ flush(const char __user *str, size_t cnt, int exiting)
 		|| d->ref)
 			goto cont;
 
+		spin_unlock(&d->lock);
+		spin_unlock_irqrestore(&devlist_lock, flags);
 		aoedev_downdev(d);
 		d->flags |= DEVFL_TKILL;
+		goto restart1;
 cont:
 		spin_unlock(&d->lock);
 	}
@@ -348,7 +355,7 @@ flush(const char __user *str, size_t cnt, int exiting)
 	/* pass two: call freedev, which might sleep,
 	 * for aoedevs marked with DEVFL_TKILL
 	 */
-restart:
+restart2:
 	spin_lock_irqsave(&devlist_lock, flags);
 	for (d = devlist; d; d = d->next) {
 		spin_lock(&d->lock);
@@ -357,7 +364,7 @@ flush(const char __user *str, size_t cnt, int exiting)
 			spin_unlock(&d->lock);
 			spin_unlock_irqrestore(&devlist_lock, flags);
 			freedev(d);
-			goto restart;
+			goto restart2;
 		}
 		spin_unlock(&d->lock);
 	}
-- 
2.7.4

