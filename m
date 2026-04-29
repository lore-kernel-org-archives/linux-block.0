Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E6837DEBA
	for <linux-block@vger.kernel.org>; Wed, 29 Apr 2026 15:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777476393; cv=none; b=lUFLreZNep8ukmUQlQNC3fq3k+w5M8Ac7f7xdHkD6iUdKcD7CZJ1BcCSutVnkwZJpTbyUMF1G2vTz8wrDubjbUui4wfbJGz5jBp32iJWfa8DBcpuVEn5Db8A8csAA8a2cDJYklaiX5QyPgT1QDqdllsBXxbaliqFev5n8/Ja0o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777476393; c=relaxed/simple;
	bh=CNs/Yxbm5MZEeW58x4HT0ka3sUBh+wiGFZ1q5uz6Eyg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qc3uzrxYARhe//ERT0tRa3xHsUEWgcphEIgUvadOlAD1aDWzVebh71YVu/l4nWsPSDu3XyEb34JslwoTG2EZW8cWOzBM79XIXlJG6Am9IRIU+COZ4QhwJZvTB3fPFnedZMJUi7Tjz/YKWshNDlqo72eCoxoXHeCG4Ob31qBfEwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RAXK9GyR; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RAXK9GyR"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-43fde5b81a1so9453084f8f.0
        for <linux-block@vger.kernel.org>; Wed, 29 Apr 2026 08:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777476389; x=1778081189; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wYUNmBP6U3FeRokeO7r7d75tv9vLUxF9835eHvzSe1g=;
        b=RAXK9GyRu97bc5WOLSH+4gh1auoZTmpa1HqX78LaANkYEjuGMxYtdmGzrscRlggjBu
         FI3MsWnBF3K0c0J/xBIYa+adAOw5BsKftyc1EPzIn8JGIRtL7jqGBntr6V5PzM7K30/D
         ivK00yx75TjAMKw60V5vtbYCC/qAlhBTy4Q4xIqoeQx5uozrlsf0y1angULIyPkwyaeG
         yAxohAfltZlkqdgnlN0d0y14nTPr5JAZqtpAddVndfInu54FrdPpttKn6nwzBZX4XZV0
         Be3oCXsLQR05Bnj4njUgZL2x+U6oIgTBvRou2ue8Q47n0uxfFeQ5R+drvSVYb84N0Dgl
         NEMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777476389; x=1778081189;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wYUNmBP6U3FeRokeO7r7d75tv9vLUxF9835eHvzSe1g=;
        b=st9d6QwOSlwnQ4oyinwCzcFhrigvZbBl6kN8vMdQidLNXJd2fcpxvI2D2ftol3dFFe
         +SOE5MrfEdu98uJywKhQOSmWka0p4f1xUTQGDocFxHDduHAyvNqxxs7xmOgyzQKu6yjB
         gddM/rF29Xj6h6xHwB6g5GXv0h0kFRgjIc8HcuuGXwWfUWBRNjwfwugZFKX7byz1yhaG
         YM50nOy4v5ysaL5PP8nlz2Z4g/12bRBQrQvhIJ72uO/9icmwNx0pHQgMH160c3fTowb9
         JrbBdmoWwjg80xEJ/ElP0tAdr0lwMcyWhELkCdyEiB25TMpoap0oxtvm16TuDv5fr3W9
         BSSA==
X-Forwarded-Encrypted: i=1; AFNElJ+EzxluY7hrbXRctTvlRL2RZ7BWqGjvP5Xp1VoQz1EWbZXKW6MpgrI6lc/XSnTHw27he6y/6XcU3u8cew==@vger.kernel.org
X-Gm-Message-State: AOJu0YzZsCk9RUgrlpv1wbkesiqmcxpYOR0Ol3R9zdi+9FmGO6pa/l3W
	osYuuvSRjNhgQIECYeDMpYNrNRVuFmUyj1bF5F97NNRCAY9FSPyWaLwh
