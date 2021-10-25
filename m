Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A81BC433EF
	for <linux-block@archiver.kernel.org>; Mon, 25 Oct 2021 07:07:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0456760EFF
	for <linux-block@archiver.kernel.org>; Mon, 25 Oct 2021 07:07:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbhJYHJ1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Oct 2021 03:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230472AbhJYHJ0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Oct 2021 03:09:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE529C061745;
        Mon, 25 Oct 2021 00:07:04 -0700 (PDT)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1635145621;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Qw8LYIRUW5MohI8nU8fJVIRK2sGNzquW52Vwd2NNTmY=;
        b=2g8rgjSZEQrjnOdVOUArn8AAUfI9L3Rl7Ak5o8RfGhJjnc0lq4rb8hKkUdsc1nd/ZPVvXA
        IIdVPtN0ORQoCour+jUXJk7Js2WSQxt2tn4IwOpvkOt3i6Ywk5Tu9WVS8KkDBRsQjVU8zh
        YjY2Vw/M47BYFduWURHYfqCHl4vEPNJ5QM+r6UIUPwwOleWqNE5OWEKLRdTWgoIjSct7TG
        ZzmNJqqG9KYp7tVtvM/yHjWYZtTpA+jFYhZQxTxA77oKdJ9O64pC5kRQ69rB5NoLNIafjU
        9f+33lM7WDatG4GTxo0b3gqgkyzZW+FCWCDTHVeLZgvDgo+C2TQ6CHnh0eKKJg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1635145621;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Qw8LYIRUW5MohI8nU8fJVIRK2sGNzquW52Vwd2NNTmY=;
        b=jzM9EPBtVRGbBvx6fGtpk9AHiJ4UNHdPAxkor07WfrZ1B6axA035eolu7V6i/PPRqnoG5a
        HWm9s/77/gHlnuBg==
To:     linux-block@vger.kernel.org, linux-mmc@vger.kernel.org
Cc:     tglx@linutronix.de, Ulf Hansson <ulf.hansson@linaro.org>,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v3 1/2] blk-mq: Add blk_mq_complete_request_direct()
Date:   Mon, 25 Oct 2021 09:06:57 +0200
Message-Id: <20211025070658.1565848-2-bigeasy@linutronix.de>
In-Reply-To: <20211025070658.1565848-1-bigeasy@linutronix.de>
References: <20211025070658.1565848-1-bigeasy@linutronix.de>
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
index 13ba1861e688f..4c0bd305891aa 100644
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
+		   void (*complete)(struct request *rq))
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

