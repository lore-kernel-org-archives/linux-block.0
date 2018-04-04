Return-Path: <jglisse@redhat.com>
From: jglisse@redhat.com
To: linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Tejun Heo <tj@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Josef Bacik <jbacik@fb.com>,
	Mel Gorman <mgorman@techsingularity.net>
Subject: [RFC PATCH 39/79] fs/buffer: add struct address_space to clean_page_buffers() arguments
Date: Wed,  4 Apr 2018 15:18:13 -0400
Message-Id: <20180404191831.5378-24-jglisse@redhat.com>
In-Reply-To: <20180404191831.5378-1-jglisse@redhat.com>
References: <20180404191831.5378-1-jglisse@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

From: Jérôme Glisse <jglisse@redhat.com>

Add struct address_space to clean_page_buffers() arguments.

One step toward dropping reliance on page->mapping.

Signed-off-by: Jérôme Glisse <jglisse@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>
CC: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>
Cc: Jan Kara <jack@suse.cz>
Cc: Josef Bacik <jbacik@fb.com>
Cc: Mel Gorman <mgorman@techsingularity.net>
---
 fs/block_dev.c              | 2 +-
 fs/mpage.c                  | 9 +++++----
 include/linux/buffer_head.h | 2 +-
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index dd9da97615e3..b653cd8fd1e3 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -712,7 +712,7 @@ int bdev_write_page(struct block_device *bdev, sector_t sector,
 	if (result) {
 		end_page_writeback(page);
 	} else {
-		clean_page_buffers(page);
+		clean_page_buffers(mapping, page);
 		unlock_page(page);
 	}
 	blk_queue_exit(bdev->bd_queue);
diff --git a/fs/mpage.c b/fs/mpage.c
index a75cea232f1a..624995c333e0 100644
--- a/fs/mpage.c
+++ b/fs/mpage.c
@@ -447,7 +447,8 @@ struct mpage_data {
  * We have our BIO, so we can now mark the buffers clean.  Make
  * sure to only clean buffers which we know we'll be writing.
  */
-static void clean_buffers(struct page *page, unsigned first_unmapped)
+static void clean_buffers(struct address_space *mapping, struct page *page,
+			  unsigned first_unmapped)
 {
 	unsigned buffer_counter = 0;
 	struct buffer_head *bh, *head;
@@ -477,9 +478,9 @@ static void clean_buffers(struct page *page, unsigned first_unmapped)
  * We don't need to calculate how many buffers are attached to the page,
  * we just need to specify a number larger than the maximum number of buffers.
  */
-void clean_page_buffers(struct page *page)
+void clean_page_buffers(struct address_space *mapping, struct page *page)
 {
-	clean_buffers(page, ~0U);
+	clean_buffers(mapping, page, ~0U);
 }
 
 static int __mpage_writepage(struct page *page, struct address_space *_mapping,
@@ -643,7 +644,7 @@ static int __mpage_writepage(struct page *page, struct address_space *_mapping,
 		goto alloc_new;
 	}
 
-	clean_buffers(page, first_unmapped);
+	clean_buffers(mapping, page, first_unmapped);
 
 	BUG_ON(PageWriteback(page));
 	set_page_writeback(page);
diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index 22e79307c055..f3baf88a251b 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -248,7 +248,7 @@ int generic_write_end(struct file *, struct address_space *,
 				loff_t, unsigned, unsigned,
 				struct page *, void *);
 void page_zero_new_buffers(struct page *page, unsigned from, unsigned to);
-void clean_page_buffers(struct page *page);
+void clean_page_buffers(struct address_space *mapping, struct page *page);
 int cont_write_begin(struct file *, struct address_space *, loff_t,
 			unsigned, unsigned, struct page **, void **,
 			get_block_t *, loff_t *);
-- 
2.14.3
