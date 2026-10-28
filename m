Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793205896;
	b=ph9KuAPmAuqOEyPrJukKCy59D5Z2Z+kde0H0tRJJ/L8EC4X71hhmuscRP7JTif2HrlN5
	 +vYDSru+tMlw9ptKWDpMr1+a9xVgUmE9EioFpVDqBkfFSGOoG1hI3e30Yq3+cMmq7MG9z
	 PskXzzba8vEfpwKS14DmDQ+hoMcVlx6K7zodDsFZ44xgzleH3Tloq7n0PpY3H15/dzLLf
	 n5k1dWR82AnlcHqeIDN68+5sfHsc6+9Bi4SdwejBlR7PA/K9DJYTbFUpPOWK6Enul5q/t
	 DRXVWn5DuDmFAaMLTKa+B9s3i8Su8XtS7MI1QXNjTzSnP19YJBjOzkbWDQMBQgksehw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205896;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=pbm/9fNPBn6VZIQJkU202yuj6ZGmU7yhZTKmescL0/s=;
	b=k9EyonCTbSWAr1w8wmbhSuqEfQ7DODyKe/5ycXAo7RgOTd/WCemTAEckCrdDUvpzYACb
	 bphgCrj1AzZD5nn8z2DxksRCWYBCpO6F1xkZAM8tZ9L8qGl8MqrjTs76BEwm2Ppst70Pg
	 9QOaDdzLezzAEHI3CCmE33SExM8i2cCBXBvOJEhb/1gzadnxt2GvYwfIHd94TibJGKl4v
	 PNLhAc6QxY4+dVyvY08zgPyITXszwnmLz3b+New482U0eirq2F0Obdm/Zv9PJjZTf2JcE
	 HiRlkrelwm7pOGa2CwjQivztJao0t1KGHXiTNty6qgaBT679SDwTC6+okpZCeXoatlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=dibhQwdK;
	arc=none smtp.remote-ip=209.85.210.54
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ABF4606A321
	for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 16:44:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6ABF4606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=dibhQwdK
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-843a4ca671eso638432a34.2
        for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 09:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793205895; x=1793810695; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pbm/9fNPBn6VZIQJkU202yuj6ZGmU7yhZTKmescL0/s=;
        b=dibhQwdKB2/Hy6pnwvAI4jxK0VCbjO/CGndXq3h49yG77qZPi2gtxk9Je2DVH60nkd
         jZCjWBWyYB+JOAINSfziDT1+pK59Uo8YjQrdWc+OHhaznAMO4YzKW263qa4OO1HOuCnr
         RHaYEMMZNSLPJ4fHhDKGQxehmjvSpqsFF9SEs7NMUqSsWgcRaMqXuPUua5fdi4cmB7e4
         VdsNxsAI+fT33SUw7ALL/bONa5jChbWn//m+rm0yYoA0vj1aNzHdQ0QQa/EBpgYdLX5y
         DZD1x1kqD9p5OdIUsWUVBidXMSB/TETMQhBaz3Ahm370g1wCLjEnnWWVQ8JUxAmoHLsP
         S3FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793205895; x=1793810695;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pbm/9fNPBn6VZIQJkU202yuj6ZGmU7yhZTKmescL0/s=;
        b=vmmxeb4RDOEOtzAmqI0ShQ6WbIUrd7J8AeL2RCcYTFNxN8wiI30MeCmKLed13XuCmJ
         8c6C7vI18hph4C4wrfwtU2Q2PfGkdkzKANP3sOlkUmtZD0YT2+4826i0Am/xaSatp/Ra
         tcfiRe8JxsJDIAv2uFp1Q4WrRCfGc1vjdVAGo/tBCYR8U2U/ikV2PlN/+x3VKVe58NTt
         fXs9dBLSIgHjQs9aULrz74L9fsQTRx0MC2rlRVUS+Dx+0F6ZXRfCkRPpbUtXfXL+m3Is
         uXTPwLAzCxDxtO4yW1UuHdKBpu0GDmW4KNwJBNuKPXhKJT0p808hh3/yZ8Irb45TPkoL
         sxig==
X-Gm-Message-State: AFq9FYIMSeqlI7cIwkYgSpJEVke7Wrq5RG+5y/cRi2KtdPbRecL+6AV9
	TH2120GEpWlIeQ7yplCCBHo/54ON2vR3GhYksAoN/j9yZpsf4+XLASbDuwYPJ2euy3xWUA51kt4
	g0B4Boqk=
