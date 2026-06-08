Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2C235F189;
	Mon,  8 Jun 2026 05:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780895675; cv=none; b=Pal0PJc1Drt1IMJ94pFkpeNyi40CudhFch2zZaRBBdwsRj5IuVJUJ53hFi+afZqEOSoC1VRD09Ml2vlm6AP/194y36SpBaLloAOvsshCXDowdNvPQmGPxqQEzC1vvSCfEy75GCzO2EaJVUIY9du4KkQ+16MrYccFcwH6ShGvWQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780895675; c=relaxed/simple;
	bh=3MeQj47BJCbwHHIiKgyLeN/STBCEu2QQ7PlK43++/1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NkW6cRPz68YKdPeVpj6xSoC60jE/KHXSmBv7DxS107vGjtWg2VFF5nxfKWdwgnvAx2+Ob+zAKHvKddcWvBINzk8CjYFJNzEZWq0XKmM3MEJXZ0FgawACQ+wRKxUiEHbKosS4YlVeKGFvAHCyqkHwiCJPA2twlU2duPajfjXUFr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Ks2EGiqn; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ks2EGiqn"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=H1E8yMCaBmeBvqCf0h4Oms6/8U4usKvsJ7Vhr/sXl0Y=; b=Ks2EGiqnQ2+PSRvTEQi7j8GGzQ
	Yj7277gps9gwzXS7VV64SBQElsDn3F/4JRp2jegExmVlaUwHdLJAUt0vncwPLXirgAp+/fkkh5gqy
	B02xCoT8acAYRjrg4gqrhz9wifaT59NHz2vDMUggf7LAkvbtlX1vR0ZEMuIWq9vE3t+VvclK9UFVt
	9W35tpAHiXzHEtkgwBofiSeI2nMAwsAJ2xkthZ8F1iX84PHEtGGOJyrAZDCgPG5dXzhIEQDddXq/K
	ggiN0/E5J3Kaw+CP5bWI9EN3Tu2VAUk25jCU8GU32DVXZmrVyVciT+rzeD9j5GKFnoQDLe7wJ17Gi
	rVrWwQLQ==;
Received: from 2a02-8389-2341-5b80-decc-1a96-daaa-a2cc.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:decc:1a96:daaa:a2cc] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWSJj-00000002pWB-2nk2;
	Mon, 08 Jun 2026 05:14:32 +0000
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
Date: Mon,  8 Jun 2026 07:14:05 +0200
Message-ID: <20260608051416.1205282-4-hch@lst.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260608051416.1205282-1-hch@lst.de>
References: <20260608051416.1205282-1-hch@lst.de>
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
index 0eb8e932ec66..e8b7d5517086 100644
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

