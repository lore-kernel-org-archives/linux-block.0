Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0AE370D6E;
	Wed, 10 Jun 2026 05:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781068233; cv=none; b=R6RAf4DFDkvWACe09Nd4AT0Pg5s2iFBq8pcgz80rGe8OpUPzyiGPdghekRX8C5BaN3yKh1TF+wckfgv76WkFt3Oawr+WaNYb9mxjKpz0Bjdv1eq291XvcWaxOWzDlylyGXDnVTIxhwyT1tudbKj4wIY+fLt69ntrm25/7u1vLKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781068233; c=relaxed/simple;
	bh=fxsgWqb4oeZjTkOnPtvEkC+RxaxFm9+SrNUoHvj8UHY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pz07YcyHIOt6hCKwoZ5D19KMLmBEQQ42yp6fhK0cr5PcoSndNEEM49P0+ZWwvudcGzfcltPssCVAIaXnltlDmmsdqHHThucpiljOMSVN6yeo+Vh28t0trnXqw6X0k8aHxUWvg9cgQu/F22d1939WIJtFYP58dz6SBazqu86pmm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=NhS54jTl; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NhS54jTl"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=TBWurqR6BINgttp5FSmfnCljJoIYXOvWGzovteaTBTY=; b=NhS54jTlJIBhwc0Fv6o/cf4S02
	xnZERKt+6aW6y8FLg8LBpKSEzZqe8/SEsxgOv5Oc/3sNcF2M95AlHc2i2XSazDrzUH4+97jbc29un
	cYwDuI8QugD0DNqaLQ6nhneoA3ayprowrXdxhmE18KEZSnaxtVJsuAjeZ1bc+gwHL6j7NqrAcJoMX
	kelbDaRGdH6sA4MLyD6/qI0lRsYqbvP+b3aALD7yqY8oUHnDq6Wt0NEPXdR8A60wvH8X50wiATb05
	W6GWnlsIUwU4/UqMS0RpXMN4IFYegaHdaryNKF05I8e1Oz2iMx4afblNwZxPHmolLjprMD60JU9jJ
	kl1Vy3Kw==;
Received: from 2a02-8389-2341-5b80-decc-1a96-daaa-a2cc.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:decc:1a96:daaa:a2cc] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXBCx-00000006oIh-0tzB;
	Wed, 10 Jun 2026 05:10:31 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Damien Le Moal <dlemoal@kernel.org>,
	Hannes Reinecke <hare@suse.de>,
	Keith Busch <kbusch@kernel.org>,
	linux-block@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 3/4] block: add a str_to_blk_op helper
Date: Wed, 10 Jun 2026 07:08:04 +0200
Message-ID: <20260610051015.1906799-4-hch@lst.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260610051015.1906799-1-hch@lst.de>
References: <20260610051015.1906799-1-hch@lst.de>
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
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Hannes Reinecke <hare@kernel.org>
---
 block/blk-core.c | 10 ++++++++++
 block/blk.h      |  1 +
 2 files changed, 11 insertions(+)

diff --git a/block/blk-core.c b/block/blk-core.c
index 842b5c6f2fb4..beaab7a71fba 100644
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
index 3ab2cdd6ed12..507ab34a6e90 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -53,6 +53,7 @@ void blk_free_flush_queue(struct blk_flush_queue *q);
 const char *blk_status_to_str(blk_status_t status);
 const char *blk_status_to_tag(blk_status_t status);
 blk_status_t tag_to_blk_status(const char *tag);
+enum req_op str_to_blk_op(const char *op);
 
 bool __blk_mq_unfreeze_queue(struct request_queue *q, bool force_atomic);
 bool blk_queue_start_drain(struct request_queue *q);
-- 
2.53.0

