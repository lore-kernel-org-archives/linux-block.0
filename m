Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDE42C2D0E4
	for <linux-block@archiver.kernel.org>; Fri, 13 Nov 2020 01:27:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F3B821D7F
	for <linux-block@archiver.kernel.org>; Fri, 13 Nov 2020 01:27:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RY8X2Law"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726041AbgKMB1o (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 12 Nov 2020 20:27:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:31713 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725972AbgKMB1o (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Nov 2020 20:27:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605230863;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lV54YU+Y2Y4e+7PhqUzWDRed50pkkVt7/DClvgkkexc=;
        b=RY8X2Lawbn/kfHL3gdn2iwd1SaAXZXcafde5hhdtMOvN3G8udfXLvI2iDVaQE8EvTDxIRb
        d2p4AD5ySev1PmuZrw7sIbmSPvI39ycrAR4IyfcT1c5ttU7jdPF2KhrGQrMg/7r5IobVj4
        4FD2vhDBwpr4vVETdlw3rEzT6C3EbwA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-170-slz7WspHMemeuUB_wBgjmg-1; Thu, 12 Nov 2020 20:27:41 -0500
X-MC-Unique: slz7WspHMemeuUB_wBgjmg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ACD12107B467;
        Fri, 13 Nov 2020 01:27:39 +0000 (UTC)
Received: from T590 (ovpn-12-25.pek2.redhat.com [10.72.12.25])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E42605B4DA;
        Fri, 13 Nov 2020 01:27:26 +0000 (UTC)
Date:   Fri, 13 Nov 2020 09:27:22 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>
Cc:     Qian Cai <cai@redhat.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        John Garry <john.garry@huawei.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH V2 3/3] Revert "block: Fix a lockdep complaint triggered by
 request queue flushing"
Message-ID: <20201113012722.GD1012796@T590>
References: <20201112075526.947079-1-ming.lei@redhat.com>
 <20201112075526.947079-4-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201112075526.947079-4-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From a519f421957a1205918e9bcc15087d15234e4e9f Mon Sep 17 00:00:00 2001
From: Ming Lei <ming.lei@redhat.com>
Date: Thu, 12 Nov 2020 09:56:02 +0800
Subject: [PATCH V2 3/3] Revert "block: Fix a lockdep complaint triggered by
 request queue flushing"

This reverts commit b3c6a59975415bde29cfd76ff1ab008edbf614a9.

Now we can avoid nvme-loop lockdep warning of 'lockdep possible recursive
locking' by nvme-loop's lock class, no need to apply dynamically
allocated lock class key, so revert commit b3c6a5997541("block: Fix a
lockdep complaint triggered by request queue flushing").

This way fixes horrible SCSI probe delay issue on megaraid_sas(host_tagset is 1),
and it is reported the whole probe may take more than half an hour. The reason
is that synchronize_rcu() is implied in lockdep_unregister_key() which is
called from each hctx's release handler, and some SCSI hosts can support
too many hw queues, meantime generic SCSI probe may synchronously create
and destroy lots of MQ request_queues for non-existent devices.

Another benefit is that lockdep doesn't maintain so many runtime lock class for
fq->mq_flush_lock which is per-hctx, then lock validation can be improved much.

Reported-by: Qian Cai <cai@redhat.com>
Cc: Sumit Saxena <sumit.saxena@broadcom.com>
Cc: John Garry <john.garry@huawei.com>
Cc: Kashyap Desai <kashyap.desai@broadcom.com>
Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Hannes Reinecke <hare@suse.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
V2:
	- add more commit log

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

