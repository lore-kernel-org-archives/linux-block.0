Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABED327FD59
	for <linux-block@vger.kernel.org>; Sun, 23 Nov 2025 22:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763938308; cv=none; b=cBhzeRTJwNLSlM3KsttK57YWp6qEBbPknBDbH4f0SyBeu1QEoKVd1YGx8Nafa3GQe0dAkx/3HgatFIrjH3nOKsgAv9fXsz1m0arnQq75NqBvw6oWzXGxb5qVJIcumzvQADgGUmPfJWzKN1CSKO3NCv+xpWa3w3i4RgHOJcimJ7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763938308; c=relaxed/simple;
	bh=biIYoLFZIunfY+RjkNduyhE0he3gpQJOgrFilhAOH4g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F7J5a98babpUUsrVE2wGaM0NFRxC/bUJHG8G5E2Ry/tnusNTQL+bPMGZqPSSCOARz4rI1kanfO2R+Shq27iguL61Yqx0aRtjEVSF9+mHtG9qAlxrHBPaK2Mj/5jd9RnE+G7pU12Ipsoy8336BRZoDX90ElOq0ajbI1ZoNCh13m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WpmGMvm3; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WpmGMvm3"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-42b566859ecso3321323f8f.2
        for <linux-block@vger.kernel.org>; Sun, 23 Nov 2025 14:51:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763938304; x=1764543104; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Eb2Dznv7cN1HWvl69eUL3qKJ9duXd8EJVDjyGYBP64I=;
        b=WpmGMvm3Tt0Y2XyUxUpwW2d5teUAZCtS8tXckR5X/RDdFiEfJCS4kG6UaJnYUThtom
         hVeXn8TIJ9meTxceBvBKwkHciPinGwCqfv3wjWwIf+m88DPx3FN4hpvukifhHXo98Zgf
         Z5WVvQboSs4e2gH8x979VuM5bzCFt6GmbE24Kvbr4tFLnXRGk/0iExyengLb2OvbRPVc
         TDwO+nPjaWdkwTGWQsEJozk5nUZ1UUcVRUS05QTkW3lCmRFGs3QFAmSHXsGZmUKgcjnC
         LGqCFndJS+bJKiRwz7ujKWxSlhm7A/S03RXh/ctR3jiEVpK1SkHNGZ36PnMNEchv4zDe
         naPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763938304; x=1764543104;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Eb2Dznv7cN1HWvl69eUL3qKJ9duXd8EJVDjyGYBP64I=;
        b=HjHxlvorzx2o9ShCoTvd2vGOmfxVg7dWcWysB4/TUY5tfq5BuKJJfCUJTzJ2Welm43
         QdRhteXF8TRjWMdGTbsWhzlBHE7zxioAN3dgiNa9Q65CC3fAyBR2f9Spq6IKJ1DM6d5F
         urgRENjTZp2T7NVTqsqToRglQbowgSKWLD5LsWNMuWWe0yJ7ULXf73sIeMDR+NGVN/Cp
         9KFbdZ8n048hLUkGG1KhiXNJ0QOxukOD/knxmaTZBr2TBNin/X45UXTC/eUHuC8LhBks
         A0TrYfBuhVE+wjwLuz/eL/wItdiXMGNsFPJixIoI/QbG2re7g6H7aar+HOkPLdhlNwGT
         Ikcg==
X-Gm-Message-State: AOJu0Yx16XD3G2LBXV8VibvV3OBIX4xR8YvDM0pVmTfbPeCyCIJpoJ01
	MDSPougHHyaAXpjXF/oIlqPl5jPdUaMQDMvx895GLtgDZb9htuMJ5BdCkbKasA==
