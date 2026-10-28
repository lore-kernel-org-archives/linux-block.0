Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793205893;
	b=mZfejCo5DG1nX8yGUZ6Byi0V1BWBfslMu5UjZx9/Yt8SJ1Zxyj5XbiE6DBUmvF39203I
	 jyTy2QoVvvg57ICEx6i6f4KaRcYmnDcWqT/zS7yZvwY2ImyXk/CFaeX31wlEsyU2CuiH2
	 8JqsTs6tQViUzI3bWx+1S8hDRRi3zMTSsnwGnm7jx92IGCAnSIN2G95o7yP3yXMWTiD8h
	 db5+2DjWg/Tp02GYgaoZBCYlZBFsUoHSZ/De8a89Xgm0Stqm7ih1cilllN+zBKYhtVT3A
	 JGR/ZM82x+n2ugI2nrsFFGNq1pUT6UiINCljR3Z8qDWO3/+Kh19YWug9cMCj6eB7jpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205893;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=NopKNI1TscCvs8AXqOgByddNyfZiOAXivM+rgWj+cp0=;
	b=2s1EJxrnU5gLrgA/n5s1/P58fH3ItudRDynkA7UO8L9u0YmJKqDoe55ZLofsmvSgfa+J
	 vc2gm96Q1kt7y2DO0NSCp1ssac1xWL2M5QJ0YpYZetddiBBHf1NvpOuT5ThjoTJA2uxQY
	 tt7dNAIuqdzqjnSBbuw6/FaZ9jOMUtK+3kPpBVR4GoKZktBOi7hP4K89Lg3Him5blkSB1
	 JH/cQ4ZXF21hLRoMptdArpmAdBKwDmHQDBxgHrOw2/aJfNoIWlRVbNLZ6AV0nlMuhpFoZ
	 uk3QugZ6IehwEzGcvIwG2wS3PanTY4iRJLWURgOegx/xddJ2GfoQVJVVztBevzB59Xg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=lDJWSqw1;
	arc=none smtp.remote-ip=209.85.161.43
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02BEA606A321
	for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 16:44:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 02BEA606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=lDJWSqw1
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-6fe4372c5f3so836948eaf.3
        for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 09:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793205892; x=1793810692; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NopKNI1TscCvs8AXqOgByddNyfZiOAXivM+rgWj+cp0=;
        b=lDJWSqw1Ns1vKTcCsiZ6i4ZOKj42HYhi+Rtyh25khn9/wOvd+a7wiWc3qjtDOjx/uX
         uIfyO4DH3OFiWkkMNJJw4xlozB33CAcK4onXBQokq00MMM14nn0Jh5DbY0/AAYIWHeOu
         gVuvzczCDGqY2tj5ddZl0/DDjHt+HwWA/sndgkqB3Rfu+nfgmdhIMqurDe0H2FmsD8q3
         Hd27efGl7AMjxfXCBfYTTtkDoY/pXhNVIWRuaHUEvTMjmwenrwDuyfKy+EYc0wMNGErn
         8yrVfuJpzhhOkh3dia3hqtEOKPFT7wz3TJqg4DaT0DKQs7hMM91et/8I5rGkUFzLx8t1
         aeaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793205892; x=1793810692;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NopKNI1TscCvs8AXqOgByddNyfZiOAXivM+rgWj+cp0=;
        b=SuND4Jr52XC6jXFL60J8LQY2fSClcIks+Qm1frpIUgeh8s8n703B2Sjyu4LW/54wJR
         TgP7kN40L7ZMfH4AFLoLmpjqeCd8+nQGFLgwZlsouS+lQsAFFltZJ9JOzfLCukHilsQU
         /YtN24LbnkVTowiHZbjGdPyy6elWlNefsxja+493mDizRdZoAa7FINZmqT/yM9/TRz0V
         k824XZBMYhrevIeJWP6+W0v60crVIDRf/8kJOe9fPSkQ31hm5mJwBi6EeendGKmFyVh3
         7c6OWIp5XSbgY+6Q3Gu9QOrhF83DGDFsafYnLJqlcy+Fk+RCcA5uaw3ndMMdpn7mv+y7
         OyYA==
X-Gm-Message-State: AFq9FYI4IslWKmryUTXGTvm1CBnWobVc0fRxMH7erqmvqCkIguEf/NOV
	j+wx+0DqaCu4eR/R7igoxFjBOU46w0WgbjtzFqDBdfeU+yDxtuk34lFp9kjL4wumIWCQbGJoFt5
	V1Vu6xNc=
