Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.mpynet.fi ([82.197.21.85]:26485 "EHLO mx2.mpynet.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753652AbdDSVyi (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Apr 2017 17:54:38 -0400
Date: Thu, 20 Apr 2017 00:47:54 +0300
From: Rakesh Pandit <rakesh@tuxera.com>
To: Matias Bjorling <mb@lightnvm.io>
CC: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <rakesh@tuxera.com>
Subject: [PATCH] ligtnvm: fix double blk_put_queue on same queue
Message-ID: <20170419214754.GA7979@hercules.tuxera.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On an error path in NVM_DEV_CREATE ioctl blk_put_queue is being called
twice: one via blk_cleanup_queue and another via put_disk.  Straight fix
seems to remove queue pointer so that disk_release never ends up caling
blk_put_queue again.

  [  391.808827] WARNING: CPU: 1 PID: 1250 at lib/refcount.c:128 refcount_sub_and_test+0x70/0x80
  [  391.808830] refcount_t: underflow; use-after-free.
  [ 391.808832] Modules linked in: nf_conntrack_netbios_ns............
  [  391.809052] CPU: 1 PID: 1250 Comm: nvme Not tainted.........
  [  391.809057] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
             BIOS rel-1.7.5-0-ge51488c-20140602_164612-nilsson.home.kraxel.org 04/01/2014
  [  391.809060] Call Trace:
  [  391.809079]  dump_stack+0x63/0x86
  [  391.809094]  __warn+0xcb/0xf0
  [  391.809103]  warn_slowpath_fmt+0x5f/0x80
  [  391.809118]  refcount_sub_and_test+0x70/0x80
  [  391.809125]  refcount_dec_and_test+0x11/0x20
  [  391.809136]  kobject_put+0x1f/0x60
  [  391.809149]  blk_put_queue+0x15/0x20
  [  391.809159]  disk_release+0xae/0xf0
  [  391.809172]  device_release+0x32/0x90
  [  391.809184]  kobject_release+0x6a/0x170
  [  391.809196]  kobject_put+0x2f/0x60
  [  391.809206]  put_disk+0x17/0x20
  [  391.809219]  nvm_ioctl_dev_create.isra.16+0x897/0xa30
  [  391.809236]  nvm_ctl_ioctl+0x23c/0x4c0
  [  391.809248]  do_vfs_ioctl+0xa3/0x5f0
  [  391.809258]  SyS_ioctl+0x79/0x90
  [  391.809271]  entry_SYSCALL_64_fastpath+0x1a/0xa9
  [  391.809280] RIP: 0033:0x7f5d3ef363c7
  [  391.809286] RSP: 002b:00007ffc72ed8d78 EFLAGS: 00000206 ORIG_RAX: 0000000000000010
  [  391.809296] RAX: ffffffffffffffda RBX: 00007ffc72edb552 RCX: 00007f5d3ef363c7
  [  391.809301] RDX: 00007ffc72ed8d90 RSI: 0000000040804c22 RDI: 0000000000000003
  [  391.809306] RBP: 0000000000000001 R08: 0000000000000020 R09: 0000000000000001
  [  391.809311] R10: 000000000000053f R11: 0000000000000206 R12: 0000000000000000
  [  391.809316] R13: 0000000000000000 R14: 00007ffc72edb58d R15: 00007ffc72edb581

Signed-off-by: Rakesh Pandit <rakesh@tuxera.com>
---
 drivers/lightnvm/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index 2c26af3..5d7aa45 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -309,6 +309,7 @@ static int nvm_create_tgt(struct nvm_dev *dev, struct nvm_ioctl_create *create)
 		tt->exit(targetdata);
 err_init:
 	blk_cleanup_queue(tqueue);
+	tdisk->queue = NULL;
 err_disk:
 	put_disk(tdisk);
 err_dev:
-- 
2.5.5
