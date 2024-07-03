Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BB917C60
	for <linux-block@vger.kernel.org>; Wed,  3 Jul 2024 05:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719983923; cv=none; b=nKBkm2kwTh5j7QufeRFnufDXbNy9nvcuOaZ2eQxbdPJ8+t4XBNZOdyskS7KhkcKsEZHlhJDs2ywpNQcL8LAtwuDiMS5CKgh1rechyqmsMJlqDhX0sHss2Q2kx8yYGNWELMnBLOgB5CymPyCRKBeaos0dI8LL9l6q4kQHJzoOrmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719983923; c=relaxed/simple;
	bh=OzLnIYKgPcU/TLD1JRO5cXKasaZ8up+zkavkYFYeCx4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hSt1ltFRigQspyzSaUYW6PPYSA1mtFcY0k64kfTes4BkJJhEFsa79lgXP11nmOnTT0OhK0ABOX9wU/CflEg+I4DuVlZRVvrcOOIziif8g+jj3Jqs0/3TbRVUff1ntjo3ThKsgLA1ibOPnlgxSA5gSwqlb3BiMlKCKnGe1X1DOGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=iC5fx6oP; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iC5fx6oP"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=IUk+gsWibGlyWllIWsTUa19ftnAVOQSGX+v+sHKE0mg=; b=iC5fx6oPBnUmE3G5iWybpEVbCW
	NOat7BBm4vxS3/2Mn+mmrt5HCrkgGPbtG6tmGo9igSeLvZcHhlCD+oIzClUw8Q0xcteV9L4Dg2rxR
	kIdJ7+Ugv6rTiTgR6zN2nH99LlPypBR9InAYI5HNYUg2tPKZwsMNrVJLt6oBUoHbi0xSL1M8xZfIR
	vTyzKEJlj2BI6Vp8wx9M8xuCpLrOwtC843+9AteYPlDtxJtQO378JeXrri1dmwdlk6pGLSDg77pX3
	k2rqZkj/i/2WzrqiAIjkgLAYG3wyg2tPNCZbRsy2FqW8EEGPzstBskSSYE6L7Tdjv5q3iwHkYrJQz
	hOPEP3Kw==;
Received: from 2a02-8389-2341-5b80-5426-fccf-3409-1082.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:5426:fccf:3409:1082] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOsO9-000000092H6-2N69;
	Wed, 03 Jul 2024 05:18:41 +0000
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org
Subject: [PATCH] block: remove QUEUE_FLAG_STOPPED
Date: Wed,  3 Jul 2024 07:18:34 +0200
Message-ID: <20240703051834.1771374-1-hch@lst.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

QUEUE_FLAG_STOPPED is entirely unused.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq-debugfs.c | 1 -
 include/linux/blkdev.h | 2 --
 2 files changed, 3 deletions(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 344f9e503bdb32..03d0409e5018c4 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -79,7 +79,6 @@ static int queue_pm_only_show(void *data, struct seq_file *m)
 
 #define QUEUE_FLAG_NAME(name) [QUEUE_FLAG_##name] = #name
 static const char *const blk_queue_flag_name[] = {
-	QUEUE_FLAG_NAME(STOPPED),
 	QUEUE_FLAG_NAME(DYING),
 	QUEUE_FLAG_NAME(NOMERGES),
 	QUEUE_FLAG_NAME(SAME_COMP),
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 4d0d4b83bc740f..26fb272ec5d3bf 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -590,7 +590,6 @@ struct request_queue {
 };
 
 /* Keep blk_queue_flag_name[] in sync with the definitions below */
-#define QUEUE_FLAG_STOPPED	0	/* queue is stopped */
 #define QUEUE_FLAG_DYING	1	/* queue being torn down */
 #define QUEUE_FLAG_NOMERGES     3	/* disable merge attempts */
 #define QUEUE_FLAG_SAME_COMP	4	/* complete on same CPU-group */
@@ -610,7 +609,6 @@ struct request_queue {
 void blk_queue_flag_set(unsigned int flag, struct request_queue *q);
 void blk_queue_flag_clear(unsigned int flag, struct request_queue *q);
 
-#define blk_queue_stopped(q)	test_bit(QUEUE_FLAG_STOPPED, &(q)->queue_flags)
 #define blk_queue_dying(q)	test_bit(QUEUE_FLAG_DYING, &(q)->queue_flags)
 #define blk_queue_init_done(q)	test_bit(QUEUE_FLAG_INIT_DONE, &(q)->queue_flags)
 #define blk_queue_nomerges(q)	test_bit(QUEUE_FLAG_NOMERGES, &(q)->queue_flags)
-- 
2.43.0

