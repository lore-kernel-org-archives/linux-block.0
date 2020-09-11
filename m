Return-Path: <SRS0=ap3D=CU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E6F3C43461
	for <linux-block@archiver.kernel.org>; Fri, 11 Sep 2020 10:42:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB6AF208FE
	for <linux-block@archiver.kernel.org>; Fri, 11 Sep 2020 10:42:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SpP5IxO/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725781AbgIKKmy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 11 Sep 2020 06:42:54 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:53872 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725768AbgIKKmx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Sep 2020 06:42:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599820972;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ouPWSsE8jznFKfgxcFegc7nzNcfkRv5747NYjLQh6iE=;
        b=SpP5IxO/JyJr2lAqgoqB5TEg8c2vOVr9Di1S7UtU+ES34z1uDrAp3K4Wz/jNCnXKx2x7DK
        GJ+YcodkWSLJJ77/1VsuU/fZLBG3arJt5u8CP3dArwjymdh6Gr1RNU88dvVN2QDouGUF1d
        Bq07PYdEtzNm6kPmQQwhK5+svbRn20U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-248-2PF8A-e6PEGzIIcnibhtfw-1; Fri, 11 Sep 2020 06:42:48 -0400
X-MC-Unique: 2PF8A-e6PEGzIIcnibhtfw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 28C7E2FD01;
        Fri, 11 Sep 2020 10:42:47 +0000 (UTC)
Received: from localhost (ovpn-13-69.pek2.redhat.com [10.72.13.69])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B806C7E8F1;
        Fri, 11 Sep 2020 10:42:43 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>
Cc:     Ming Lei <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.de>,
        David Milburn <dmilburn@redhat.com>,
        "Ewan D . Milne" <emilne@redhat.com>
Subject: [PATCH V2] blk-mq: always allow reserved allocation in hctx_may_queue
Date:   Fri, 11 Sep 2020 18:41:14 +0800
Message-Id: <20200911104114.163691-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

NVMe shares tagset between fabric queue and admin queue or between
connect_q and NS queue, so hctx_may_queue() can be called to allocate
request for these queues.

Tags can be reserved in these tagset. Before error recovery, there is
often lots of in-flight requests which can't be completed, and new
reserved request may be needed in error recovery path. However,
hctx_may_queue() can always return false because there is too many
in-flight requests which can't be completed during error handling.
Finally, everything can't move on.

Fix this issue by always allowing reserved tag allocation in
hctx_may_queue(). This ways is reasonable because reserved tag
suppose to be ready any time.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Cc: David Milburn <dmilburn@redhat.com>
Cc: Ewan D. Milne <emilne@redhat.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
V2:
	- remove 'reserved' local variable, as suggested by Christoph 

 block/blk-mq-tag.c | 3 ++-
 block/blk-mq.c     | 5 +++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index c31c4a0478a5..aacf10decdbd 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -76,7 +76,8 @@ void __blk_mq_tag_idle(struct blk_mq_hw_ctx *hctx)
 static int __blk_mq_get_tag(struct blk_mq_alloc_data *data,
 			    struct sbitmap_queue *bt)
 {
-	if (!data->q->elevator && !hctx_may_queue(data->hctx, bt))
+	if (!data->q->elevator && !(data->flags & BLK_MQ_REQ_RESERVED) &&
+			!hctx_may_queue(data->hctx, bt))
 		return BLK_MQ_NO_TAG;
 
 	if (data->shallow_depth)
diff --git a/block/blk-mq.c b/block/blk-mq.c
index ccb500e38008..fb609fc38cf5 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1153,10 +1153,11 @@ static bool __blk_mq_get_driver_tag(struct request *rq)
 	if (blk_mq_tag_is_reserved(rq->mq_hctx->sched_tags, rq->internal_tag)) {
 		bt = rq->mq_hctx->tags->breserved_tags;
 		tag_offset = 0;
+	} else {
+		if (!hctx_may_queue(rq->mq_hctx, bt))
+			return false;
 	}
 
-	if (!hctx_may_queue(rq->mq_hctx, bt))
-		return false;
 	tag = __sbitmap_queue_get(bt);
 	if (tag == BLK_MQ_NO_TAG)
 		return false;
-- 
2.25.2

