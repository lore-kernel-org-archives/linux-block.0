Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15B3311592
	for <linux-block@vger.kernel.org>; Tue, 26 May 2026 07:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779778848; cv=none; b=l1FY8B2rDW3qMXY9rhRJuvYTmUsbL7+NxH9Nc+MHhDrwbSq2U8EI5wIijYkENTziwYuA/NgarwJ8GLNItZ5X8MUjCDfYZJfNALfceHP4Mq9gp4a4o3Gt6p4k8wn/CnXjwkOtvyUN0jaPxhGoD7sk786IKaHnVsG2vfmb/OiRq2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779778848; c=relaxed/simple;
	bh=cBy1RASED8tpQcVNZ0PC6v81YPS+JHIae+dxKcYMQiU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ceQLPcNTaGalOWNnJZUL6wQNjyewL+MJ8F8ilG3J2ZF0+TntSc3vGDspeQ7i+lHCbOT4lu2bwTCYaIAiZOoJ44JLbDUEhOj63P19SdRAo0K1BI7gt2++9pbi1EWl2iLf8SkjpggEvc+/Wc23Yf8uQeoHC6kJop0LpoqvhyE0+vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=j35FB+OP; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="j35FB+OP"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=U/hY4p/KeYUqDQ6Rn6it0Fc0whdJtg5g6XevOLJ4jHU=; b=j35FB+OPPhxLsAP7cUbdZM4YEy
	tu9oZXHAw0Pg6XG5t/gKvUYy/EKxEZsGIGP+wsUXLJKrrr0Fgoj1mzKnhhq55tQ7bV30PQ/M/S5xK
	1htFuiH8sn2WV5XVjFErApxriO6QNJuWnGC0crP1kddawZTDzCju2tjW6l4nP3IDVt4sl/ocG7QFd
	Kp+JvUdORZBBcn5oTVzbDY8jWLoW4wRDawTJIHAEQ+j3ZhDT8PvdUZfnEjh+apxy+xRJOP4udXAkR
	gvZgoFHkrVzUH+iFTXMWYwEqqDJ2lvlsLKpBcAraW7xz3fHJLHIBoOQD2ljSERWU5PtGp6TRsCIWq
	VETY94hQ==;
Received: from 2a02-8389-2341-5b80-decc-1a96-daaa-a2cc.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:decc:1a96:daaa:a2cc] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRlmQ-00000001Dqn-405E;
	Tue, 26 May 2026 07:00:47 +0000
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org
Subject: [PATCH] bvec: make the bvec_iter helpers inline functions
Date: Tue, 26 May 2026 09:00:27 +0200
Message-ID: <20260526070042.1817997-1-hch@lst.de>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

The macros are impossible to follow due to the lack of visual type
information and all the braces.  Replace them with inline helpers to
improve on that.  Because the calling conventions are a bit problematic
with a lot of passing structures by value, all the helpers are marked
as __always_inline so that they are force inlined.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/bvec.h | 101 +++++++++++++++++++++++++++----------------
 1 file changed, 64 insertions(+), 37 deletions(-)

diff --git a/include/linux/bvec.h b/include/linux/bvec.h
index d36dd476feda..f4c7ec282ac9 100644
--- a/include/linux/bvec.h
+++ b/include/linux/bvec.h
@@ -104,51 +104,78 @@ struct bvec_iter_all {
 	unsigned	done;
 };
 
-/*
- * various member access, note that bio_data should of course not be used
- * on highmem page vectors
- */
-#define __bvec_iter_bvec(bvec, iter)	(&(bvec)[(iter).bi_idx])
+static __always_inline const struct bio_vec *
+__bvec_iter_bvec(const struct bio_vec *bvecs, const struct bvec_iter iter)
+{
+	return bvecs + iter.bi_idx;
+}
 
 /* multi-page (mp_bvec) helpers */
-#define mp_bvec_iter_page(bvec, iter)				\
-	(__bvec_iter_bvec((bvec), (iter))->bv_page)
+static __always_inline struct page *
+mp_bvec_iter_page(const struct bio_vec *bvecs, const struct bvec_iter iter)
+{
+	return __bvec_iter_bvec(bvecs, iter)->bv_page;
+}
 
