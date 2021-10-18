Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F299DC43217
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 14:15:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E042860F9F
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 14:15:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233289AbhJRORc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Oct 2021 10:17:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232376AbhJROR3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Oct 2021 10:17:29 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07268C035458;
        Mon, 18 Oct 2021 06:56:27 -0700 (PDT)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634565384;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FbuCZW8tC6lqui4GKA5A6qN/AO3jQkqlVwJsCa0MEiE=;
        b=qT2k7Sr82VQ/j+wajtD2cTX7/obyF355c7t3mMPtSKlv2+sW5GTiJRtBJutYSUC3hpGuLp
        ZSZR3YmljNGRRfY2/rmdBlm9zWLaD+kDzWbB343L/b0CZ4MES6fDycnZVmorXfIFx2Gtop
        tKpvTnLRAdAjzceUBw64EPgOZ2CHux7oYyC65b3Zxwq+Vl9slBwcm4FFnuq6YjA3+UOtoX
        xS2i17fN8bAtsi0tSMBeTkGrduBONTcxW1qXIz4RAjMXoWY+TgvlUQEbeLUeJ1wfb5sDGi
        H1mw/4PgmtSghJTJ/P1ApCWl2Ql715oZYY/xvroWwB8pzek2l70wJzghDbg3tQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634565384;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FbuCZW8tC6lqui4GKA5A6qN/AO3jQkqlVwJsCa0MEiE=;
        b=1fxZFlhr2viQpNxxJBLFG56b/9Nl7gH/dFrCtdg2add+ZojEselG+czI1KBMfm7OvunkGn
        tOfhhWCD/MNMQbBQ==
To:     linux-block@vger.kernel.org, linux-mmc@vger.kernel.org
Cc:     tglx@linutronix.de, Ulf Hansson <ulf.hansson@linaro.org>,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v2 2/2] mmc: core: Use blk_mq_complete_request_direct().
Date:   Mon, 18 Oct 2021 15:55:59 +0200
Message-Id: <20211018135559.244400-3-bigeasy@linutronix.de>
In-Reply-To: <20211018135559.244400-1-bigeasy@linutronix.de>
References: <20211018135559.244400-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The completion callback for the sdhci-pci device is invoked from a
kworker.
I couldn't identify in which context is mmc_blk_mq_req_done() invoke but
the remaining caller are from invoked from preemptible context. Here it
would make sense to complete the request directly instead scheduling
ksoftirqd for its completion.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/mmc/core/block.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 431af5e8be2f8..7d6b43fe52e8a 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -2051,7 +2051,8 @@ static void mmc_blk_mq_dec_in_flight(struct mmc_queue=
 *mq, struct request *req)
 		mmc_put_card(mq->card, &mq->ctx);
 }
=20
-static void mmc_blk_mq_post_req(struct mmc_queue *mq, struct request *req)
+static void mmc_blk_mq_post_req(struct mmc_queue *mq, struct request *req,
+				bool can_sleep)
 {
 	struct mmc_queue_req *mqrq =3D req_to_mmc_queue_req(req);
 	struct mmc_request *mrq =3D &mqrq->brq.mrq;
@@ -2063,10 +2064,14 @@ static void mmc_blk_mq_post_req(struct mmc_queue *m=
q, struct request *req)
 	 * Block layer timeouts race with completions which means the normal
 	 * completion path cannot be used during recovery.
 	 */
-	if (mq->in_recovery)
+	if (mq->in_recovery) {
 		mmc_blk_mq_complete_rq(mq, req);
-	else if (likely(!blk_should_fake_timeout(req->q)))
-		blk_mq_complete_request(req);
+	} else if (likely(!blk_should_fake_timeout(req->q))) {
+		if (can_sleep)
+			blk_mq_complete_request_direct(req, mmc_blk_mq_complete);
+		else
+			blk_mq_complete_request(req);
+	}
=20
 	mmc_blk_mq_dec_in_flight(mq, req);
 }
@@ -2087,7 +2092,7 @@ void mmc_blk_mq_recovery(struct mmc_queue *mq)
=20
 	mmc_blk_urgent_bkops(mq, mqrq);
=20
-	mmc_blk_mq_post_req(mq, req);
+	mmc_blk_mq_post_req(mq, req, true);
 }
=20
 static void mmc_blk_mq_complete_prev_req(struct mmc_queue *mq,
@@ -2106,7 +2111,7 @@ static void mmc_blk_mq_complete_prev_req(struct mmc_q=
ueue *mq,
 	if (prev_req)
 		*prev_req =3D mq->complete_req;
 	else
-		mmc_blk_mq_post_req(mq, mq->complete_req);
+		mmc_blk_mq_post_req(mq, mq->complete_req, true);
=20
 	mq->complete_req =3D NULL;
=20
@@ -2178,7 +2183,8 @@ static void mmc_blk_mq_req_done(struct mmc_request *m=
rq)
 	mq->rw_wait =3D false;
 	wake_up(&mq->wait);
=20
-	mmc_blk_mq_post_req(mq, req);
+	/* context unknown */
+	mmc_blk_mq_post_req(mq, req, false);
 }
=20
 static bool mmc_blk_rw_wait_cond(struct mmc_queue *mq, int *err)
@@ -2238,7 +2244,7 @@ static int mmc_blk_mq_issue_rw_rq(struct mmc_queue *m=
q,
 	err =3D mmc_start_request(host, &mqrq->brq.mrq);
=20
 	if (prev_req)
-		mmc_blk_mq_post_req(mq, prev_req);
+		mmc_blk_mq_post_req(mq, prev_req, true);
=20
 	if (err)
 		mq->rw_wait =3D false;
--=20
2.33.0

