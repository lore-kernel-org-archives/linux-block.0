Received: from forward100b.mail.yandex.net (forward100b.mail.yandex.net [178.154.239.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AADBE3D9667;
	Tue, 12 May 2026 17:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778605534; cv=none; b=jVNcoX717ZN/QDbAZiHUQ7PvqccuCJ6Dm6nSP1q2vGPZjB7QBrEopJebAdd/kXeW1iVr95DABqBcsuU1Zb9cbH3g1vubV6BWdq2FeOzNhlMwZKXJ09HDWn9aIYU1ENU1j3t/lTojnP78a/AaQrTfDKKaKtXXZfEVM6xFrO+hex8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778605534; c=relaxed/simple;
	bh=wb3HSmNosdqptO3dRgL9o4qWohh94lpRvjhPSzOlI5g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nWPv0ryXqiLLkZWuHdDmzuzD6cZs/FOkgcw3Nx1R+5QnSGZzV9vrdjQOB1Q5lmHc6YWsFv+ha+gLj/ciRnfIoH4DrrcXaBSfJw36B3EynH4JLHDJKCoFHscty+k1rwmuEyXisDG25/qe9rmy+xPoabwyaaR89ekGV2XiLj3Qd7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=PlYy/Ga8; arc=none smtp.client-ip=178.154.239.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="PlYy/Ga8"
Received: from mail-nwsmtp-smtp-production-canary-88.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-canary-88.sas.yp-c.yandex.net [IPv6:2a02:6b8:c1c:2e1d:0:640:64e7:0])
	by forward100b.mail.yandex.net (Yandex) with ESMTPS id 69FEF80704;
	Tue, 12 May 2026 20:05:27 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-canary-88.sas.yp-c.yandex.net (smtp) with ESMTPSA id P5OhAM7SNKo0-wzu57YWN;
	Tue, 12 May 2026 20:05:26 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1778605526; bh=Dz2tFGc3ay+rhzIOyBbBtK1z4o5Q6TFVolXqbWTpEic=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=PlYy/Ga8GDBee2Opcx2YQ0iVjDRs08lRO1YxdEBg4og49yRQdMWb+1XiqU9UoBnkW
	 q7hQ0VUpSvmtPbQfzRMCVbvYKZRdhx9VjT8DfqFUpvudhBka8kbqDL9wQhBxN4HCMD
	 FzKnqcYgKsPSfsmsSDyQjhyucQwmo4KhR/I0Xe7c=
Authentication-Results: mail-nwsmtp-smtp-production-canary-88.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Jens Axboe <axboe@kernel.dk>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Christoph Hellwig <hch@lst.de>,
	Caleb Sander Mateos <csander@purestorage.com>,
	linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>,
	stable@vger.kernel.org,
	Fedor Pchelkin <pchelkin@ispras.ru>
Subject: [PATCH v2] lib: free pagelist on error in iov_iter_extract_pages()
Date: Tue, 12 May 2026 20:05:25 +0300
Message-ID: <20260512170525.357573-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Users of 'iov_iter_extract_pages()' may provide small, likely
stack-allocated, array of pages by itself and then reject to
use it if it's considered too small. In such a case, passing
NULL pointer means that 'iov_iter_extract_pages()' should
allocate array of pages internally (via 'want_pages_array()').
An overall scenario may be:

...
struct page *stack_pages[SMALL];
struct page **pages = stack_pages;
...
if (not_enough_pages(SMALL))
        pages = NULL;
...
if (iov_iter_extract_pages(..., &pages, ...) <= 0) {
        /* Even in case of error, new array of pages may be allocated */
        if (pages != stack_pages)
                kvfree(pages);                                  [1]
        /* The rest of error handling and return */
}
/* Regular flow */
...
if (pages != stack_pages)
        kvfree(pages);
...

That is, if you're unlucky so SMALL amount of pages wasn't enough and
new array of pages was allocated, missing [1] causes the memory leak.

Currently 'bio_integrity_map_user()' seems the only place where such
a leak looks possible. Older kernels may have more. In particular,
6.12.x has this type of leak in 'bio_map_user_iov()', and it was
found with syzkaller and reproduced experimentally.

So adjust 'iov_iter_extract_pages()' to make cleanup [1] itself rather
than rely on caller's handling on error paths.

Fixes: 7d58fe731028 ("iov_iter: Add a function to extract a page list from an iterator")
Cc: stable@vger.kernel.org
Suggested-by: Fedor Pchelkin <pchelkin@ispras.ru>
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
v2: fix commit message and issues observed by Sashiko
---
 lib/iov_iter.c | 54 ++++++++++++++++++++++++++++++--------------------
 1 file changed, 33 insertions(+), 21 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 243662af1af7..30c5baccc6a9 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1807,7 +1807,8 @@ static ssize_t iov_iter_extract_user_pages(struct iov_iter *i,
  *  (*) Use with ITER_DISCARD is not supported as that has no content.
  *
  * On success, the function sets *@pages to the new pagelist, if allocated, and
- * sets *offset0 to the offset into the first page.
+ * sets *offset0 to the offset into the first page. On error, new pagelist
+ * is freed if was allocated, and *@pages sets back to its original value.
  *
  * It may also return -ENOMEM and -EFAULT.
  */
@@ -1818,31 +1819,42 @@ ssize_t iov_iter_extract_pages(struct iov_iter *i,
 			       iov_iter_extraction_t extraction_flags,
 			       size_t *offset0)
 {
+	struct page **oldpages = *pages;
+	ssize_t ret;
+
 	maxsize = min_t(size_t, min_t(size_t, maxsize, i->count), MAX_RW_COUNT);
 	if (!maxsize)
 		return 0;
 
 	if (likely(user_backed_iter(i)))
-		return iov_iter_extract_user_pages(i, pages, maxsize,
-						   maxpages, extraction_flags,
-						   offset0);
-	if (iov_iter_is_kvec(i))
-		return iov_iter_extract_kvec_pages(i, pages, maxsize,
-						   maxpages, extraction_flags,
-						   offset0);
-	if (iov_iter_is_bvec(i))
-		return iov_iter_extract_bvec_pages(i, pages, maxsize,
-						   maxpages, extraction_flags,
-						   offset0);
-	if (iov_iter_is_folioq(i))
-		return iov_iter_extract_folioq_pages(i, pages, maxsize,
-						     maxpages, extraction_flags,
-						     offset0);
-	if (iov_iter_is_xarray(i))
-		return iov_iter_extract_xarray_pages(i, pages, maxsize,
-						     maxpages, extraction_flags,
-						     offset0);
-	return -EFAULT;
+		ret = iov_iter_extract_user_pages(i, pages, maxsize,
+						  maxpages, extraction_flags,
+						  offset0);
+	else if (iov_iter_is_kvec(i))
+		ret = iov_iter_extract_kvec_pages(i, pages, maxsize,
+						  maxpages, extraction_flags,
+						  offset0);
+	else if (iov_iter_is_bvec(i))
+		ret = iov_iter_extract_bvec_pages(i, pages, maxsize,
+						  maxpages, extraction_flags,
+						  offset0);
+	else if (iov_iter_is_folioq(i))
+		ret = iov_iter_extract_folioq_pages(i, pages, maxsize,
+						    maxpages, extraction_flags,
+						    offset0);
+	else if (iov_iter_is_xarray(i))
+		ret = iov_iter_extract_xarray_pages(i, pages, maxsize,
+						    maxpages, extraction_flags,
+						    offset0);
+	else
+		ret = -EFAULT;
+
+	if (unlikely(ret <= 0) && *pages && *pages != oldpages) {
+		kvfree(*pages);
+		*pages = oldpages;
+	}
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(iov_iter_extract_pages);
 
-- 
2.54.0

