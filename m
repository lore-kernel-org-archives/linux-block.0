Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794414120;
	b=B3TRTC5munXgbI+EYW3nptuTBx+BJ7BZLBVUb2Mn2ulPMgkfrFiy8mKFQFxgmgA97xty
	 040EihiUkE/YfkuS0CUfCzMEeomSrdEew0l01ABu07lcXbbaN/UZQ9V5JW6TLmTqkItpw
	 oSIATHP3cDgu5XLJdnk3vKvcHWbFoTB5caPzYBSpAwWjLMiPh/ni9LxNkk0LPPIUiEjAl
	 o0oFx/TVMgiqCxzRTfPfFjOekQmVVzG0JA4u/6UtVjslbL8PKzLJG24JzPV9334O1rB3A
	 xFOs05t26BpgA1KRhcIH9Vt/rn660M3nBAAnoFjbgOtiTfjQGTLDa7mq/wD5swjhDxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794414120;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=VJGtlaPINj1DXcWX4y85rvvcbuq32TLYXZeY2c0DWog=;
	b=0yPFObeu9WLW9KR9UhZJ6SbbgLx4zwrS7G1+Gi/sOjMsTbIua6R7wrs/XShTksowJhN5
	 DQNVJmzTJ422D41T4Do2gBmuQ1OAu/Dsrdd01YJIZ0dzxCDTCTTa6XaLPgupon6NMQ768
	 TTbBQ9FQxa6IhzxM9FZeFGA4zFd1nu1PLSnp4y1FOgHv6iDlHK/dIipqT0duzaatIVeRo
	 tUI7YCYtI0t9hF47vKFKJdxJWxpKhPN9fdSXWEk8fOTTlQLh+u7WfDmm9CJCosITWvEF/
	 xwkUXKmzNO4gI86dFgia5gNUjEV0fp53u9/ERsqGCBZbw1XqCVQgjcfwfBvunzGowTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=WRRqZqaP;
	arc=none smtp.remote-ip=95.215.58.72
Received: from mta1.migadu.com (out-72.mta1.migadu.com [95.215.58.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D01606A324
	for <linux-block@vger.kernel.org>; Wed, 11 Nov 2026 16:21:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 42D01606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=WRRqZqaP
X-Envelope-To: linux-block@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=EoFT4KkRoHJY5kdQFyTVPzb3Rq1uBeETUVCmnHBlUgM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794414117; v=1; x=1795018917;
 b=WRRqZqaP1PQfncI9QH8UiNKTsqKMbuIYmfwiUW8I9HD5mHgyPR5j69m7q1phtIUknEcMu48d
 8uA1HY/vvW89h6TwHeTN92QRwVFaLf0YUrjxtsG6qjGlOD7yf5dRARRGvyDX6YgOOdLi5hWJ4nf
 QdMM10zkPxMxJrC1lDzDLyWE=
X-Envelope-To: linux-block@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 73970e10ef5fd271;
	Wed, 11 Nov 2026 16:21:57 +0000
X-Mizu-Trace-ID: 73970e10ef5fd271
X-Migadu-Flow: FLOW_OUT
From: Tao Cui <cui.tao@linux.dev>
To: tj@kernel.org,
	axboe@kernel.dk,
	josef@toxicpanda.com
Cc: oliver.sang@intel.com,
	nilay@linux.ibm.com,
	hch@lst.de,
	yukuai@fygo.io,
	linux-block@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cui.tao@linux.dev,
	cuitao@kylinos.cn,
	sashiko-bot@kernel.org
Subject: [PATCH] blk-iocost: fix the lock order in ioc_cost_model_write()
Date: Thu, 12 Nov 2026 00:21:37 +0800
Message-ID: <20261111162137.295523-1-cui.tao@linux.dev>
X-Mailer: git-send-email 2.53.0
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

ioc_cost_model_write() holds rq_qos_mutex, which is acquired by
blkg_conf_open_bdev(), across blk_mq_freeze_queue(). ioc_qos_write()
freezes the queue before taking the mutex instead.

The inversion cannot currently deadlock because blk_mq_freeze_queue()
is in a noio scope since 1e1a9cecfa ("block: force noio scope in
blk_mq_freeze_queue"), so a caller freezing a queue cannot recurse
into the frozen queue through reclaim. Holding the mutex across
the freeze needlessly serializes config writers behind it and
leaves two different orderings in the same file. Release the mutex
around the freeze to match ioc_qos_write(), mirroring the fix there
in 9730763f4756 ("block: correct locking order for protecting
blk-wbt parameters").

Reported-by: sashiko-bot@kernel.org
Link: https://sashiko.dev/#/patchset/20261103132613.1952975-1-cui.tao@linux.dev?part=1
Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 block/blk-iocost.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 1c1025157d8e..7fe0a6fa146e 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -3605,7 +3605,14 @@ static ssize_t ioc_cost_model_write(struct kernfs_open_file *of, char *input,
 		ioc = q_to_ioc(q);
 	}
 
+	/*
+	 * Nothing in the cost model is protected yet; release rq_qos_mutex
+	 * around the freeze to match ioc_qos_write().
+	 */
+	mutex_unlock(&q->rq_qos_mutex);
 	memflags = blk_mq_freeze_queue(q);
+	mutex_lock(&q->rq_qos_mutex);
+
 	blk_mq_quiesce_queue(q);
 
 	spin_lock_irq(&ioc->lock);
-- 
2.53.0