X-Gm-Gg: AYBFou2bOeNz98ExQskPfoJuxH9FXxsMDIDewXGx73UzJYznt1bRRkJs5dlw9luDduE
	KaOnmPuCPkDT7giPXFzrQwAQCHu0pnxbzNluXEt/+9JfcAfHyLKwkYmPDCvR9Otasih81ce7l7b
	8Hx2iYE6Kr19GO68kjYprCK4EHWUlX3bRK/xIbSRPh3Oja+YWUTPRf8MqdvAvpyiCsjyRw51A3Y
	YLlxUhLOSgJKsNWtR6RVG/0Acg6ro7mxuVcdY3hWRMBjg6DkK/LtRe102w7Yh0phbJtLsGFYT+Q
	iFVeWdF8ddio00XrU7lb2xcD8EYBslr3Y74d0+khZ+4uWaA8rdk6YW94+w9H0yo7ru4SHyf4lw9
	SnOqPTV9VJtHnpnICRpzKbf5HTg4wsN1C5XDBppvri5aZxQED19RSo6DbpFtJNtcdmy4qL5ZPZT
	8ubiJDESsRg8gh8QP1d3kbn0nTHcFtQoiIe7D7psBUmxe5ficby4I3THzUBUVO8mlZ+Gu0DRrGY
	/XAifrVpA2ZltM+htV4Pf92TEGFkxcFpqTHZdX88IjIkB72i/UXXxxZunJfY6UnU5u0iAje43tT
	e81TbNkwLDa95pDme8xgyEjRGtwiScWrKpn4aNXowwemHjBJ+fma6aFdOEbZHz7R/iGUoxFcKw=
	=
X-Received: by 2002:a05:6830:4420:b0:812:c5fe:5e4e with SMTP id 46e09a7af769-85ac0806dfamr2685093a34.19.1793205895485;
        Wed, 28 Oct 2026 09:44:55 -0700 (PDT)
Received: from xps16 ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-85b20216828sm2416941a34.19.2026.10.28.09.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 09:44:54 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 30/98] blk-mq: don't bring back flags of a completed request
Date: Wed, 28 Oct 2026 10:41:33 -0600
Message-ID: <20261028164415.1262013-31-axboe@kernel.dk>
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

The timeout handler sets and clears RQF_TIMED_OUT in a request it only
holds a reference to, with a plain read-modify-write, while the
completion clears flags in rq_flags the same way. If the two interleave,
blk_mq_finish_request() runs twice with the flags back: the zone write
plug reference is dropped twice and the scheduler's ->finish_request()
is called again.

Change RQF_TIMED_OUT with cmpxchg, so the handler never writes back a
flag that changed under it.

Fixes: e5c0ca13659e ("blk-mq: release scheduler resource when request completes")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-mq.c      |  2 +-
 block/blk-timeout.c |  3 ++-
 block/blk.h         | 14 ++++++++++++++
 3 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 6d3c60b4ea2b..0491e9821322 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1639,7 +1639,7 @@ EXPORT_SYMBOL_GPL(blk_mq_queue_inflight);
 
 static void blk_mq_rq_timed_out(struct request *req)
 {
-	req->rq_flags |= RQF_TIMED_OUT;
+	blk_rq_change_timed_out(req, true);
 	if (req->q->mq_ops->timeout) {
 		enum blk_eh_timer_return ret;
 
diff --git a/block/blk-timeout.c b/block/blk-timeout.c
index 1b8de0417fc1..0590720e38c7 100644
--- a/block/blk-timeout.c
+++ b/block/blk-timeout.c
@@ -137,7 +137,8 @@ void blk_add_timer(struct request *req)
 	if (!req->timeout)
 		req->timeout = q->rq_timeout;
 
-	req->rq_flags &= ~RQF_TIMED_OUT;
+	if (req->rq_flags & RQF_TIMED_OUT)
+		blk_rq_change_timed_out(req, false);
 
 	expiry = jiffies + req->timeout;
 	WRITE_ONCE(req->deadline, expiry);
diff --git a/block/blk.h b/block/blk.h
index a48665e10994..de3a1633403b 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -365,6 +365,20 @@ static inline void bio_integrity_free(struct bio *bio)
 unsigned long blk_rq_timeout(unsigned long timeout);
 void blk_add_timer(struct request *req);
 
+/*
+ * The timeout handler changes RQF_TIMED_OUT in a request which it does not
+ * own: whoever completes it changes rq_flags at the same time, with plain
+ * loads and stores. Never write back a flag that has changed under us.
+ */
+static inline void blk_rq_change_timed_out(struct request *rq, bool set)
+{
+	req_flags_t old = READ_ONCE(rq->rq_flags), new;
+
+	do {
+		new = set ? old | RQF_TIMED_OUT : old & ~RQF_TIMED_OUT;
+	} while (!try_cmpxchg(&rq->rq_flags, &old, new));
+}
+
 enum bio_merge_status {
 	BIO_MERGE_OK,
 	BIO_MERGE_NONE,
-- 
2.56.0

