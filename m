Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929C33EB819;
	Fri,  5 Jun 2026 18:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780685099; cv=none; b=pj9RLS4QMGXNParn6yq3LRdq2UWfPXrW2jT3N5FFXeHu5gqEcJZI/OgdYoU22i91rSrsgCRe4jmiOC9lwCmCLuyMAgFFyk2E2KM20ayjc/Sxaaa45K9UXYni1Cattyirau9pZeTV7rYZVMDl7ZZfz0SqgByaurK12yELw4zOG6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780685099; c=relaxed/simple;
	bh=ASBAtUTT9ZqbmIT29Fw7T5RmfjzrY1/ITnUkgBV+sKg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gciZDCNcbRSt5r6hv1mktcp+tkNNWcxddsztNMhgAmk0kUszPyzDhafxlAvr0E2Wl0y6Py8pgk54n08e+g5nPZKIeTQA315ARkU8iTyacAxfSJJ37YqoHRqz1blUtrFu/2bIRt3oSMWmZiDvJ6PaAmB0fAL1/CwjtJspGVtDlxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hZw+udIb; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hZw+udIb"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=vGHBFFmo7qmjjUy7lsqyMG8SVK4UX1DZFOIQvyYEmHk=; b=hZw+udIbGv5xKbU6tFivWMUKAV
	otbVRCESiiHVWhButDF1PFn8eAKPceWUuRKegJirmhO8MPfPs5MT0lkE7iB8G0p4lUh0p2T/TNUD8
	gJAwjFlfanF/fzufW8NBgMix5B98E/3FupIJPGRt7oyK3AbbyCh8XMEQF48qvVicHTCCSVAe8vW2h
	5klnxbiMtEteFg/h+lt7UOCfplsAAlyuT0IQ+VAgkXEHSWbaUPpE/fuFEaGP+631OqI/Nqn67EJQX
	IdyvM1LhzXRok6NfWc/q5CU14AgDHPr8IMErd7bpvFIR6uDzMHDRTitQqwargLDhdS6cxdruTRpAf
	0mV+F1hQ==;
Received: from 2a02-8389-2341-5b80-decc-1a96-daaa-a2cc.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:decc:1a96:daaa:a2cc] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wVZXL-000000014QQ-2ifb;
	Fri, 05 Jun 2026 18:44:55 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Jonathan Corbet <corbet@lwn.net>,
	linux-block@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Keith Busch <kbusch@kernel.org>
Subject: [PATCH 3/4] block: add a str_to_blk_op helper
Date: Fri,  5 Jun 2026 20:44:29 +0200
Message-ID: <20260605184441.590927-4-hch@lst.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260605184441.590927-1-hch@lst.de>
References: <20260605184441.590927-1-hch@lst.de>
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
Reviewed-by: Keith Busch <kbusch@kernel.org>
---
 block/blk-core.c | 10 ++++++++++
 block/blk.h      |  1 +
 2 files changed, 11 insertions(+)

diff --git a/block/blk-core.c b/block/blk-core.c
index 7aa9cd110bdd..aa90aad6da13 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -132,6 +132,16 @@ inline const char *blk_op_str(enum req_op op)
 }
 EXPORT_SYMBOL_GPL(blk_op_str);
 
+enum req_op str_to_blk_op(const char *op)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(blk_op_name); i++)
+		if (blk_op_name[i] && !strcmp(blk_op_name[i], op))
+			return (enum req_op)i;
+	return REQ_OP_LAST;
+}
+
 #define ENT(_tag, _errno, _desc)	\
 [BLK_STS_##_tag] = {				\
 	.errno		= _errno,		\
diff --git a/block/blk.h b/block/blk.h
index 10426d23f662..93b30d1d0ec6 100644
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

