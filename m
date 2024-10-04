Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1431C3048
	for <linux-block@vger.kernel.org>; Fri,  4 Oct 2024 15:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728055843; cv=none; b=mwGvifX+JD/hD/PEwbrEt7xCV/UcmFLF8Jlrp3BuJe2fYDLPze5IS0Q/FAYGhtQISuKZX8QVrhGTGpPRN+CF4NMozWf99HXCnFMGzO2rNsU4yMiWL7JiqUY94nLNCP86IpzloPocXH28kxvWXa+OuksKX3scn4Q1TD15igMIYrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728055843; c=relaxed/simple;
	bh=crHaYagkgo6VoCxFYlW3iJ5g8SOMwNWskhvJG8xhac0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tgNxr0x2+qFyG+LYAxdwSYYetSe+TNtcniVmqlVPkIAicqayljhphEZ9fVAYXypmwCDe6nNMvBren/BQOkB+Ddpb7OBngUvnCFqigPsqy631zfjOSN1ORshr97yA8EmIcpFjVXrnu6fjaRuez2ZctPwPzbllZp/8I1i2Do9/Y7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WiM8cACc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WiM8cACc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728055840;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nJxNMvGZJj5t/DTE3o+ykBUvxddJVXwreZIV/z+vrk8=;
	b=WiM8cACcLB40TdeG84KRWSgps/D4kcyjl55uyeC0SNX+4Fyy1D7hgq4lNe8dL+cThqmuU3
	X7Zh5v/EfYiw48sv18n+HOWvLind/w1+W8wo4hqwddkyETD31+3td+Ndru+vsomrxZjy0h
	dhEklQ8FFzUUZ6j+9BHdJzL7rA/Rabo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-455-iFZrV0BxOQKw7QLmB50IOw-1; Fri,
 04 Oct 2024 11:30:39 -0400
X-MC-Unique: iFZrV0BxOQKw7QLmB50IOw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B8BCE1944CCA;
	Fri,  4 Oct 2024 15:30:37 +0000 (UTC)
Received: from localhost (unknown [10.72.116.24])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4D0491955E93;
	Fri,  4 Oct 2024 15:30:35 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>,
	David Howells <dhowells@redhat.com>
Subject: [PATCH] lib/iov_iter.c: extract virt-contiguous pages in iov_iter_extract_bvec_pages
Date: Fri,  4 Oct 2024 23:30:25 +0800
Message-ID: <20241004153025.1867858-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

All iov_iter_bvec() users only want to extract virt-contiguous pages from
iov_iter_extract_pages() instead physical-contiguous pages.

Change iov_iter_extract_bvec_pages() to extract virt-contiguous pages via
bvec helper.

This way can fill much more pages one time, instead of (often)one page from
iov_iter_extract_pages() each time.

Cc: David Howells <dhowells@redhat.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 include/linux/bvec.h |  6 ++++++
 lib/iov_iter.c       | 47 +++++++++++++++++++++++---------------------
 2 files changed, 31 insertions(+), 22 deletions(-)

diff --git a/include/linux/bvec.h b/include/linux/bvec.h
index f41c7f0ef91e..98e1a4ad09e0 100644
--- a/include/linux/bvec.h
+++ b/include/linux/bvec.h
@@ -184,6 +184,12 @@ static inline void bvec_iter_advance_single(const struct bio_vec *bv,
 		((bvl = bvec_iter_bvec((bio_vec), (iter))), 1);	\
 	     bvec_iter_advance_single((bio_vec), &(iter), (bvl).bv_len))
 
+#define for_each_bvec_max(bvl, bio_vec, iter, start, nr_bvecs)		\
+	for (iter = (start);						\
+	     (iter).bi_size && iter.bi_idx < nr_bvecs &&		\
+		((bvl = bvec_iter_bvec((bio_vec), (iter))), 1);	\
+	     bvec_iter_advance_single((bio_vec), &(iter), (bvl).bv_len))
+
 /* for iterating one bio from start to end */
 #define BVEC_ITER_ALL_INIT (struct bvec_iter)				\
 {									\
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 97003155bfac..6e00f6da5259 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1677,8 +1677,8 @@ static ssize_t iov_iter_extract_xarray_pages(struct iov_iter *i,
 }
 
 /*
- * Extract a list of contiguous pages from an ITER_BVEC iterator.  This does
- * not get references on the pages, nor does it get a pin on them.
+ * Extract a list of virtually contiguous pages from an ITER_BVEC iterator.
+ * This does not get references on the pages, nor does it get a pin on them.
  */
 static ssize_t iov_iter_extract_bvec_pages(struct iov_iter *i,
 					   struct page ***pages, size_t maxsize,
@@ -1686,35 +1686,38 @@ static ssize_t iov_iter_extract_bvec_pages(struct iov_iter *i,
 					   iov_iter_extraction_t extraction_flags,
 					   size_t *offset0)
 {
-	struct page **p, *page;
-	size_t skip = i->iov_offset, offset, size;
-	int k;
+	size_t skip = i->iov_offset, size = 0;
+	struct bvec_iter bi;
+	struct bio_vec bv;
+	int k = 0;
 
-	for (;;) {
-		if (i->nr_segs == 0)
-			return 0;
-		size = min(maxsize, i->bvec->bv_len - skip);
-		if (size)
-			break;
+	if (i->nr_segs == 0)
+		return 0;
+
+	if (i->iov_offset == i->bvec->bv_len) {
 		i->iov_offset = 0;
 		i->nr_segs--;
 		i->bvec++;
 		skip = 0;
 	}
+	bi.bi_size = maxsize + skip;
+	bi.bi_bvec_done = skip;
 
-	skip += i->bvec->bv_offset;
-	page = i->bvec->bv_page + skip / PAGE_SIZE;
-	offset = skip % PAGE_SIZE;
-	*offset0 = offset;
+	maxpages = want_pages_array(pages, maxsize, skip, maxpages);
 
-	maxpages = want_pages_array(pages, size, offset, maxpages);
-	if (!maxpages)
-		return -ENOMEM;
-	p = *pages;
-	for (k = 0; k < maxpages; k++)
-		p[k] = page + k;
+	for_each_bvec_max(bv, i->bvec, bi, bi, i->nr_segs) {
+		if (k >= maxpages)
+			break;
+		if (!k)
+			*offset0 = bv.bv_offset;
+		else if (bv.bv_offset)
+			break;
+		(*pages)[k++] = bv.bv_page;
+		size += bv.bv_len;
+		if (bv.bv_offset + bv.bv_len != PAGE_SIZE)
+			break;
+	}
 
-	size = min_t(size_t, size, maxpages * PAGE_SIZE - offset);
 	iov_iter_advance(i, size);
 	return size;
 }
-- 
2.46.0

