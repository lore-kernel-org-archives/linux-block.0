Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB252C43334
	for <linux-block@archiver.kernel.org>; Wed, 15 Jun 2022 06:48:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237430AbiFOGsv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Jun 2022 02:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240224AbiFOGst (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Jun 2022 02:48:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8EEFF42EFD
        for <linux-block@vger.kernel.org>; Tue, 14 Jun 2022 23:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655275727;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XAxR6aNCsoctIggKbTVTI/qefWKjK8KuT/BZaeLk9hU=;
        b=UjzDHDcukk+VuH8XE5l18rP3I/NmvQ2NQMYe3kMWxkcHFtQEncsgFergCND7jHIscJvtRh
        ZCv4/2oX3OtYKB8PNVMCcPDe2rLwR04flXGCUCOgmS4mJhjd+dRd0MfP/V5HlaVcU1zaFa
        78uEJ7Q5eYySXn4RwO9OxrTj7SwzxdU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-104-EeyQ46rHNU-nFghUd2sFSQ-1; Wed, 15 Jun 2022 02:48:44 -0400
X-MC-Unique: EeyQ46rHNU-nFghUd2sFSQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E7E823C025CC;
        Wed, 15 Jun 2022 06:48:43 +0000 (UTC)
Received: from localhost (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9C50040CFD0A;
        Wed, 15 Jun 2022 06:48:42 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>, Yu Kuai <yukuai3@huawei.com>
Subject: [PATCH V2 3/3] blk-mq: don't clear flush_rq from tags->rqs[]
Date:   Wed, 15 Jun 2022 14:48:26 +0800
Message-Id: <20220615064826.773067-4-ming.lei@redhat.com>
In-Reply-To: <20220615064826.773067-1-ming.lei@redhat.com>
References: <20220615064826.773067-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

commit 364b61818f65 ("blk-mq: clearing flush request reference in
tags->rqs[]") is added to clear the to-be-free flush request from
tags->rqs[] for avoiding use-after-free on the flush rq.

Yu Kuai reported that blk_mq_clear_flush_rq_mapping() slows down boot time
by ~8s because running scsi probe which may create and remove lots of
unpresent LUNs on megaraid-sas which uses BLK_MQ_F_TAG_HCTX_SHARED and
each request queue has lots of hw queues.

Improve the situation by not running blk_mq_clear_flush_rq_mapping if
disk isn't added when there can't be any flush request issued.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reported-by: Yu Kuai <yukuai3@huawei.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 112dce569192..992997f6acbd 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3429,8 +3429,9 @@ static void blk_mq_exit_hctx(struct request_queue *q,
 	if (blk_mq_hw_queue_mapped(hctx))
 		blk_mq_tag_idle(hctx);
 
-	blk_mq_clear_flush_rq_mapping(set->tags[hctx_idx],
-			set->queue_depth, flush_rq);
+	if (blk_queue_init_done(q))
+		blk_mq_clear_flush_rq_mapping(set->tags[hctx_idx],
+				set->queue_depth, flush_rq);
 	if (set->ops->exit_request)
 		set->ops->exit_request(set, flush_rq, hctx_idx);
 
-- 
2.31.1

