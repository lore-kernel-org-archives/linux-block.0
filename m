Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.226
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793844835;
	b=qiDQi78RD9z/AfT/JMg6Q9rTnEpQIz6AE78csHD+08AJ3i5SP0FVLtnXZETukDygy3r7
	 j/+54zKsJOtiNKp5amqGp3D0CHYWzAeGLUsknjpvpWy6xv160DYZeIGIDSVCR8ipEc3LN
	 9Oj60ULVmAoz5tN3koiHPRVHCyDp9JUfT1lJ75gFzZQy3jUee5n0H4OV0rkAC1fQu49Wn
	 /C/aRdfAellVTofujqh8ac3CY2zLQVcWbZnXDHgUHYZbHWdDEz7s0ObGvj828PupkJLCw
	 d9C1hIQIYa3sSwCLWblzXLmvpgqjLDy31KWUsmORyEooHsrL+kXYiIkMEz81uTocMRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793844835;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 X-Relaying-Domain:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=jbk/ihbbo8xIG/OluC/zPXeNuyP21AAyIO9Pon6dIe4=;
	b=bVQT9SUhA8gBbNLlfycwL683kZzS7xo2Hz7rjnRh+YzYl1MJ+hhjZvisxKiZuGaFowOn
	 9xrYpbNvhmTjzkKjHk06f971TRFq35pzlWbfvqavSFrf+ThE0glPozrA9uVuf4RmlszCB
	 PvNnEu2JYOpOnt57uY7igBP8okT3F0HQlG41Iqi9J9zOFln+RcAtjs+L3oEdUa53Qh6hY
	 Z093jY+nu138s8HzDPFdRgG+MS2QN6/kupk0A0fVT7DQC9TCC0kk3pwTd25IKmUU9Hmm7
	 tq6fqrMHNUUZXDuCR21SZ9jIQ/+qmuiXfNyY0zbZIMpaF3YZohTKCb47Av7xw6faIRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=purestorage.com;
	spf=pass smtp.mailfrom=purestorage.com;
	dkim=pass header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b="MBoxWp/V";
	arc=none smtp.remote-ip=209.85.215.226
Received: from mail-pg1-f226.google.com (mail-pg1-f226.google.com [209.85.215.226])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC538606A31B
	for <linux-block@vger.kernel.org>; Thu,  5 Nov 2026 02:13:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DC538606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=MBoxWp/V
Received: by mail-pg1-f226.google.com with SMTP id 41be03b00d2f7-cd15c885bdaso52767a12.1
        for <linux-block@vger.kernel.org>; Wed, 04 Nov 2026 18:13:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1793844834; x=1794449634; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jbk/ihbbo8xIG/OluC/zPXeNuyP21AAyIO9Pon6dIe4=;
        b=MBoxWp/VMp/jHihnId3EgiwONu5hVMB9flYotVj8jbkpwsPWHst2MDLmXCtuLa7IFL
         X1JFGYe6k9FuOJgk3nEOmlQauGkmZ2siyEH27d33Q8aityv0sL0AwVLBAOluwqbOOQbT
         ikYV4SkwafMXj3pYYKwlQO/yq2AhRIrMBjv//F5wdHRNDrDbloJ7wB5KSfqo8PNPp0Gp
         7quKUFAGAlDhhBezsDodHQMZcpuuZPHNB8yvx2Qi7PBM0kvNeCJ5Wsxyu4GzMjoLnOBU
         5fk70VKuXXN6cEnU3gkFlvNTB8rZbLf222TV4ol1xYweWgRe5vMoNCs0l5soZEH0aiMw
         LGAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793844834; x=1794449634;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jbk/ihbbo8xIG/OluC/zPXeNuyP21AAyIO9Pon6dIe4=;
        b=iSXbya780+IJvuHwwjSanCMGQKcGRIWS2p6N6UVOJyAm9Uz3rCDTaCWl022aCe1Ig1
         QnxlVKZ5kVSUQXHF2r+vCa1iFdrKVzCJPXvwhyK++zznwxHwM57YfGXkv0RPb0+wNqnE
         posaCkhL67k6y+KKk2iAxwzSXKshbqJuptGvE53sUpl3tyZbvR9hSwy3lY2HjpJp13EJ
         /hZ5WsoCmEIaXCenTbyBsQ3ezk7Kl0hC7Povvtoir6aeE/HXdsjaZJ6Xe5XDh8QEvxaA
         szqSFetyOzOPbvcOHGGNuQI4NH9iZaDdS49414yCR6uU6YGmnpqjURoxexBJUBfk4CAw
         dnIw==
X-Forwarded-Encrypted: i=1; AKwUvBxw9T6N7dLUSh1tcKxV7dcqMOgQOcpWgnOboVDHv5Pw3oCczJ5CjWjsPk8vx09N4b9cgfFJ6gfqRAUTsA==@vger.kernel.org
X-Gm-Message-State: APuU4Z/Gm9Nr5mXhE08Bd+ifn4f/E+UEru9SuHuEqVs85Qs8h5zl+mas
	gVEREgx69h1nDsvrgpol01UA7el+O4jDlrSHaJbBY7sbqcWDsiyuynllECKREbXrFjNSPnzFpHN
	ENI3IWcSGOCmNtntG55Ae8yEexPQAob1IbVzE
