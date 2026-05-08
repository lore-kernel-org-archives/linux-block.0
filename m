Received: from forward102d.mail.yandex.net (forward102d.mail.yandex.net [178.154.239.213])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE7937187B;
	Fri,  8 May 2026 11:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778238927; cv=none; b=gZaZesjo/aLS9z9u8ZGhmbniSldkfB6zWfmzu4vXmKtpdTiwj/XK4IJxBGIg4GaKzAARsJftEKYnyN1Rm2eg0sAzXq7AR1HU31MgBKVIHog6m1ioJxy4MW2FTcb7eOwLwWl+r7jO30bEdRrB1spYGeTV36UsI+hyvo0U+1lorRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778238927; c=relaxed/simple;
	bh=233mq/faJh6is6meW777b5v9jeXzszz2Xt3EdCCMPeg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qPstQvWLG/3KoZhbrq521QiiWV5mNLoSJWLUcHmR0ej37rI0SFeShy+IMeuvubNygM7wIahdpOreVg9Uynzme0iRKEHlKN79qJtFC0c9/0NdKISBNciut87MzdLNu2/1BCf80EXBfybvTt7JGGXNpFC9WmY1gb9RDTbx0O18tn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=sPUWgfAB; arc=none smtp.client-ip=178.154.239.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="sPUWgfAB"
Received: from mail-nwsmtp-smtp-production-main-77.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-77.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:7ba3:0:640:5ad4:0])
	by forward102d.mail.yandex.net (Yandex) with ESMTPS id 2A883C01D3;
	Fri, 08 May 2026 14:15:15 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-77.klg.yp-c.yandex.net (smtp) with ESMTPSA id DFESAFMS7Os0-YZiOMHrK;
	Fri, 08 May 2026 14:15:14 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1778238914; bh=hdEv90OrIa5Or68EvQ9jPENOtjFFvSTt1FJMESWp1pE=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=sPUWgfABlGj4F+i0tV7eMT2VXirgVwBD/nO7cSxleRbYEKidjlxS5nePA+69oSdBE
	 Bq9/7507YaSmLgRd6I7zuUnsiAhwuBirbkIuJuNj5bk7H1wF7lDA/9Hm8qIzdF6G2A
	 tLGuIxCInDjGsTxMVkjpk9syZcRr/kzlE2k4PbH8=
Authentication-Results: mail-nwsmtp-smtp-production-main-77.klg.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Jens Axboe <axboe@kernel.dk>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Christoph Hellwig <hch@lst.de>,
	linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>,
	Fedor Pchelkin <pchelkin@ispras.ru>
Subject: [PATCH] lib: free pagelist on error in iov_iter_extract_pages()
Date: Fri,  8 May 2026 14:13:29 +0300
Message-ID: <20260508111329.329943-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since 'iov_iter_extract_pages()' may allocate new pagelist if the passed
one isn't large enough, the worst-case scenario may be:

...
struct page *stack_pages[SMALL];
struct page **pages = stack_pages;
...
if (iov_iter_extract_pages(i..., &pages, ...) <= 0) {
        /* Even in case of error, new pagelist may be allocated */
        if (pages != stack_pages)
                kvfree(pages);                                  [1]
        /* The rest of error handling and return */
}
/* Regular flow */
...
if (pages != stack_pages)
        kvfree(pages);
...
return 0;

If you're unlucky so SMALL amount of pages wasn't enough and new
pagelist was allocated, missing [1] causes the memory leak similar
to one I've recently observed and fixed for 6.12 in [2]. So adjust
'iov_iter_extract_pages()' to make such a cleanup itself rather than
rely on caller's handling on error paths, thus making [1] not needed.

[2] https://lore.kernel.org/stable/20260505094529.406783-1-dmantipov@yandex.ru/T/#u

Suggested-by: Fedor Pchelkin <pchelkin@ispras.ru>
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 lib/iov_iter.c | 54 ++++++++++++++++++++++++++++++--------------------
 1 file changed, 33 insertions(+), 21 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 243662af1af7..46dd11913df0 100644
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
+	int ret;
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
+	if (unlikely(ret) && *pages && *pages != oldpages) {
+		kvfree(*pages);
+		*pages = oldpages;
+	}
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(iov_iter_extract_pages);
 
-- 
2.54.0