X-Gm-Gg: AYBFou2wsH3fuJCrJAXPTWTSjWYsUfcPt1EBtvj+Wx4Ix73ipeZ1CuHbTUogf7rgSQ7
	6pAs/R3ZSON1eChqrB2h3KjFMFDN/1wAzVK2KmreJOdygqHqnbjgmYt69E0uCu2Gs/NNiFHfCnx
	yXlxloL8R60M1olLSludhQUr87g85+oJh+42huGkaZzhUYbth4wIaTOeuymJUnf8jf2jggC0P3+
	AkAtS4M3BzFUGg7LEzRR1pTT71hXLpiBwqyoGFpLPaJhYqkAjq/r2w/tUqk/hcCuR3wvAQ6xa5q
	bViw81tCOfYRaexRDEkyw1+PEL7W5wvugUogoSpxuKn+d/Tjwv2uEa8krPg7plND1vptDp/2uli
	CQe44zzvOiP4cEebmbphrbAaj2bqzV0DvsEcxOKOtWWNzM2ahLULQcTS7RRe10UWaEL/UVCtykO
	lzyR6SEazVntrr0pim9Y1uA9oklmBa7SIhEX1lDDspZTaYQR2giygLV6mjlXpBeWtYspX1qA2Wi
	ou8qw8a8CwUp6vdpVjHpi7F8TBuHXGYdBSfg3p6c5QRL4gcSq6Mtwujim9LjmNdlWtsk6AWHsWE
	TPD5TOf2YA2EPSQ69Bo6VA4zw2o96uHrylABz3jJC72DbjHvUE/ZhTxG6QhTLK6Ay8l2OFw2561
	dqIkJcnBv+hMmaoqphPA=
X-Received: by 2002:a05:6820:55c2:10b0:703:3ff5:ddc1 with SMTP id 006d021491bc7-713eaf5b41emr1336637eaf.8.1793205891943;
        Wed, 28 Oct 2026 09:44:51 -0700 (PDT)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85b20216828sm2416941a34.19.2026.10.28.09.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:44:51 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 27/98] blk-mq: don't trust the cookie in blk_mq_poll()
Date: Wed, 28 Oct 2026 10:41:30 -0600
Message-ID: <20261028164415.1262013-28-axboe@kernel.dk>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261028164415.1262013-1-axboe@kernel.dk>
References: <20261028164415.1262013-1-axboe@kernel.dk>
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

From: Josef Bacik <josef@toxicpanda.com>

blk_mq_poll() indexes queue_hw_ctx[] with bio->bi_cookie unchecked. Zone
write plugging keeps the segment count of a plugged write in
__bi_nr_segments, which shares a union with the cookie, and clears
REQ_POLLED, but bio_poll() only looks at the cookie. A plugged polled
write with more segments than there are hardware queues reads past the
array. The bio is also SLAB_TYPESAFE_BY_RCU, so a cookie from a bio
reused for another device can meet the wrong array as well.

Ignore a cookie that is out of range or doesn't name a poll queue.

Fixes: 3e08773c3841 ("block: switch polling to be bio based")
Fixes: dd291d77cc90 ("block: Introduce zone write plugging")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-mq.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index c91306f8156f..5ebe2e23df5c 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -5245,9 +5245,22 @@ static int blk_hctx_poll(struct request_queue *q, struct blk_mq_hw_ctx *hctx,
 int blk_mq_poll(struct request_queue *q, blk_qc_t cookie,
 		struct io_comp_batch *iob, unsigned int flags)
 {
+	struct blk_mq_hw_ctx *hctx;
+
 	if (!blk_mq_can_poll(q))
 		return 0;
-	return blk_hctx_poll(q, q->queue_hw_ctx[cookie], iob, flags);
+
+	/*
+	 * The cookie is no more than a hint. iocb_bio_iopoll() may have read it
+	 * from a bio that was reused for another queue right afterwards, and
+	 * zone write plugging keeps the number of segments in the same field.
+	 */
+	if (cookie >= q->nr_hw_queues)
+		return 0;
+	hctx = q->queue_hw_ctx[cookie];
+	if (hctx->type != HCTX_TYPE_POLL)
+		return 0;
+	return blk_hctx_poll(q, hctx, iob, flags);
 }
 
 int blk_rq_poll(struct request *rq, struct io_comp_batch *iob,
-- 
2.56.0

