Return-Path: <baijiaju1990@gmail.com>
Return-Path: <baijiaju1990@gmail.com>
From: Jia-Ju Bai <baijiaju1990@gmail.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH 2/2] block: blk-tag: Replace GFP_ATOMIC with GFP_KERNEL in init_tag_map
Date: Thu, 25 Jan 2018 11:38:56 +0800
Message-Id: <1516851536-6871-1-git-send-email-baijiaju1990@gmail.com>
List-ID: <linux-block@vger.kernel.org>

After checking all possible call chains to init_tag_map here,
my tool finds that init_tag_map is never called in atomic context.
Thus GFP_ATOMIC is not necessary, and it can be replaced with GFP_KERNEL.

This is found by a static analysis tool named DCNS written by myself.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 block/blk-tag.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/blk-tag.c b/block/blk-tag.c
index 09f19c6..177b6d1 100644
--- a/block/blk-tag.c
+++ b/block/blk-tag.c
@@ -99,12 +99,12 @@ void blk_queue_free_tags(struct request_queue *q)
 		       __func__, depth);
 	}
 
-	tag_index = kzalloc(depth * sizeof(struct request *), GFP_ATOMIC);
+	tag_index = kzalloc(depth * sizeof(struct request *), GFP_KERNEL);
 	if (!tag_index)
 		goto fail;
 
 	nr_ulongs = ALIGN(depth, BITS_PER_LONG) / BITS_PER_LONG;
-	tag_map = kzalloc(nr_ulongs * sizeof(unsigned long), GFP_ATOMIC);
+	tag_map = kzalloc(nr_ulongs * sizeof(unsigned long), GFP_KERNEL);
 	if (!tag_map)
 		goto fail;
 
-- 
1.7.9.5
