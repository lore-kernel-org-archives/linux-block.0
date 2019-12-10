Return-Path: <SRS0=EWGC=2A=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FEB3C43603
	for <linux-block@archiver.kernel.org>; Tue, 10 Dec 2019 18:47:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F35720828
	for <linux-block@archiver.kernel.org>; Tue, 10 Dec 2019 18:47:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727374AbfLJSrL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 Dec 2019 13:47:11 -0500
Received: from ale.deltatee.com ([207.54.116.67]:39430 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726771AbfLJSrL (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Dec 2019 13:47:11 -0500
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1iekXN-00086y-OQ; Tue, 10 Dec 2019 11:47:10 -0700
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1iekXL-0006H8-U5; Tue, 10 Dec 2019 11:47:07 -0700
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        kernel test robot <rong.a.chen@intel.com>
Date:   Tue, 10 Dec 2019 11:47:04 -0700
Message-Id: <20191210184704.24081-1-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, axboe@kernel.dk, hch@lst.de, torvalds@linux-foundation.org, logang@deltatee.com, rong.a.chen@intel.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH] block: fix NULL pointer dereference in account statistics with IDE
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The IDE driver creates some passthru requests which never get
submitted to the block layer in such a way that blk_account_io_start()
gets called. However, the driver still calls __blk_mq_end_request() in
ide_end_rq() which will call blk_account_io_completion() which tries
to dereferences req->part which is never set. See ide_prep_sense() for
an example of where these requests come from.

To fix this, blk_account_io_completion() and blk_account_io_done()
should do nothing if req->part is not set.

The back trace of this bug is:

    BUG: kernel NULL pointer dereference, address: 000002ac
    #PF: supervisor write access in kernel mode
    #PF: error_code(0x0002) - not-present page
    *pde = 00000000
    Oops: 0002 [#1]
    CPU: 0 PID: 237 Comm: kworker/0:1H Not tainted
    5.4.0-rc2-00011-g48d9b0d43105e #1
    Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1
    04/01/2014
    Workqueue: kblockd drive_rq_insert_work
    EIP: blk_account_io_completion+0x7a/0xf0
    Code: 89 54 24 08 31 d2 89 4c 24 04 31 c9 c7 04 24 02 00 00 00 c1 ee
    09 e8 f5 21 a6 ff e8 70 5c a7 ff 8b 53 60 8d 04 bd 00 00 00 00 <01> b4
    02 ac 02 00 00 8b 9a 88 02 00 00 85 db 74 11 85 d2 74 51 8b
    EAX: 00000000 EBX: f5b80000 ECX: 00000000 EDX: 00000000
    ESI: 00000000 EDI: 00000000 EBP: f3031e70 ESP: f3031e54
    DS: 007b ES: 007b FS: 0000 GS: 0000 SS: 0068 EFLAGS: 00010046
    CR0: 80050033 CR2: 000002ac CR3: 03c25000 CR4: 000406d0
    Call Trace:
     <IRQ>
      blk_update_request+0x85/0x420
      ide_end_rq+0x38/0xa0
      ide_complete_rq+0x3d/0x70
      cdrom_newpc_intr+0x258/0xba0
      ide_intr+0x135/0x250
      __handle_irq_event_percpu+0x3e/0x250
      handle_irq_event_percpu+0x1f/0x50
      handle_irq_event+0x32/0x60
      handle_level_irq+0x6c/0x110
      handle_irq+0x72/0xa0
      </IRQ>
      do_IRQ+0x45/0xad
      common_interrupt+0x115/0x11c

Fixes: 48d9b0d43105 ("block: account statistics for passthrough requests")
Reported-by: kernel test robot <rong.a.chen@intel.com>
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 block/blk-core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index a1e228752083..68c309ce6735 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1310,7 +1310,7 @@ EXPORT_SYMBOL_GPL(blk_rq_err_bytes);
 
 void blk_account_io_completion(struct request *req, unsigned int bytes)
 {
-	if (blk_do_io_stat(req)) {
+	if (req->part && blk_do_io_stat(req)) {
 		const int sgrp = op_stat_group(req_op(req));
 		struct hd_struct *part;
 
@@ -1328,7 +1328,8 @@ void blk_account_io_done(struct request *req, u64 now)
 	 * normal IO on queueing nor completion.  Accounting the
 	 * containing request is enough.
 	 */
-	if (blk_do_io_stat(req) && !(req->rq_flags & RQF_FLUSH_SEQ)) {
+	if (req->part && blk_do_io_stat(req) &&
+	    !(req->rq_flags & RQF_FLUSH_SEQ)) {
 		const int sgrp = op_stat_group(req_op(req));
 		struct hd_struct *part;
 
-- 
2.20.1

