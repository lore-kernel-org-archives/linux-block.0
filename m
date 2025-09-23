Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A17166F1A
	for <linux-block@vger.kernel.org>; Tue, 23 Sep 2025 00:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758587638; cv=none; b=LXvO+B0vfWrmJ74VlaxwtoXLsQdyHFllukLRT1VZkvYatmH7omYJJAT6waszv9LaZHa0vflS9fIYTWJEEhkxq9BIIAmJYQubhdUh452Ou4eOYLs3HXb/Is+lf7lAo8vbwrcyi7T4FQAVbwJYVq6rpwrcPLziWZXCtMcFjSOTIyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758587638; c=relaxed/simple;
	bh=CSiGtKrWb8zqpNUe8yL7Pevqy9qFJhFmaY58ZJGrYSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tRQ+WsB4/gCvQ9e1UJ3mP2SUZMbFwNjs66rfqUhQNASp+ytHqH3i2gNzPhzo/lYmMNBaiGtwHp4qyakVyGtNCaAE6OwRPMRnMuy5lwKkZwmi9UO28abj/MP9yV3ukBx4EOQmqUVtMR68aJ4yX8mePINo9PPCgZ5TvVnSMzz3h4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XzYHos0j; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XzYHos0j"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-77f2e960728so2283304b3a.2
        for <linux-block@vger.kernel.org>; Mon, 22 Sep 2025 17:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758587634; x=1759192434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L8Zc1MP+97msutqoeYloSdkN6RJEwl1bHJXdXkLR+a8=;
        b=XzYHos0jTd0Cc+zCh4if+nFQs5Qe9MqaHzNgescPY6ANwnsfhs/BsI8D2MAbDOHTgU
         4teujGeqxpxArLOapynGfV3o0DVDb/BFjNNn/dT42chj0cHr3ncU6UpDQ0qgDAYuG3rm
         ypTEPCYI64jouXY71ZkM4fPSnW+KyL2inDzlbkkJQdrmjylLK0/ayvtQPlX/ErjBC73K
         uTa6ewd50dW5aGpTp96GHnb/T9fETG1zbpGvk1cSvphV12THa563vKzXWuW4pwrC3CLX
         897Sb9RYlEoPFYtWN3yxJ+0JTShC2H6JTvW64TldOz7RQFZorvEuJeT4h/kJsbbgaNzF
         HAXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758587634; x=1759192434;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L8Zc1MP+97msutqoeYloSdkN6RJEwl1bHJXdXkLR+a8=;
        b=XGS8rJk7rCmlwb5aRjKgaQGfIE8z+CSzA3BYZygb1Fe4k5YuIQH7Szlp+357nl8ktH
         8EF3u2GmBnXa6XLikZzCWn873cGV9V7oAvVXqGyaiSax8pYaXWh9S6exoSWFHXH6p5l/
         OCWR4uNyV9GmWC/7Ogl0DTpFbFSuLZYo7FAsRMU/PwClLTi2JPs4XCyUNsNhhEwBCEq1
         SRWpdxtLFEMTaUyP3e6rmiLu8DfXvO3WTzm4ZAZ61n4B1qzvwSRzbw2orLrbW3SMdPOe
         eFbwA0CjWJX32mIbD9Xv+AngglTGgMii1iYjV4Z+uJ85wRcC9Pxz/8BNFFd3qR+Vc/Nm
         V7Bw==
X-Forwarded-Encrypted: i=1; AJvYcCXB3SRh835rxURNFlCY/afUY/JQIK4rJW1cMKTuIFwJBo7BWZ/kb8HH3zdy63YhEZe8fQQeCsqZTWZF+Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2cpYryPCSJDhTqrLaFKYYepoowu5ylPPEe/6oL2M4Srh1ZP/U
	S/5qMGNo4ASIyRRghQBMRf5J4UltJv992f5R9qtUyIGjGzIkiiSyB9sa
X-Gm-Gg: ASbGncu+eV4VbnE8GYVPLag7yldESnZBhlaZROd/h4WntatxDRQP47IGsKn8P6gS684
	RIqeE5jEe1m2aBcPBXYo8iyzLXV8iA7NY7SnfgzR9CuLyEPgHQrI0GtJq73obBPadHg2BiIkyk1
	oKARZzpPeWu6kpBFmf8SJxpxeM01plzju8MRo7+qeidskrrJsWEulA5WVqsEn6Xzr2ms8zjNCqJ
	btZJNC8xr3HgSu1dmLJqkp9QGLweBugF6rUv+akVxVPPdT+hQLRQWsX85cZn9DsWi+rKEVQmBU2
	Q0c1CzAI/d5TjkS7ZJkB7yVyfJvWfSegUCbQTwDhn9r/DNMWKTJZFwGZd4uxpaP/mzURLpUvv4W
	hfKyOG5VDaRxTjqE6/US9isnNZEehTtOAUPnS1AaLLJLu5Q==
X-Google-Smtp-Source: AGHT+IE9UTk9DOOxHIk7V9AusMOVMJaA+o0ouKvy94Kuhd+S63mgnV20FB06J29O2ckAhaW6BtwlSg==
X-Received: by 2002:a05:6a20:258b:b0:262:c083:bb38 with SMTP id adf61e73a8af0-2cfbb09d4e3mr1348063637.0.1758587633950;
        Mon, 22 Sep 2025 17:33:53 -0700 (PDT)
