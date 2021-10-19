Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FC78C433EF
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 06:13:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06BEA611BF
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 06:13:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbhJSGPk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Oct 2021 02:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233925AbhJSGPk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Oct 2021 02:15:40 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F03CC06161C;
        Mon, 18 Oct 2021 23:13:28 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id c4so11350698pgv.11;
        Mon, 18 Oct 2021 23:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=fZTllbsSBYU1vPbQBtiyTDOE4RVPNFyvyDVGuq1Qtmg=;
        b=YRpiDcJNMuVkungisKW9S159fE72BkbKddnDnSs20bZGeMr8zayqi2c3aTBDjpf6JI
         YPHZl+tEe1BFeJLVf7zNX/PvA0J3+D3+hOiQyFbo9LEtjGgzhEtoorDK+G0IyOGzABOG
         Vs5ek89vF48yEWc7bMeMK42Kd0qgkg1K+BITrBBdhcsiAd8D9xO9DKGMAbEwVa+X54BY
         5Br+4qZqxyRfPE41fi3pR4mRKfTQfiFpUDWH5c0YO7ho+LWm0aIqd/e8Lw0jH+c9JbfR
         16ub4CZxwWuYxV6WunxTojmD5OGcdPM1CX/Pau/PV76Rc6L7gTEyenAr6o3K2kh/PAXG
         9zDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fZTllbsSBYU1vPbQBtiyTDOE4RVPNFyvyDVGuq1Qtmg=;
        b=5/JrgC19B8wb4ZP3gzeu2VhDgiZQ9XYocPH2WfAdumSJLosfBpi7NFKnXRD6ikZH7A
         81DwEKfywckCk7sY3mjgWqqzbxIuPgjo9KV7xXPfu4KvKlSPCUhjrb1C5/S/a+TvVO23
         n6CVe52ELNX+sZVEd/QqBopQjIo+ciIBuMYdKaYGfjuOm9ufFLbnVlyYmIEvV9SmsXJ+
         S0JgcDpkA9XR04x8JlsBovvUhGbXAbMQWiZuS2nQCgER5yvY7r263Rm0xZsvsLjEZRqT
         dJvfpdM/NGUhObD75O5T5H61QBRWNAxp5sbWGunp9uFqXEiTxDFO5uNrt/t/+bENH63u
         9ICg==
X-Gm-Message-State: AOAM532iBrjXKJuEd5nEMDVeR9oeyfQTh+e/K0Q/4NGtYozJl2xx7g+r
        rNhrMFIKkqDR8hXxVoaGisnftZYrP7c=
X-Google-Smtp-Source: ABdhPJzzA4Kr0e0/XdFu/nPGlw+m0w+w8mUpsHfhsHSBeAjUznfckS0qEt5jih6iFndchyk/iJVjNw==
X-Received: by 2002:a62:31c5:0:b0:447:b30c:9a79 with SMTP id x188-20020a6231c5000000b00447b30c9a79mr33520690pfx.67.1634624007602;
        Mon, 18 Oct 2021 23:13:27 -0700 (PDT)
Received: from xplor.waratah.dyndns.org (222-155-4-20-adsl.sparkbb.co.nz. [222.155.4.20])
        by smtp.gmail.com with ESMTPSA id t22sm11427388pfg.148.2021.10.18.23.13.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Oct 2021 23:13:27 -0700 (PDT)
Received: by xplor.waratah.dyndns.org (Postfix, from userid 1000)
        id 6349436040C; Tue, 19 Oct 2021 19:13:23 +1300 (NZDT)
From:   Michael Schmitz <schmitzmic@gmail.com>
To:     linux-m68k@vger.kernel.org, geert@linux-m68k.org
Cc:     schmitzmic@gmail.com, linux-block@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: [PATCH v2] block - ataflop.c: fix breakage introduced at blk-mq refactoring
Date:   Tue, 19 Oct 2021 19:13:21 +1300
Message-Id: <20211019061321.26425-1-schmitzmic@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Refactoring of the Atari floppy driver when converting to blk-mq
has broken the state machine in not-so-subtle ways:

