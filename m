Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B69CA6B;
	Thu, 11 Jun 2026 14:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781186837; cv=none; b=R1fejLWxu4iimPwJTc0LQKCaG+xLN86ixlplgKKBBioWAdM3/MP/6NBcLKNwOC7zk3VWjxnsgPia0nlc5jBZZ7slVM5VAuxdUTJqkipaImTGpH4FxglgXBstxJLZ0IGxFwHJ+5Fc7NshhzLXMXB2qsVHk9GLA3an9Z37uZ3hWr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781186837; c=relaxed/simple;
	bh=vuSdk88zwjeGFr8fzwLIV7cj7nwQFF52yTgJ/h67AUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qxLHE7lbtbtA4a5BPKtLFLw7ceveWM2l5e2SwPiZ99rAzgWY3mDu0qVgJeFfAMFn957YTUxx3QGLnGFDYxeObyoB8vf+omP7CwrdeuR1vWVMGoASbnwE8eM/PH+p41v7or55Ejy5oIy2V7/vF2quqm86t5CSyJg43NjnPV1U5l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=RDlIM6yN; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RDlIM6yN"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=eNcnXFwyahPkKYI9OBdA7esRxefWS4Jdn5Q7SvmX/Ow=; b=RDlIM6yNU5r2G54p6kk5DEpY3C
	k7U859HYgge3XWWQys9YuHYEvJsNhwD9EUn40o5TSUMIujFxQtsE6do9uW6sGp0J1PgyBQjqDu6Y2
	WT+xl7HsA2gia3WF+F2JZW4CawlNipiEazY7awt7ieNU8Pi0FUe8i3BbJGe7exBcT1+9lfSY6qJ9R
	5JezRFYGpy3ZQe2gkXgp6Pg0XhJ0lOXn3UNGKhouqObGTZgG29VfN6ajqrZRykot2VDmAYOtBvq1k
	dYIuldrWyFVuIOD2vr8TqVLfp0VA4FOwr2hVleucwtPCU5LtWnBwMnFcqVFbxMIhdv8ByU7MyOisb
	ai0Q6ULA==;
Received: from 2a02-8389-2341-5b80-decc-1a96-daaa-a2cc.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:decc:1a96:daaa:a2cc] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXg3v-00000009ZYS-32xP;
	Thu, 11 Jun 2026 14:07:16 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Damien Le Moal <dlemoal@kernel.org>,
	Hannes Reinecke <hare@suse.de>,
	Keith Busch <kbusch@kernel.org>,
	linux-block@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 2/4] block: add a "tag" for block status codes
Date: Thu, 11 Jun 2026 16:06:45 +0200
Message-ID: <20260611140703.2401204-3-hch@lst.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260611140703.2401204-1-hch@lst.de>
References: <20260611140703.2401204-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

The full name of the status codes is not good for user interfaces as it
can contain white spaces.  Add the name of the status code without the
BLK_STS_ prefix as a tag so that it can be used for user interfaces.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Hannes Reinecke <hare@kernel.org>
---
 block/blk-core.c | 28 ++++++++++++++++++++++++++++
 block/blk.h      |  2 ++
 2 files changed, 30 insertions(+)

diff --git a/block/blk-core.c b/block/blk-core.c
index 43121a9f99f0..842b5c6f2fb4 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -135,10 +135,12 @@ EXPORT_SYMBOL_GPL(blk_op_str);
 #define ENT(_tag, _errno, _desc)	\
 [BLK_STS_##_tag] = {				\
 	.errno		= _errno,		\
+	.tag		= __stringify(_tag),	\
 	.name		= _desc,		\
 }
 static const struct {
 	int		errno;
+	const char	*tag;
 	const char	*name;
 } blk_errors[] = {
 	ENT(OK,			0,		""),
@@ -203,6 +205,32 @@ const char *blk_status_to_str(blk_status_t status)
 	return blk_errors[idx].name;
 }
 
+const char *blk_status_to_tag(blk_status_t status)
+{
+	int idx = (__force int)status;
+
+	if (WARN_ON_ONCE(idx >= ARRAY_SIZE(blk_errors) || !blk_errors[idx].tag))
+		return "<null>";
+	return blk_errors[idx].tag;
+}
+
+blk_status_t tag_to_blk_status(const char *tag)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(blk_errors); i++) {
+		if (blk_errors[i].tag &&
+		    !strcmp(blk_errors[i].tag, tag))
+			return (__force blk_status_t)i;
+	}
+
+	/*
+	 * Return BLK_STS_OK for mismatches as this function is intended to
+	 * parse error status values.
+	 */
+	return BLK_STS_OK;
+}
+
 /**
  * blk_sync_queue - cancel any pending callbacks on a queue
  * @q: the queue
diff --git a/block/blk.h b/block/blk.h
index 7fdfb9012ce1..3ab2cdd6ed12 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -51,6 +51,8 @@ struct blk_flush_queue *blk_alloc_flush_queue(int node, int cmd_size,
 void blk_free_flush_queue(struct blk_flush_queue *q);
 
 const char *blk_status_to_str(blk_status_t status);
+const char *blk_status_to_tag(blk_status_t status);
+blk_status_t tag_to_blk_status(const char *tag);
 
 bool __blk_mq_unfreeze_queue(struct request_queue *q, bool force_atomic);
 bool blk_queue_start_drain(struct request_queue *q);
-- 
2.53.0