X-Gm-Gg: ASbGncvjmXdaDgIB2dFQO1bLsX/wNxqaHQYYpnBgwbOe6dTPLDIqRwPqwmVWnWBXBAm
	9CFWTLndX1j1pG+KkKVO/zWIkx26M+AUmwyA0kBs7WAdTBhwOFrH5la2kanwIDFAN4h7kyYRpRR
	cY4kxKCNoAgtCC/ItAIkd19zfuiA0wCzlfUaJAAr00iMFLBa4VhmVqniGFPNtXn9JkQoSTLHv4n
	fN42wyhB3xnqR9Hjh5KURc6F2PwHwU5zL9vd1EeH2Q+HfvVYOI+PEE6EomRaXGSgs7kuEk8Ky3/
	9oZJ6mL0vyAH+vkGYMdqgt+4TFLJUFT5Tix142onBVn0sOzb84UlW9O4T8LoB/cqvOuEdLS6RR6
	le57DSOE+sSoXhApGtakhWIKka6lkUn+vevalhVA4PaOlLH2gahXQp3CnkPyDJQ7xodxbNaqKXc
	GY0RFJTMlvCLXwdw==
X-Google-Smtp-Source: AGHT+IED8z7T9BZIQ3+G6TZGcukyRm9aG9PTE7rjzPMs+94mQ+eXcoj3xDrYuPfTG51yWGc4ynh5VQ==
X-Received: by 2002:a05:6000:601:b0:42b:5592:ebd1 with SMTP id ffacd0b85a97d-42cc19f0b39mr11000772f8f.0.1763938304146;
        Sun, 23 Nov 2025 14:51:44 -0800 (PST)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7fb9190sm24849064f8f.33.2025.11.23.14.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Nov 2025 14:51:43 -0800 (PST)
From: Pavel Begunkov <asml.silence@gmail.com>
To: linux-block@vger.kernel.org,
	io-uring@vger.kernel.org
Cc: Vishal Verma <vishal1.verma@intel.com>,
	tushar.gohad@intel.com,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org
Subject: [RFC v2 02/11] iov_iter: introduce iter type for pre-registered dma
Date: Sun, 23 Nov 2025 22:51:22 +0000
Message-ID: <f57269489c4d6f670ab1f9de4d0764030d8d080c.1763725387.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1763725387.git.asml.silence@gmail.com>
References: <cover.1763725387.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a new iterator type backed by a pre mapped dmabuf represented
by struct dma_token. The token is specific to the file for which it was
created, and the user must avoid the token and the iterator to any other
file. This limitation will be softened in the future.

Suggested-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 include/linux/uio.h | 10 ++++++++++
 lib/iov_iter.c      | 30 ++++++++++++++++++++++++------
 2 files changed, 34 insertions(+), 6 deletions(-)

diff --git a/include/linux/uio.h b/include/linux/uio.h
index 5b127043a151..1b22594ca35b 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -29,6 +29,7 @@ enum iter_type {
 	ITER_FOLIOQ,
 	ITER_XARRAY,
 	ITER_DISCARD,
+	ITER_DMA_TOKEN,
 };
 
 #define ITER_SOURCE	1	// == WRITE
@@ -71,6 +72,7 @@ struct iov_iter {
 				const struct folio_queue *folioq;
 				struct xarray *xarray;
 				void __user *ubuf;
+				struct dma_token *dma_token;
 			};
 			size_t count;
 		};
@@ -155,6 +157,11 @@ static inline bool iov_iter_is_xarray(const struct iov_iter *i)
 	return iov_iter_type(i) == ITER_XARRAY;
 }
 
