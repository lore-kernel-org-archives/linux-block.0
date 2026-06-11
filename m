Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492AA3EAC9B;
	Thu, 11 Jun 2026 14:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781186841; cv=none; b=SaZiUnELbw0p8pH/ROLXHbr+x7poCj09n8KGByjWGPMWJA39NGS5vnNtz2IoNJEBptbUT5+d6LZMRZYkRDHdja8fiNW03A6KbIfAndn8QNDlwnJw9cXgetcOiofVNhVeLYKf9Vgt9BRYH+eOQk6R67UrHwASEYh3TjpvuFa3uzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781186841; c=relaxed/simple;
	bh=fxsgWqb4oeZjTkOnPtvEkC+RxaxFm9+SrNUoHvj8UHY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IQ41cQWM7W5iRwiXKDMLQnEFsvzvy/gso64DtvD3Z8MUSOqtPEahhTQXTqOymSytpr/NDTi0IaASfxdddrfky2Idby0cBgU8apgremE8OuP61sDvoyhkBTmrdulVzL+eA35prfj30Ypzl8fwVy8zU264Rv2nkb0YUwFpXYD6ez4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fcrUBikV; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fcrUBikV"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=TBWurqR6BINgttp5FSmfnCljJoIYXOvWGzovteaTBTY=; b=fcrUBikV6Ue/bYZPKJgLxl6Wne
	Wpfw62YAN9WGEJjasVtgP3mHIxav3Nw5GLwEsQQiIl5qMo11iD4IKpKb61Idj30Ng7qAWCuToyfuc
	eD5m6TkgEdm5Vicc/2jmWrGGkdfUkQ/GiC2qf+J0W0zz9Q3PCOccE36fMV+VTydc3zQTd3ZrVue4u
	wm8S5P1HTLmLqp0hUK8UPysqrIwcNnJSVlB6BxRxLxWcH1jOPfL6L8nvOkZh0hKGbSeeH8St5U66a
	tjEbvdLGR+EO/qduHxLHQLturmuHL/v0mZKcYBPOXWdDDhudTj0xJHevZitipepFLO10367oabmx2
	HYlUgLhw==;
Received: from 2a02-8389-2341-5b80-decc-1a96-daaa-a2cc.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:decc:1a96:daaa:a2cc] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXg3z-00000009ZYf-1Zrl;
	Thu, 11 Jun 2026 14:07:19 +0000
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
Date: Thu, 11 Jun 2026 16:06:46 +0200
Message-ID: <20260611140703.2401204-4-hch@lst.de>
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

