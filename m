Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792747580;
	b=38KhmhBwOmnAefmfLj0pfS6Jt3sWHQIKs2hLKpKX5Xaq5JU43nGrig82v4mogCdv63J4
	 u0tlYBU97Ah7wVBv5pXMMRcOXYvoAwmxqLTGYDNNQm+oDwesAF5S6HaKGthcWhncAnxxF
	 dr0iWbZARALjDpU1/4UoTHyrOnJaows1Z2aZFP0b4P+rKMOao5xugoPlejJyGHzEWcly8
	 9MInSXk1afEBosM7M2J+YGZyl0Fk+nDNq8vaUOGL1ZNsA+9TrtZTandg5I7OpOcf/neGk
	 j2fQmb6oV6xj2t8BKUoUAuVH3CEtev+tT0ODJGpxb3iI+L7X366CYdDFmJeRZL2P4Yw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792747580;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=kS1Z5LCsa+qRBaBJIS5asNgQIOLlArqrMwVB7Pu9irg=;
	b=R0OYUQ1Te/iYv1JZPkg+hJ0ZvMvoOYPQO9wZKB6rjA2f6puhvcm5jTpLK451AntsbaYy
	 Mimhl8K3iKpbzO2xvBvSTkE4TVYmSSJuBvycbRtUrte38fvbkNPKArmReqA/hymd5+ExZ
	 DyACJVVSoZhjn0w7PrvJIH9VToZcDj95ZFpMtWzaWmhJK3nTKqQi72l1O9q1gQX4q3N2l
	 9tKi9CzaBRN/CA68hSmK4kXJ+tLglSFeAPBElJCU5XkvG8AECu4cdfw04KpkN+bC5bFsv
	 vqeGe9UiFhLEJanAS+GOwnI3G7eYSzFTd7AD1iUtJpSuspJp7D/mvrvwfXeGTzJdvbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=aye1zcez;
	arc=none smtp.remote-ip=209.85.216.44
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A95606A31D
	for <linux-block@vger.kernel.org>; Fri, 23 Oct 2026 09:26:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C5A95606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=aye1zcez
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3ab41538192so514437a91.0
        for <linux-block@vger.kernel.org>; Fri, 23 Oct 2026 02:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792747579; x=1793352379; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=kS1Z5LCsa+qRBaBJIS5asNgQIOLlArqrMwVB7Pu9irg=;
        b=aye1zceze7CiaTprYqf7PTybamY+omzp0KHLB4UaPBglrTNLqCqxTJ+nqcr1i2cFU+
         xu7T6P7coPrPJFfOaHLTHQ8dii2XHZXhhDN3MhNpxmnvvB/wgUgbasZxAOH7P85ZOKlZ
         zdYNxXW4v1vhvFPZxR1XNWeZIfddtjV4QRX8jn1QLHJWVc2TRwI9QWNxe2CLPfG+mDen
         twpF2AiPqd069e2f5B+L/OwEaGrH3PilfWW7mKtBsAkRRRBbrV6Ph5nFMd6i2wDb2P9Q
         aKOpdtqDsfjFvLQsccZrQfLT9VY5/1KrcNMyMEf1l1LlcI3zxcxyBXafm9B2WgMZzNXG
         bJOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792747579; x=1793352379;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kS1Z5LCsa+qRBaBJIS5asNgQIOLlArqrMwVB7Pu9irg=;
        b=a2gA5wK6q1PLRVEPla0TIA4shMB+lJ8p4Jo9JfIyZz9qeBhdZr4s134Oj4q/QM/sTq
         xrkFBfaQqzNQeORInT0v5kM/RPR3bhpXmeYJ4O4J+d8WLmvJd0JJQe3vi0qv8l6QB79I
         dSLxNfMqpgYrfGv39vj0Syg2RuDRn7Ts3/x9x4sZz+dtOcy3n3v4jHilddGQyLXxi/5K
         cXj5TIdbdPtC6/RqAhCxLC/En1ozwKyLNMdQ/c8WhWhn0CKnM7h/jFKEJn/auIgczFPZ
         8Beoy2TULt8swFBS1Dw+HAlsznQNCSZth7X2h/HO/J8GepDKTq7rZQo7bANdUTY0R3en
         3rlA==
X-Gm-Message-State: AFq9FYJRkJliGHsH2FKGYMZfwkTqAe0eQjNmpYe1BdSxfe0vcLXUzmKL
	NlK6PzKviil++2xvgvkXJ4g65zw8UdRhG1wzXvrnDYvATIDzCEy64xJ6aoernuA1p2c=
