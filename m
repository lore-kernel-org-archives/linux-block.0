Return-Path: <SRS0=yWXY=D3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91616C43457
	for <linux-block@archiver.kernel.org>; Tue, 20 Oct 2020 08:53:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32A95222C8
	for <linux-block@archiver.kernel.org>; Tue, 20 Oct 2020 08:53:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LSLq76+Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389700AbgJTIxb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Oct 2020 04:53:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:54625 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389671AbgJTIxb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Oct 2020 04:53:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603184010;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4oDUZuYctKO2IhywzwXf/gS+GjO9UXFqR9rKJje1jxs=;
        b=LSLq76+Zn+Xa0R/y9GLsM7QLlyjkHRF573qD03hnhuXmp+4KyrrK+9ACDc0EM86X17TQ8h
        EniYeDmp2yMF+Rjdf50/ue1HrwKbtpPKZu4N6qp7i0Tomx/YRP4T3qlZRC8kQN3DSaxw7h
        +p7gDkrP/JMpjjE8otvU4EbbAPaXo98=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-22-wvrevCDwPfS8odjO8FIEtQ-1; Tue, 20 Oct 2020 04:53:26 -0400
X-MC-Unique: wvrevCDwPfS8odjO8FIEtQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C1DFA1006C8B;
        Tue, 20 Oct 2020 08:53:24 +0000 (UTC)
Received: from localhost (ovpn-12-164.pek2.redhat.com [10.72.12.164])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 01FDB27CDC;
        Tue, 20 Oct 2020 08:53:17 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>
Cc:     Ming Lei <ming.lei@redhat.com>, Chao Leng <lengchao@huawei.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Yi Zhang <yi.zhang@redhat.com>
Subject: [PATCH V2 1/4] blk-mq: check rq->state explicitly in blk_mq_tagset_count_completed_rqs
Date:   Tue, 20 Oct 2020 16:52:58 +0800
Message-Id: <20201020085301.1553959-2-ming.lei@redhat.com>
In-Reply-To: <20201020085301.1553959-1-ming.lei@redhat.com>
References: <20201020085301.1553959-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

blk_mq_tagset_count_completed_rqs() is called from
blk_mq_tagset_wait_completed_request() for draining requests being
completed remotely. What we need to do is to make sure that request->state
is switched to non-MQ_RQ_COMPLETE.

So check MQ_RQ_COMPLETE explicitly in blk_mq_tagset_count_completed_rqs().

Meantime mark flush request as IDLE in its .end_io() for aligning to
end normal request because flush request may stay in inflight tags in case
of !elevator, so we need to change its state into IDLE.

Cc: Chao Leng <lengchao@huawei.com>
Cc: Sagi Grimberg <sagi@grimberg.me>
Reported-by: Yi Zhang <yi.zhang@redhat.com>
Tested-by: Yi Zhang <yi.zhang@redhat.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-flush.c  | 2 ++
 block/blk-mq-tag.c | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/block/blk-flush.c b/block/blk-flush.c
index 53abb5c73d99..f6a07ae533c9 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -231,6 +231,8 @@ static void flush_end_io(struct request *flush_rq, blk_status_t error)
 		return;
 	}
 
+	WRITE_ONCE(flush_rq->state, MQ_RQ_IDLE);
+
 	if (fq->rq_status != BLK_STS_OK)
 		error = fq->rq_status;
 
diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 9c92053e704d..10ff8968b93b 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -367,7 +367,7 @@ static bool blk_mq_tagset_count_completed_rqs(struct request *rq,
 {
 	unsigned *count = data;
 
-	if (blk_mq_request_completed(rq))
+	if (blk_mq_rq_state(rq) == MQ_RQ_COMPLETE)
 		(*count)++;
 	return true;
 }
-- 
2.25.2

