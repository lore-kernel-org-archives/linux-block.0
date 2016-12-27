Return-Path: <tom.leiming@gmail.com>
Return-Path: <tom.leiming@gmail.com>
From: Ming Lei <tom.leiming@gmail.com>
To: Jens Axboe <axboe@fb.com>,
	linux-kernel@vger.kernel.org
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>,
	Ming Lei <tom.leiming@gmail.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v1 09/54] block: comment on bio_iov_iter_get_pages()
Date: Tue, 27 Dec 2016 23:55:58 +0800
Message-Id: <1482854250-13481-10-git-send-email-tom.leiming@gmail.com>
In-Reply-To: <1482854250-13481-1-git-send-email-tom.leiming@gmail.com>
References: <1482854250-13481-1-git-send-email-tom.leiming@gmail.com>
List-ID: <linux-block@vger.kernel.org>

bio_iov_iter_get_pages() used unused bvec spaces for
storing page pointer array temporarily, and this patch
comments on this usage wrt. multipage bvec support.

Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 block/bio.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/block/bio.c b/block/bio.c
index d4a1e0b63ea0..10398969353b 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -859,6 +859,10 @@ EXPORT_SYMBOL(bio_add_page);
  *
  * Pins as many pages from *iter and appends them to @bio's bvec array. The
  * pages will have to be released using put_page() when done.
+ *
+ * The hacking way of using bvec table as page pointer array is safe
+ * even after multipage bvec is introduced because that space can be
+ * thought as unused by bio_add_page().
  */
 int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 {
-- 
2.7.4
