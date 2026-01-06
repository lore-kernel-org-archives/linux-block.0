Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F876309EE5
	for <linux-block@vger.kernel.org>; Tue,  6 Jan 2026 07:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767683129; cv=none; b=Aov0GZN1gZoWomCN3kaCHtKikauMQbCAwKM5lHxNQq/wUCWTyH5W0Y1Lg6zUePn/cMy8tP9fKZzAyrrKNlc39/9ldB0kzh8o2V9yR10XhepKAAlRuMN3fPEXbkKg9xaaKXP/H97nHxy518Ot1286wL2VG/f49cR5c3TK3E+uCMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767683129; c=relaxed/simple;
	bh=TE19mLFIXPOI42YLz0H6SZ7aEpqV+IgYHcbHTHEYys4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B3/n9Jc2kFbKz92LLsrpDfKa2CV8oGesMMTrOIiwPJVJtRxhskfu96+0JEOJ1CuihQte1NIDgv03jYk3A0BInksEE++lF+3gXiEShBe0eMjbOWyIvZcefcl1V3dA3b1VhIn0zvvwsU2Ef4Z4Qva1fvVmbdwiQkYP96lOj0yFOuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=irJUvjG/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="irJUvjG/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F6CBC19424;
	Tue,  6 Jan 2026 07:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767683128;
	bh=TE19mLFIXPOI42YLz0H6SZ7aEpqV+IgYHcbHTHEYys4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=irJUvjG/JWi5NHmEuRGi80RTFCtFLvsBZ/AZppL/K5P+hY3gCwh9jWBEorvrNA0hf
	 O/ZbGCOgWxr4KliDNXxDEzf5I9JUfKhOWNOqroma99qDSzF7Vopfo4Mp4jlgNjrbiA
	 N+4g/NQJWK9sE7GlQPix+dNTG/PE9hW7MFFzrjHjyjNe5BZqYVgO0TsONmNrwVXFPT
	 CJmykbvy5aa0+tc7LhEAyfPrFkbSD+xDd6DL9e5FAcuhugbOo8rguJ/pWHbIZDRmC6
	 FoJcfkPscJw8Pi+48TfjgGU2WB24U+1kjdHzVlGq/Q7r4xx+XWSbjh9whIgmqwSptb
	 CQcCzWwGp9oew==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Subject: [PATCH 2/2] block: improve blk_op_str() comment
Date: Tue,  6 Jan 2026 16:00:57 +0900
Message-ID: <20260106070057.1364551-3-dlemoal@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260106070057.1364551-1-dlemoal@kernel.org>
References: <20260106070057.1364551-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace XXX with what it actually means.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 block/blk-core.c       | 10 +++++-----
 include/linux/blkdev.h |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 8387fe50ea15..a8a62154376c 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -114,12 +114,12 @@ static const char *const blk_op_name[] = {
 #undef REQ_OP_NAME
 
 /**
- * blk_op_str - Return string XXX in the REQ_OP_XXX.
- * @op: REQ_OP_XXX.
+ * blk_op_str - Return the string "name" for an operation REQ_OP_name.
+ * @op: a request operation.
  *
- * Description: Centralize block layer function to convert REQ_OP_XXX into
- * string format. Useful in the debugging and tracing bio or request. For
- * invalid REQ_OP_XXX it returns string "UNKNOWN".
+ * Convert a request operation REQ_OP_name into the string "name". Useful for
+ * debugging and tracing BIOs and requests. For an invalid request operation
+ * code, the string "UNKNOWN" is returned.
  */
 inline const char *blk_op_str(enum req_op op)
 {
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 63affe898059..438c4946b6e5 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1026,7 +1026,7 @@ extern int blk_queue_enter(struct request_queue *q, blk_mq_req_flags_t flags);
 extern void blk_queue_exit(struct request_queue *q);
 extern void blk_sync_queue(struct request_queue *q);
 
-/* Helper to convert REQ_OP_XXX to its string format XXX */
+/* Convert a request operation REQ_OP_name into the string "name" */
 extern const char *blk_op_str(enum req_op op);
 
 int blk_status_to_errno(blk_status_t status);
-- 
2.52.0

