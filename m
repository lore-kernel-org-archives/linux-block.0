Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:36470 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932642AbcL0QFt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Dec 2016 11:05:49 -0500
From: Ming Lei <tom.leiming@gmail.com>
To: Jens Axboe <axboe@fb.com>, linux-kernel@vger.kernel.org
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Ming Lei <tom.leiming@gmail.com>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Shaohua Li <shli@kernel.org>, Hannes Reinecke <hare@suse.com>,
        Takashi Iwai <tiwai@suse.de>, Jiri Kosina <jkosina@suse.cz>,
        Mike Christie <mchristi@redhat.com>,
        Guoqing Jiang <gqjiang@suse.com>,
        Zheng Liu <gnehzuil.liu@gmail.com>,
        linux-bcache@vger.kernel.org (open list:BCACHE (BLOCK LAYER CACHE)),
        linux-raid@vger.kernel.org (open list:SOFTWARE RAID (Multiple Disks)
        SUPPORT)
Subject: [PATCH v1 35/54] bcache: convert to bio_for_each_segment_all_sp()
Date: Wed, 28 Dec 2016 00:04:44 +0800
Message-Id: <1482854706-14128-4-git-send-email-tom.leiming@gmail.com>
In-Reply-To: <1482854706-14128-1-git-send-email-tom.leiming@gmail.com>
References: <1482854706-14128-1-git-send-email-tom.leiming@gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 drivers/md/bcache/btree.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/md/bcache/btree.c b/drivers/md/bcache/btree.c
index fc35cfb4d0f1..61d40b1903f3 100644
--- a/drivers/md/bcache/btree.c
+++ b/drivers/md/bcache/btree.c
@@ -419,8 +419,9 @@ static void do_btree_node_write(struct btree *b)
 		int j;
 		struct bio_vec *bv;
 		void *base = (void *) ((unsigned long) i & ~(PAGE_SIZE - 1));
+		struct bvec_iter_all bia;
 
-		bio_for_each_segment_all(bv, b->bio, j)
+		bio_for_each_segment_all_sp(bv, b->bio, j, bia)
 			memcpy(page_address(bv->bv_page),
 			       base + j * PAGE_SIZE, PAGE_SIZE);
 
-- 
2.7.4

