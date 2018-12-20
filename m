Return-Path: <SRS0=9Hvz=O5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 323A6C43387
	for <linux-block@archiver.kernel.org>; Thu, 20 Dec 2018 16:00:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 014DD20645
	for <linux-block@archiver.kernel.org>; Thu, 20 Dec 2018 16:00:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="B3058spL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731160AbeLTQAU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Dec 2018 11:00:20 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:33787 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbeLTQAU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Dec 2018 11:00:20 -0500
Received: by mail-io1-f65.google.com with SMTP id t24so1218281ioi.0
        for <linux-block@vger.kernel.org>; Thu, 20 Dec 2018 08:00:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ddus5cogUDfousviziEGHBPNm2evGouhFp6p+7mm4XA=;
        b=B3058spL6ETNkbq2NfmTIDh82Yr1iS3ES9badUw2JvxpvN14kYAmRHezuK8GInyF1X
         hBnwj+CjfGi2VkeGJA/+XQrZG+5tePCCK82gCR8P2e2Uotcicl8NFDEIN8O9ya7hTNZ0
         1n6HVCegPotVTxbBzhKr5PfbkJVkxUvniY5oPtrI+UwJ+7BbOWGPeUlR49NAv4DSAMj4
         muwkw4+kxlOkEUy+XfBp7R2NOGpLBIDZQ6R/zkNPrBBZbeLM5fYM0uqGwLAo+/2P9ft1
         77lv66PL8cwAxqaAf+LCxbW01q/+Hqas83XwMWtxscy+8s11ckrWaDQsipGMIp4YGE5K
         GM9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ddus5cogUDfousviziEGHBPNm2evGouhFp6p+7mm4XA=;
        b=sByoSHDXJ+u3wa69HSiBDsihs1fssE+XDSmGBkDdwtjKQfMZdQLdn7bbP0P2QdLJvx
         ixo/f7MkE0suT8o4U09xBACUr8TErL5vtLyK/uYnQTMY1glzDRlH753czMXZG4XOSp8J
         mysm1MWW1I+z3OZ6HSpBrC5RpNPqCZXREzGb+OP8KA5llyDWwFqI9PZ43tkXC05mYa5V
         gP0V/jIMp2cTB5SkpcoXxodurpiVpMdJBNnEYzDDXwBzaeUaFVktMDacKfoXr/7DqIRi
         c9QEw1yfds2odePqP8eWx+bHIXZhnnrBON/FLHwjVvlnVdcodQZyfRFhacKLrGuirlHo
         WFHw==
X-Gm-Message-State: AJcUukf8RM13HIpgPcLouWo07ALr4oDrWO66mgM+1go5YQmr/L/HXTsm
        Mam1sl4t5OwQp+ovZnJXSW2kE0H2wukl0Q==
X-Google-Smtp-Source: AFSGD/UauujqFPDi16iblcmgajpnrox2ZMGsUXKy2Y8uo5sXWPa7HGr9QALFbhF0vs5RbkFzd3PFtQ==
X-Received: by 2002:a6b:d101:: with SMTP id l1mr4317606iob.81.1545321618891;
        Thu, 20 Dec 2018 08:00:18 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id v189sm4950904itb.42.2018.12.20.08.00.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 08:00:17 -0800 (PST)
Subject: Re: [PATCH 2/2] kyber: use sbitmap add_wait_queue/list_del wait
 helpers
To:     linux-block@vger.kernel.org
Cc:     ming.lei@redhat.com, osandov@osandov.com
References: <20181220155515.31202-1-axboe@kernel.dk>
 <20181220155515.31202-3-axboe@kernel.dk>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <7b00146c-3c7d-2a94-7e58-51e08326518b@kernel.dk>
Date:   Thu, 20 Dec 2018 09:00:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181220155515.31202-3-axboe@kernel.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/20/18 8:55 AM, Jens Axboe wrote:
> sbq_wake_ptr() checks sbq->ws_active to know if it needs to loop
> the wait indexes or not. This requires the use of the sbitmap
> waitqueue wrappers, but kyber doesn't use those for its domain
> token waitqueue handling.
> 
> Convert kyber to use the helpers. This fixes a hang with waiting
> for domain tokens.
> 
> Fixes: 5d2ee7122c73 ("sbitmap: optimize wakeup check")
> Reported-by: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---

That sent out a wrong one, here's the right one...

