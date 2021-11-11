Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EF67C433F5
	for <linux-block@archiver.kernel.org>; Thu, 11 Nov 2021 08:53:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4254861108
	for <linux-block@archiver.kernel.org>; Thu, 11 Nov 2021 08:53:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbhKKIz4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Nov 2021 03:55:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41035 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232531AbhKKIzz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Nov 2021 03:55:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636620786;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5kc9pT/tLYhZ/5mTa/eyqUsNxJ5D/hyH8C1DbRIhIXo=;
        b=FuY2e6iftCZZi9NwQYM4T0JE0KS41I0sg8IFcpYSaBOA9OHlTkZpcRJjEHc431o90NscMm
        uS01XZKl2hX5P60ViXCa8AGEqViCsfKE/gIdLv4tnM8DASYIFTl2KkKZ9wXddpSkqUJ4s/
        Rtk4lFfzeWkIlyDlAdTa03lDLTgf1gU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-497-3mociXAIO1mf9vlRhzG2gg-1; Thu, 11 Nov 2021 03:53:02 -0500
X-MC-Unique: 3mociXAIO1mf9vlRhzG2gg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C85A7804146;
        Thu, 11 Nov 2021 08:53:01 +0000 (UTC)
Received: from localhost (ovpn-8-28.pek2.redhat.com [10.72.8.28])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 672E97945B;
        Thu, 11 Nov 2021 08:52:33 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH 2/2] blk-mq: rename blk_attempt_bio_merge
Date:   Thu, 11 Nov 2021 16:51:34 +0800
Message-Id: <20211111085134.345235-3-ming.lei@redhat.com>
In-Reply-To: <20211111085134.345235-1-ming.lei@redhat.com>
References: <20211111085134.345235-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

It is very annoying to have two block layer functions which share same
name, so rename blk_attempt_bio_merge in blk-mq.c as
blk_mq_attempt_bio_merge.

Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 629cf421417f..f511db395c7f 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2495,8 +2495,9 @@ static inline unsigned short blk_plug_max_rq_count(struct blk_plug *plug)
 	return BLK_MAX_REQUEST_COUNT;
 }
 
-static bool blk_attempt_bio_merge(struct request_queue *q, struct bio *bio,
-				  unsigned int nr_segs, bool *same_queue_rq)
+static bool blk_mq_attempt_bio_merge(struct request_queue *q,
+				     struct bio *bio, unsigned int nr_segs,
+				     bool *same_queue_rq)
 {
 	if (!blk_queue_nomerges(q) && bio_mergeable(bio)) {
 		if (blk_attempt_plug_merge(q, bio, nr_segs, same_queue_rq))
@@ -2524,7 +2525,7 @@ static struct request *blk_mq_get_new_requests(struct request_queue *q,
 		return NULL;
 	if (unlikely(!submit_bio_checks(bio)))
 		goto put_exit;
-	if (blk_attempt_bio_merge(q, bio, nsegs, same_queue_rq))
+	if (blk_mq_attempt_bio_merge(q, bio, nsegs, same_queue_rq))
 		goto put_exit;
 
 	rq_qos_throttle(q, bio);
@@ -2560,7 +2561,8 @@ static inline struct request *blk_mq_get_request(struct request_queue *q,
 		if (rq && rq->q == q) {
 			if (unlikely(!submit_bio_checks(bio)))
 				return NULL;
-			if (blk_attempt_bio_merge(q, bio, nsegs, same_queue_rq))
+			if (blk_mq_attempt_bio_merge(q, bio, nsegs,
+						same_queue_rq))
 				return NULL;
 			plug->cached_rq = rq_list_next(rq);
 			INIT_LIST_HEAD(&rq->queuelist);
-- 
2.31.1

