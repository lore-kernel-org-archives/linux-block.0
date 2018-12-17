Return-Path: <SRS0=xbel=O2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E164AC43387
	for <linux-block@archiver.kernel.org>; Mon, 17 Dec 2018 10:43:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF7762145D
	for <linux-block@archiver.kernel.org>; Mon, 17 Dec 2018 10:43:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726972AbeLQKnJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Dec 2018 05:43:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33916 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726911AbeLQKnJ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Dec 2018 05:43:09 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C33D181DE9;
        Mon, 17 Dec 2018 10:43:08 +0000 (UTC)
Received: from localhost (ovpn-8-31.pek2.redhat.com [10.72.8.31])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D5A2D1883F;
        Mon, 17 Dec 2018 10:43:00 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Jeff Moyer <jmoyer@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH V2 1/4] blk-mq: fix allocation for queue mapping table
Date:   Mon, 17 Dec 2018 18:42:45 +0800
Message-Id: <20181217104248.5828-2-ming.lei@redhat.com>
In-Reply-To: <20181217104248.5828-1-ming.lei@redhat.com>
References: <20181217104248.5828-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Mon, 17 Dec 2018 10:43:09 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Type of each element in queue mapping table is 'unsigned int,
intead of 'struct blk_mq_queue_map)', so fix it.

Cc: Jeff Moyer <jmoyer@redhat.com>
Cc: Mike Snitzer <snitzer@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 2d3a29eb58ca..313f28b2d079 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3019,7 +3019,7 @@ int blk_mq_alloc_tag_set(struct blk_mq_tag_set *set)
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

