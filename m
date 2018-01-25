Return-Path: <baijiaju1990@gmail.com>
Return-Path: <baijiaju1990@gmail.com>
From: Jia-Ju Bai <baijiaju1990@gmail.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH 1/2] block: blk-tag: Replace GFP_ATOMIC with GFP_KERNEL in __blk_queue_init_tags
Date: Thu, 25 Jan 2018 11:38:45 +0800
Message-Id: <1516851525-6828-1-git-send-email-baijiaju1990@gmail.com>
List-ID: <linux-block@vger.kernel.org>

After checking all possible call chains to kmalloc here,
my tool finds that kmalloc is never called in atomic context.
Thus GFP_ATOMIC is not necessary, and it can be replaced with GFP_KERNEL.

This is found by a static analysis tool named DCNS written by myself.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 block/blk-tag.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-tag.c b/block/blk-tag.c
index 09f19c6..84db7f663 100644
--- a/block/blk-tag.c
+++ b/block/blk-tag.c
@@ -124,7 +124,7 @@ static struct blk_queue_tag *__blk_queue_init_tags(struct request_queue *q,
 {
 	struct blk_queue_tag *tags;
 
-	tags = kmalloc(sizeof(struct blk_queue_tag), GFP_ATOMIC);
+	tags = kmalloc(sizeof(struct blk_queue_tag), GFP_KERNEL);
 	if (!tags)
 		goto fail;
 
-- 
1.7.9.5
