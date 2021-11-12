Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1BD4C433EF
	for <linux-block@archiver.kernel.org>; Fri, 12 Nov 2021 08:12:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4A1A60EC0
	for <linux-block@archiver.kernel.org>; Fri, 12 Nov 2021 08:12:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbhKLIO7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 12 Nov 2021 03:14:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:20561 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231173AbhKLIO7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 Nov 2021 03:14:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636704728;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Aq5ywiUXPmj6zdOBrFh0JQbEf0TDyDer72qthYrVBK4=;
        b=ZdYDpzYmuGCrtVBV13YZPmVC8ZPw+coklyzWph86s4WmCsOd7V+USwRb34BciNHZIwpDkb
        NqmYgA1AiG3+f8Qrnc14nv4Yma0+OWm394GdzgWrCOfdePIs6ULH56VJTxIiJveakmKmXT
        VzuaYVnssRs5QCUDA6x3BNPaTMe8uJE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-142-y1UqtXnnOYG2Jg33hEtZvg-1; Fri, 12 Nov 2021 03:12:07 -0500
X-MC-Unique: y1UqtXnnOYG2Jg33hEtZvg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 447021922960;
        Fri, 12 Nov 2021 08:12:06 +0000 (UTC)
Received: from localhost (ovpn-8-32.pek2.redhat.com [10.72.8.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0B2505BAE2;
        Fri, 12 Nov 2021 08:11:57 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH] blk-mq: setup blk_mq_alloc_data.cmd_flags after submit_bio_checks() is done
Date:   Fri, 12 Nov 2021 16:11:37 +0800
Message-Id: <20211112081137.406930-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

submit_bio_checks() may update bio->bi_opf, so we have to initialize
blk_mq_alloc_data.cmd_flags after submit_bio_checks() returns when
allocating new requests.

In case of using cached request, fallback to allocate new request if
cached rq's cmd_flags isn't same with bio->bi_opf after
submit_bio_checks().

Fixes: 900e080752025f00 ("block: move queue enter logic into blk_mq_submit_bio()")
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index f511db395c7f..f84044c8de3f 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2517,7 +2517,6 @@ static struct request *blk_mq_get_new_requests(struct request_queue *q,
 	struct blk_mq_alloc_data data = {
 		.q		= q,
 		.nr_tags	= 1,
-		.cmd_flags	= bio->bi_opf,
 	};
 	struct request *rq;
 
@@ -2525,6 +2524,7 @@ static struct request *blk_mq_get_new_requests(struct request_queue *q,
 		return NULL;
 	if (unlikely(!submit_bio_checks(bio)))
 		goto put_exit;
+	data.cmd_flags	= bio->bi_opf;
 	if (blk_mq_attempt_bio_merge(q, bio, nsegs, same_queue_rq))
 		goto put_exit;
 
@@ -2564,13 +2564,15 @@ static inline struct request *blk_mq_get_request(struct request_queue *q,
 			if (blk_mq_attempt_bio_merge(q, bio, nsegs,
 						same_queue_rq))
 				return NULL;
+			if (bio->bi_opf != rq->cmd_flags)
+				goto fallback;
 			plug->cached_rq = rq_list_next(rq);
 			INIT_LIST_HEAD(&rq->queuelist);
 			rq_qos_throttle(q, bio);
 			return rq;
 		}
 	}
-
+fallback:
 	return blk_mq_get_new_requests(q, plug, bio, nsegs, same_queue_rq);
 }
 
-- 
2.31.1

