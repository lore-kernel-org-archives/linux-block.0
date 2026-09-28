Received: from mta1.migadu.com (out-63.mta1.migadu.com [95.215.58.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F30502D58
	for <linux-block@vger.kernel.org>; Mon, 28 Sep 2026 22:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.63
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790633817; cv=none; b=Mf/2knJGXMJpbRFXSEzfCYp4siWNK+iq0YSEkkL4/XQggqBtqWnEz2/BCG+krqRxUChZ22xiw87KJhPT+KujUT+YjHCOk0V9UHQ0eMVyyVvcox7dThxADNqjoPVT1IO4qRz7LXCy0jkZk4SSO46GHle17SY6BpJqPpr3dUgEEWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790633817; c=relaxed/simple;
	bh=REY+bf/fVu7ynW73ZWt6hdkvruU9IcxvmHVikFMi3Lc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gWOq1E15ufzduDsLtwVWudvCksSnyGWb9xaugPZwcGEz8xXibmrER2lCj0xK8+ilpUsVPlKnjJ7saLJsdqZ15bxAK+FWs5ICL39papwPqq5L2t2v6rYcQS0s27Bk0vtQa8a5njR5NFDeFKPFuJnrinJO8s7ey+77gPN3DA6BWEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ihAJtgLb; arc=none smtp.client-ip=95.215.58.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ihAJtgLb"
X-Envelope-To: linux-block@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=REY+bf/fVu7ynW73ZWt6hdkvruU9IcxvmHVikFMi3Lc=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790633812; v=1; x=1791238612;
 b=ihAJtgLboM5OJVQz9xx2eXK4Jz4mSNi/6yKBOLV9/TP21KW8Epz7fTte1qb8IIF7DubGyLRc
 +tCMgtKK5qrVwHG4AP8F9k736wIIsVOfA8W9BQ/qcTV1Zu5y0Amst8txSWzt9OuXGsEL25p/cyK
 0PTzV55muhMSnnLTcPlgRmsQ=
X-Envelope-To: linux-block@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id e6069451f38441c3;
	Mon, 28 Sep 2026 22:16:52 +0000
X-Mizu-Trace-ID: e6069451f38441c3
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
Subject: [v3 for-next 1/3] block: Reject unknown status tags in error injection rules
Date: Tue, 29 Sep 2026 00:16:32 +0200
Message-ID: <20260928221634.43239-2-haris.iqbal@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260928221634.43239-1-haris.iqbal@linux.dev>
References: <20260928221634.43239-1-haris.iqbal@linux.dev>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
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
Assisted-by: Claude:claude-opus-5
Signed-off-by: Md Haris Iqbal <haris.iqbal@linux.dev>
---
 block/blk-core.c        | 14 ++++++--------
 block/blk.h             |  2 +-
 block/error-injection.c |  7 ++++---
 3 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 13dc70e8f55d..c45846b9c50d 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -225,21 +225,19 @@ const char *blk_status_to_tag(blk_status_t status)
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
index 2cc03aa54c53..5fa54162c686 100644
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

