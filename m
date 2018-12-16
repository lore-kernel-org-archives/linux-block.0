Return-Path: <SRS0=nu7S=OZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A849C43387
	for <linux-block@archiver.kernel.org>; Sun, 16 Dec 2018 02:25:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAA782084D
	for <linux-block@archiver.kernel.org>; Sun, 16 Dec 2018 02:25:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728987AbeLPCZ4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 15 Dec 2018 21:25:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56362 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727403AbeLPCZ4 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 15 Dec 2018 21:25:56 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 47D7B8830E;
        Sun, 16 Dec 2018 02:25:56 +0000 (UTC)
Received: from localhost (ovpn-8-20.pek2.redhat.com [10.72.8.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2E3595D70A;
        Sun, 16 Dec 2018 02:25:49 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Jeff Moyer <jmoyer@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH 2/4] blk-mq: fix allocation for queue mapping table
Date:   Sun, 16 Dec 2018 10:25:15 +0800
Message-Id: <20181216022517.26650-3-ming.lei@redhat.com>
In-Reply-To: <20181216022517.26650-1-ming.lei@redhat.com>
References: <20181216022517.26650-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Sun, 16 Dec 2018 02:25:56 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Type of each element in queue mapping table is 'unsigned int,
intead of 'struct blk_mq_queue_map)', so fix it.

Cc: Jeff Moyer <jmoyer@redhat.com>
Cc: Mike Snitzer <snitzer@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 9690f4f8de7e..a4a0895dae65 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3023,7 +3023,7 @@ int blk_mq_alloc_tag_set(struct blk_mq_tag_set *set)
 	ret = -ENOMEM;
 	for (i = 0; i < set->nr_maps; i++) {
 		set->map[i].mq_map = kcalloc_node(nr_cpu_ids,
-						  sizeof(struct blk_mq_queue_map),
+						  sizeof(set->map[i].mq_map[0]),
 						  GFP_KERNEL, set->numa_node);
 		if (!set->map[i].mq_map)
 			goto out_free_mq_map;
-- 
2.9.5

