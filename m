Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.220
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794553658;
	b=jC6fOnBQdIPL31Mu69Ywv4GEvPsOJsKG5uVk9b+x68lYt4M7D3cI4usw+dihxIYT0glc
	 8WhEx8d5LGSOr5Lu/fbEMYue+Sfu1BdJukvA5bt/6F/jfgJVSbm1vhSTAd51NvvqxWX+7
	 NFOdcF2l3AKzPYh85Z+F+I15qrrGsPmJHcJFWNOPVA667lONo9agVICnRrEgxOzHgL8l5
	 iJf02WrwxyBhit0Y69G/BMsE7Y+QiGK1e2eS00q2BHKxXOehqXi8lCMn++gs8hfv9cAEM
	 T/G9hmoawV90ytYSr+cyarjZ4bEaLKwOEeGqaAPyoO0XEICfm9PMoc2gb4M7YXH0VGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794553658;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=KYrqfOt3WaM6xb5MUDSy7pQiGraRuXX8G5HzWKe5LoM=;
	b=S7GuYvu3bEOWCVAtMHHyoWaRyapvFqL7RlwFq14i+oT51IuBSb33hrtiZKRNd+K+j9zF
	 gy8Z8GANqC75KgsyWmjvVCW+1isffz8wSEJKBysEe6J17oDZQl4UnlwqLdxEEeOTf9bjl
	 IIvUcxAuDth5nayC4pGOJs+bUxXDiRG6bIwnqpPKW54OWTje9jLQ2puoVEspxomHQEQCr
	 bAmvCXKBhLwrtB/JfJr9ZQIspDAkLmhGyeYpSE7qLlX281fvfQ162dqb53F1Velz/W4X8
	 dag9rfkxIf5m3uc2jvhgJEtAx2riGVOEWd37k3LUzOLPhRt0n/IvcR2A/rBwiFY3aFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=WkSfPD9k;
	arc=none smtp.remote-ip=91.218.175.220
Received: from mta0.migadu.com (out-220.mta0.migadu.com [91.218.175.220])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C683E606A880
	for <linux-block@vger.kernel.org>; Fri, 13 Nov 2026 07:07:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C683E606A880
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=WkSfPD9k
X-Envelope-To: linux-block@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=FEKih65dVLqip/qvv/nnGzIKP8TulmlEVfQQ2ZV1WNs=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794553655; v=1; x=1795158455;
 b=WkSfPD9k/5h9jc1pqBMSW+EIhZjIrv2U0aAFAZvg32Z65gZjSRCWqnXgqwZxgJ4NmUjYJH5Z
 yphGNvIXpk74iF5pdVOpIOwJNpd3zATxSYy2zWF3HUvAh9DeFZUE4LEtoVw6CjCHtMm6tC41Yno
 dSI7XL8yihhVYrk6iQdEpZDE=
X-Envelope-To: linux-block@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 399a8e2f5a148472;
	Fri, 13 Nov 2026 07:07:35 +0000
X-Mizu-Trace-ID: 399a8e2f5a148472
X-Migadu-Flow: FLOW_OUT
From: Mengmeng Zhao <mengmeng.zhao@linux.dev>
To: Christoph Hellwig <hch@lst.de>,
	Anuj Gupta <anuj1072538@gmail.com>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	christian.koenig@amd.com,
	Philipp Stanner <phasta@kernel.org>,
	Dan Williams <djbw@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.cz>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	tytso@mit.edu,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Baokun Li <libaokun@linux.alibaba.com>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Zhang Yi <yi.zhang@huawei.com>,
	asml.silence@gmail.com,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	nvdimm@lists.linux.dev,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	Li Wang <liwang@kylinos.cn>,
	Mengmeng Zhao <zhaomengmeng@kylinos.cn>