diff --git a/block/kyber-iosched.c b/block/kyber-iosched.c
index de78e8aa7b0a..ec6a04e01bc1 100644
--- a/block/kyber-iosched.c
+++ b/block/kyber-iosched.c
@@ -195,7 +195,7 @@ struct kyber_hctx_data {
 	unsigned int batching;
 	struct kyber_ctx_queue *kcqs;
 	struct sbitmap kcq_map[KYBER_NUM_DOMAINS];
-	wait_queue_entry_t domain_wait[KYBER_NUM_DOMAINS];
+	struct sbq_wait domain_wait[KYBER_NUM_DOMAINS];
 	struct sbq_wait_state *domain_ws[KYBER_NUM_DOMAINS];
 	atomic_t wait_index[KYBER_NUM_DOMAINS];
 };
@@ -501,10 +501,11 @@ static int kyber_init_hctx(struct blk_mq_hw_ctx *hctx, unsigned int hctx_idx)
 
 	for (i = 0; i < KYBER_NUM_DOMAINS; i++) {
 		INIT_LIST_HEAD(&khd->rqs[i]);
-		init_waitqueue_func_entry(&khd->domain_wait[i],
+		khd->domain_wait[i].sbq = NULL;
+		init_waitqueue_func_entry(&khd->domain_wait[i].wait,
 					  kyber_domain_wake);
-		khd->domain_wait[i].private = hctx;
-		INIT_LIST_HEAD(&khd->domain_wait[i].entry);
+		khd->domain_wait[i].wait.private = hctx;
+		INIT_LIST_HEAD(&khd->domain_wait[i].wait.entry);
 		atomic_set(&khd->wait_index[i], 0);
 	}
 
@@ -698,12 +699,13 @@ static void kyber_flush_busy_kcqs(struct kyber_hctx_data *khd,
 			     flush_busy_kcq, &data);
 }
 
-static int kyber_domain_wake(wait_queue_entry_t *wait, unsigned mode, int flags,
+static int kyber_domain_wake(wait_queue_entry_t *wqe, unsigned mode, int flags,
 			     void *key)
 {
-	struct blk_mq_hw_ctx *hctx = READ_ONCE(wait->private);
+	struct blk_mq_hw_ctx *hctx = READ_ONCE(wqe->private);
+	struct sbq_wait *wait = container_of(wqe, struct sbq_wait, wait);
 
-	list_del_init(&wait->entry);
+	sbitmap_del_wait_queue(wait);
 	blk_mq_run_hw_queue(hctx, true);
 	return 1;
 }
@@ -714,7 +716,7 @@ static int kyber_get_domain_token(struct kyber_queue_data *kqd,
 {
 	unsigned int sched_domain = khd->cur_domain;
 	struct sbitmap_queue *domain_tokens = &kqd->domain_tokens[sched_domain];
-	wait_queue_entry_t *wait = &khd->domain_wait[sched_domain];
+	struct sbq_wait *wait = &khd->domain_wait[sched_domain];
 	struct sbq_wait_state *ws;
 	int nr;
 
@@ -725,11 +727,11 @@ static int kyber_get_domain_token(struct kyber_queue_data *kqd,
 	 * run when one becomes available. Note that this is serialized on
 	 * khd->lock, but we still need to be careful about the waker.
 	 */
-	if (nr < 0 && list_empty_careful(&wait->entry)) {
+	if (nr < 0 && list_empty_careful(&wait->wait.entry)) {
 		ws = sbq_wait_ptr(domain_tokens,
 				  &khd->wait_index[sched_domain]);
 		khd->domain_ws[sched_domain] = ws;
-		add_wait_queue(&ws->wait, wait);
+		sbitmap_add_wait_queue(domain_tokens, ws, wait);
 
 		/*
 		 * Try again in case a token was freed before we got on the wait
@@ -745,10 +747,10 @@ static int kyber_get_domain_token(struct kyber_queue_data *kqd,
 	 * between the !list_empty_careful() check and us grabbing the lock, but
 	 * list_del_init() is okay with that.
 	 */
-	if (nr >= 0 && !list_empty_careful(&wait->entry)) {
+	if (nr >= 0 && !list_empty_careful(&wait->wait.entry)) {
 		ws = khd->domain_ws[sched_domain];
 		spin_lock_irq(&ws->wait.lock);
-		list_del_init(&wait->entry);
+		sbitmap_del_wait_queue(wait);
 		spin_unlock_irq(&ws->wait.lock);
 	}
 
@@ -951,7 +953,7 @@ static int kyber_##name##_waiting_show(void *data, struct seq_file *m)	\
 {									\
 	struct blk_mq_hw_ctx *hctx = data;				\
 	struct kyber_hctx_data *khd = hctx->sched_data;			\
-	wait_queue_entry_t *wait = &khd->domain_wait[domain];		\
+	wait_queue_entry_t *wait = &khd->domain_wait[domain].wait;	\
 									\
 	seq_printf(m, "%d\n", !list_empty_careful(&wait->entry));	\
 	return 0;							\

-- 
Jens Axboe

