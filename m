Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F4D1DFF7;
	Fri, 29 Aug 2025 01:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756432495; cv=none; b=JkVq/TIDGwGdyzY8kgaxQ4cyrEBfqsaiwnolFGX70WfI5yp1WDrQ7yHzcAVkRYH+YBkxOkYxrnYE+MwGBKV/f53dcsUy2PL2LAXLwyE9v0Vuxs1+FJ4AJwnnbA0kf2E+lCuLnwDCgijGXT+CAC9Rcfbb1gp8S4TtXgW8B2zvjDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756432495; c=relaxed/simple;
	bh=YclyQ4i+1A+XSiGnQYtVvgpux14BRsuB2iVV3iNQaIA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fu+qEaOHU7j719zz7gvuvn+WzDnh/zuGKuHYHXUuZPZ6b7Yqh/gsu6VVcU1up4l9EBrZ8x3PcrHlE8f3yKDDJZnC7qp2dgsupYlIJDZ+T7+7fIPpOaeG7mCDZVbgOqNf0EO84xcsgDMsZm44+UUscELWq0lwbs/VxOLakkYha4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k/VM7y+R; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k/VM7y+R"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-771eecebb09so2183553b3a.3;
        Thu, 28 Aug 2025 18:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756432493; x=1757037293; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SFdYFdqoRoLnPkCUEAB/IXpng8DVVDKCbntTxIYp4z4=;
        b=k/VM7y+RA9Xee1mBt2bbXma+PZ3g6hqMd63NP7E5MPloqLQvuh76mkVQbJoqrDMApW
         zfa2QkxAJ3b+B+FJaYEV4/EvM34kYAM4HGVJwPB9A/2iHgCZQfIQluZJFEnAWPWt6IgD
         soePiuSRhb53x/O1Joh/qNS25ykYlu8cab2LGeHQohZEuLUtwhMHMVM20JyJHQtEYGKe
         s7kbVtgT6DuMwZthQuLjHzaCpdpXHjGw7q51o7OxfhddmhIKEhCCp1aYJLXxobip53qp
         TK6MqpJBFDwbSU/ynuUANghinA4Sq39cW7BgVhXZKrAuY81Q4oW1/AMZyRUU4vvusT2g
         cGgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756432493; x=1757037293;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SFdYFdqoRoLnPkCUEAB/IXpng8DVVDKCbntTxIYp4z4=;
        b=vFWoNct6P0sNPOSzWbqByFo8yRExd206E+SMkbR6nOhx/5z/Q+3PC+6auxH/QYwiTy
         rHGs3fBTp8Y9HqADh4vQqQflUZPCAKbaZrSvOQuGI3vGFXfrmHx1/THTNVuAKFBGP4Tt
         X9XAMKngutZtWAE9KHERR4HzeiV31GMwMq4HG3rCm8wvM4iLWpSQNmmSc7i/XN0wVluN
         6z+jx2SibbNzmDWU2YVh+f8MGxJPr5nSznudJPMfskGcu8Yl8IJTG8TM88EJr0IymT99
         PqB0w8FXMU97eZo+AiIOx61WS8EQeXqKGaovZgRoP0qhRuzGZbHwe7aiJUKieHGDiIGf
         OnNA==
X-Forwarded-Encrypted: i=1; AJvYcCVR8vIoFvG6zAKmLBTFO5R0ZdTMQDQWJbPkuziApzplIGDBN10Myl5nMtmHt0aeAwszybvHDK1H6E4N7DY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yws5YqQNlAZRmBBaNp0ScEKZaOj3+s04VWCCTS/cjtiAxYLNF0r
	6auYlBD2Kk4BndTUcUpyQyaQkmEcP3894ycQPahRb8IhRjegmhjeEus5TdUBZI27UXw=
X-Gm-Gg: ASbGnctB6TlQkM2w6VLmp7ih2bsfCdb99x9dDRY/KntTcGA5rQTP0nURPmWE2gusgEu
	2NhNS1EUJVhROlCoAEaZzOC8scSIy9V+r5a7ldV81ObEKPS5xGmxlIqZNYtrzLJ4dA0az0XARg/
	T4/bHBTzK4/xaNfQplK/bMd6uEuNj0z5e7KC8FDc0wM3fCqY0ca65sKXO0G192QjZMAT3gV7kRl
	ejCN+bjmrBmXKv0zVDp8uIuFUiEszgQdLYAMaj5z1fD00GiMkGqZ4Oj9gfZ6YWf40yKInVlGN4E
	Jjxz1HcZVXQqnjAvhy+IdsHraQhvzFxgtpz52GA2vYKwwPdvGu1vr74QCMNGu460B9vmrJdSjJx
	xVvN9CJglCc2NzxrJzFUuuQc9ss8tX17NnjnkuAsOzhBXHrCT0yDE1jSOmhw=