-#define mp_bvec_iter_len(bvec, iter)				\
-	min((iter).bi_size,					\
-	    __bvec_iter_bvec((bvec), (iter))->bv_len - (iter).bi_bvec_done)
+static __always_inline unsigned int
+mp_bvec_iter_len(const struct bio_vec *bvecs, const struct bvec_iter iter)
+{
+	return min(__bvec_iter_bvec(bvecs, iter)->bv_len - iter.bi_bvec_done,
+			iter.bi_size);
+}
 
-#define mp_bvec_iter_offset(bvec, iter)				\
-	(__bvec_iter_bvec((bvec), (iter))->bv_offset + (iter).bi_bvec_done)
+static __always_inline unsigned int
+mp_bvec_iter_offset(const struct bio_vec *bvecs, const struct bvec_iter iter)
+{
+	return __bvec_iter_bvec(bvecs, iter)->bv_offset + iter.bi_bvec_done;
+}
 
-#define mp_bvec_iter_page_idx(bvec, iter)			\
-	(mp_bvec_iter_offset((bvec), (iter)) / PAGE_SIZE)
+static __always_inline unsigned int
+mp_bvec_iter_page_idx(const struct bio_vec *bvecs, const struct bvec_iter iter)
+{
+	return mp_bvec_iter_offset(bvecs, iter) / PAGE_SIZE;
+}
 
-#define mp_bvec_iter_bvec(bvec, iter)				\
-((struct bio_vec) {						\
-	.bv_page	= mp_bvec_iter_page((bvec), (iter)),	\
-	.bv_len		= mp_bvec_iter_len((bvec), (iter)),	\
-	.bv_offset	= mp_bvec_iter_offset((bvec), (iter)),	\
-})
+static __always_inline struct bio_vec
+mp_bvec_iter_bvec(const struct bio_vec *bvecs, const struct bvec_iter iter)
+{
+	return (struct bio_vec) {
+		.bv_page	= mp_bvec_iter_page(bvecs, iter),
+		.bv_len		= mp_bvec_iter_len(bvecs, iter),
+		.bv_offset	= mp_bvec_iter_offset(bvecs, iter),
+	};
+}
 
 /* For building single-page bvec in flight */
- #define bvec_iter_offset(bvec, iter)				\
-	(mp_bvec_iter_offset((bvec), (iter)) % PAGE_SIZE)
-
-#define bvec_iter_len(bvec, iter)				\
-	min_t(unsigned, mp_bvec_iter_len((bvec), (iter)),		\
-	      PAGE_SIZE - bvec_iter_offset((bvec), (iter)))
-
-#define bvec_iter_page(bvec, iter)				\
-	(mp_bvec_iter_page((bvec), (iter)) +			\
-	 mp_bvec_iter_page_idx((bvec), (iter)))
-
-#define bvec_iter_bvec(bvec, iter)				\
-((struct bio_vec) {						\
-	.bv_page	= bvec_iter_page((bvec), (iter)),	\
-	.bv_len		= bvec_iter_len((bvec), (iter)),	\
-	.bv_offset	= bvec_iter_offset((bvec), (iter)),	\
-})
+static __always_inline unsigned int
+bvec_iter_offset(const struct bio_vec *bvecs, const struct bvec_iter iter)
+{
+	return mp_bvec_iter_offset(bvecs, iter) % PAGE_SIZE;
+}
+
+static __always_inline unsigned int
+bvec_iter_len(const struct bio_vec *bvecs, const struct bvec_iter iter)
+{
+	return min(mp_bvec_iter_len(bvecs, iter),
+			PAGE_SIZE - bvec_iter_offset(bvecs, iter));
+}
+
+static __always_inline struct page *
+bvec_iter_page(const struct bio_vec *bvecs, const struct bvec_iter iter)
+{
+	return mp_bvec_iter_page(bvecs, iter) +
+		mp_bvec_iter_page_idx(bvecs, iter);
+}
+
+static __always_inline struct bio_vec
+bvec_iter_bvec(const struct bio_vec *bvecs, const struct bvec_iter iter)
+{
+	return (struct bio_vec) {
+		.bv_page	= bvec_iter_page(bvecs, iter),
+		.bv_len		= bvec_iter_len(bvecs, iter),
+		.bv_offset	= bvec_iter_offset(bvecs, iter),
+	};
+}
 
 static inline bool bvec_iter_advance(const struct bio_vec *bv,
 		struct bvec_iter *iter, unsigned bytes)
-- 
2.53.0

