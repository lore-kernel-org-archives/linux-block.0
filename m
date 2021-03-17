Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE5CDC433DB
	for <linux-block@archiver.kernel.org>; Wed, 17 Mar 2021 13:55:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DABC64F50
	for <linux-block@archiver.kernel.org>; Wed, 17 Mar 2021 13:55:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231397AbhCQNzY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 Mar 2021 09:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231390AbhCQNy4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Mar 2021 09:54:56 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B89F7C06174A
        for <linux-block@vger.kernel.org>; Wed, 17 Mar 2021 06:54:55 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id j7so1920928wrd.1
        for <linux-block@vger.kernel.org>; Wed, 17 Mar 2021 06:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6+koUDgUdhyNVpKTDQb/68oSkvw0IUeSaffGL26hYQc=;
        b=bB8m4IZH/VEs52xpwKVFyPOHaFABjVnbtpwGDFmgoX0YLfSGIGWrgAebBs4g4lbrn/
         x7CrUpUhKgrDi0YELOaZ+M280A6JGF4bN9nhtjHGqO3VP93yMTfg37JBzedJbAUrK/Rg
         jse4yD6EsLN8neyHvXjbiqXv6TW9WddEwXkp3NxuaWvW7pwvNEipfI7EfOoY2swQIV+4
         StbBmH+JCZNYklfVEGm2pcFXi6luEWTGldG8B7Af5TiAKgQtCl2ZeR6Z3wLhZHa0J3N2
         CBcY6SKMVayeoh8Zfuuld4Hvjep9QfGzKswyM+tQD9R0lAUOn5y9uQH/lGGul/hw6/f5
         6paQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6+koUDgUdhyNVpKTDQb/68oSkvw0IUeSaffGL26hYQc=;
        b=M/pXt37s+8Z1Z7GNQGTb/lFe6KJiO1Vs5l8TGla+i9a8Ry05axGclrWHxAV+eSMraZ
         Ve7vIOrCsWjZekbY5RmkKm9BQKcrCdsFLFHnB4FcBk4X5Dh3lGiU4XjaKidKmEbAj1al
         tRZkpWQw5sBI5BRa7HXnqzScMqS77UcqwoGE57JG6gQS3ppHuSfvjFrHo87vduA435dI
         ts6l7edxh+kllgv8HIL4il4+Ko4X3UTzlREQrNBeWymlKcfgSVXqOzSlB3+d8cnjQKmf
         mOpgVDoZw2d9oQzR9zCP01kacs1E+/eih1rGL3Ye3+TuwcJUrHQtPECmyx7KYqOl3Rbk
         IEOw==
X-Gm-Message-State: AOAM533HQK+5TZHTGSncb/nBdOcxGloKVsdTxVzxDQ4ct6kjDY53a/tZ
        qQcUAyddZWyOlZewuc4vqZvxtwwprr3vKA==
X-Google-Smtp-Source: ABdhPJwEKzAV0Is/AHxVrj2u6U0w3vNIu3iL0g17wimVczMgZD6cWU1woYokZouJfMOEGc33dvjw0g==
X-Received: by 2002:a5d:4f0e:: with SMTP id c14mr4522066wru.78.1615989294465;
        Wed, 17 Mar 2021 06:54:54 -0700 (PDT)
Received: from localhost.localdomain ([185.69.144.157])
        by smtp.gmail.com with ESMTPSA id h20sm2528903wmm.19.2021.03.17.06.54.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 06:54:53 -0700 (PDT)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: [PATCH 5.12] nullb: fix use_after_free on rq timeout
Date:   Wed, 17 Mar 2021 13:50:50 +0000
Message-Id: <74a2c9ded02ead5b1fe2332e5f3e7cd2177dba97.1615987901.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

// insmod ./null_blk queue_mode=2 irqmode=2 completion_nsec=10000000000

[  332.929595] null_blk: rq 00000000ecf12d66 timed out
[  336.036131] ------------[ cut here ]------------
[  336.036139] refcount_t: underflow; use-after-free.
[  336.036155] WARNING: CPU: 0 PID: 0 at lib/refcount.c:28 refcount_warn_saturate+0xae/0xf0
[  336.036407] RIP: 0010:refcount_warn_saturate+0xae/0xf0
[  336.036467] Call Trace:
[  336.036470]  <IRQ>
[  336.036476]  blk_mq_free_request+0x140/0x150
[  336.036487]  blk_mq_end_request+0x129/0x140
[  336.036496]  end_cmd+0x30/0x80 [null_blk]
[  336.036516]  ? null_complete_rq+0x20/0x20 [null_blk]
[  336.036532]  null_cmd_timer_expired+0x12/0x20 [null_blk]
[  336.036546]  __hrtimer_run_queues+0x10d/0x2a0
[  336.036555]  hrtimer_interrupt+0x109/0x220
[  336.036561]  ? sched_clock_cpu+0x16/0xd0
[  	336.036573]  __sysvec_apic_timer_interrupt+0x69/0x120
[  336.036581]  sysvec_apic_timer_interrupt+0x77/0x90
[  336.036593]  </IRQ>
[  336.036596]  asm_sysvec_apic_timer_interrupt+0x12/0x20
...
[  336.036740] ---[ end trace bfb36b9c4f62fd9a ]---
[  339.756204] null_blk: rq 0000000050397c34 timed out
[  339.756934] null_blk: module loaded

In case of expiried NULL_IRQ_TIMER nullblk requests, first
null_timeout_rq() does blk_mq_complete_request() dropping a ref and not
removing killing cmd->timer, and then cmd->timer fires and gets
underflow in null_cmd_timer_expired(). Cancel hrtimer on blk-mq
request expiration.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---

non-NULL_IRQ_TIMER may also need some patching.

 drivers/block/null_blk/main.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index d6c821d48090..a87c3359f357 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -1451,8 +1451,16 @@ static bool should_requeue_request(struct request *rq)
 
 static enum blk_eh_timer_return null_timeout_rq(struct request *rq, bool res)
 {
+	struct nullb_cmd *cmd = blk_mq_rq_to_pdu(rq);
+
 	pr_info("rq %p timed out\n", rq);
-	blk_mq_complete_request(rq);
+
+	if (cmd->nq->dev->irqmode == NULL_IRQ_TIMER) {
+		if (hrtimer_try_to_cancel(&cmd->timer) != -1)
+			blk_mq_complete_request(rq);
+	} else {
+		blk_mq_complete_request(rq);
+	}
 	return BLK_EH_DONE;
 }
 
-- 
2.24.0

