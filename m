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
Subject: [RFC PATCH 31/79] fs/block: add struct address_space to __block_write_begin_int() args
Date: Wed,  4 Apr 2018 15:18:05 -0400
Message-Id: <20180404191831.5378-16-jglisse@redhat.com>
In-Reply-To: <20180404191831.5378-1-jglisse@redhat.com>
References: <20180404191831.5378-1-jglisse@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

From: Jérôme Glisse <jglisse@redhat.com>

Add struct address_space to __block_write_begin_int() arguments.

One step toward dropping reliance on page->mapping.

----------------------------------------------------------------------
@exists@
identifier M;
expression E1, E2, E3, E4, E5;
@@
struct address_space *M;
...
-__block_write_begin_int(E1, E2, E3, E4, E5)
+__block_write_begin_int(M, E1, E2, E3, E4, E5)

@exists@
identifier M, F;
expression E1, E2, E3, E4, E5;
@@
F(..., struct address_space *M, ...) {...
-__block_write_begin_int(E1, E2, E3, E4, E5)
+__block_write_begin_int(M, E1, E2, E3, E4, E5)
...}
----------------------------------------------------------------------

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
 fs/buffer.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index de16588d7f7f..c83878d0a4c0 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -1943,8 +1943,9 @@ iomap_to_bh(struct inode *inode, sector_t block, struct buffer_head *bh,
 	}
 }
 
-int __block_write_begin_int(struct page *page, loff_t pos, unsigned len,
-		get_block_t *get_block, struct iomap *iomap)
+int __block_write_begin_int(struct address_space *mapping, struct page *page,
+		loff_t pos, unsigned len, get_block_t *get_block,
+		struct iomap *iomap)
 {
 	unsigned from = pos & (PAGE_SIZE - 1);
 	unsigned to = from + len;
@@ -2031,7 +2032,8 @@ int __block_write_begin_int(struct page *page, loff_t pos, unsigned len,
 int __block_write_begin(struct address_space *mapping, struct page *page,
 		loff_t pos, unsigned len, get_block_t *get_block)
 {
-	return __block_write_begin_int(page, pos, len, get_block, NULL);
+	return __block_write_begin_int(mapping, page, pos, len, get_block,
+				       NULL);
 }
 EXPORT_SYMBOL(__block_write_begin);
 
-- 
2.14.3