X-Gm-Gg: AYBFou3UCAPNayVus4yAfK8dQin7XUkyefkL8zPGFCHtNjnat7KIQzVO71uAL1fyQnY
	QSdSmhmVSGrlwot4FTb23p2jEnfOBopnWI4PwdaJVq8ljhzjBBm5JYH2XMud3kIpl4RNmULybaH
	B6sUyjDSt66uPBhOj7Wtg3AfGav2UngvGTSeJ2cJPX143twTzZ0/UW4gDId6y2PCDQMiPTswMI+
	xvGnIMexKO9UwUWfpmhRun0azI+xD1HV2Ytl+TxbJy73bsJW9SG2KlUC2L+QRd0QJ+lqdoyLrzo
	/Jan+TyuWefKXoiGcB+tUvcTwlrQSl30jdMUp3/VIfJJT2zvK024t+6CjhUKJZCUFUfpnOzzL/j
	tySqRKFLUHLC5B5p6RjPlo5J9oWYIAJ7bFHDblNVpsDrWHWB8byDrPjxjYEQ5XyPYmS12fgatfB
	VCWCM7rPp3arbgbpqJ3G28l2oEM1aD+gqA88d3rCXfTbBMBegiVjELHRecwoKsQqsfJgvMhBEPQ
	QGWCIIhfLN58Kb6ceeFKQFA8+xjon/2yXUiBTCQOC10Zp29ykPn9cne0Y8ihYss+jzf9Qw252vi
	hQ+Gg7Jl+kmpdsW8C2Y=
X-Received: by 2002:a17:90b:1844:b0:3a0:9c9d:eb18 with SMTP id 98e67ed59e1d1-3adce0a49d3mr1376081a91.54.1792747579117;
        Fri, 23 Oct 2026 02:26:19 -0700 (PDT)
Received: from 4ce604c9y2.bytedance.net ([61.213.176.58])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ada49366fdsm7975741a91.14.2026.10.23.02.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 02:26:18 -0700 (PDT)
From: Jianan Huang <jnhuang95@gmail.com>
To: linux-block@vger.kernel.org,
	axboe@kernel.dk
Cc: linux-kernel@vger.kernel.org,
	ming.lei@redhat.com,
	Jianan Huang <jnhuang95@gmail.com>
Subject: [PATCH] blk-mq: reset queue state on scheduler teardown
Date: Fri, 23 Oct 2026 17:26:11 +0800
Message-ID: <20261023092611.116795-1-jnhuang95@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We observed I/O timeouts with requests stalled in per-CPU software
queues.

The affected queue had no elevator, but QUEUE_FLAG_SQ_SCHED remained
set. A failed elevator switch can leave this state when falling back to
none without clearing the flag. With empty hctx dispatch lists, a
queue-wide restart on CPU4 would skip requests pending in ctx5/ctx7:

CPU4: blk_mq_run_hw_queues(q)
  sq_hctx = hctx4
  hctx4: no pending requests   -> selected
  hctx5: 9 reads in ctx5       -> skipped
  hctx7: 3 writes in ctx7      -> skipped

The pending requests may remain undispatched until another event runs
their hardware queues.

Clear the flag and restore nr_requests and async_depth to the driver
queue depth in the common scheduler teardown path, covering both
scheduler exit and failed initialization.

Fixes: 4d337cebcb1c ("blk-mq: avoid to touch q->elevator without any protection")
Assisted-by: LLM
Signed-off-by: Jianan Huang <jnhuang95@gmail.com>
---
 block/blk-mq-sched.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 0a00f5a76f5a..d7b45778732b 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -374,7 +374,7 @@ bool blk_mq_sched_try_insert_merge(struct request_queue *q, struct request *rq,
 }
 EXPORT_SYMBOL_GPL(blk_mq_sched_try_insert_merge);
 
-/* called in queue's release handler, tagset has gone away */
+/* Clear scheduler tags and reset queue state. */
 static void blk_mq_sched_tags_teardown(struct request_queue *q, unsigned int flags)
 {
 	struct blk_mq_hw_ctx *hctx;
@@ -385,6 +385,10 @@ static void blk_mq_sched_tags_teardown(struct request_queue *q, unsigned int fla
 
 	if (blk_mq_is_shared_tags(flags))
 		q->sched_shared_tags = NULL;
+
+	blk_queue_flag_clear(QUEUE_FLAG_SQ_SCHED, q);
+	q->nr_requests = q->tag_set->queue_depth;
+	q->async_depth = q->tag_set->queue_depth;
 }
 
 void blk_mq_sched_reg_debugfs(struct request_queue *q)
-- 
2.43.0