X-Gm-Gg: AYBFou0wQuLNIBrlmGllcCah4/WiK/hHtcm0Vw8LAzj4ZTGbO5+Q1Oyse6+tZIoReJT
	bKkSuOxhcyvuGdcNIWqPs11burc0k9elUiUJ80CCgAzJweCt0n+pgfAWg1CxBD8CXQxXDppavwK
	WqDebv+mmBZh+sz8Aw35IVxU4DOmnH/F2BDzZZxp0xYgBGWypNsLkrpokilhXVdKcIks6MvNU0F
	oS22l4nhVxy6Hfq7mNvkGDDkHTMdLTj11QwAAZttSUv/SbQ+etGlHtJZeOIAXWAhyrj8xRGcwl9
	x8WmSnpUYypFWqcxcJHXvW5sjgzghLpLFBaiLVnKTPPfxT7+VA1Ci05D8uRl/8fmunEzT1kmkmM
	BDwPqK2VQQl9VniO5/W3FloALpcMXt1en
X-Received: by 2002:a17:90b:3ec6:b0:3ac:a11a:7c88 with SMTP id 98e67ed59e1d1-3ae89767d8dmr25056607a91.3.1793844834135;
        Wed, 04 Nov 2026 18:13:54 -0800 (PST)
Received: from c7-smtp-2026.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b0b2e09962sm836221a91.0.2026.11.04.18.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 18:13:54 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.17.2.4])
	by c7-smtp-2026.dev.purestorage.com (Postfix) with ESMTP id 6CBA940278;
	Wed,  4 Nov 2026 19:13:53 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 609FCE4054E; Wed,  4 Nov 2026 19:13:53 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Ming Lei <tom.leiming@gmail.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ublk: optimize ublk_queue_cmd_list() for length-1 lists
Date: Wed,  4 Nov 2026 19:13:49 -0700
Message-ID: <20261105021351.2295547-1-csander@purestorage.com>
X-Mailer: git-send-email 2.56.0
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

For a request list of length 1, ublk_cmd_list_tw_cb() is more expensive
than ublk_cmd_tw_cb(). It loads rq_next, which is in a separate cache
line from the other struct request fields accessed in the dispatch path.
And it dereferences mq_hctx->driver_data to get the struct ublk_queue *,
whereas ublk_cmd_tw_cb() gets it from struct ublk_uring_cmd_pdu
alongside the request pointer. On the submission, ublk_queue_cmd_list()
can cheaply check whether the request list just assembled has length 1.
So pass ublk_cmd_tw_cb as the io_uring task work callback if the list
has a single request and ublk_cmd_list_tw_cb if it contains multiple.

Collapse the req/req_list union in ublk_uring_cmd_pdu into a single
field so ublk_queue_cmd_list() can store the head request to it in
either case.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/block/ublk_drv.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 3d322fa1bc83..c397e354a7d6 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -117,21 +117,18 @@ struct ublk_batch_fetch_cmd {
 	unsigned short buf_group;
 };
 
 struct ublk_uring_cmd_pdu {
 	/*
-	 * Store requests in same batch temporarily for queuing them to
-	 * daemon context.
+	 * For ublk_cmd_list_tw_cb(), a list of batched requests queued to
+	 * daemon context. For ublk_cmd_tw_cb(), a single request.
 	 *
 	 * It should have been stored to request payload, but we do want
 	 * to avoid extra pre-allocation, and uring_cmd payload is always
 	 * free for us
 	 */
-	union {
-		struct request *req;
-		struct request *req_list;
-	};
+	struct request *req;
 
 	/*
 	 * The following two are valid in this cmd whole lifetime, and
 	 * setup in ublk uring_cmd handler
 	 */
@@ -2104,11 +2101,11 @@ static void ublk_queue_cmd(struct ublk_queue *ubq, struct request *rq)
 
 static void ublk_cmd_list_tw_cb(struct io_tw_req tw_req, io_tw_token_t tw)
 {
 	struct io_uring_cmd *cmd = io_uring_cmd_from_tw(tw_req);
 	struct ublk_uring_cmd_pdu *pdu = ublk_get_uring_cmd_pdu(cmd);
-	struct request *rq = pdu->req_list;
+	struct request *rq = pdu->req;
 	struct request *next;
 
 	do {
 		next = rq->rq_next;
 		rq->rq_next = NULL;
@@ -2119,14 +2116,16 @@ static void ublk_cmd_list_tw_cb(struct io_tw_req tw_req, io_tw_token_t tw)
 
 static void ublk_queue_cmd_list(struct ublk_io *io, struct rq_list *l)
 {
 	struct io_uring_cmd *cmd = io->cmd;
 	struct ublk_uring_cmd_pdu *pdu = ublk_get_uring_cmd_pdu(cmd);
+	io_req_tw_func_t tw_cb;
 
-	pdu->req_list = rq_list_peek(l);
+	tw_cb = l->head == l->tail ? ublk_cmd_tw_cb : ublk_cmd_list_tw_cb;
+	pdu->req = rq_list_peek(l);
 	rq_list_init(l);
-	io_uring_cmd_complete_in_task(cmd, ublk_cmd_list_tw_cb);
+	io_uring_cmd_complete_in_task(cmd, tw_cb);
 }
 
 static enum blk_eh_timer_return ublk_timeout(struct request *rq)
 {
 	struct ublk_queue *ubq = rq->mq_hctx->driver_data;

base-commit: e6ac1da6a53c5f670bf09e60a2500d15be68d2fc
-- 
2.56.0

