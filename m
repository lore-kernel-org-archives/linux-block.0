Return-Path: <SRS0=yWXY=D3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46456C433E7
	for <linux-block@archiver.kernel.org>; Tue, 20 Oct 2020 08:53:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E16DB223FB
	for <linux-block@archiver.kernel.org>; Tue, 20 Oct 2020 08:53:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xdla9Sbx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389675AbgJTIxi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Oct 2020 04:53:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53703 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389671AbgJTIxi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Oct 2020 04:53:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603184016;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=njZ643iU/149cfh/2UCilYzskogU0Ipm2B4QLECmfSU=;
        b=Xdla9SbxwLJA+i2cePfPMEQWKWWgvQhbW75lmSI1YuD/Vqt+wNRvK3Yz685cu3S1rAbDRp
        s/fA6bhjn4CceO8DaHo9UztQXMJEGPscwYwzOsfRMt7COXaplmxqrTQLtViJO23BYNYZfn
        m6SobSqXFGvdpORRIcFID//Dma6Hat8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-573-uWeYhmjuNUauJIvhhYwzAg-1; Tue, 20 Oct 2020 04:53:35 -0400
X-MC-Unique: uWeYhmjuNUauJIvhhYwzAg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 81230801AE0;
        Tue, 20 Oct 2020 08:53:33 +0000 (UTC)
Received: from localhost (ovpn-12-164.pek2.redhat.com [10.72.12.164])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 360DC5D9D2;
        Tue, 20 Oct 2020 08:53:26 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>
Cc:     Ming Lei <ming.lei@redhat.com>, Yi Zhang <yi.zhang@redhat.com>,
        Chao Leng <lengchao@huawei.com>,
        Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH V2 2/4] blk-mq: fix blk_mq_request_completed
Date:   Tue, 20 Oct 2020 16:52:59 +0800
Message-Id: <20201020085301.1553959-3-ming.lei@redhat.com>
In-Reply-To: <20201020085301.1553959-1-ming.lei@redhat.com>
References: <20201020085301.1553959-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

MQ_RQ_COMPLETE is one transient state, because the .complete callback
ends or requeues this request, then the request state is updated to
IDLE from the .complete callback.

blk_mq_request_completed() is often used by driver for avoiding
double completion with help of driver's specific sync approach. Such as,
NVMe TCP calls blk_mq_request_completed() in its timeout handler
and abort handler for avoiding double completion. If request's state
is updated to IDLE in either one, another code path may think this
request as not completed, and will complete it one more time. Then
double completion is triggered.

Yi reported[1] that 'refcount_t: underflow; use-after-free' of rq->ref
is triggered in blktests(nvme/012) on one very slow machine.

Fixes this issue by thinking request as completed if its state becomes
not IN_FLIGHT.

Reported-by: Yi Zhang <yi.zhang@redhat.com>
Tested-by: Yi Zhang <yi.zhang@redhat.com>
Cc: Chao Leng <lengchao@huawei.com>
Cc: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 include/linux/blk-mq.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 90da3582b91d..9a67408f79d9 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -478,9 +478,15 @@ static inline int blk_mq_request_started(struct request *rq)
 	return blk_mq_rq_state(rq) != MQ_RQ_IDLE;
 }
 
+/*
+ * It is often called in abort handler for avoiding double completion,
+ * MQ_RQ_COMPLETE is one transient state because .complete callback
+ * may end or requeue this request, in either way the request is marked
+ * as IDLE. So return true if this request's state become not IN_FLIGHT.
+ */
 static inline int blk_mq_request_completed(struct request *rq)
 {
-	return blk_mq_rq_state(rq) == MQ_RQ_COMPLETE;
+	return blk_mq_rq_state(rq) != MQ_RQ_IN_FLIGHT;
 }
 
 void blk_mq_start_request(struct request *rq);
-- 
2.25.2

