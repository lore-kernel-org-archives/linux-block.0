Return-Path: <SRS0=Z7Y6=B6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 190B6C433E4
	for <linux-block@archiver.kernel.org>; Thu, 20 Aug 2020 18:04:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D83B620FC3
	for <linux-block@archiver.kernel.org>; Thu, 20 Aug 2020 18:04:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BOU+fyc9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbgHTSEG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Aug 2020 14:04:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38378 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725819AbgHTSEE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Aug 2020 14:04:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597946643;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aRuOvVXOit+sTt/GX9gxcFe+1KQ7rUBZjwvjadOlvPM=;
        b=BOU+fyc9T/U8JPuNc6UhNmfnY6tHO2TIr8O1g0hnR2MSL3s+IhY+TDMNfDSnm29NX0uVi8
        5G77YRd9GkVC4QEuetn4q0r/VDjdJNuoagDq7rHO4AXkEzc1AnVrM3poB1jyLQ72GAmmla
        076gI4FyPjogilQB3VTLzQenObEckbY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-293-BJv-U2eDNJSXCCOTTRBfZg-1; Thu, 20 Aug 2020 14:03:59 -0400
X-MC-Unique: BJv-U2eDNJSXCCOTTRBfZg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7D34C8030BC;
        Thu, 20 Aug 2020 18:03:58 +0000 (UTC)
Received: from localhost (ovpn-12-36.pek2.redhat.com [10.72.12.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D62C039A55;
        Thu, 20 Aug 2020 18:03:57 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Hannes Reinecke <hare@suse.de>,
        Bart Van Assche <bvanassche@acm.org>,
        John Garry <john.garry@huawei.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH 2/5] blk-mq: add helper of blk_mq_get_hw_queue_node
Date:   Fri, 21 Aug 2020 02:03:32 +0800
Message-Id: <20200820180335.3109216-3-ming.lei@redhat.com>
In-Reply-To: <20200820180335.3109216-1-ming.lei@redhat.com>
References: <20200820180335.3109216-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add helper of blk_mq_get_hw_queue_node for retrieve hw queue's numa
node.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Bart Van Assche <bvanassche@acm.org>
Cc: John Garry <john.garry@huawei.com>
Cc: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index f9da2d803c18..5019d21e7ff8 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2263,6 +2263,18 @@ blk_qc_t blk_mq_submit_bio(struct bio *bio)
 }
 EXPORT_SYMBOL_GPL(blk_mq_submit_bio); /* only for request based dm */
 
+static int blk_mq_get_hw_queue_node(struct blk_mq_tag_set *set,
+		unsigned int hctx_idx)
+{
+	int node = blk_mq_hw_queue_to_node(&set->map[HCTX_TYPE_DEFAULT],
+			hctx_idx);
+
+	if (node == NUMA_NO_NODE)
+		node = set->numa_node;
+
+	return node;
+}
+
 void blk_mq_free_rqs(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
 		     unsigned int hctx_idx)
 {
@@ -2309,11 +2321,7 @@ struct blk_mq_tags *blk_mq_alloc_rq_map(struct blk_mq_tag_set *set,
 					unsigned int reserved_tags)
 {
 	struct blk_mq_tags *tags;
-	int node;
-
-	node = blk_mq_hw_queue_to_node(&set->map[HCTX_TYPE_DEFAULT], hctx_idx);
-	if (node == NUMA_NO_NODE)
-		node = set->numa_node;
+	int node = blk_mq_get_hw_queue_node(set, hctx_idx);
 
 	tags = blk_mq_init_tags(nr_tags, reserved_tags, node,
 				BLK_MQ_FLAG_TO_ALLOC_POLICY(set->flags));
@@ -2367,11 +2375,7 @@ int blk_mq_alloc_rqs(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
 {
 	unsigned int i, j, entries_per_page;
 	size_t rq_size, left;
-	int node;
-
-	node = blk_mq_hw_queue_to_node(&set->map[HCTX_TYPE_DEFAULT], hctx_idx);
-	if (node == NUMA_NO_NODE)
-		node = set->numa_node;
+	int node = blk_mq_get_hw_queue_node(set, hctx_idx);
 
 	INIT_LIST_HEAD(&tags->page_list);
 
-- 
2.25.2

