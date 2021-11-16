Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23498C433EF
	for <linux-block@archiver.kernel.org>; Tue, 16 Nov 2021 13:17:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0854D613D0
	for <linux-block@archiver.kernel.org>; Tue, 16 Nov 2021 13:17:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236562AbhKPNUr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 Nov 2021 08:20:47 -0500
Received: from pv50p00im-ztbu10011701.me.com ([17.58.6.53]:43831 "EHLO
        pv50p00im-ztbu10011701.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232753AbhKPNUq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Nov 2021 08:20:46 -0500
X-Greylist: delayed 417 seconds by postgrey-1.27 at vger.kernel.org; Tue, 16 Nov 2021 08:20:46 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1637068251; bh=D6fqXzn7nucldDdZ09YcVxbRKPlu/uYTTAEh1lmhBTE=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=FQWvlUJkJ5Agu7iTa0E+U2jCVGcy0t8UCBG5ZDgIby86Oll/KA3eJVt0W7DmRiJgd
         YAOVZ0ny1o1H9CrkXpSSLxHe2+ktdHbknkml04xixfEgFk0GOVco6Pzc26lYFHN8U/
         kF5PIf/ozA/KLrm7a526gS1U+jNmncRhTofsv6SjANdX6FOr9pVHYLgeEGgFY8YSC6
         zPg83o6zFpvxgQpDl1n/eexTdkX9aNVGmqdOkik7mY9A03e8WqiMOiP02XJPBdDXsk
         P375BAjoHYOtTHBPD7FVJUuMvZaF05arjL5XD7ztxhmzw8jmOdX7w8/2E1/4qTc0Sh
         i8lri8L00dt/w==
Received: from xiongwei.. (unknown [120.245.2.201])
        by pv50p00im-ztbu10011701.me.com (Postfix) with ESMTPSA id 058B28A0407;
        Tue, 16 Nov 2021 13:10:48 +0000 (UTC)
From:   sxwjean@me.com
To:     axboe@kernel.dk, efremov@linux.com, linux-block@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Xiongwei Song <sxwjean@gmail.com>
Subject: [PATCH] floppy: Add max size check for user space request
Date:   Tue, 16 Nov 2021 21:10:33 +0800
Message-Id: <20211116131033.27685-1-sxwjean@me.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.790
 definitions=2021-11-16_02:2021-11-16,2021-11-16 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011 mlxscore=0
 mlxlogscore=913 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2009150000 definitions=main-2111160068
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Xiongwei Song <sxwjean@gmail.com>

We need to check the max request size that is from user space before
allocating pages. If the request size exceeds the limit, return -EINVAL.
This check can avoid the warning below from page allocator.

WARNING: CPU: 3 PID: 16525 at mm/page_alloc.c:5344 current_gfp_context include/linux/sched/mm.h:195 [inline]
WARNING: CPU: 3 PID: 16525 at mm/page_alloc.c:5344 __alloc_pages+0x45d/0x500 mm/page_alloc.c:5356
Modules linked in:
CPU: 3 PID: 16525 Comm: syz-executor.3 Not tainted 5.15.0-syzkaller #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
RIP: 0010:__alloc_pages+0x45d/0x500 mm/page_alloc.c:5344
Code: be c9 00 00 00 48 c7 c7 20 4a 97 89 c6 05 62 32 a7 0b 01 e8 74 9a 42 07 e9 6a ff ff ff 0f 0b e9 a0 fd ff ff 40 80 e5 3f eb 88 <0f> 0b e9 18 ff ff ff 4c 89 ef 44 89 e6 45 31 ed e8 1e 76 ff ff e9
RSP: 0018:ffffc90023b87850 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 1ffff92004770f0b RCX: dffffc0000000000
RDX: 0000000000000000 RSI: 0000000000000033 RDI: 0000000000010cc1
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000001
R10: ffffffff81bb4686 R11: 0000000000000001 R12: ffffffff902c1960
R13: 0000000000000033 R14: 0000000000000000 R15: ffff88804cf64a30
FS:  0000000000000000(0000) GS:ffff88802cd00000(0063) knlGS:00000000f44b4b40
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 000000002c921000 CR3: 000000004f507000 CR4: 0000000000150ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 alloc_pages+0x1a7/0x300 mm/mempolicy.c:2191
 __get_free_pages+0x8/0x40 mm/page_alloc.c:5418
 raw_cmd_copyin drivers/block/floppy.c:3113 [inline]
 raw_cmd_ioctl drivers/block/floppy.c:3160 [inline]
 fd_locked_ioctl+0x12e5/0x2820 drivers/block/floppy.c:3528
 fd_ioctl drivers/block/floppy.c:3555 [inline]
 fd_compat_ioctl+0x891/0x1b60 drivers/block/floppy.c:3869
 compat_blkdev_ioctl+0x3b8/0x810 block/ioctl.c:662
 __do_compat_sys_ioctl+0x1c7/0x290 fs/ioctl.c:972
 do_syscall_32_irqs_on arch/x86/entry/common.c:112 [inline]
 __do_fast_syscall_32+0x65/0xf0 arch/x86/entry/common.c:178
 do_fast_syscall_32+0x2f/0x70 arch/x86/entry/common.c:203
 entry_SYSENTER_compat_after_hwframe+0x4d/0x5c

Reported-by: syzbot+23a02c7df2cf2bc93fa2@syzkaller.appspotmail.com
Signed-off-by: Xiongwei Song <sxwjean@gmail.com>
---
 drivers/block/floppy.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index c4267da716fe..52112ed59dd0 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -3081,6 +3081,8 @@ static void raw_cmd_free(struct floppy_raw_cmd **ptr)
 	}
 }
 
+#define MAX_LEN (1UL << MAX_ORDER << PAGE_SHIFT)
+
 static int raw_cmd_copyin(int cmd, void __user *param,
 				 struct floppy_raw_cmd **rcmd)
 {
@@ -3108,7 +3110,7 @@ static int raw_cmd_copyin(int cmd, void __user *param,
 	ptr->resultcode = 0;
 
 	if (ptr->flags & (FD_RAW_READ | FD_RAW_WRITE)) {
-		if (ptr->length <= 0)
+		if (ptr->length <= 0 || ptr->length >= MAX_LEN)
 			return -EINVAL;
 		ptr->kernel_data = (char *)fd_dma_mem_alloc(ptr->length);
 		fallback_on_nodma_alloc(&ptr->kernel_data, ptr->length);
-- 
2.30.2