X-Gm-Gg: AeBDietB3aSIFOvopxnm/p6M0t2jYTqh/sUV4C3244p4Q8HOQcGjCNkro4s4mQ5MgLJ
	NJVsQS8Wcy2BZzdq6lV2Ooa0B9QnkulTywkOrBJDSLqZPtH3VcGoY3MM7mfKZHTnwb5VsJdj64V
	xkmgz62NsOf9FKug00c1WaiFUfdrwjgHuafdVkeW2+Rs53/+wbJA83vQqCMbo4666DTF0hlGdYV
	6sJymemegfHWu1TAbcYiSNnH+SGXqGwGsVpwChDxvwghehaDxzaqc57bWod4jdCp8/mCq6bOd5w
	DXneg+Uv3Ne60/PjzQH/udTKjjc71bFyveq2BNN9jb6mf2cuoikm7Y5IjdFQPN9pQI4Iv/d9Fop
	5wnBSgo2bS/Ohb/opQliscGd0xeDKhQXASRTHWe4C8nEN1bqoMMf8bRSKkw4/kg6zgXiswJqpyF
	2oRr5Nbt0+3m4oBe3KOGT/PrzsevJOuLE/SPQP+RXoiPxJgHa8InbspEUgtp8sDYbmIbMvOq2CG
	LwX/XdzYuPMJvIfp3JI6/jwnMPhdB+ZkaOxcUNI/4vKfWKe9FE7QlM=
X-Received: by 2002:a05:6000:26cb:b0:43f:de5a:eb63 with SMTP id ffacd0b85a97d-4478ea89a58mr8097281f8f.11.1777476388358;
        Wed, 29 Apr 2026 08:26:28 -0700 (PDT)
Received: from 127.0.0.1localhost ([82.132.184.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-447b76e5c22sm6382951f8f.28.2026.04.29.08.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 08:26:27 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org
Cc: asml.silence@gmail.com,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Tushar Gohad <tushar.gohad@intel.com>,
	William Power <william.power@intel.com>,
	Phil Cayton <phil.cayton@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v3 02/10] iov_iter: add iterator type for dmabuf maps
Date: Wed, 29 Apr 2026 16:25:48 +0100
Message-ID: <20a233d2f35274817aa643cc0fe113707eb47e72.1777475843.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1777475843.git.asml.silence@gmail.com>
References: <cover.1777475843.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a new iterator type for dmabuf maps. The map in an opaque
object with internals and format specific to the subsystem / driver, and
only it can use that subsystem / driver for issuing IO. The task of the
middle layers is to pass the map / iterator further down, maybe doing
basic splitting and length checking. The iterator can only be used by
operations of the file the associated map was created for.

Suggested-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 include/linux/uio.h | 11 +++++++++++
 lib/iov_iter.c      | 29 +++++++++++++++++++++++------
 2 files changed, 34 insertions(+), 6 deletions(-)

diff --git a/include/linux/uio.h b/include/linux/uio.h
index a9bc5b3067e3..75051aed70de 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -12,6 +12,7 @@
 
 struct page;
 struct folio_queue;
+struct io_dmabuf_map;
 
 typedef unsigned int __bitwise iov_iter_extraction_t;
 
@@ -29,6 +30,7 @@ enum iter_type {
 	ITER_FOLIOQ,
 	ITER_XARRAY,
 	ITER_DISCARD,
+	ITER_DMABUF_MAP,
 };
 
 #define ITER_SOURCE	1	// == WRITE
@@ -71,6 +73,7 @@ struct iov_iter {
 				const struct folio_queue *folioq;
 				struct xarray *xarray;
 				void __user *ubuf;
+				struct io_dmabuf_map *dmabuf_map;
 			};
 			size_t count;
 		};
@@ -155,6 +158,11 @@ static inline bool iov_iter_is_xarray(const struct iov_iter *i)
 	return iov_iter_type(i) == ITER_XARRAY;
 }
 
