Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF982379C23;
	Tue,  2 Jun 2026 05:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780379207; cv=none; b=dU8bs8rwGslwZzlpuwQddoTCA+cGEuSFwHFTXELtGznn+SozFYVBtQW9bPzMJiefjUauR9JzQakCDQsO5UbMuTtQmtNkr2/g5gQttC4tTl+jZXeRcKlYSHbf6Ca3lYN+w2uCp14Ht5MBYNKGim25BlH8t1wkmG961f4DrjLeEYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780379207; c=relaxed/simple;
	bh=APCw1cEWopHWhwedbCIUvSoTSp5H7NijbX7pVtv/Pww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bUj8/QZonG8ksH2xf8CRIMQRmbpvAiOZdE9NABbhYdjkQSHU83d33ZOJa2tubT8WZ95YtInICq/kwog1RM2mUlPjx3Qb7mjdF00ERmAcS6yCLyuse8ZIkwcOYSICNmgxqTrAqH8KHjtChIr2/ctWBNiGxAFgpoM7yScPwdTMhC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=AkEliDO9; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AkEliDO9"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=g663VL2As30LH7t1nj4DdbKAj/dqzmJVSf2vvAp0Q1g=; b=AkEliDO92rQyhHClqJ22QD/u/4
	6XOVyTWAVqUCDGTwcNgD5ev1X4SOsu2zpKYbeGlNLYbUpq1lpMcrhRR3iTdl9UlUxZFo2k53AMJvD
	T2gfExYqmM978w1VxIeHE9FwNBwgnLXh299OBQjGJtjKQxaeWSUeD4Ec0BOIN5DaYvZUGqHGMFvbn
	G14SKUxTs01/izxkfxKLRV8RruiWjI2+PgRs53ErzsQOJTgtXg91FwqajGV17vJLwWCUk3tMsxqlL
	Qndw8wivQWcBiL6Ibgk1a0dzGtZrTz1Tsn9EPkzMKI/q+dOjuoN03y4S81q39Dnlbs4EVZ71Tm86I
	jY5WQ9Qg==;
Received: from 2a02-8389-2341-5b80-decc-1a96-daaa-a2cc.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:decc:1a96:daaa:a2cc] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUHxc-0000000CLBt-3lcD;
	Tue, 02 Jun 2026 05:46:45 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Jonathan Corbet <corbet@lwn.net>,
	linux-block@vger.kernel.org,
	linux-doc@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 7/9] block: add a str_to_blk_op helper
Date: Tue,  2 Jun 2026 07:45:39 +0200
Message-ID: <20260602054615.3788425-8-hch@lst.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260602054615.3788425-1-hch@lst.de>
References: <20260602054615.3788425-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Add a helper to find the REQ_OP_XYZ constant from the "XYZ" string.
This will be used for the error injection debugfs interface.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-core.c | 13 +++++++++++++
 block/blk.h      |  1 +
 2 files changed, 14 insertions(+)

diff --git a/block/blk-core.c b/block/blk-core.c
index 19a4d0672b3d..8bbc03ce924f 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -132,6 +132,19 @@ inline const char *blk_op_str(enum req_op op)
 }
 EXPORT_SYMBOL_GPL(blk_op_str);
 
+enum req_op str_to_blk_op(const char *op)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(blk_op_name); i++) {
+		if (blk_op_name[i] &&
+		    !strcmp(blk_op_name[i], op))
+			return i;
+	}
+
+	return REQ_OP_LAST;
+}
+
 #define ENT(_tag, _errno, _desc)	\
 [BLK_STS_##_tag] = {				\
 	.errno		= _errno,		\
diff --git a/block/blk.h b/block/blk.h
index 1e80338af858..4857b899e2b6 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -52,6 +52,7 @@ void blk_free_flush_queue(struct blk_flush_queue *q);
 const char *blk_status_to_str(blk_status_t status);
 const char *blk_status_to_tag(blk_status_t status);
 blk_status_t tag_to_blk_status(const char *tag);
+enum req_op str_to_blk_op(const char *op);
 
 bool __blk_mq_unfreeze_queue(struct request_queue *q, bool force_atomic);
 bool blk_queue_start_drain(struct request_queue *q);
-- 
2.53.0

