Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9AD8C636D4
	for <linux-block@archiver.kernel.org>; Fri, 17 Feb 2023 09:29:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbjBQJ3U (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 17 Feb 2023 04:29:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbjBQJ3T (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Feb 2023 04:29:19 -0500
Received: from smtp.smtpout.orange.fr (smtp-11.smtpout.orange.fr [80.12.242.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6C2D5EC8B
        for <linux-block@vger.kernel.org>; Fri, 17 Feb 2023 01:29:17 -0800 (PST)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id Sx3Lp87Ho71C0Sx3LpPVzN; Fri, 17 Feb 2023 10:29:15 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Fri, 17 Feb 2023 10:29:15 +0100
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-block@vger.kernel.org
Subject: [PATCH] blk-mq: Reorder fields in 'struct blk_mq_tag_set'
Date:   Fri, 17 Feb 2023 10:29:10 +0100
Message-Id: <6f249f9b02a3490283ef0278096556de41aa0cf0.1676626130.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Group some variables based on their sizes to reduce hole and avoid padding.
On x86_64, this shrinks the size of 'struct blk_mq_tag_set'
from 304 to 296 bytes.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Using pahole

Before:
======
struct blk_mq_tag_set {
	struct blk_mq_queue_map    map[3];               /*     0    48 */
	unsigned int               nr_maps;              /*    48     4 */

	/* XXX 4 bytes hole, try to pack */

	const struct blk_mq_ops  * ops;                  /*    56     8 */
	/* --- cacheline 1 boundary (64 bytes) --- */
	unsigned int               nr_hw_queues;         /*    64     4 */
	unsigned int               queue_depth;          /*    68     4 */
	unsigned int               reserved_tags;        /*    72     4 */
	unsigned int               cmd_size;             /*    76     4 */
	int                        numa_node;            /*    80     4 */
	unsigned int               timeout;              /*    84     4 */
	unsigned int               flags;                /*    88     4 */

	/* XXX 4 bytes hole, try to pack */

	void *                     driver_data;          /*    96     8 */
	struct blk_mq_tags * *     tags;                 /*   104     8 */
	struct blk_mq_tags *       shared_tags;          /*   112     8 */
	struct mutex               tag_list_lock;        /*   120   160 */
	/* --- cacheline 4 boundary (256 bytes) was 24 bytes ago --- */
	struct list_head           tag_list;             /*   280    16 */
	struct srcu_struct *       srcu;                 /*   296     8 */

	/* size: 304, cachelines: 5, members: 16 */
	/* sum members: 296, holes: 2, sum holes: 8 */
	/* last cacheline: 48 bytes */
};

After:
=====
struct blk_mq_tag_set {
	const struct blk_mq_ops  * ops;                  /*     0     8 */
	struct blk_mq_queue_map    map[3];               /*     8    48 */
	unsigned int               nr_maps;              /*    56     4 */
	unsigned int               nr_hw_queues;         /*    60     4 */
	/* --- cacheline 1 boundary (64 bytes) --- */
	unsigned int               queue_depth;          /*    64     4 */
	unsigned int               reserved_tags;        /*    68     4 */
	unsigned int               cmd_size;             /*    72     4 */
	int                        numa_node;            /*    76     4 */
	unsigned int               timeout;              /*    80     4 */
	unsigned int               flags;                /*    84     4 */
	void *                     driver_data;          /*    88     8 */
	struct blk_mq_tags * *     tags;                 /*    96     8 */
	struct blk_mq_tags *       shared_tags;          /*   104     8 */
	struct mutex               tag_list_lock;        /*   112   160 */
	/* --- cacheline 4 boundary (256 bytes) was 16 bytes ago --- */
	struct list_head           tag_list;             /*   272    16 */
	struct srcu_struct *       srcu;                 /*   288     8 */

	/* size: 296, cachelines: 5, members: 16 */
	/* last cacheline: 40 bytes */
};
---
 include/linux/blk-mq.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 779fba613bd0..dd5ce1137f04 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -473,6 +473,7 @@ enum hctx_type {
 
 /**
  * struct blk_mq_tag_set - tag set that can be shared between request queues
+ * @ops:	   Pointers to functions that implement block driver behavior.
  * @map:	   One or more ctx -> hctx mappings. One map exists for each
  *		   hardware queue type (enum hctx_type) that the driver wishes
  *		   to support. There are no restrictions on maps being of the
@@ -480,7 +481,6 @@ enum hctx_type {
  *		   types.
  * @nr_maps:	   Number of elements in the @map array. A number in the range
  *		   [1, HCTX_MAX_TYPES].
- * @ops:	   Pointers to functions that implement block driver behavior.
  * @nr_hw_queues:  Number of hardware queues supported by the block driver that
  *		   owns this data structure.
  * @queue_depth:   Number of tags per hardware queue, reserved tags included.
@@ -505,9 +505,9 @@ enum hctx_type {
  *		   (BLK_MQ_F_BLOCKING).
  */
 struct blk_mq_tag_set {
+	const struct blk_mq_ops	*ops;
 	struct blk_mq_queue_map	map[HCTX_MAX_TYPES];
 	unsigned int		nr_maps;
-	const struct blk_mq_ops	*ops;
 	unsigned int		nr_hw_queues;
 	unsigned int		queue_depth;
 	unsigned int		reserved_tags;
-- 
2.34.1

