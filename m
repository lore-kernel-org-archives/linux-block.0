Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F2E0C6369E
	for <linux-block@archiver.kernel.org>; Thu,  3 Dec 2020 01:28:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A40D822228
	for <linux-block@archiver.kernel.org>; Thu,  3 Dec 2020 01:28:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726222AbgLCB2n (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Dec 2020 20:28:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:45825 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726167AbgLCB2m (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 2 Dec 2020 20:28:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606958835;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DdlIhQrVcQSjcRRu6rCOZzDSNzJA1THUuCHTl6bEpAg=;
        b=QBPiHKghvMxmSD0iQM+afnRE7FLp1dIfBgKx2bHieUvYVjLtdV4O7RntwKnkH4Cu7i2sZC
        VtB54m5NNE0n64MJP+1dn/tE2zHXJcuXH5mc9bK65wCSZm2+bMqTfiRS5jAeHH6/G+oDhP
        WxpgDk798mre3kJJCXMyz3DYAxgWHJU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-94-ptaMkaECOsifWyO4caZBwg-1; Wed, 02 Dec 2020 20:27:12 -0500
X-MC-Unique: ptaMkaECOsifWyO4caZBwg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8FBA8185E48F;
        Thu,  3 Dec 2020 01:27:10 +0000 (UTC)
Received: from localhost (ovpn-12-87.pek2.redhat.com [10.72.12.87])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 14F125D6BA;
        Thu,  3 Dec 2020 01:27:02 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Qian Cai <cai@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH V2 2/3] nvme-loop: use blk_mq_hctx_set_fq_lock_class to set loop's lock class
Date:   Thu,  3 Dec 2020 09:26:37 +0800
Message-Id: <20201203012638.543321-3-ming.lei@redhat.com>
In-Reply-To: <20201203012638.543321-1-ming.lei@redhat.com>
References: <20201203012638.543321-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Set nvme-loop's lock class via blk_mq_hctx_set_fq_lock_class for avoiding
lockdep possible recursive locking, then we can remove the dynamically
allocated lock class for each flush queue, finally we can avoid horrible
SCSI probe delay.

This way may not address situation in which one nvme-loop is backed on
another nvme-loop. However, in reality, people seldom uses this way
for test. Even though someone played in this way, it is just one
recursive locking false positive, no real deadlock issue.

Tested-by: Kashyap Desai <kashyap.desai@broadcom.com>
Reported-by: Qian Cai <cai@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Cc: Sumit Saxena <sumit.saxena@broadcom.com>
Cc: John Garry <john.garry@huawei.com>
Cc: Kashyap Desai <kashyap.desai@broadcom.com>
Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Hannes Reinecke <hare@suse.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/nvme/target/loop.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index f6d81239be21..07806016c09d 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -211,6 +211,8 @@ static int nvme_loop_init_request(struct blk_mq_tag_set *set,
 			(set == &ctrl->tag_set) ? hctx_idx + 1 : 0);
 }
 
+static struct lock_class_key loop_hctx_fq_lock_key;
+
 static int nvme_loop_init_hctx(struct blk_mq_hw_ctx *hctx, void *data,
 		unsigned int hctx_idx)
 {
@@ -219,6 +221,14 @@ static int nvme_loop_init_hctx(struct blk_mq_hw_ctx *hctx, void *data,
 
 	BUG_ON(hctx_idx >= ctrl->ctrl.queue_count);
 
+	/*
+	 * flush_end_io() can be called recursively for us, so use our own
+	 * lock class key for avoiding lockdep possible recursive locking,
+	 * then we can remove the dynamically allocated lock class for each
+	 * flush queue, that way may cause horrible boot delay.
+	 */
+	blk_mq_hctx_set_fq_lock_class(hctx, &loop_hctx_fq_lock_key);
+
 	hctx->driver_data = queue;
 	return 0;
 }
-- 
2.28.0