+static inline bool iov_iter_is_dma_token(const struct iov_iter *i)
+{
+	return iov_iter_type(i) == ITER_DMA_TOKEN;
+}
+
 static inline unsigned char iov_iter_rw(const struct iov_iter *i)
 {
 	return i->data_source ? WRITE : READ;
@@ -300,6 +307,9 @@ void iov_iter_folio_queue(struct iov_iter *i, unsigned int direction,
 			  unsigned int first_slot, unsigned int offset, size_t count);
 void iov_iter_xarray(struct iov_iter *i, unsigned int direction, struct xarray *xarray,
 		     loff_t start, size_t count);
+void iov_iter_dma_token(struct iov_iter *i, unsigned int direction,
+			struct dma_token *token,
+			loff_t off, size_t count);
 ssize_t iov_iter_get_pages2(struct iov_iter *i, struct page **pages,
 			size_t maxsize, unsigned maxpages, size_t *start);
 ssize_t iov_iter_get_pages_alloc2(struct iov_iter *i, struct page ***pages,
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 2fe66a6b8789..26fa8f8f13c0 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -563,7 +563,8 @@ void iov_iter_advance(struct iov_iter *i, size_t size)
 {
 	if (unlikely(i->count < size))
 		size = i->count;
-	if (likely(iter_is_ubuf(i)) || unlikely(iov_iter_is_xarray(i))) {
+	if (likely(iter_is_ubuf(i)) || unlikely(iov_iter_is_xarray(i)) ||
+	    unlikely(iov_iter_is_dma_token(i))) {
 		i->iov_offset += size;
 		i->count -= size;
 	} else if (likely(iter_is_iovec(i) || iov_iter_is_kvec(i))) {
@@ -619,7 +620,8 @@ void iov_iter_revert(struct iov_iter *i, size_t unroll)
 		return;
 	}
 	unroll -= i->iov_offset;
-	if (iov_iter_is_xarray(i) || iter_is_ubuf(i)) {
+	if (iov_iter_is_xarray(i) || iter_is_ubuf(i) ||
+	    iov_iter_is_dma_token(i)) {
 		BUG(); /* We should never go beyond the start of the specified
 			* range since we might then be straying into pages that
 			* aren't pinned.
@@ -763,6 +765,21 @@ void iov_iter_xarray(struct iov_iter *i, unsigned int direction,
 }
 EXPORT_SYMBOL(iov_iter_xarray);
 
+void iov_iter_dma_token(struct iov_iter *i, unsigned int direction,
+			struct dma_token *token,
+			loff_t off, size_t count)
+{
+	WARN_ON(direction & ~(READ | WRITE));
+	*i = (struct iov_iter){
+		.iter_type = ITER_DMA_TOKEN,
+		.data_source = direction,
+		.dma_token = token,
+		.iov_offset = 0,
+		.count = count,
+		.iov_offset = off,
+	};
+}
+
 /**
  * iov_iter_discard - Initialise an I/O iterator that discards data
  * @i: The iterator to initialise.
@@ -829,7 +846,7 @@ static unsigned long iov_iter_alignment_bvec(const struct iov_iter *i)
 
 unsigned long iov_iter_alignment(const struct iov_iter *i)
 {
-	if (likely(iter_is_ubuf(i))) {
+	if (likely(iter_is_ubuf(i)) || iov_iter_is_dma_token(i)) {
 		size_t size = i->count;
 		if (size)
 			return ((unsigned long)i->ubuf + i->iov_offset) | size;
@@ -860,7 +877,7 @@ unsigned long iov_iter_gap_alignment(const struct iov_iter *i)
 	size_t size = i->count;
 	unsigned k;
 
-	if (iter_is_ubuf(i))
+	if (iter_is_ubuf(i) || iov_iter_is_dma_token(i))
 		return 0;
 
 	if (WARN_ON(!iter_is_iovec(i)))
@@ -1457,11 +1474,12 @@ EXPORT_SYMBOL_GPL(import_ubuf);
 void iov_iter_restore(struct iov_iter *i, struct iov_iter_state *state)
 {
 	if (WARN_ON_ONCE(!iov_iter_is_bvec(i) && !iter_is_iovec(i) &&
-			 !iter_is_ubuf(i)) && !iov_iter_is_kvec(i))
+			 !iter_is_ubuf(i) && !iov_iter_is_kvec(i) &&
+			 !iov_iter_is_dma_token(i)))
 		return;
 	i->iov_offset = state->iov_offset;
 	i->count = state->count;
-	if (iter_is_ubuf(i))
+	if (iter_is_ubuf(i) || iov_iter_is_dma_token(i))
 		return;
 	/*
 	 * For the *vec iters, nr_segs + iov is constant - if we increment
-- 
2.52.0

