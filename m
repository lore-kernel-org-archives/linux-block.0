Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 155AFC77B7E
	for <linux-block@archiver.kernel.org>; Tue,  2 May 2023 09:00:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbjEBJAi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 May 2023 05:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjEBJAh (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 May 2023 05:00:37 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F45919A1
        for <linux-block@vger.kernel.org>; Tue,  2 May 2023 02:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=Sym1pMgJX4GaHb3fU7VvBgfec6UxA58kOTqttq8Im9c=; b=va92z/vRdY6BJ+Exh9TBDDxLuz
        I7PhpK2PHTzJGNN6+WQT0IFqUFNDPfvXnuaIxZ7KMADnt5Bl2D+ZUzXWVcSNtJDjyCQhQnN9ctRag
        v28s96fyZjoNtJtaJDz5Be4mO1n3n+WMu1gZ6BrhL75su40HjoOucsMqtnWzy3uS5sHiQkV6cH5TB
        vN0Y46YZJG70y2Qkfy3COGIDchnA8cc0uCQRJ9lHVA84wRQSkJM2i1NhOxklOR+S5UKTaADMsqPhs
        WwZXWw64VM4/sNZHnU/TXQMx4TPV9WsRb41Qo4uO7fwFaHvtxzXPD45lWwkGLY4w7nb7fKJV2IMWt
        16TuSI2Q==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1ptlsA-000i4I-2h;
        Tue, 02 May 2023 09:00:34 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     linux-block@vger.kernel.org
Cc:     mcgrof@kernel.org, kbusch@kernel.org, willy@infradead.org,
        p.raghav@samsung.com, da.gomez@samsung.com
Subject: [RFC] block: dio: immediately fail when count < logical block size
Date:   Tue,  2 May 2023 02:00:18 -0700
Message-Id: <20230502090018.169275-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When using direct IO of say 4k on a 32k physical block size device
we crash. The amount of data requested must match the minimum IO supported
by the device but instead we take it for a ride right now and try to fail
later after checking alignments.

Use the logical block size to ensure the data passed on matches our minimum
supported.

Without this we end up in a crash below:

kernel BUG at lib/iov_iter.c:999!
invalid opcode: 0000 [#1] PREEMPT SMP PTI
CPU: 4 PID: 949 Comm: fio Not tainted 6.3.0-large-block-20230426-dirty #28
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.0-debian-1.16.0-5        04/01/2014                                                                              [   43.513057] RIP: 0010:iov_iter_revert.part.0+0x16e/0x170
Code: f9 40 a2 63 af 74 07 03 56 08 89 d8 29 d0 89 45 08 44 89 6d 20 <etc>
RSP: 0018:ffffaa52006cfc60 EFLAGS: 00010246
RAX: 0000000000000016 RBX: 0000000000000016 RCX: 0000000000000000
RDX: 0000000000000004 RSI: 0000000000000006 RDI: ffffaa52006cfd08
RBP: ffffaa52006cfd08 R08: 0000000000000000 R09: ffffaa52006cfb40
R10: 0000000000000003 R11: ffffffffafcc21e8 R12: 0000000000004000
R13: 0000000000003fea R14: ffff9de3d7565e00 R15: ffff9de3c1f68600
FS:  00007f8bfe726c40(0000) GS:ffff9de43bd00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f8bf5eadd68 CR3: 0000000102c76001 CR4: 0000000000770ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 55555554
Call Trace:
 <TASK>
 blkdev_direct_write+0xf0/0x160
 blkdev_write_iter+0x11b/0x230
 io_write+0x10c/0x420
 ? kmem_cache_alloc_bulk+0x2a1/0x410
 ? fget+0x79/0xb0
 io_issue_sqe+0x60/0x3b0
 ? io_prep_rw+0x5a/0x190
 io_submit_sqes+0x1e6/0x640
 __do_sys_io_uring_enter+0x54c/0xb90
 ? handle_mm_fault+0x9a/0x340
 ? preempt_count_add+0x47/0xa0
 ? up_read+0x37/0x70
 ? do_user_addr_fault+0x27c/0x780
 do_syscall_64+0x37/0x90
 entry_SYSCALL_64_after_hw

The issue is we end up calling iov_iter_revert() at the end of
blkdev_direct_write() due to the writes not being valid and
being unaligned. We can fail twice, for on __blkdev_direct_IO_simple()
and later on __blkdev_direct_IO_async().

Instead of allowing such writes through and letting them in for
an attempt to ride, kill them early and fail early.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---

But this can't be right, this should mean other failed unaligned
writes were possibly doing the wrong accounting also with
iov_iter_revert(). So this patch can't be right, right?

 block/fops.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/block/fops.c b/block/fops.c
index 524b8a828aad..c03c1bafcb1b 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -583,9 +583,14 @@ static int blkdev_close(struct inode *inode, struct file *filp)
 static ssize_t
 blkdev_direct_write(struct kiocb *iocb, struct iov_iter *from)
 {
+	struct file *file = iocb->ki_filp;
+	struct block_device *bdev = file->private_data;
 	size_t count = iov_iter_count(from);
 	ssize_t written;
 
+	if (count < bdev_logical_block_size(bdev))
+		return -EINVAL;
+
 	written = kiocb_invalidate_pages(iocb, count);
 	if (written) {
 		if (written == -EBUSY)
-- 
2.39.2