Subject: [RFC PATCH v2 3/8] iomap: don't ask for a buffered fallback for dma-buf iterators
Date: Fri, 13 Nov 2026 15:06:16 +0800
Message-ID: <20261113070621.273953-4-mengmeng.zhao@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261113070621.273953-1-mengmeng.zhao@linux.dev>
References: <20261113070621.273953-1-mengmeng.zhao@linux.dev>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mengmeng Zhao <zhaomengmeng@kylinos.cn>

-ENOTBLK tells the caller to retry with buffered I/O.  A dma-buf iterator
has no pages to copy, so the callers refuse that fallback, which would
turn the error into a successful transfer of zero bytes.

Report the reason instead: a busy folio becomes -EAGAIN, which the caller
can retry, any other invalidation failure keeps its error code, and
-ENOTBLK from ->iomap_begin() becomes -EOPNOTSUPP when nothing was
transferred.  A partial direct I/O still reports its progress.  Both
branches are reachable only through a file that opted into dma-buf I/O,
which ext4 does in the last patch.

Signed-off-by: Mengmeng Zhao <zhaomengmeng@kylinos.cn>
Signed-off-by: Li Wang <liwang@kylinos.cn>
---
 .../filesystems/iomap/operations.rst          |  3 +++
 fs/iomap/direct-io.c                          | 20 +++++++++++++++++--
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/Documentation/filesystems/iomap/operations.rst b/Documentation/filesystems/iomap/operations.rst
index da982ca7e413..ca59716d225c 100644
--- a/Documentation/filesystems/iomap/operations.rst
+++ b/Documentation/filesystems/iomap/operations.rst
@@ -513,6 +513,9 @@ Return Values
    cache before issuing the I/O to storage.
    The ``->iomap_begin`` or ``->iomap_end`` functions may also return
    this value.
+   A dma-buf iterator cannot fall back to buffered I/O, so it gets
+   ``-EAGAIN`` when the failure is retryable and ``-EOPNOTSUPP`` when no
+   data could be transferred.
 
  * ``-EIOCBQUEUED``: The asynchronous direct I/O request has been
    queued and will be completed separately.
diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 4a2b0f9df5a7..83fda6973bb9 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -706,7 +706,9 @@ static int iomap_dio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
  * completing partial requests asynchronously.
  *
  * Returns -ENOTBLK In case of a page invalidation invalidation failure for
- * writes.  The callers needs to fall back to buffered I/O in this case.
+ * writes.  The callers needs to fall back to buffered I/O in this case.  A
+ * dma-buf iterator cannot use that fallback, so it gets -EAGAIN when the
+ * failure is retryable and -EOPNOTSUPP when nothing was transferred.
  */
 struct iomap_dio *
 __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
@@ -806,7 +808,7 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 		/*
 		 * Try to invalidate cache pages for the range we are writing.
 		 * If this invalidation fails, let the caller fall back to
-		 * buffered I/O.
+		 * buffered I/O unless the iterator cannot be handled there.
 		 */
 		ret = kiocb_invalidate_pages(iocb, iomi.len);
 		if (ret) {
@@ -820,6 +822,14 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 					 * the caller tries again.
 					 */
 					ret = -EAGAIN;
+				} else if (iov_iter_is_dmabuf_map(iter)) {
+					/*
+					 * A dma-buf iterator has no buffered
+					 * fallback, so -ENOTBLK would hide the
+					 * real failure.  A busy folio is retryable.
+					 */
+					if (ret == -EBUSY)
+						ret = -EAGAIN;
 				} else {
 					/* fall back to buffered write */
 					ret = -ENOTBLK;
@@ -867,6 +877,12 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 	if (ret == -ENOTBLK) {
 		wait_for_completion = true;
 		ret = 0;
+		/*
+		 * A dma-buf iterator cannot use that fallback.  Anything
+		 * already transferred is still reported as a short I/O.
+		 */
+		if (!dio->size && iov_iter_is_dmabuf_map(iter))
+			ret = -EOPNOTSUPP;
 	}
 	if (ret < 0)
 		iomap_dio_set_error(dio, ret);
-- 
2.43.0

