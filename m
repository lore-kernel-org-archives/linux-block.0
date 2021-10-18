Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1EA0C433F5
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 22:22:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BC2660C41
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 22:22:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbhJRWYQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Oct 2021 18:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232134AbhJRWYP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Oct 2021 18:24:15 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53DC5C06161C;
        Mon, 18 Oct 2021 15:22:04 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id w17so432536plg.9;
        Mon, 18 Oct 2021 15:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=YRsopof5A2/00ri8cvfNmLoaL3AbJ/UUBzy5J1HTjAE=;
        b=WLut5/yqQPRQlFB6sNQu20MRY5WRYac19gvCcyrvs9R1TXLrEvfU1FfMo3dXec6SJy
         SXjEaKSkDai+wL7rdqP+Sm083UIR7ZmmI4gcQDxTuing7LqEJR0N3zxN1aJnLz1GPGJs
         +kt1GU7eKzsnCrEii/vf+Vau2KC7AXtNr5wc7itLTb+3wojAb/oT041t3qq2aRZbPi+2
         SofUrAKf0mvgtzyV3w+MxvB753re1XSdTFsl8+dek8Btwf+7mQNC0HHc27wTCnHu4Ifp
         cNE9l/EZaOnJ1PwDuyBHUt4W1ofR4UDL5J54Ul1WSTVNnFb6B2NxmVUX+3chcA4AMyZF
         L0XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=YRsopof5A2/00ri8cvfNmLoaL3AbJ/UUBzy5J1HTjAE=;
        b=vXJwb9RjhcmQlOC1NMrt9f1vf0Pp8S+gyPalch5B4an0imSxjO25MBnHT8sIrbKg41
         yaVsGrXMcYtEULO/QxrgXQS5/uZqb52xtRUFTu0J4kovlnP9gOdTm3oosjYjWsoC2Ox+
         wVtrrpswXbND5hHV/YrkQBTdow4j/SF4zjzZKD+NX0+QH64i1dxCkMAWg+0UX8iT4Lm5
         oWTuFDbcQHkz+xgK7IjyYNXTwMLY9yC0Xt1+qqGOB6i8PFQW0d0eyysYPjSAqSErc0ev
         y8gby6d7ifAzzI5VpBx7nsx4w4RYi08HDexuq5tCWT/UxwGwN+QvJX5AVzecf4p9Tl7E
         zGFw==
X-Gm-Message-State: AOAM530TNPD77t7qKwuxeLh2Us6FHWGWnpUx4QNqTT9Kvce2gJ75do+Q
        kn9y+Te33f0kAkvKHEXlYDV7WvPbt4g=
X-Google-Smtp-Source: ABdhPJx6HLGaH4A7tSbTuMILV6baudXGJmokjtCBElyrBC/7eRIYErJ8ujk+MGrl8v0+MxCwg8l9wA==
X-Received: by 2002:a17:903:1ca:b0:13e:f367:9361 with SMTP id e10-20020a17090301ca00b0013ef3679361mr29760440plh.3.1634595723560;
        Mon, 18 Oct 2021 15:22:03 -0700 (PDT)
Received: from xplor.waratah.dyndns.org (222-155-4-20-adsl.sparkbb.co.nz. [222.155.4.20])
        by smtp.gmail.com with ESMTPSA id 21sm395334pjg.57.2021.10.18.15.22.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Oct 2021 15:22:03 -0700 (PDT)
Received: by xplor.waratah.dyndns.org (Postfix, from userid 1000)
        id 286DC36040C; Tue, 19 Oct 2021 11:21:59 +1300 (NZDT)
From:   Michael Schmitz <schmitzmic@gmail.com>
To:     linux-m68k@vger.kernel.org, geert@linux-m68k.org
Cc:     schmitzmic@gmail.com, linux-block@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: [PATCH RFC] block - ataflop.c: fix breakage introduced at blk-mq refactoring
Date:   Tue, 19 Oct 2021 11:21:57 +1300
Message-Id: <20211018222157.12238-1-schmitzmic@gmail.com>
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

When rewriting the drivers' old do_request() function, the fact
that finish_fdc() was called only when all queued requests had
completed appears to have been overlooked. Instead, the new
request function calls finish_fdc() immediately after the last
request has been queued. finish_fdc() executes a dummy seek after
most requests, and this overwrites the state machine's interrupt
hander that was set up to wait for completion of the read/write
request just prior. To make matters worse, finish_fdc() is called
before device interrupts are re-enabled, making certain that the
read/write interupt is missed.

Shifting the finish_fdc() call into the read/write request completion
handler ensures the driver waits for the request to actually complete.

Testing this change, I've only ever seen single sector requests with the
'last' flag set. If there is a way to send requests to the driver
without that flag set, I'd appreciate a hint. As it now stands,
the driver won't release the ST-DMA lock on requests that don't have
this flag set, but won't accept further requests because the attempt
to acquire the already-held lock once more will fail.

Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
Fixes: 6ec3938cff95f (ataflop: convert to blk-mq)
CC: linux-block@vger.kernel.org
CC: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
---
 drivers/block/ataflop.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/block/ataflop.c b/drivers/block/ataflop.c
index 96e2abe34a72..95469b4a8f78 100644
--- a/drivers/block/ataflop.c
+++ b/drivers/block/ataflop.c
@@ -653,8 +653,10 @@ static inline void copy_buffer(void *from, void *to)
 		*p2++ = *p1++;
 }
 
+/* finish_fdc() handling */
   
-  
+static void (*fdc_finish_action)( void ) = NULL;
+
 
 /* General Interrupt Handling */
 
@@ -1228,6 +1230,12 @@ static void fd_rwsec_done1(int status)
 	}
 	else {
 		/* all sectors finished */
+		void (*handler)( void );
+
+		handler = xchg(&fdc_finish_action, NULL);
+		if (handler)
+			handler();
+
 		fd_end_request_cur(BLK_STS_OK);
 	}
 	return;
@@ -1391,6 +1399,11 @@ static void finish_fdc_done( int dummy )
 	DPRINT(("finish_fdc() finished\n"));
 }
 
+static void queue_finish_fdc( void )
+{
+	fdc_finish_action = finish_fdc;
+}
+
 /* The detection of disk changes is a dark chapter in Atari history :-(
  * Because the "Drive ready" signal isn't present in the Atari
  * hardware, one has to rely on the "Write Protect". This works fine,
@@ -1491,6 +1504,8 @@ static blk_status_t ataflop_queue_rq(struct blk_mq_hw_ctx *hctx,
 	int drive = floppy - unit;
 	int type = floppy->type;
 
+	DPRINT(("Queue request: drive %d type %d\n", drive, type));
+
 	spin_lock_irq(&ataflop_lock);
 	if (fd_request) {
 		spin_unlock_irq(&ataflop_lock);
@@ -1551,7 +1566,7 @@ static blk_status_t ataflop_queue_rq(struct blk_mq_hw_ctx *hctx,
 	do_fd_action( drive );
 
 	if (bd->last)
-		finish_fdc();
+		queue_finish_fdc();
 	atari_enable_irq( IRQ_MFP_FDC );
 
 out:
-- 
2.17.1

