Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97EB235C1AC;
	Thu,  5 Feb 2026 07:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770276551; cv=none; b=QlI89uoS9+2ecosH1gA2XdLNZa4TnhxBUswcj8jBXjO2hr5ui7Q9yN6xl+stvl4pxojtakVi7QQyMFUsL1qfht1S+hfr1mygsxfFT0vve4gJEjnJq+rRuLtD6XSwVJ+KO4RKZMcSV+trh8Qk7fVPQSqNNx6fBsPLGpRbr5Je+AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770276551; c=relaxed/simple;
	bh=EY/43pJFwmCcoMuG08MLSmg6vTo2De+I2D6wtNw8qaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eQQHo+BrVUi2XPa9OP4FK+x05ZRmN5Tj2TxT1xk3IFEtxnZ8mzBJqO4F9T3MSWEGTP503P5mdv0kcphb2Qef2tWa50em9NNvwHdMrMRyL3u9JigqssTBF02nxQ0euidnOWrDaye0XDTzoz82yfwa7KfRNVyvBlNKrQKfc2OC1k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=b8+xK3BV; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="b8+xK3BV"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=GvYSS0kO3rEuc+Lw6sAuhOdJdDPjLPfPKlxMhr/mFOo=; b=b8+xK3BV1+Y08pOpH5RLqjVaMT
	xbxhI/sF3AnusuBfBBKXPaY3e0dE1P/8S8lYgP824kcaz35ZpyIp3qm2bUlD2odrCm7HtCpUmLq4J
	p4CP6Mp9e3jqjTAsxRkp766qMFecTYK+I0s9TeC99qO4GSptm34X9aeF5c3YXfThad3RnsNw8ku8F
	FX3kndEwOEMv5WZCQ2GkegRjdVsKv9qnlOqVDfsYh6yeIwm8uGPEYb777wqhozRut83N4mJiMfREw
	oc0bMVWskeVK9361d6FnAjobVyKI99r4Vb4MEvEykIfWGG96er77/TKvbe9rAcBvlNrnr4JfZRe1o
	dJOkfp7A==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vntnX-00000009YZD-2JYS;
	Thu, 05 Feb 2026 07:29:07 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Yu Kuai <yukuai@fnnas.com>,
	Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-doc@vger.kernel.org
Subject: [PATCH -next] blk-mq: ABI/sysfs-block: fix docs build warnings
Date: Wed,  4 Feb 2026 23:29:03 -0800
Message-ID: <20260205072906.1881343-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Clean up the async_depth documentation:
- insert blank lines before and after lists where needed
- convert verb tense in a few places
- make lines fit within 80 characters

Documentation/ABI/stable/sysfs-block:612: ERROR: Unexpected indentation. [docutils]
Documentation/ABI/stable/sysfs-block:612: ERROR: Unexpected indentation. [docutils]
Documentation/ABI/stable/sysfs-block:612: ERROR: Unexpected indentation. [docutils]

Fixes: 2c04718edcd5 ("blk-mq: add documentation for new queue attribute async_dpeth")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Yu Kuai <yukuai@fnnas.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-doc@vger.kernel.org

 Documentation/ABI/stable/sysfs-block |   33 ++++++++++++++++---------
 1 file changed, 22 insertions(+), 11 deletions(-)

--- linux-next-20260204.orig/Documentation/ABI/stable/sysfs-block
+++ linux-next-20260204/Documentation/ABI/stable/sysfs-block
@@ -613,34 +613,45 @@ What:		/sys/block/<disk>/queue/async_dep
 Date:		August 2025
 Contact:	linux-block@vger.kernel.org
 Description:
-		[RW] Controls how many asynchronous requests may be allocated in the
-		block layer. The value is always capped at nr_requests.
+		[RW] Controls how many asynchronous requests may be allocated
+		in the block layer. The value is always capped at nr_requests.
 
 		When no elevator is active (none):
+
 		- async_depth is always equal to nr_requests.
 
 		For bfq scheduler:
+
 		- By default, async_depth is set to 75% of nr_requests.
 		  Internal limits are then derived from this value:
+
 		  * Sync writes: limited to async_depth (≈75% of nr_requests).
-		  * Async I/O: limited to ~2/3 of async_depth (≈50% of nr_requests).
+		  * Async I/O: limited to ~2/3 of async_depth (≈50% of
+		    nr_requests).
 
 		  If a bfq_queue is weight-raised:
-		  * Sync writes: limited to ~1/2 of async_depth (≈37% of nr_requests).
-		  * Async I/O: limited to ~1/4 of async_depth (≈18% of nr_requests).
 
-		- If the user writes a custom value to async_depth, BFQ will recompute
-		  these limits proportionally based on the new value.
+		  * Sync writes: limited to ~1/2 of async_depth (≈37% of
+		    nr_requests).
+		  * Async I/O: limited to ~1/4 of async_depth (≈18% of
+		    nr_requests).
+
+		- If the user writes a custom value to async_depth, BFQ will
+		  recompute these limits proportionally based on the new value.
 
 		For Kyber:
+
 		- By default async_depth is set to 75% of nr_requests.
-		- If the user writes a custom value to async_depth, then it override the
-		  default and directly control the limit for writes and async I/O.
+		- If the user writes a custom value to async_depth, then it
+		  overrides the default and directly controls the limit for
+		  writes and async I/O.
 
 		For mq-deadline:
+
 		- By default async_depth is set to nr_requests.
-		- If the user writes a custom value to async_depth, then it override the
-		  default and directly control the limit for writes and async I/O.
+		- If the user writes a custom value to async_depth, then it
+		  overrides the default and directly controls the limit for
+		  writes and async I/O.
 
 
 What:		/sys/block/<disk>/queue/nr_zones
