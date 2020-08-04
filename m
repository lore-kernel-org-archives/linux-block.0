Return-Path: <SRS0=uCqz=BO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2D86C433DF
	for <linux-block@archiver.kernel.org>; Tue,  4 Aug 2020 04:15:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD7F820A8B
	for <linux-block@archiver.kernel.org>; Tue,  4 Aug 2020 04:15:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CBnuS35M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728811AbgHDEP2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Aug 2020 00:15:28 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:49054 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728622AbgHDEP1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 4 Aug 2020 00:15:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596514525;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=naMljwKN55pXG0BE7fSTMQuUDDEz+6xfHwNCVPrHzOM=;
        b=CBnuS35M54oGBo23y4Jn5q15x3VCoRuu++eRYWxZ6mk+SN6iDJ6zscJOvyIqvrJC3GFXh1
        70WckF93CrW63j/5i7T/fHXf9s7nJ2XGOMdNa0NjjcWVe1J/J/fILriza9QbjZpOnlt71S
        Y1Bf21WGhsK4pqs4a/AF4YpJ/wzhC+A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-23-FULBt5jEMXCuxbr0axN_vQ-1; Tue, 04 Aug 2020 00:15:21 -0400
X-MC-Unique: FULBt5jEMXCuxbr0axN_vQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9FCE118C63C0;
        Tue,  4 Aug 2020 04:15:20 +0000 (UTC)
Received: from localhost (ovpn-13-169.pek2.redhat.com [10.72.13.169])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DBD2910013C1;
        Tue,  4 Aug 2020 04:15:16 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Coly Li <colyli@suse.de>, Hannes Reinecke <hare@suse.com>,
        Xiao Ni <xni@redhat.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: [PATCH] block: loop: set discard granularity and alignment for block device backed loop
Date:   Tue,  4 Aug 2020 12:15:08 +0800
Message-Id: <20200804041508.1870113-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In case of block device backend, if the backend supports discard, the
loop device will set queue flag of QUEUE_FLAG_DISCARD.

However, limits.discard_granularity isn't setup, and this way is wrong,
see the following description in Documentation/ABI/testing/sysfs-block:

	A discard_granularity of 0 means that the device does not support
	discard functionality.

Especially 9b15d109a6b2 ("block: improve discard bio alignment in
__blkdev_issue_discard()") starts to take q->limits.discard_granularity
for computing max discard sectors. And zero discard granularity causes
kernel oops[1].

Fix the issue by set up discard granularity and alignment.

[1] kernel oops when use block disk as loop backend:

[   33.405947] ------------[ cut here ]------------
[   33.405948] kernel BUG at block/blk-mq.c:563!
[   33.407504] invalid opcode: 0000 [#1] SMP PTI
[   33.408245] CPU: 3 PID: 0 Comm: swapper/3 Not tainted 5.8.0-rc2_update_rq+ #17
[   33.409466] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS ?-20180724_192412-buildhw-07.phx2.fedor4
[   33.411546] RIP: 0010:blk_mq_end_request+0x1c/0x2a
[   33.412354] Code: 48 89 df 5b 5d 41 5c 41 5d e9 2d fe ff ff 0f 1f 44 00 00 55 48 89 fd 53 40 0f b6 de 8b 57 5
[   33.415724] RSP: 0018:ffffc900019ccf48 EFLAGS: 00010202
[   33.416688] RAX: 0000000000000001 RBX: 0000000000000000 RCX: ffff88826f2600c0
[   33.417990] RDX: 0000000000200042 RSI: 0000000000000001 RDI: ffff888270c13100
[   33.419286] RBP: ffff888270c13100 R08: 0000000000000001 R09: ffffffff81345144
[   33.420584] R10: ffff88826f260600 R11: 0000000000000000 R12: ffff888270c13100
[   33.421881] R13: ffffffff820050c0 R14: 0000000000000004 R15: 0000000000000004
[   33.423053] FS:  0000000000000000(0000) GS:ffff888277d80000(0000) knlGS:0000000000000000
[   33.424360] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   33.425416] CR2: 00005581d7903f08 CR3: 00000001e9a16002 CR4: 0000000000760ee0
[   33.426580] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   33.427706] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   33.428910] PKRU: 55555554
[   33.429412] Call Trace:
[   33.429858]  <IRQ>
[   33.430189]  blk_done_softirq+0x84/0xa4
[   33.430884]  __do_softirq+0x11a/0x278
[   33.431567]  asm_call_on_stack+0x12/0x20
[   33.432283]  </IRQ>
[   33.432673]  do_softirq_own_stack+0x31/0x40
[   33.433448]  __irq_exit_rcu+0x46/0xae
[   33.434132]  sysvec_call_function_single+0x7d/0x8b
[   33.435021]  asm_sysvec_call_function_single+0x12/0x20
[   33.435965] RIP: 0010:native_safe_halt+0x7/0x8
[   33.436795] Code: 25 c0 7b 01 00 f0 80 60 02 df f0 83 44 24 fc 00 48 8b 00 a8 08 74 0b 65 81 25 db 38 95 7e b
[   33.440179] RSP: 0018:ffffc9000191fee0 EFLAGS: 00000246
[   33.441143] RAX: ffffffff816c4118 RBX: 0000000000000000 RCX: ffff888276631a00
[   33.442442] RDX: 000000000000ddfe RSI: 0000000000000003 RDI: 0000000000000001
[   33.443742] RBP: 0000000000000000 R08: 00000000f461e6ac R09: 0000000000000004
[   33.445046] R10: 8080808080808080 R11: fefefefefefefeff R12: 0000000000000000
[   33.446352] R13: 0000000000000003 R14: ffffffffffffffff R15: 0000000000000000
[   33.447450]  ? ldsem_down_write+0x1f5/0x1f5
[   33.448158]  default_idle+0x1b/0x2c
[   33.448809]  do_idle+0xf9/0x248
[   33.449392]  cpu_startup_entry+0x1d/0x1f
[   33.450118]  start_secondary+0x168/0x185
[   33.450843]  secondary_startup_64+0xa4/0xb0
[   33.451612] Modules linked in: scsi_debug iTCO_wdt iTCO_vendor_support nvme nvme_core i2c_i801 lpc_ich virtis
[   33.454292] Dumping ftrace buffer:
[   33.454951]    (ftrace buffer empty)
[   33.455626] ---[ end trace beece202d663d38f ]---

Fixes: 9b15d109a6b2 ("block: improve discard bio alignment in __blkdev_issue_discard()")
Cc: Coly Li <colyli@suse.de>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Xiao Ni <xni@redhat.com>
Cc: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/loop.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index d18160146226..6102370bee35 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -890,6 +890,11 @@ static void loop_config_discard(struct loop_device *lo)
 		struct request_queue *backingq;
 
 		backingq = bdev_get_queue(inode->i_bdev);
+
+		q->limits.discard_granularity =
+			queue_physical_block_size(backingq);
+		q->limits.discard_alignment = 0;
+
 		blk_queue_max_discard_sectors(q,
 			backingq->limits.max_write_zeroes_sectors);
 
-- 
2.25.2

