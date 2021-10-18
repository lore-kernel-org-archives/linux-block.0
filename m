Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F7ADC4332F
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 13:58:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C515610E8
	for <linux-block@archiver.kernel.org>; Mon, 18 Oct 2021 13:58:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234600AbhJROAk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Oct 2021 10:00:40 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38726 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234719AbhJRN6h (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Oct 2021 09:58:37 -0400
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634565384;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UAapEy9YV68gpvvIuJBv9mDji+Afov+c7/4D1dx5Wow=;
        b=mIvXHdED577fcCOw12dEbFJnsn2Kf1zCO7QkjFph79WqpAjnfqy0ikn9K2u6uYyBo2FfAq
        JO00KuhW7Z85Ie2wI5SrNozXfvDnofuPnbp1qckgRgMc2PaZQPv3FvbmVEUfHdZJ1h/QJO
        ncgIAT8PGo1Fo1RlSB4oVXPRu5Lq9owyC+RIzcQnYDBMkkQcL9LT1WOoFp1X0KXCg93kzv
        EdWbxEeDyclvnekG87xjbRKP4Gb93/S4FcRWiQSC0eCNvD8Uubf8GVEOYPOV8p5pI8ElB6
        hapERUHDZcGG8RVztokfaA6mV9AbMy8OEap8BGfjzoNNAzjpEsdJ0G6HBBVueA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634565384;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UAapEy9YV68gpvvIuJBv9mDji+Afov+c7/4D1dx5Wow=;
        b=4wdtSV1PXeczY/kLT/2UCZxfMlmFyI+oc5a94yCPCVHbhYDVxlL6t3QAGnoOfGDFv0OtLA
        4Teo5m+zVqQqsDCQ==
To:     linux-block@vger.kernel.org, linux-mmc@vger.kernel.org
Cc:     tglx@linutronix.de, Ulf Hansson <ulf.hansson@linaro.org>,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v2 1/2] blk-mq: Add blk_mq_complete_request_direct()
Date:   Mon, 18 Oct 2021 15:55:58 +0200
Message-Id: <20211018135559.244400-2-bigeasy@linutronix.de>
In-Reply-To: <20211018135559.244400-1-bigeasy@linutronix.de>
References: <20211018135559.244400-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add blk_mq_complete_request_direct() which completes the block request
directly instead deferring it to softirq for single queue devices.

This is useful for devices which complete the requests in preemptible
context and raising softirq from means scheduling ksoftirqd.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/blk-mq.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 13ba1861e688f..93780c890b479 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -521,6 +521,17 @@ static inline void blk_mq_set_request_complete(struct =
request *rq)
 	WRITE_ONCE(rq->state, MQ_RQ_COMPLETE);
 }
=20
+/*
+ * Complete the request directly instead of deferring it to softirq or
+ * completing it another CPU. Useful in preemptible instead of an interrup=
t.
+ */
+static inline void blk_mq_complete_request_direct(struct request *rq,
+						  void (*complete)(struct request *rq))
+{
+	WRITE_ONCE(rq->state, MQ_RQ_COMPLETE);
+	complete(rq);
+}
+
 void blk_mq_start_request(struct request *rq);
 void blk_mq_end_request(struct request *rq, blk_status_t error);
 void __blk_mq_end_request(struct request *rq, blk_status_t error);
--=20
2.33.0

