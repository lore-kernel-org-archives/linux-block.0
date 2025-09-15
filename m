Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6641428506D
	for <linux-block@vger.kernel.org>; Mon, 15 Sep 2025 13:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757941576; cv=none; b=R5T3oOOK5U5gmsKqIoNuoW9oRjjU+bP7IQT5KUdNGkO7WrPi89NwPlwYi0546CGl2SIAZ0P3t0/acGfjPypQEpDk8RbqsqUU8FvpOzAfAwPw80h3xlSYMoteUwbU2X4K/6uNZ1WisWT6fTtFjhC1NKSw8wr65NBFoBqoCmRud4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757941576; c=relaxed/simple;
	bh=xvtyOxlt0sd5V+mr1Uz3PvxlTQ7hAmIsxOoPbAbzTuE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=P4eW5uhlJXEoAPTLb0xkh3X3CHeeofYNSvEaJnhxiSKYYWOuSjpUiUlm8sIVUayoTE3Tnx9auiEDJ7IRsb9cPuRHUlkw5Qc3TNw2AaYw5Px5wNWOYwsC1aUueilUbbPJKOnN+azKnNzIudVAlQr+67QkSNXc+0ECXw+DHNtEQ1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S9KsEy/F; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S9KsEy/F"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7761a8a1dbcso2161948b3a.1
        for <linux-block@vger.kernel.org>; Mon, 15 Sep 2025 06:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757941575; x=1758546375; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BDcFa+cXk5N40j8gIEFqJLaKFAmqCOwEkbotvenWYbY=;
        b=S9KsEy/FlN/GvXLJC8A95Ri7QYpP0a67pwOlOfrVhKmHMckw47mdQdKGXZ84DyTliy
         kMnbHx+/mSoa35bFFqMa/A/CPR8K5Yqt6tzey+Lbrc/9SN2HOfm6zPNHvNd3N83lfVZU
         LdePnqCGkMRD/dQcs1jgGyE1hLE1XbMEInQgXc9bQEgqrO6tv7z/txJMFqqjZw5DM6pb
         tZbsdc1Pnngz5EjCowk25rnW9pz1XaWQIItDjS86EvoeY7LL4uHllizc5XzNgmg+JzWH
         m8fyE5Zg1CZQ5NMlrc6Tqw/PeAbIUHY0Anar87KI8xd7T/r4S6dm3uDeLNjtPuLIGVZA
         OJCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757941575; x=1758546375;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BDcFa+cXk5N40j8gIEFqJLaKFAmqCOwEkbotvenWYbY=;
        b=bAd0XimAoG04jFTwk6bjjPO1L0KU8XHOudx6lq9MkBYdNl90kwbc713t8vaQgiz+Nv
         BvgeHqpufwegEIIUZ9Nlmu+2rvch9g9/GnAy4wKecB/ZPGp4nx1DEyPTvUzkegjmXcOa
         T68kh/O8bYADpj17reRxTHrTEmEPbvdSIthO1Pntj+hKj5I6nMsp/NHDSL3gaz6FU7NK
         Q0b1WMUzWDLnCwbKnk/e0tK3kI/NMeC1UJtGu5rhI+n+6RVJHPvUlxJArsNjxdgtf54I
         /5ivDXPwQcFyX0MQP8/SiEfFM1fi9RNxjoRfXMxdrt7i+AZAsoyCxO/rq0gWi/Ean12P
         OssQ==
X-Gm-Message-State: AOJu0Yxmxcc77pVuYuDahFShD6PKzuwFOL07QcNW+bVPsOdDLipDxm2/
	PcVh3CP/S0Ux226odKxXpAkHJaTMh9yhAfX2CqiC0ntXng/uoxfnLR3l
X-Gm-Gg: ASbGncuCGSjR9ZLsogV0bgoy8hv7yT8VjY/mw6UreWDHvK04iB3zxsWJV8sWxMWKdAV
	P52v2OhlGcPCuuB5bzAprAXXHPNfvZtShFQhxU+tBijkTKAf7WsixUhKZJ4BudqIWJKZPnwyMN0
	0sjOIjJ4QfJcSPiAoifHIRxWkF+f4SvJ35Vby//1LX3ZwpCn3R/xJeza9mOucQSydve1v9wYUEK
	eoC3lMP+XzFzOLIWqSr2NCnxrKAlIyeJglR4ZO8i49ZWDOE78dy8yKFjNX4fGHOs7iDgb5GiEZ4
	eNZfMYhTnodipRge3JqYMJvWlWKsvbJwuaGsrkATJ5loZWwuXDj7rNRH4PuO9SV/Jj9db5l9CZg
	YcBLuPbTZqYGP4YCdnFZ6k74RQ0RiFT6pI3VcWmlYx508HxDnSv4sxi1JkL0=
