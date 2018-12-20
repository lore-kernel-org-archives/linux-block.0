Return-Path: <SRS0=9Hvz=O5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56494C43387
	for <linux-block@archiver.kernel.org>; Thu, 20 Dec 2018 16:01:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25FBB20645
	for <linux-block@archiver.kernel.org>; Thu, 20 Dec 2018 16:01:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="wPfJ4U5O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731654AbeLTQB5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Dec 2018 11:01:57 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:37100 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731635AbeLTQB5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Dec 2018 11:01:57 -0500
Received: by mail-io1-f68.google.com with SMTP id k4so1204570iop.4
        for <linux-block@vger.kernel.org>; Thu, 20 Dec 2018 08:01:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GAH+nRBrJvV+C2KRMcJCO0VU6aOQWle7L/rpTK098Mk=;
        b=wPfJ4U5OgVUzI68v4xLMo0DJ3XgowymJB+71CAl/IFal9OqPKxZfkoIll/XCGtzUYQ
         J/jhe5LdM4io2mUzmUhgrf/I5BHos8kFy8K/dXRoGsD4SvL1Q7hUrY82ibp8s6S1PJPq
         wcFNTL6sGpT4S92nAFMyTUsA1beTUfJ1gEknfiDqgUcPeFskzZ1564NpSZgqSeHh2HlR
         tv60VA8oZuWkN6iPkhy3PlRv0jxYE1iKBW2mu2CUzi1C5utSExgy2iaq6bm7Qu0NPIw5
         VFuiIOwYDQrA3DtLal4ZcQkPkHo6hZiUpJD7c+gb4ylOiekRlMJsGBlKX4rZ8IjRDB57
         MkAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GAH+nRBrJvV+C2KRMcJCO0VU6aOQWle7L/rpTK098Mk=;
        b=ExpcosfYrHeh8AFF8e0uvxE4BV8iLdrGH1IL0gYcZixKGGD+w+K9Um6zPAk7gY7j6E
         HWZL6vJgI44JAjsDr8+GAhLhHzr6bQ1q1+pq2cMKYus0nEDzC7aYCh0twViGuRa+xSTB
         9OZTLuigkapArQ3Il9y/kCr4qHMXf9Obm2rk3635ibx5MeEYVrxxQoPVEH6J1hWENTWO
         34wOOWujrtSlZi03XY3KKWLkuQZgBydjZufaXMl+rSFR2/zqjCerWzIul27ceEiUU1YA
         /2/SW2KITat8VeXbKgUMW4lQD55MbEnhOrbh7XiBzhywiw8HwA/PpBFfe5UgknOkliD6
         1ZUA==
X-Gm-Message-State: AA+aEWaTmbeFBFG/W9R1l8cL6zUHl+8PhEu39Lp/yZkg766Qx53puGXR
        g4t11hqjwzM932oXaCt/xz8CqEpgfHyoWg==
X-Google-Smtp-Source: AFSGD/V/KtOiwxHdMMMksnsYjEIZUXriajt3izgPKH4nd/uHRBa17XrJiyTAiPqotSxWeZnamhIDLQ==
X-Received: by 2002:a6b:156:: with SMTP id 83mr21031061iob.63.1545321715336;
        Thu, 20 Dec 2018 08:01:55 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id x99sm4974365ita.23.2018.12.20.08.01.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 08:01:54 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     ming.lei@redhat.com, osandov@osandov.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 2/2] kyber: use sbitmap add_wait_queue/list_del wait helpers
Date:   Thu, 20 Dec 2018 09:01:49 -0700
Message-Id: <20181220160149.4042-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181220160149.4042-1-axboe@kernel.dk>
References: <20181220160149.4042-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

sbq_wake_ptr() checks sbq->ws_active to know if it needs to loop
the wait indexes or not. This requires the use of the sbitmap
waitqueue wrappers, but kyber doesn't use those for its domain
token waitqueue handling.

Convert kyber to use the helpers. This fixes a hang with waiting
for domain tokens.

Fixes: 5d2ee7122c73 ("sbitmap: optimize wakeup check")
Reported-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/kyber-iosched.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

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
2.17.1

