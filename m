Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.168
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794434331;
	b=cENGkXkzLFbK/0Ujw7pI1vr5Q5NGWVXrilyPbPJQ5Ls/eQFi1ou3ECShwnn5I6/Ipqki
	 PHOdCLLUsYYM7spEp9rADWaMlajoXf45IeeCZc/oNAnXB6N3wvPMMwpVmycuDQ+2HVD8g
	 lK63R7j92ZMABdcbdptfzCKSAQV69Z3K87qPVqAZQIrSMcr9UNcTHcmmmZyVdqkkp3VYB
	 /2PwZwZccI+2p/moEqhs0/G5ttjmg1yrokOJK2eHIEpv/c0hgS+s9UWTSBOV+ClU58KcH
	 KLGJlHGjS08naPHnNSYxoo0nifbmNxczhLkLVEyN1Ngwo/I55IkUqoNyqiwsJwXpyKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794434331;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=C+Gn6RummdqO4CrCZxOhHXaoNeGZaSqp0ZgNY3d5bAo=;
	b=raxHYM+nPcG/9AXSoPEWvtxYWYfHcCme+tBaluLTkzN2lo1be2HQeMyOKjIuZTLikw7D
	 6RdzFtliEOippT6UArrM7nthr0x9NOK262HvPG3J2/v5G7R6rNOKQHJ17/G1GOISY5rwA
	 7NiwPYqU/VrTzPWrjTCNG/P2fcoa0OUbieKHs+zTnVtlc/Gc0XsRvWzwjsEdfqvLGCwvz
	 thKdg+QX4THH2qfeabtoobLAfOfre1oD7wyTS0ANR6QV2kAgUqdriG4zYf6sAcY3z3G+F
	 uGIdVsRuvfv+IZJbvXgjKHD4vVywr75qpINBVA5ABJ6voBAPJpaIBQwcHR/OePNjCcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=k2Epol4T;
	arc=none smtp.remote-ip=95.215.58.168
Received: from mta1.migadu.com (out-168.mta1.migadu.com [95.215.58.168])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0359606A89A
	for <linux-block@vger.kernel.org>; Wed, 11 Nov 2026 21:58:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0359606A89A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=k2Epol4T
X-Envelope-To: linux-block@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=szU6BENnGtaOWNLKR0jKnvvcedxpIyMKQtFwTvNdL5k=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794434329; v=1; x=1795039129;
 b=k2Epol4TSVIJbKVaNAqeSLxetxd5/MvfTG0EpXx4AQC5QQsKXV8JVG5yJuobXsa1RzT8dgrC
 ImjaZIooMDCMOblLUazuNTiBO62WG7MTAWI7wb5YmVG8VmM7BG35NurZmX6jXlt1JASAP/H0RCi
 tl+twPCfoSdU/OHiAhOgTlwY=
X-Envelope-To: linux-block@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id c3e555939cfd8b79;
	Wed, 11 Nov 2026 21:58:48 +0000
X-Mizu-Trace-ID: c3e555939cfd8b79
X-Migadu-Flow: FLOW_OUT
From: Md Haris Iqbal <haris.iqbal@linux.dev>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	Md Haris Iqbal <haris.iqbal@linux.dev>
Subject: [v4 1/3] block: Reject unknown status tags in error injection rules
Date: Wed, 11 Nov 2026 22:58:36 +0100
Message-ID: <20261111215838.103356-2-haris.iqbal@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111215838.103356-1-haris.iqbal@linux.dev>
References: <20261111215838.103356-1-haris.iqbal@linux.dev>
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

tag_to_blk_status() returns BLK_STS_OK both for the "OK" tag and for a
tag it does not recognize, so a caller cannot tell the two apart. The
block error injection code (which is the sole user of this function
currently) relies on error_inject_add() later to reject adding a rule with
status=BLK_STS_OK. This is okay for the current state of error injection.

The delay option added in the next commit makes the rule with status=OK
valid, meaning the function tag_to_blk_status() now needs to explicitly
match BLK_STS_OK for it, and fail for a tag it does not recognize. Hence
make tag_to_blk_status() take a second param to update the matched status,
and return true in case of a successful match. If a match is not found,
the function tag_to_blk_status() returns false and *status remains
unchanged.

A repeated status= where an invalid tag comes first is now rejected
instead of being overridden by the later one.

Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Md Haris Iqbal <haris.iqbal@linux.dev>
---
 block/blk-core.c        | 14 ++++++--------
 block/blk.h             |  2 +-
 block/error-injection.c |  7 ++++---
 3 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 8836c7028568..2ee079c1ce15 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -226,21 +226,19 @@ const char *blk_status_to_tag(blk_status_t status)
 	return blk_errors[idx].tag;
 }
 
-blk_status_t tag_to_blk_status(const char *tag)
+bool tag_to_blk_status(const char *tag, blk_status_t *status)
 {
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(blk_errors); i++) {
 		if (blk_errors[i].tag &&
-		    !strcmp(blk_errors[i].tag, tag))
-			return (__force blk_status_t)i;
+		    !strcmp(blk_errors[i].tag, tag)) {
+			*status = (__force blk_status_t)i;
+			return true;
+		}
 	}
 
-	/*
-	 * Return BLK_STS_OK for mismatches as this function is intended to
-	 * parse error status values.
-	 */
-	return BLK_STS_OK;
+	return false;
 }
 
 /**
diff --git a/block/blk.h b/block/blk.h
index 0e38e4b88cf5..105fff157bfb 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -52,7 +52,7 @@ void blk_free_flush_queue(struct blk_flush_queue *q);
 
 const char *blk_status_to_str(blk_status_t status);
 const char *blk_status_to_tag(blk_status_t status);
-blk_status_t tag_to_blk_status(const char *tag);
+bool tag_to_blk_status(const char *tag, blk_status_t *status);
 enum req_op str_to_blk_op(const char *op);
 
 bool __blk_mq_unfreeze_queue(struct request_queue *q, bool force_atomic);
diff --git a/block/error-injection.c b/block/error-injection.c
index e14bc4b723ef..db543fe27630 100644
--- a/block/error-injection.c
+++ b/block/error-injection.c
@@ -171,15 +171,16 @@ static int match_op(substring_t *args, enum req_op *op)
 static int match_status(substring_t *args, blk_status_t *status)
 {
 	const char *tag;
+	bool found;
 
 	tag = match_strdup(args);
 	if (!tag)
 		return -ENOMEM;
-	*status = tag_to_blk_status(tag);
-	if (!*status)
+	found = tag_to_blk_status(tag, status);
+	if (!found)
 		pr_warn("invalid status '%s'\n", tag);
 	kfree(tag);
-	return 0;
+	return found ? 0 : -EINVAL;
 }
 
 static ssize_t blk_error_injection_parse_options(struct gendisk *disk,
-- 
2.53.0

