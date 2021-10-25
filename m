Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 298AAC4332F
	for <linux-block@archiver.kernel.org>; Mon, 25 Oct 2021 07:07:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15F7C60F9C
	for <linux-block@archiver.kernel.org>; Mon, 25 Oct 2021 07:07:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbhJYHJZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Oct 2021 03:09:25 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:52918 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231134AbhJYHJY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Oct 2021 03:09:24 -0400
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1635145621;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vH+73vDvv7GuENHB3PghTqwm9bAPTvpImmgcXPHzm+c=;
        b=pYY8oZiBH+iN9U8+wa9/3VG5SONuhEB4EuKWU/hiqH2l4559DLdjMZEO2wclq0DKJzXOIM
        VvLsM76/tJA9/QfsfwI2HJFEeylvdzQNAjW/FpBu/AvDttEOARGllBudFt9o19Z2WEmcIt
        8qhkks7gOm/nAhW1B8Do8/z/vaGM+XCKS2J0Y0Xhj0nVLXGTJsWcAL/zCycbq6HyhQFknN
        5wYhKqeI5KL6deReiGwwlVGk9f3ZL88zhaiWU2bJ7daA63mcyiHegP64anfIVHFOosk5jK
        hXctl+1Iuyk1mUKEOZFy3+Zh++24e47waSRzHQF6U9WDELpAhPgL6xikGjr5Gw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1635145621;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vH+73vDvv7GuENHB3PghTqwm9bAPTvpImmgcXPHzm+c=;
        b=3x3N2IaWSQNv6pIhZ2YJhTd0YmV68EN3U4cjzrrySFBaZljxxRULNoANEoaRgCeFbwDA3S
        z1FXmp0zRq6u6pBg==
To:     linux-block@vger.kernel.org, linux-mmc@vger.kernel.org
Cc:     tglx@linutronix.de, Ulf Hansson <ulf.hansson@linaro.org>,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH v3 2/2] mmc: core: Use blk_mq_complete_request_direct().
Date:   Mon, 25 Oct 2021 09:06:58 +0200
Message-Id: <20211025070658.1565848-3-bigeasy@linutronix.de>
In-Reply-To: <20211025070658.1565848-1-bigeasy@linutronix.de>
References: <20211025070658.1565848-1-bigeasy@linutronix.de>
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
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
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

