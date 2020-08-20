Return-Path: <SRS0=Z7Y6=B6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B1C9C433DF
	for <linux-block@archiver.kernel.org>; Thu, 20 Aug 2020 18:04:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 196D020758
	for <linux-block@archiver.kernel.org>; Thu, 20 Aug 2020 18:04:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GcnZfdr0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbgHTSEC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Aug 2020 14:04:02 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:20039 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725819AbgHTSEB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Aug 2020 14:04:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597946640;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ty6cDUgncqJhmr9uZX9K42afGHpqzuZGxNGcoZPaJpw=;
        b=GcnZfdr0nmULbGgJ84WACJMfDq8Q1c5FwYyoOcreIPcKUYoEulMaJhK2e+EyWGNmnEvKB4
        r15IfG20cTLEOc1Me23ulcteqMkEadL7nhLs0pjqricAW83/ee1JYiM4N8o9g7uRgCLXTA
        1zq/K/L1pgnH8E6b/HYbbeEs2bhD1hU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-283-TQpHYkzONN-Uy04unaF-pQ-1; Thu, 20 Aug 2020 14:03:56 -0400
X-MC-Unique: TQpHYkzONN-Uy04unaF-pQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 843428030C8;
        Thu, 20 Aug 2020 18:03:55 +0000 (UTC)
Received: from localhost (ovpn-12-36.pek2.redhat.com [10.72.12.36])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E492E74E08;
        Thu, 20 Aug 2020 18:03:51 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Hannes Reinecke <hare@suse.de>,
        Bart Van Assche <bvanassche@acm.org>,
        John Garry <john.garry@huawei.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH 1/5] blk-mq: define max_order for allocating rqs pages as macro
Date:   Fri, 21 Aug 2020 02:03:31 +0800
Message-Id: <20200820180335.3109216-2-ming.lei@redhat.com>
In-Reply-To: <20200820180335.3109216-1-ming.lei@redhat.com>
References: <20200820180335.3109216-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Inside blk_mq_alloc_rqs(), 'max_order' is actually one const local
variable, define it as macro, and this macro will be re-used
in following patch.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Bart Van Assche <bvanassche@acm.org>
Cc: John Garry <john.garry@huawei.com>
Cc: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 77d885805699..f9da2d803c18 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2360,10 +2360,12 @@ static int blk_mq_init_request(struct blk_mq_tag_set *set, struct request *rq,
 	return 0;
 }
 
+#define MAX_RQS_PAGE_ORDER 4
+
 int blk_mq_alloc_rqs(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
 		     unsigned int hctx_idx, unsigned int depth)
 {
-	unsigned int i, j, entries_per_page, max_order = 4;
+	unsigned int i, j, entries_per_page;
 	size_t rq_size, left;
 	int node;
 
@@ -2382,7 +2384,7 @@ int blk_mq_alloc_rqs(struct blk_mq_tag_set *set, struct blk_mq_tags *tags,
 	left = rq_size * depth;
 
 	for (i = 0; i < depth; ) {
-		int this_order = max_order;
+		int this_order = MAX_RQS_PAGE_ORDER;
 		struct page *page;
 		int to_do;
 		void *p;
-- 
2.25.2