X-Google-Smtp-Source: AGHT+IFudtmSL+bTtLqgWp+E6DIbs+k4HVO2HQfJkkCawfaRHc1emhDfWa4M7rnQ4QwX8jiee+PUQA==
X-Received: by 2002:a05:6a00:4f96:b0:771:447:9346 with SMTP id d2e1a72fcca58-77104479531mr25952225b3a.6.1756432492981;
        Thu, 28 Aug 2025 18:54:52 -0700 (PDT)
Received: from localhost.localdomain ([116.128.244.171])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-772300a3e84sm24300b3a.40.2025.08.28.18.54.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 28 Aug 2025 18:54:52 -0700 (PDT)
From: chengkaitao <pilgrimtao@gmail.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chengkaitao <chengkaitao@kylinos.cn>
Subject: [PATCH] block/mq-deadline: Replace DD_PRIO_MAX with DD_PRIO_COUNT
Date: Fri, 29 Aug 2025 09:54:44 +0800
Message-Id: <20250829015444.91369-1-pilgrimtao@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: chengkaitao <chengkaitao@kylinos.cn>

Remove redundant DD_PRIO_MAX and enum types, Move DD_PRIO_COUNT
into enum dd_prio{}, and similarly for DD_DIR_COUNT.

Signed-off-by: chengkaitao <chengkaitao@kylinos.cn>
---
 block/mq-deadline.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index b9b7cdf1d3c9..1a031922c447 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -41,19 +41,16 @@ static const int fifo_batch = 16;       /* # of sequential requests treated as o
 enum dd_data_dir {
 	DD_READ		= READ,
 	DD_WRITE	= WRITE,
+	DD_DIR_COUNT	= 2
 };
 
-enum { DD_DIR_COUNT = 2 };
-
 enum dd_prio {
-	DD_RT_PRIO	= 0,
-	DD_BE_PRIO	= 1,
-	DD_IDLE_PRIO	= 2,
-	DD_PRIO_MAX	= 2,
+	DD_RT_PRIO,
+	DD_BE_PRIO,
+	DD_IDLE_PRIO,
+	DD_PRIO_COUNT
 };
 
-enum { DD_PRIO_COUNT = 3 };
-
 /*
  * I/O statistics per I/O priority. It is fine if these counters overflow.
  * What matters is that these counters are at least as wide as
@@ -441,7 +438,7 @@ static struct request *dd_dispatch_prio_aged_requests(struct deadline_data *dd,
 	if (prio_cnt < 2)
 		return NULL;
 
-	for (prio = DD_BE_PRIO; prio <= DD_PRIO_MAX; prio++) {
+	for (prio = DD_BE_PRIO; prio < DD_PRIO_COUNT; prio++) {
 		rq = __dd_dispatch_request(dd, &dd->per_prio[prio],
 					   now - dd->prio_aging_expire);
 		if (rq)
@@ -475,7 +472,7 @@ static struct request *dd_dispatch_request(struct blk_mq_hw_ctx *hctx)
 	 * Next, dispatch requests in priority order. Ignore lower priority
 	 * requests if any higher priority requests are pending.
 	 */
-	for (prio = 0; prio <= DD_PRIO_MAX; prio++) {
+	for (prio = 0; prio < DD_PRIO_COUNT; prio++) {
 		rq = __dd_dispatch_request(dd, &dd->per_prio[prio], now);
 		if (rq || dd_queued(dd, prio))
 			break;
@@ -530,7 +527,7 @@ static void dd_exit_sched(struct elevator_queue *e)
 	struct deadline_data *dd = e->elevator_data;
 	enum dd_prio prio;
 
-	for (prio = 0; prio <= DD_PRIO_MAX; prio++) {
+	for (prio = 0; prio < DD_PRIO_COUNT; prio++) {
 		struct dd_per_prio *per_prio = &dd->per_prio[prio];
 		const struct io_stats_per_prio *stats = &per_prio->stats;
 		uint32_t queued;
@@ -565,7 +562,7 @@ static int dd_init_sched(struct request_queue *q, struct elevator_queue *eq)
 
 	eq->elevator_data = dd;
 
-	for (prio = 0; prio <= DD_PRIO_MAX; prio++) {
+	for (prio = 0; prio < DD_PRIO_COUNT; prio++) {
 		struct dd_per_prio *per_prio = &dd->per_prio[prio];
 
 		INIT_LIST_HEAD(&per_prio->dispatch);
@@ -748,7 +745,7 @@ static bool dd_has_work(struct blk_mq_hw_ctx *hctx)
 	struct deadline_data *dd = hctx->queue->elevator->elevator_data;
 	enum dd_prio prio;
 
-	for (prio = 0; prio <= DD_PRIO_MAX; prio++)
+	for (prio = 0; prio < DD_PRIO_COUNT; prio++)
 		if (dd_has_work_for_prio(&dd->per_prio[prio]))
 			return true;
 
-- 
2.39.5 (Apple Git-154)

