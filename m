Return-Path: <SRS0=xbel=O2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31834C43387
	for <linux-block@archiver.kernel.org>; Mon, 17 Dec 2018 17:29:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0963620675
	for <linux-block@archiver.kernel.org>; Mon, 17 Dec 2018 17:29:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727478AbeLQR3C (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Dec 2018 12:29:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39512 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726436AbeLQR3C (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Dec 2018 12:29:02 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 48F3681138;
        Mon, 17 Dec 2018 17:29:02 +0000 (UTC)
Received: from localhost (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 690A91019630;
        Mon, 17 Dec 2018 17:29:01 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Jeff Moyer <jmoyer@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH] blk-mq: skip zero-queue maps in blk_mq_map_swqueue
Date:   Tue, 18 Dec 2018 01:28:56 +0800
Message-Id: <20181217172856.14743-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Mon, 17 Dec 2018 17:29:02 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From 7e849dd9cf37 ("nvme-pci: don't share queue maps"), the mapping
table won't be initialized actually if map->nr_queues is zero, so
we can't use blk_mq_map_queue_type() to retrieve hctx any more.

This way still may cause broken mapping, fix it by skipping zero-queues
maps in blk_mq_map_swqueue().

Cc: Jeff Moyer <jmoyer@redhat.com>
Cc: Mike Snitzer <snitzer@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 17de117be019..8075b16c5228 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2433,6 +2433,9 @@ static void blk_mq_map_swqueue(struct request_queue *q)
 
 		ctx = per_cpu_ptr(q->queue_ctx, i);
 		for (j = 0; j < set->nr_maps; j++) {
+			if (!set->map[j].nr_queues)
+				continue;
+
 			hctx = blk_mq_map_queue_type(q, j, i);
 
 			/*
-- 
2.9.5