Received: from localhost ([2a03:2880:ff::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54ff445dd7sm12934627a12.51.2025.09.22.17.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 17:33:53 -0700 (PDT)
From: Joanne Koong <joannelkoong@gmail.com>
To: brauner@kernel.org,
	miklos@szeredi.hu
Cc: djwong@kernel.org,
	hch@infradead.org,
	linux-block@vger.kernel.org,
	gfs2@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-doc@vger.kernel.org,
	hsiangkao@linux.alibaba.com,
	kernel-team@meta.com
Subject: [PATCH v4 01/15] iomap: move bio read logic into helper function
Date: Mon, 22 Sep 2025 17:23:39 -0700
Message-ID: <20250923002353.2961514-2-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250923002353.2961514-1-joannelkoong@gmail.com>
References: <20250923002353.2961514-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the iomap_readpage_iter() bio read logic into a separate helper
function, iomap_bio_read_folio_range(). This is needed to make iomap
read/readahead more generically usable, especially for filesystems that
do not require CONFIG_BLOCK.

Additionally rename buffered write's iomap_read_folio_range() function
to iomap_bio_read_folio_range_sync() to better describe its synchronous
behavior.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/iomap/buffered-io.c | 68 ++++++++++++++++++++++++------------------
 1 file changed, 39 insertions(+), 29 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 9535733ed07a..7e65075b6345 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -367,36 +367,15 @@ struct iomap_readpage_ctx {
 	struct readahead_control *rac;
 };
 
-static int iomap_readpage_iter(struct iomap_iter *iter,
-		struct iomap_readpage_ctx *ctx)
+static void iomap_bio_read_folio_range(const struct iomap_iter *iter,
+		struct iomap_readpage_ctx *ctx, loff_t pos, size_t plen)
 {
+	struct folio *folio = ctx->cur_folio;
 	const struct iomap *iomap = &iter->iomap;
-	loff_t pos = iter->pos;
+	struct iomap_folio_state *ifs = folio->private;
+	size_t poff = offset_in_folio(folio, pos);
 	loff_t length = iomap_length(iter);
-	struct folio *folio = ctx->cur_folio;
-	struct iomap_folio_state *ifs;
-	size_t poff, plen;
 	sector_t sector;
-	int ret;
-
-	if (iomap->type == IOMAP_INLINE) {
-		ret = iomap_read_inline_data(iter, folio);
-		if (ret)
-			return ret;
-		return iomap_iter_advance(iter, length);
-	}
-
-	/* zero post-eof blocks as the page may be mapped */
-	ifs = ifs_alloc(iter->inode, folio, iter->flags);
-	iomap_adjust_read_range(iter->inode, folio, &pos, length, &poff, &plen);
-	if (plen == 0)
-		goto done;
-
-	if (iomap_block_needs_zeroing(iter, pos)) {
-		folio_zero_range(folio, poff, plen);
-		iomap_set_range_uptodate(folio, poff, plen);
-		goto done;
-	}
 
 	ctx->cur_folio_in_bio = true;
 	if (ifs) {
@@ -435,6 +414,37 @@ static int iomap_readpage_iter(struct iomap_iter *iter,
 		ctx->bio->bi_end_io = iomap_read_end_io;
 		bio_add_folio_nofail(ctx->bio, folio, plen, poff);
 	}
+}
+
+static int iomap_readpage_iter(struct iomap_iter *iter,
+		struct iomap_readpage_ctx *ctx)
+{
+	const struct iomap *iomap = &iter->iomap;
+	loff_t pos = iter->pos;
+	loff_t length = iomap_length(iter);
+	struct folio *folio = ctx->cur_folio;
+	size_t poff, plen;
+	int ret;
+
+	if (iomap->type == IOMAP_INLINE) {
+		ret = iomap_read_inline_data(iter, folio);
+		if (ret)
+			return ret;
+		return iomap_iter_advance(iter, length);
+	}
+
+	/* zero post-eof blocks as the page may be mapped */
+	ifs_alloc(iter->inode, folio, iter->flags);
+	iomap_adjust_read_range(iter->inode, folio, &pos, length, &poff, &plen);
+	if (plen == 0)
+		goto done;
+
+	if (iomap_block_needs_zeroing(iter, pos)) {
+		folio_zero_range(folio, poff, plen);
+		iomap_set_range_uptodate(folio, poff, plen);
+	} else {
+		iomap_bio_read_folio_range(iter, ctx, pos, plen);
+	}
 
 done:
 	/*
@@ -559,7 +569,7 @@ void iomap_readahead(struct readahead_control *rac, const struct iomap_ops *ops)
 }
 EXPORT_SYMBOL_GPL(iomap_readahead);
 
-static int iomap_read_folio_range(const struct iomap_iter *iter,
+static int iomap_bio_read_folio_range_sync(const struct iomap_iter *iter,
 		struct folio *folio, loff_t pos, size_t len)
 {
 	const struct iomap *srcmap = iomap_iter_srcmap(iter);
@@ -572,7 +582,7 @@ static int iomap_read_folio_range(const struct iomap_iter *iter,
 	return submit_bio_wait(&bio);
 }
 #else
-static int iomap_read_folio_range(const struct iomap_iter *iter,
+static int iomap_bio_read_folio_range_sync(const struct iomap_iter *iter,
 		struct folio *folio, loff_t pos, size_t len)
 {
 	WARN_ON_ONCE(1);
@@ -749,7 +759,7 @@ static int __iomap_write_begin(const struct iomap_iter *iter,
 				status = write_ops->read_folio_range(iter,
 						folio, block_start, plen);
 			else
-				status = iomap_read_folio_range(iter,
+				status = iomap_bio_read_folio_range_sync(iter,
 						folio, block_start, plen);
 			if (status)
 				return status;
-- 
2.47.3

