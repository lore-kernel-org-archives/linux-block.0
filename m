Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BB81C5517A
	for <linux-block@archiver.kernel.org>; Thu, 12 Nov 2020 07:56:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1441A21D40
	for <linux-block@archiver.kernel.org>; Thu, 12 Nov 2020 07:56:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bp3NjkH/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbgKLH4H (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 12 Nov 2020 02:56:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28269 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726210AbgKLH4H (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Nov 2020 02:56:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605167766;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tEoa++yckJvX4gcWfT2MBofUbpK3jZSNs2PNG4vNnbQ=;
        b=bp3NjkH/zGhhUb1wjGej1/tcQa+mIwtByNcVSICjvgQenOD7afIHsxmK2uw116QBe5df1a
        FvT9s/hteUKI/C/BWVGDRM5Vj6P2Mx6JVSKz1ECQdPqu6zGtUzYxPOKGVJIJjvHktHlynu
        MgxqQ935yWV4XpIYdgB0R6UrVisXzco=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-137-Qy0ZrkkNMQmHW1aSSMJYhw-1; Thu, 12 Nov 2020 02:56:01 -0500
X-MC-Unique: Qy0ZrkkNMQmHW1aSSMJYhw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C87CA425F3;
        Thu, 12 Nov 2020 07:55:59 +0000 (UTC)
Received: from localhost (ovpn-12-132.pek2.redhat.com [10.72.12.132])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 294CA5DA74;
        Thu, 12 Nov 2020 07:55:52 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>
Cc:     Ming Lei <ming.lei@redhat.com>, Qian Cai <cai@redhat.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        John Garry <john.garry@huawei.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH 3/3] Revert "block: Fix a lockdep complaint triggered by request queue flushing"
Date:   Thu, 12 Nov 2020 15:55:26 +0800
Message-Id: <20201112075526.947079-4-ming.lei@redhat.com>
In-Reply-To: <20201112075526.947079-1-ming.lei@redhat.com>
References: <20201112075526.947079-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This reverts commit b3c6a59975415bde29cfd76ff1ab008edbf614a9.

Now we can avoid nvme-loop lockdep warning of 'lockdep possible recursive
locking' by nvme-loop's lock class, no need to apply dynamically
allocated lock class key, so revert commit b3c6a5997541("block: Fix a
lockdep complaint triggered by request queue flushing").

This way fixes horrible SCSI probe delay issue on megaraid_sas, and it
is reported the whole probe may take more than half an hour.

Reported-by: Qian Cai <cai@redhat.com>
Cc: Sumit Saxena <sumit.saxena@broadcom.com>
Cc: John Garry <john.garry@huawei.com>
Cc: Kashyap Desai <kashyap.desai@broadcom.com>
Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Hannes Reinecke <hare@suse.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-flush.c | 5 -----
 block/blk.h       | 1 -
 2 files changed, 6 deletions(-)

diff --git a/block/blk-flush.c b/block/blk-flush.c
index 657743524e15..c64f049226f6 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -69,7 +69,6 @@
 #include <linux/blkdev.h>
 #include <linux/gfp.h>
 #include <linux/blk-mq.h>
-#include <linux/lockdep.h>
 
 #include "blk.h"
 #include "blk-mq.h"
@@ -469,9 +468,6 @@ struct blk_flush_queue *blk_alloc_flush_queue(int node, int cmd_size,
 	INIT_LIST_HEAD(&fq->flush_queue[1]);
 	INIT_LIST_HEAD(&fq->flush_data_in_flight);
 
-	lockdep_register_key(&fq->key);
-	lockdep_set_class(&fq->mq_flush_lock, &fq->key);
-
 	return fq;
 
  fail_rq:
@@ -486,7 +482,6 @@ void blk_free_flush_queue(struct blk_flush_queue *fq)
 	if (!fq)
 		return;
 
-	lockdep_unregister_key(&fq->key);
 	kfree(fq->flush_rq);
 	kfree(fq);
 }
diff --git a/block/blk.h b/block/blk.h
index dfab98465db9..806fd6537295 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -25,7 +25,6 @@ struct blk_flush_queue {
 	struct list_head	flush_data_in_flight;
 	struct request		*flush_rq;
 
-	struct lock_class_key	key;
 	spinlock_t		mq_flush_lock;
 };
 
-- 
2.25.4

