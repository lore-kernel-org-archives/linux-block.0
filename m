Return-Path: <SRS0=XMJ3=U3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4E30C4321A
	for <linux-block@archiver.kernel.org>; Fri, 28 Jun 2019 04:44:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A32432070D
	for <linux-block@archiver.kernel.org>; Fri, 28 Jun 2019 04:44:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ArWvWp5p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbfF1Eou (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Jun 2019 00:44:50 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40425 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbfF1Eou (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Jun 2019 00:44:50 -0400
Received: by mail-pl1-f196.google.com with SMTP id a93so2516518pla.7
        for <linux-block@vger.kernel.org>; Thu, 27 Jun 2019 21:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Hl6Pnq3xmamo6vmydBFzkBduZblIOAKNn76di+zQvGg=;
        b=ArWvWp5pND/lULGeiiBYq6FEwP8p5dbr+MdcNPFR2BzY0chrPL6fMADb9DDlqSXbPp
         nGMaut7nZwa7plZh313G3DdV9Rhdbu8/dnIvEysC8NUXtwTofGM6qYax8bpercPIPKBO
         Z8sgFuTkhQXgmGDAxn536HqD06p0cEXUtYYnk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Hl6Pnq3xmamo6vmydBFzkBduZblIOAKNn76di+zQvGg=;
        b=IBtku/u3j1T2sUI6rhRJhzuHkzVMkWPILZz4iiOwgcEAaXrfqrkjlJoIT7K0+AamkP
         3sygErecG1p7NsBl+0GqCUZWZ7D8NeiTI96PEleSSxdh9aUWVJUv10hWvaVWWL6Jbed1
         XAng9ag/MVngF1eZFsl/GEJ9MtxzLvbGHiGWtZf0yD74PGL9oQro/WudqmA2Kz+F6D6M
         oy01oz0vCEkBG3VMSPRMeLF5t49moepHZdxReJSHcQUclR93yWjVb5nCIN83nSou0XeF
         Rh7zNWEwkCTyjgfKaJQ61x1Aj9/4HROUOucduAiiZl2Ya4j1LN/XFMwDBbA6JdrZrxT2
         3sVw==
X-Gm-Message-State: APjAAAWx0pp1gXqHK+VhD1Mtvvw4xq/4guLPT2iK/CmtkLMDpu2La3m9
        gH1pS3HFcuvxexqx1fP8WfBdrQ==
X-Google-Smtp-Source: APXvYqxyD53Q4D6YjfYZpwSQr5iBPVpFjp/1qcQRyBbAVksVmFchZUGIkAn9E7IYzwslmLgUq6AIFw==
X-Received: by 2002:a17:902:301:: with SMTP id 1mr936859pld.323.1561697089853;
        Thu, 27 Jun 2019 21:44:49 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id q13sm675562pgq.90.2019.06.27.21.44.48
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 27 Jun 2019 21:44:49 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>
Cc:     groeck@chromium.org, drinkcat@chromium.org,
        Douglas Anderson <dianders@chromium.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] block, bfq: NULL out the bic when it's no longer valid
Date:   Thu, 27 Jun 2019 21:44:09 -0700
Message-Id: <20190628044409.128823-1-dianders@chromium.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In reboot tests on several devices we were seeing a "use after free"
when slub_debug or KASAN was enabled.  The kernel complained about:

  Unable to handle kernel paging request at virtual address 6b6b6c2b

...which is a classic sign of use after free under slub_debug.  The
stack crawl in kgdb looked like:

 0  test_bit (addr=<optimized out>, nr=<optimized out>)
 1  bfq_bfqq_busy (bfqq=<optimized out>)
 2  bfq_select_queue (bfqd=<optimized out>)
 3  __bfq_dispatch_request (hctx=<optimized out>)
 4  bfq_dispatch_request (hctx=<optimized out>)
 5  0xc056ef00 in blk_mq_do_dispatch_sched (hctx=0xed249440)
 6  0xc056f728 in blk_mq_sched_dispatch_requests (hctx=0xed249440)
 7  0xc0568d24 in __blk_mq_run_hw_queue (hctx=0xed249440)
 8  0xc0568d94 in blk_mq_run_work_fn (work=<optimized out>)
 9  0xc024c5c4 in process_one_work (worker=0xec6d4640, work=0xed249480)
 10 0xc024cff4 in worker_thread (__worker=0xec6d4640)

Digging in kgdb, it could be found that, though bfqq looked fine,
bfqq->bic had been freed.

Through further digging, I postulated that perhaps it is illegal to
access a "bic" (AKA an "icq") after bfq_exit_icq() had been called
because the "bic" can be freed at some point in time after this call
is made.  I confirmed that there certainly were cases where the exact
crashing code path would access the "bic" after bfq_exit_icq() had
been called.  Sspecifically I set the "bfqq->bic" to (void *)0x7 and
saw that the bic was 0x7 at the time of the crash.

To understand a bit more about why this crash was fairly uncommon (I
saw it only once in a few hundred reboots), you can see that much of
the time bfq_exit_icq_fbqq() fully frees the bfqq and thus it can't
access the ->bic anymore.  The only case it doesn't is if
bfq_put_queue() sees a reference still held.

However, even in the case when bfqq isn't freed, the crash is still
rare.  Why?  I tracked what happened to the "bic" after the exit
routine.  It doesn't get freed right away.  Rather,
put_io_context_active() eventually called put_io_context() which
queued up freeing on a workqueue.  The freeing then actually happened
later than that through call_rcu().  Despite all these delays, some
extra debugging showed that all the hoops could be jumped through in
time and the memory could be freed causing the original crash.  Phew!

To make a long story short, assuming it truly is illegal to access an
icq after the "exit_icq" callback is finished, this patch is needed.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
Most of the testing of this was done on the Chrome OS 4.19 kernel with
BFQ backported (thanks to Paolo's help).  I did manage to reproduce a
crash on mainline Linux (v5.2-rc6) though.

To see some of the techniques used to debug this, see
<https://crrev.com/c/1679134> and <https://crrev.com/c/1681258/1>.

I'll also note that on linuxnext (next-20190627) I saw some other
use-after-frees that seemed related to BFQ but haven't had time to
debug.  They seemed unrelated.

 block/bfq-iosched.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index f8d430f88d25..6c0cff03f8f6 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -4584,6 +4584,7 @@ static void bfq_exit_icq_bfqq(struct bfq_io_cq *bic, bool is_sync)
 		unsigned long flags;
 
 		spin_lock_irqsave(&bfqd->lock, flags);
+		bfqq->bic = NULL;
 		bfq_exit_bfqq(bfqd, bfqq);
 		bic_set_bfqq(bic, NULL, is_sync);
 		spin_unlock_irqrestore(&bfqd->lock, flags);
-- 
2.22.0.410.gd8fdbe21b5-goog

