Return-Path: <linux-fsdevel-owner@vger.kernel.org>
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@infradead.org>,
        Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v2 09/51] block: comment on bio_iov_iter_get_pages()
Date: Mon, 26 Jun 2017 20:09:52 +0800
Message-Id: <20170626121034.3051-10-ming.lei@redhat.com>
In-Reply-To: <20170626121034.3051-1-ming.lei@redhat.com>
References: <20170626121034.3051-1-ming.lei@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

bio_iov_iter_get_pages() used unused bvec spaces for
storing page pointer array temporarily, and this patch
comments on this usage wrt. multipage bvec support.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/bio.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/block/bio.c b/block/bio.c
index a5db117e8dfa..bf7f25889f6e 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -870,6 +870,10 @@ EXPORT_SYMBOL(bio_add_page);
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
2.9.4
