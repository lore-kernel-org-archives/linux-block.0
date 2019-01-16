Return-Path: <SRS0=7Bp6=PY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9DDBC43387
	for <linux-block@archiver.kernel.org>; Wed, 16 Jan 2019 11:08:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 888C020657
	for <linux-block@archiver.kernel.org>; Wed, 16 Jan 2019 11:08:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732343AbfAPLIX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Jan 2019 06:08:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35612 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726546AbfAPLIX (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Jan 2019 06:08:23 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8F24DB98DB;
        Wed, 16 Jan 2019 11:08:23 +0000 (UTC)
Received: from localhost (ovpn-8-20.pek2.redhat.com [10.72.8.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BDB6B60FC8;
        Wed, 16 Jan 2019 11:08:18 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCH] block: don't lose track of REQ_INTEGRITY flag
Date:   Wed, 16 Jan 2019 19:08:15 +0800
Message-Id: <20190116110815.9557-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Wed, 16 Jan 2019 11:08:23 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We need to pass bio->bi_opf after bio intergrity preparing, otherwise
the flag of REQ_INTEGRITY may not be set on the allocated request, then
breaks block integrity.

Fixes: f9afca4d367b ("blk-mq: pass in request/bio flags to queue mapping")
Cc: Hannes Reinecke <hare@suse.com>
Cc: Keith Busch <keith.busch@intel.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 3ba37b9e15e9..8f5b533764ca 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1906,7 +1906,7 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
 {
 	const int is_sync = op_is_sync(bio->bi_opf);
 	const int is_flush_fua = op_is_flush(bio->bi_opf);
-	struct blk_mq_alloc_data data = { .flags = 0, .cmd_flags = bio->bi_opf };
+	struct blk_mq_alloc_data data = { .flags = 0};
 	struct request *rq;
 	struct blk_plug *plug;
 	struct request *same_queue_rq = NULL;
@@ -1928,6 +1928,7 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
 
 	rq_qos_throttle(q, bio);
 
+	data.cmd_flags = bio->bi_opf;
 	rq = blk_mq_get_request(q, bio, &data);
 	if (unlikely(!rq)) {
 		rq_qos_cleanup(q, bio);
-- 
2.9.5

