Return-Path: <linux-fsdevel-owner@vger.kernel.org>
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@infradead.org>,
        Huang Ying <ying.huang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH v2 08/51] block: comment on bio_alloc_pages()
Date: Mon, 26 Jun 2017 20:09:51 +0800
Message-Id: <20170626121034.3051-9-ming.lei@redhat.com>
In-Reply-To: <20170626121034.3051-1-ming.lei@redhat.com>
References: <20170626121034.3051-1-ming.lei@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

This patch adds comment on usage of bio_alloc_pages().

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/bio.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/block/bio.c b/block/bio.c
index 89a51bd49ab7..a5db117e8dfa 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -972,7 +972,9 @@ EXPORT_SYMBOL(bio_advance);
  * @bio: bio to allocate pages for
  * @gfp_mask: flags for allocation
  *
- * Allocates pages up to @bio->bi_vcnt.
+ * Allocates pages up to @bio->bi_vcnt, and this function should only
+ * be called on a new initialized bio, which means all pages aren't added
+ * to the bio via bio_add_page() yet.
  *
  * Returns 0 on success, -ENOMEM on failure. On failure, any allocated pages are
  * freed.
-- 
2.9.4
