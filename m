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
Subject: [RFC PATCH 38/79] fs/buffer: add first buffer flag for first buffer_head in a page
Date: Wed,  4 Apr 2018 15:18:12 -0400
Message-Id: <20180404191831.5378-23-jglisse@redhat.com>
In-Reply-To: <20180404191831.5378-1-jglisse@redhat.com>
References: <20180404191831.5378-1-jglisse@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

From: Jérôme Glisse <jglisse@redhat.com>

A common pattern in code is that we have a buffer_head and we want to
get the first buffer_head in buffer_head list for a page. Before this
patch it was simply done with page_buffers(bh->b_page).

This patch introduce an helper bh_first_for_page(struct buffer_head *)
which can use a new flag (also introduced in this patch) to find the
first buffer_head struct for a given page.

This patch use page_buffers(bh->b_page) for now but latter patch can
update this helper to handle special page differently and instead scan
buffer_head list until a buffer_head with first_for_page flag set is
found.

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
 fs/buffer.c                 |  4 ++--
 include/linux/buffer_head.h | 18 ++++++++++++++++++
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 422204701a3b..44beba15c38d 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -276,7 +276,7 @@ static void end_buffer_async_read(struct address_space *mapping,
 	 * two buffer heads end IO at almost the same time and both
 	 * decide that the page is now completely done.
 	 */
-	first = page_buffers(page);
+	first = bh_first_for_page(bh);
 	local_irq_save(flags);
 	bit_spin_lock(BH_Uptodate_Lock, &first->b_state);
 	clear_buffer_async_read(bh);
@@ -332,7 +332,7 @@ void end_buffer_async_write(struct address_space *mapping, struct page *page,
 		SetPageError(page);
 	}
 
-	first = page_buffers(page);
+	first = bh_first_for_page(bh);
 	local_irq_save(flags);
 	bit_spin_lock(BH_Uptodate_Lock, &first->b_state);
 
diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index 7ae60f59f27e..22e79307c055 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -39,6 +39,12 @@ enum bh_state_bits {
 	BH_Prio,	/* Buffer should be submitted with REQ_PRIO */
 	BH_Defer_Completion, /* Defer AIO completion to workqueue */
 
+	/*
+	 * First buffer_head for a page ie page->private is pointing to this
+	 * buffer_head struct.
+	 */
+	BH_FirstForPage,
+
 	BH_PrivateStart,/* not a state bit, but the first bit available
 			 * for private allocation by other entities
 			 */
@@ -135,6 +141,7 @@ BUFFER_FNS(Unwritten, unwritten)
 BUFFER_FNS(Meta, meta)
 BUFFER_FNS(Prio, prio)
 BUFFER_FNS(Defer_Completion, defer_completion)
+BUFFER_FNS(FirstForPage, first_for_page)
 
 #define bh_offset(bh)		((unsigned long)(bh)->b_data & ~PAGE_MASK)
 
@@ -278,11 +285,22 @@ void buffer_init(void);
  * inline definitions
  */
 
+/*
+ * bh_first_for_page - return first buffer_head for a page
+ * @bh: buffer_head for which we want the first buffer_head for same page
+ * Returns: first buffer_head within the same page as given buffer_head
+ */
+static inline struct buffer_head *bh_first_for_page(struct buffer_head *bh)
+{
+	return page_buffers(bh->b_page);
+}
+
 static inline void attach_page_buffers(struct page *page,
 		struct buffer_head *head)
 {
 	get_page(page);
 	SetPagePrivate(page);
+	set_buffer_first_for_page(head);
 	set_page_private(page, (unsigned long)head);
 }
 
-- 
2.14.3