+static inline bool iov_iter_is_dmabuf_map(const struct iov_iter *i)
+{
+	return iov_iter_type(i) == ITER_DMABUF_MAP;
+}
+
 static inline unsigned char iov_iter_rw(const struct iov_iter *i)
 {
 	return i->data_source ? WRITE : READ;
@@ -300,6 +308,9 @@ void iov_iter_folio_queue(struct iov_iter *i, unsigned int direction,
 			  unsigned int first_slot, unsigned int offset, size_t count);
 void iov_iter_xarray(struct iov_iter *i, unsigned int direction, struct xarray *xarray,
 		     loff_t start, size_t count);
+void iov_iter_dmabuf_map(struct iov_iter *i, unsigned int direction,
+			struct io_dmabuf_map *map,
+			loff_t off, size_t count);
 ssize_t iov_iter_get_pages2(struct iov_iter *i, struct page **pages,
 			size_t maxsize, unsigned maxpages, size_t *start);
 ssize_t iov_iter_get_pages_alloc2(struct iov_iter *i, struct page ***pages,
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 243662af1af7..e2253684b991 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -575,7 +575,8 @@ void iov_iter_advance(struct iov_iter *i, size_t size)
 {
 	if (unlikely(i->count < size))
 		size = i->count;
-	if (likely(iter_is_ubuf(i)) || unlikely(iov_iter_is_xarray(i))) {
+	if (likely(iter_is_ubuf(i)) || unlikely(iov_iter_is_xarray(i)) ||
+	    unlikely(iov_iter_is_dmabuf_map(i))) {
 		i->iov_offset += size;
 		i->count -= size;
 	} else if (likely(iter_is_iovec(i) || iov_iter_is_kvec(i))) {
@@ -631,7 +632,8 @@ void iov_iter_revert(struct iov_iter *i, size_t unroll)
 		return;
 	}
 	unroll -= i->iov_offset;
-	if (iov_iter_is_xarray(i) || iter_is_ubuf(i)) {
+	if (iov_iter_is_xarray(i) || iter_is_ubuf(i) ||
+	    iov_iter_is_dmabuf_map(i)) {
 		BUG(); /* We should never go beyond the start of the specified
 			* range since we might then be straying into pages that
 			* aren't pinned.
@@ -775,6 +777,20 @@ void iov_iter_xarray(struct iov_iter *i, unsigned int direction,
 }
 EXPORT_SYMBOL(iov_iter_xarray);
 
+void iov_iter_dmabuf_map(struct iov_iter *i, unsigned int direction,
+			 struct io_dmabuf_map *map,
+			 loff_t off, size_t count)
+{
+	WARN_ON(direction & ~(READ | WRITE));
+	*i = (struct iov_iter){
+		.iter_type = ITER_DMABUF_MAP,
+		.data_source = direction,
+		.dmabuf_map = map,
+		.count = count,
+		.iov_offset = off,
+	};
+}
+
 /**
  * iov_iter_discard - Initialise an I/O iterator that discards data
  * @i: The iterator to initialise.
@@ -841,7 +857,7 @@ static unsigned long iov_iter_alignment_bvec(const struct iov_iter *i)
 
 unsigned long iov_iter_alignment(const struct iov_iter *i)
 {
-	if (likely(iter_is_ubuf(i))) {
+	if (likely(iter_is_ubuf(i)) || iov_iter_is_dmabuf_map(i)) {
 		size_t size = i->count;
 		if (size)
 			return ((unsigned long)i->ubuf + i->iov_offset) | size;
@@ -872,7 +888,7 @@ unsigned long iov_iter_gap_alignment(const struct iov_iter *i)
 	size_t size = i->count;
 	unsigned k;
 
-	if (iter_is_ubuf(i))
+	if (iter_is_ubuf(i) || iov_iter_is_dmabuf_map(i))
 		return 0;
 
 	if (WARN_ON(!iter_is_iovec(i)))
@@ -1469,11 +1485,12 @@ EXPORT_SYMBOL_GPL(import_ubuf);
 void iov_iter_restore(struct iov_iter *i, struct iov_iter_state *state)
 {
 	if (WARN_ON_ONCE(!iov_iter_is_bvec(i) && !iter_is_iovec(i) &&
-			 !iter_is_ubuf(i)) && !iov_iter_is_kvec(i))
+			 !iter_is_ubuf(i) && !iov_iter_is_kvec(i) &&
+			 !iov_iter_is_dmabuf_map(i)))
 		return;
 	i->iov_offset = state->iov_offset;
 	i->count = state->count;
-	if (iter_is_ubuf(i))
+	if (iter_is_ubuf(i) || iov_iter_is_dmabuf_map(i))
 		return;
 	/*
 	 * For the *vec iters, nr_segs + iov is constant - if we increment
-- 
2.53.0

