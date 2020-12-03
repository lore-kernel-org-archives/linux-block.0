Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30191C6369E
	for <linux-block@archiver.kernel.org>; Thu,  3 Dec 2020 01:28:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C891D22228
	for <linux-block@archiver.kernel.org>; Thu,  3 Dec 2020 01:28:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729233AbgLCB2w (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Dec 2020 20:28:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39195 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729218AbgLCB2w (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 2 Dec 2020 20:28:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606958845;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GX61fRXro/iN1f/QllGwrAqHqUKtdtZYtR9z3U2BCOw=;
        b=iCk4uGmiUb65u8NSreXPomdVeYAq7ZOIOrp2JbVK2M3fk7dEoalfbo36EQm0A3gmRS98MG
        ZZ4aKZtcqENLSEi3pWj/37WdnzmEi6rq7EPaCEvJlZRyyUwhYCHYvsqMHdZw9kgPgUzAPx
        GVUotrkLXM4kJApx47AxsM7zftr+mm8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-425-hQudFP02PWWwrqXiwM_qzA-1; Wed, 02 Dec 2020 20:27:24 -0500
X-MC-Unique: hQudFP02PWWwrqXiwM_qzA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 57FB510066FD;
        Thu,  3 Dec 2020 01:27:22 +0000 (UTC)
Received: from localhost (ovpn-12-87.pek2.redhat.com [10.72.12.87])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 67FC919D9C;
        Thu,  3 Dec 2020 01:27:13 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Qian Cai <cai@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH V2 3/3] Revert "block: Fix a lockdep complaint triggered by request queue flushing"
Date:   Thu,  3 Dec 2020 09:26:38 +0800
Message-Id: <20201203012638.543321-4-ming.lei@redhat.com>
In-Reply-To: <20201203012638.543321-1-ming.lei@redhat.com>
References: <20201203012638.543321-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This reverts commit b3c6a59975415bde29cfd76ff1ab008edbf614a9.

Now we can avoid nvme-loop lockdep warning of 'lockdep possible recursive locking'
by nvme-loop's lock class, no need to apply dynamically allocated lock class key,
so revert commit b3c6a5997541("block: Fix a lockdep complaint triggered by request
queue flushing").

This way fixes horrible SCSI probe delay issue on megaraid_sas, and it is reported
the whole probe may take more than half an hour.

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
 block/blk-flush.c | 5 -----
 block/blk.h       | 1 -
 2 files changed, 6 deletions(-)

diff --git a/block/blk-flush.c b/block/blk-flush.c
index bf51588762d8..996d5d03dade 100644
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
index 98f0b1ae2641..d23d018fd2cd 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -25,7 +25,6 @@ struct blk_flush_queue {
 	struct list_head	flush_data_in_flight;
 	struct request		*flush_rq;
 
-	struct lock_class_key	key;
 	spinlock_t		mq_flush_lock;
 };
 
-- 
2.28.0