finish_fdc() must be called when operations on the floppy device
have completed. This is crucial in order to relase the ST-DMA
lock, which protects against concurrent access to the ST-DMA
controller by other drivers (some DMA related, most just related
to device register access - broken beyond compare, I know).

When rewriting the driver's old do_request() function, the fact
that finish_fdc() was called only when all queued requests had
completed appears to have been overlooked. Instead, the new
request function calls finish_fdc() immediately after the last
request has been queued. finish_fdc() executes a dummy seek after
most requests, and this overwrites the state machine's interrupt
hander that was set up to wait for completion of the read/write
request just prior. To make matters worse, finish_fdc() is called
before device interrupts are re-enabled, making certain that the
read/write interupt is missed.

Shifting the finish_fdc() call into the read/write request
completion handler ensures the driver waits for the request to
actually complete. With a queue depth of 2, we won't see long
request sequences, so calling finish_fdc() unconditionally just
adds a little overhead for the dummy seeks, and keeps the code
simple.

While we're at it, kill ataflop_commit_rqs() which does nothing
but run finish_fdc() unconditionally, again likely wiping out an
in-flight request.

Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
Fixes: 6ec3938cff95f (ataflop: convert to blk-mq)
CC: linux-block@vger.kernel.org
CC: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>

--

Changes from RFC:

Jens Axboe:
- kill ataflop_commit_rqs()
- call finish_fdc() unconditionally in fd_rwsec_done1() 

---
 drivers/block/ataflop.c | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/drivers/block/ataflop.c b/drivers/block/ataflop.c
index 96e2abe34a72..a9d3b24cc8f5 100644
--- a/drivers/block/ataflop.c
+++ b/drivers/block/ataflop.c
@@ -653,9 +653,6 @@ static inline void copy_buffer(void *from, void *to)
 		*p2++ = *p1++;
 }
 
-  
-  
-
 /* General Interrupt Handling */
 
 static void (*FloppyIRQHandler)( int status ) = NULL;
@@ -1228,6 +1225,7 @@ static void fd_rwsec_done1(int status)
 	}
 	else {
 		/* all sectors finished */
+		finish_fdc();
 		fd_end_request_cur(BLK_STS_OK);
 	}
 	return;
@@ -1475,15 +1473,6 @@ static void setup_req_params( int drive )
 			ReqTrack, ReqSector, (unsigned long)ReqData ));
 }
 
-static void ataflop_commit_rqs(struct blk_mq_hw_ctx *hctx)
-{
-	spin_lock_irq(&ataflop_lock);
-	atari_disable_irq(IRQ_MFP_FDC);
-	finish_fdc();
-	atari_enable_irq(IRQ_MFP_FDC);
-	spin_unlock_irq(&ataflop_lock);
-}
-
 static blk_status_t ataflop_queue_rq(struct blk_mq_hw_ctx *hctx,
 				     const struct blk_mq_queue_data *bd)
 {
@@ -1491,6 +1480,8 @@ static blk_status_t ataflop_queue_rq(struct blk_mq_hw_ctx *hctx,
 	int drive = floppy - unit;
 	int type = floppy->type;
 
+	DPRINT(("Queue request: drive %d type %d last %d\n", drive, type, bd->last));
+
 	spin_lock_irq(&ataflop_lock);
 	if (fd_request) {
 		spin_unlock_irq(&ataflop_lock);
@@ -1550,8 +1541,6 @@ static blk_status_t ataflop_queue_rq(struct blk_mq_hw_ctx *hctx,
 	setup_req_params( drive );
 	do_fd_action( drive );
 
-	if (bd->last)
-		finish_fdc();
 	atari_enable_irq( IRQ_MFP_FDC );
 
 out:
@@ -1962,7 +1951,6 @@ static const struct block_device_operations floppy_fops = {
 
 static const struct blk_mq_ops ataflop_mq_ops = {
 	.queue_rq = ataflop_queue_rq,
-	.commit_rqs = ataflop_commit_rqs,
 };
 
 static int ataflop_alloc_disk(unsigned int drive, unsigned int type)
-- 
2.17.1

