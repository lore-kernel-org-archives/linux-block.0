Return-Path: <SRS0=I4RS=DX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D6A5C43457
	for <linux-block@archiver.kernel.org>; Fri, 16 Oct 2020 14:28:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA8CE2087D
	for <linux-block@archiver.kernel.org>; Fri, 16 Oct 2020 14:28:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NAVNIZm3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408816AbgJPO2j (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Oct 2020 10:28:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22669 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2408814AbgJPO2i (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Oct 2020 10:28:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602858517;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5NEORNZ83ko/42dG+WK88K6XSXli8mWtOAjrChHKcpM=;
        b=NAVNIZm3WUSg9ALUWB2B/cGtWEc1lsVo9yvFNeS9W+k4FK92fcxkrslXtE7gX+oSx6Darl
        RCI54khouulLkSkWLFqx0a/Kjba2SzWIZX5TeOKjXi9k48c/PmnolRk8nV7JRyRjK35shP
        NLsKLg87hd8MehAiALtjRqVMOBFXhDo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-595-Q12u0JCjM-KMX_3yLKqJig-1; Fri, 16 Oct 2020 10:28:35 -0400
X-MC-Unique: Q12u0JCjM-KMX_3yLKqJig-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 675871007465;
        Fri, 16 Oct 2020 14:28:34 +0000 (UTC)
Received: from localhost (ovpn-12-93.pek2.redhat.com [10.72.12.93])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BD52455766;
        Fri, 16 Oct 2020 14:28:30 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>
Cc:     Ming Lei <ming.lei@redhat.com>, Chao Leng <lengchao@huawei.com>,
        Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH 1/4] blk-mq: check rq->state explicitly in blk_mq_tagset_count_completed_rqs
Date:   Fri, 16 Oct 2020 22:28:08 +0800
Message-Id: <20201016142811.1262214-2-ming.lei@redhat.com>
In-Reply-To: <20201016142811.1262214-1-ming.lei@redhat.com>
References: <20201016142811.1262214-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

blk_mq_tagset_count_completed_rqs() is called from
blk_mq_tagset_wait_completed_request() for draining requests to be
completed remotely. What we need to do is to see request->state to
switch to non-MQ_RQ_COMPLETE.

So check MQ_RQ_COMPLETE explicitly in blk_mq_tagset_count_completed_rqs().

Meantime mark flush request as IDLE in its .end_io() for aligning to
end normal request because flush request may stay in inflight tags in case
of !elevator, so we need to change its state into IDLE.

Cc: Chao Leng <lengchao@huawei.com>
Cc: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-flush.c  | 2 ++
 block/blk-mq-tag.c | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/block/blk-flush.c b/block/blk-flush.c
index 53abb5c73d99..31a2ae04d3f0 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -231,6 +231,8 @@ static void flush_end_io(struct request *flush_rq, blk_status_t error)
 		return;
 	}
 
+	WRITE_ONCE(rq->state, MQ_RQ_IDLE);
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

