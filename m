Received: from mta1.migadu.com (out-226.mta1.migadu.com [95.215.58.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96BB425B087
	for <linux-block@vger.kernel.org>; Sun, 30 Aug 2026 01:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788052824; cv=none; b=XcTnOBtSPRw/uWllcMdxGQgMb6VK7tcyyGmJgb5vjMNRyNeVHXLaqREE87xIW5a0oIM6aP4WQRksSo0yxMovoCcmRbqdWKiqIAEv1+9AJ/X5sZ11muDmz0MlP1JOdOUw5scJVt3mRJ3NCiDXbXoO5jSdkS4TBCLyaeJaE2UBuSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788052824; c=relaxed/simple;
	bh=y0l2JK7SwE0igvljwsQtBdD/9LULsWF21doXn8fbuHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VgMiXnIBz7lbUu2qOpD0acGiZmsQPKnmZ7073GG7IVp/NQ+WhfDEzsHTaEqRG1n1p/ooY6YUtcz+JJEMtbc72AUzR6pPvsdjVkMDL5VZSZs7DeUnDLV3lpI9iMr8KpkULTg3SisQ6L8v4Z03vFQYLcwC6MGbcM/ieGaesWKM/1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jd3Y3GLL; arc=none smtp.client-ip=95.215.58.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jd3Y3GLL"
X-Envelope-To: linux-block@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=y0l2JK7SwE0igvljwsQtBdD/9LULsWF21doXn8fbuHo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788052820; v=1; x=1788657620;
 b=jd3Y3GLLidaY5WTX8/F9N/r2/Ez1P+H3LJnHfLVYLhYbnElDSA9/0anruqd8r5cbnu8Y8lP/
 ifIJsa3nWrC34/v8Mneb9UGX/UA1GEFh0vOPkImmdo8b9NmOEjDrssVbxXTZRmgAE7Vyj0RISx0
 +2Vs01wsYQNoE4AlVTvhZN5A=
X-Envelope-To: linux-block@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 1edf6a99255e172b;
	Sun, 30 Aug 2026 01:20:20 +0000
X-Mizu-Trace-ID: 1edf6a99255e172b
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
Subject: [v2 for-next 1/3] block: reject unknown status tags in error injection rules
Date: Sun, 30 Aug 2026 03:20:00 +0200
Message-ID: <20260830012002.80275-2-haris.iqbal@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260830012002.80275-1-haris.iqbal@linux.dev>
References: <20260830012002.80275-1-haris.iqbal@linux.dev>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tag_to_blk_status() returns BLK_STS_OK both for the "OK" tag and for a
tag it does not recognise, so a caller cannot tell the two apart.
match_status() leaves *status at BLK_STS_OK for an unknown tag and relies
on error_inject_add() rejecting BLK_STS_OK.

That holds only while a rule without a status is meaningless.  The delay
option added next makes such a rule valid, and "OK" is what
blk_error_injection_show() prints for one, so the two cases have to be
told apart.  Return the status through a pointer and report an unknown
tag as -EINVAL.  There is no spare blk_status_t to encode "not found" in:
every value in the table has a tag that can be typed, and anything
outside the table trips the WARN_ON_ONCE() in blk_status_to_str(),
blk_status_to_tag() and blk_status_to_errno().

For a single status= this does not change behaviour: an unknown tag still
fails the write with -EINVAL.  A repeated status= where an invalid tag
comes first is now rejected instead of being overridden by the later one.

Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Md Haris Iqbal <haris.iqbal@linux.dev>
---
 block/blk-core.c        | 14 ++++++--------
 block/blk.h             |  2 +-
 block/error-injection.c |  7 ++++---
 3 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 196bccf27f58..29c86addb8f2 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -225,21 +225,19 @@ const char *blk_status_to_tag(blk_status_t status)
 	return blk_errors[idx].tag;
 }
 
-blk_status_t tag_to_blk_status(const char *tag)
+int tag_to_blk_status(const char *tag, blk_status_t *status)
 {
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(blk_errors); i++) {
 		if (blk_errors[i].tag &&
-		    !strcmp(blk_errors[i].tag, tag))
-			return (__force blk_status_t)i;
+		    !strcmp(blk_errors[i].tag, tag)) {
+			*status = (__force blk_status_t)i;
+			return 0;
+		}
 	}
 
-	/*
-	 * Return BLK_STS_OK for mismatches as this function is intended to
-	 * parse error status values.
-	 */
-	return BLK_STS_OK;
+	return -EINVAL;
 }
 
 /**
diff --git a/block/blk.h b/block/blk.h
index 50abfd932886..8a8ab961528d 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -52,7 +52,7 @@ void blk_free_flush_queue(struct blk_flush_queue *q);
 
 const char *blk_status_to_str(blk_status_t status);
 const char *blk_status_to_tag(blk_status_t status);
-blk_status_t tag_to_blk_status(const char *tag);
+int tag_to_blk_status(const char *tag, blk_status_t *status);
 enum req_op str_to_blk_op(const char *op);
 
 bool __blk_mq_unfreeze_queue(struct request_queue *q, bool force_atomic);
diff --git a/block/error-injection.c b/block/error-injection.c
index e14bc4b723ef..41ee8f788bb5 100644
--- a/block/error-injection.c
+++ b/block/error-injection.c
@@ -171,15 +171,16 @@ static int match_op(substring_t *args, enum req_op *op)
 static int match_status(substring_t *args, blk_status_t *status)
 {
 	const char *tag;
+	int ret;
 
 	tag = match_strdup(args);
 	if (!tag)
 		return -ENOMEM;
-	*status = tag_to_blk_status(tag);
-	if (!*status)
+	ret = tag_to_blk_status(tag, status);
+	if (ret)
 		pr_warn("invalid status '%s'\n", tag);
 	kfree(tag);
-	return 0;
+	return ret;
 }
 
 static ssize_t blk_error_injection_parse_options(struct gendisk *disk,
-- 
2.53.0

