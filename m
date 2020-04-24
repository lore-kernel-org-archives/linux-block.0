Return-Path: <SRS0=nYW3=6I=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FD8AC54FCB
	for <linux-block@archiver.kernel.org>; Fri, 24 Apr 2020 10:24:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 080E620736
	for <linux-block@archiver.kernel.org>; Fri, 24 Apr 2020 10:24:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EJdYFp+b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbgDXKYi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 24 Apr 2020 06:24:38 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:20227 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726806AbgDXKYi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Apr 2020 06:24:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587723877;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Jy6SeT6VWkIZDXssfD8JdG74CdKwrZPo+WBzzDlVJSA=;
        b=EJdYFp+bW3A3Z1nsWRaYI4JuhJn6E44yGsZzjks+Xi3T7YPbN/ZJJq/As7qreTeUsGEiQB
        gUO9Z0kKZlrjyhA0SQA9Wh4r45/bPG2bdood7fbBEyE7mZtneVwI7MKoCIUw2O3cosf7Ce
        7iLEg5gO3yNPGG63KiT04bonFHZOBpA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-13-LEo5JnkSOCGtodYHyKQQKg-1; Fri, 24 Apr 2020 06:24:33 -0400
X-MC-Unique: LEo5JnkSOCGtodYHyKQQKg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D4D1264AD9;
        Fri, 24 Apr 2020 10:24:31 +0000 (UTC)
Received: from localhost (ovpn-8-38.pek2.redhat.com [10.72.8.38])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8E3A55D9D3;
        Fri, 24 Apr 2020 10:24:28 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH V8 03/11] blk-mq: mark blk_mq_get_driver_tag as static
Date:   Fri, 24 Apr 2020 18:23:43 +0800
Message-Id: <20200424102351.475641-4-ming.lei@redhat.com>
In-Reply-To: <20200424102351.475641-1-ming.lei@redhat.com>
References: <20200424102351.475641-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Now all callers of blk_mq_get_driver_tag are in blk-mq.c, so mark
it as static.

Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: John Garry <john.garry@huawei.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 2 +-
 block/blk-mq.h | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index a7785df2c944..79267f2e8960 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1027,7 +1027,7 @@ static inline unsigned int queued_to_index(unsigned=
 int queued)
 	return min(BLK_MQ_MAX_DISPATCH_ORDER - 1, ilog2(queued) + 1);
 }
=20
-bool blk_mq_get_driver_tag(struct request *rq)
+static bool blk_mq_get_driver_tag(struct request *rq)
 {
 	struct blk_mq_alloc_data data =3D {
 		.q =3D rq->q,
diff --git a/block/blk-mq.h b/block/blk-mq.h
index 10bfdfb494fa..e7d1da4b1f73 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -44,7 +44,6 @@ bool blk_mq_dispatch_rq_list(struct request_queue *, st=
ruct list_head *, bool);
 void blk_mq_add_to_requeue_list(struct request *rq, bool at_head,
 				bool kick_requeue_list);
 void blk_mq_flush_busy_ctxs(struct blk_mq_hw_ctx *hctx, struct list_head=
 *list);
-bool blk_mq_get_driver_tag(struct request *rq);
 struct request *blk_mq_dequeue_from_ctx(struct blk_mq_hw_ctx *hctx,
 					struct blk_mq_ctx *start);
=20
--=20
2.25.2