X-Google-Smtp-Source: AGHT+IEgPnJcnHP3rgj4/s7O4zA02USZLvX4VYAf4gtyDIGF/KoF1y/PyB3PZ5opq/mq4KZzbBRenw==
X-Received: by 2002:a05:6a00:3a1c:b0:776:214f:2021 with SMTP id d2e1a72fcca58-776214f2858mr9475735b3a.31.1757941574392;
        Mon, 15 Sep 2025 06:06:14 -0700 (PDT)
Received: from localhost.localdomain ([113.218.252.158])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77613e4308csm10451133b3a.73.2025.09.15.06.06.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 15 Sep 2025 06:06:14 -0700 (PDT)
From: chengkaitao <pilgrimtao@gmail.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chengkaitao <chengkaitao@kylinos.cn>
Subject: [PATCH RESEND] block/mq-deadline: Replace DD_PRIO_MAX with DD_PRIO_COUNT
Date: Mon, 15 Sep 2025 21:06:06 +0800
Message-Id: <20250915130606.97949-1-pilgrimtao@gmail.com>
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
 block/mq-deadline.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index b9b7cdf1d3c9..f1facbdf85c1 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -41,19 +41,17 @@ static const int fifo_batch = 16;       /* # of sequential requests treated as o
 enum dd_data_dir {
 	DD_READ		= READ,
 	DD_WRITE	= WRITE,
+	DD_DIR_COUNT	= 2
 };
 
-enum { DD_DIR_COUNT = 2 };
-
+/* Ensure that "DD_RT_PRIO < DD_BE_PRIO < DD_IDLE_PRIO" */
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
@@ -441,7 +439,7 @@ static struct request *dd_dispatch_prio_aged_requests(struct deadline_data *dd,
 	if (prio_cnt < 2)
 		return NULL;
 
-	for (prio = DD_BE_PRIO; prio <= DD_PRIO_MAX; prio++) {
+	for (prio = DD_BE_PRIO; prio < DD_PRIO_COUNT; prio++) {
 		rq = __dd_dispatch_request(dd, &dd->per_prio[prio],
 					   now - dd->prio_aging_expire);
 		if (rq)
@@ -475,7 +473,7 @@ static struct request *dd_dispatch_request(struct blk_mq_hw_ctx *hctx)
 	 * Next, dispatch requests in priority order. Ignore lower priority
 	 * requests if any higher priority requests are pending.
 	 */
-	for (prio = 0; prio <= DD_PRIO_MAX; prio++) {
+	for (prio = 0; prio < DD_PRIO_COUNT; prio++) {
 		rq = __dd_dispatch_request(dd, &dd->per_prio[prio], now);
 		if (rq || dd_queued(dd, prio))
 			break;
@@ -530,7 +528,7 @@ static void dd_exit_sched(struct elevator_queue *e)
 	struct deadline_data *dd = e->elevator_data;
 	enum dd_prio prio;
 
-	for (prio = 0; prio <= DD_PRIO_MAX; prio++) {
+	for (prio = 0; prio < DD_PRIO_COUNT; prio++) {
 		struct dd_per_prio *per_prio = &dd->per_prio[prio];
 		const struct io_stats_per_prio *stats = &per_prio->stats;
 		uint32_t queued;
@@ -565,7 +563,7 @@ static int dd_init_sched(struct request_queue *q, struct elevator_queue *eq)
 
 	eq->elevator_data = dd;
 
-	for (prio = 0; prio <= DD_PRIO_MAX; prio++) {
+	for (prio = 0; prio < DD_PRIO_COUNT; prio++) {
 		struct dd_per_prio *per_prio = &dd->per_prio[prio];
 
 		INIT_LIST_HEAD(&per_prio->dispatch);
@@ -748,7 +746,7 @@ static bool dd_has_work(struct blk_mq_hw_ctx *hctx)
 	struct deadline_data *dd = hctx->queue->elevator->elevator_data;
 	enum dd_prio prio;
 
-	for (prio = 0; prio <= DD_PRIO_MAX; prio++)
+	for (prio = 0; prio < DD_PRIO_COUNT; prio++)
 		if (dd_has_work_for_prio(&dd->per_prio[prio]))
 			return true;
 
-- 
2.39.5 (Apple Git-154)

