Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5CF742668E
	for <linux-block@vger.kernel.org>; Wed, 27 May 2026 15:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779894662; cv=none; b=E4x4qJ6kqhMHvu3zE/VQBmPnpHHu94Qcmv5VSR0Me7EeX5G5ug+QuMyIvSXSWfTnfx0Cld7cgPYpLb/j1l4okpxHRTnrG575PDc1HDQFZXEm8/rS+ijURZpfdkZIxIOYcIW87VVec5NvZNDqR8X8/fBYyFXCBglrXGjPdrWMZ2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779894662; c=relaxed/simple;
	bh=qkSYtgHxD4Ibko7vZ+u6+hQKo2VEK099eZa+NVJWizA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XLtrPs+Z8yu76449hyew8d3HIQSE1ytRtcKkYpr4tB8t7ONDgI6fJH6qNTpX4oY+j3qGZMVgARpTkRf76vFDAgc8DFOB3Yqxw8lWklmRvbqBsbfNvE0rs5q+COxa7Ot19UbjYSzkc6/pb0B1vNodv0Jvq2OBCAyh9te3U/lrhKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Wu3C0vDC; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Wu3C0vDC"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=qTSyL/LpaRpyHSI+P/nV+oZG1H26xv9fjmm1fXQdMng=; b=Wu3C0vDCILhJ7kefM+LrfYgxap
	/LqXX8GDzvrfcBQl7VHT8djK9qmddK738bUeEim9SkUKmH/pXNhrpTg+09ROMggp2TmR8efmAQXXE
	OzKur/G8o8QQ5ZyP7XqNWwJCp6JbIULRMhxMouWzINFJiOOJFT/4OUbUAHwwSlmRcZlMIRh/gmMgy
	nCeQOjlwV0krSvJPzzAFQyHuhhcZBShQc7Wy7xYnT//aAmjaauHopB/tp6NkJYA3AF9psy4XzKV6I
	k9FwPzlaB4jRQbxRuODb+z7G5D9K03FYyIvLy6axPN/UZCuig6DSOt6jmfABXRObyG7Toamp7UYJw
	uzvrP7NA==;
Received: from 2a02-8389-2341-5b80-decc-1a96-daaa-a2cc.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:decc:1a96:daaa:a2cc] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSFuM-00000004Nbf-44gl;
	Wed, 27 May 2026 15:10:59 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Ming Lei <tom.leiming@gmail.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Caleb Sander Mateos <csander@purestorage.com>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH 3/3] bvec: make the bvec_iter helpers inline functions
Date: Wed, 27 May 2026 17:10:22 +0200
Message-ID: <20260527151043.2349900-4-hch@lst.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260527151043.2349900-1-hch@lst.de>
References: <20260527151043.2349900-1-hch@lst.de>
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
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Caleb Sander Mateos <csander@purestorage.com>
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

