Return-Path: <sagi@grimberg.me>
From: Sagi Grimberg <sagi@grimberg.me>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH] blk-mq: Fix tagset reinit in the presence of cpu hot-unplug
Date: Mon, 13 Mar 2017 16:10:11 +0200
Message-Id: <1489414211-30437-1-git-send-email-sagi@grimberg.me>
List-ID: <linux-block@vger.kernel.org>

In case cpu was unplugged, we need to make sure not to assume
that the tags for that cpu are still allocated. so check
for null tags when reinitializing a tagset.

Reported-by: Yi Zhang <yizhan@redhat.com>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 block/blk-mq-tag.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index e48bc2c72615..9d97bfc4d465 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -295,6 +295,9 @@ int blk_mq_reinit_tagset(struct blk_mq_tag_set *set)
 	for (i = 0; i < set->nr_hw_queues; i++) {
 		struct blk_mq_tags *tags = set->tags[i];
 
+		if (!tags)
+			continue;
+
 		for (j = 0; j < tags->nr_tags; j++) {
 			if (!tags->static_rqs[j])
 				continue;
-- 
2.7.4
