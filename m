Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1903BC4743D
	for <linux-block@archiver.kernel.org>; Wed,  9 Jun 2021 01:58:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0165161287
	for <linux-block@archiver.kernel.org>; Wed,  9 Jun 2021 01:58:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233284AbhFICAk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Jun 2021 22:00:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28323 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233277AbhFICAk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 8 Jun 2021 22:00:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623203926;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HaZJ70SmNRIDZN2a/e3TD5t9udDBKtyNUerMWd1iySM=;
        b=UvMBqwYHmGOKPn2QusNBDENTHD0e7+aBuF5KlM1rBdOIGGSBzdKktqFMnONP0xfSs72gjE
        XDnDipnxsdChei0ZcFcdrXgkl8Cpo43uQjwymqkapwAxrYL3aqNCaXJgPPuwNJdk8aHDuE
        Ab29fJXOqsGsJBsYw/srVzdYNJH16uc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-276-Q5FOEj-sOA6AZkDFdAn7HQ-1; Tue, 08 Jun 2021 21:58:44 -0400
X-MC-Unique: Q5FOEj-sOA6AZkDFdAn7HQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 095835122;
        Wed,  9 Jun 2021 01:58:44 +0000 (UTC)
Received: from localhost (ovpn-12-143.pek2.redhat.com [10.72.12.143])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 184265D9C6;
        Wed,  9 Jun 2021 01:58:36 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Yi Zhang <yi.zhang@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH V3 1/2] block: fix race between adding/removing rq qos and normal IO
Date:   Wed,  9 Jun 2021 09:58:21 +0800
Message-Id: <20210609015822.103433-2-ming.lei@redhat.com>
In-Reply-To: <20210609015822.103433-1-ming.lei@redhat.com>
References: <20210609015822.103433-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Yi reported several kernel panics on:

[16687.001777] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000008
...
[16687.163549] pc : __rq_qos_track+0x38/0x60

or

[  997.690455] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000020
...
[  997.850347] pc : __rq_qos_done+0x2c/0x50

Turns out it is caused by race between adding rq qos(wbt) and normal IO
because rq_qos_add can be run when IO is being submitted, fix this issue
by freezing queue before adding/deleting rq qos to queue.

rq_qos_exit() needn't to freeze queue because it is called after queue
has been frozen.

iolatency calls rq_qos_add() during allocating queue, so freezing won't
add delay because queue usage refcount works at atomic mode at that
time.

iocost calls rq_qos_add() when writing cgroup attribute file, that is
fine to freeze queue at that time since we usually freeze queue when
storing to queue sysfs attribute, meantime iocost only exists on the
root cgroup.

wbt_init calls it in blk_register_queue() and queue sysfs attribute
store(queue_wb_lat_store() when write it 1st time in case of !BLK_WBT_MQ),
the following patch will speedup the queue freezing in wbt_init.

Reported-by: Yi Zhang <yi.zhang@redhat.com>
Cc: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-rq-qos.h | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/block/blk-rq-qos.h b/block/blk-rq-qos.h
index 2bc43e94f4c4..2bcb3495e376 100644
--- a/block/blk-rq-qos.h
+++ b/block/blk-rq-qos.h
@@ -7,6 +7,7 @@
 #include <linux/blk_types.h>
 #include <linux/atomic.h>
 #include <linux/wait.h>
+#include <linux/blk-mq.h>
 
 #include "blk-mq-debugfs.h"
 
@@ -99,8 +100,21 @@ static inline void rq_wait_init(struct rq_wait *rq_wait)
 
 static inline void rq_qos_add(struct request_queue *q, struct rq_qos *rqos)
 {
+	/*
+	 * No IO can be in-flight when adding rqos, so freeze queue, which
+	 * is fine since we only support rq_qos for blk-mq queue.
+	 *
+	 * Reuse ->queue_lock for protecting against other concurrent
+	 * rq_qos adding/deleting
+	 */
+	blk_mq_freeze_queue(q);
+
+	spin_lock_irq(&q->queue_lock);
 	rqos->next = q->rq_qos;
 	q->rq_qos = rqos;
+	spin_unlock_irq(&q->queue_lock);
+
+	blk_mq_unfreeze_queue(q);
 
 	if (rqos->ops->debugfs_attrs)
 		blk_mq_debugfs_register_rqos(rqos);
@@ -110,12 +124,22 @@ static inline void rq_qos_del(struct request_queue *q, struct rq_qos *rqos)
 {
 	struct rq_qos **cur;
 
+	/*
+	 * See comment in rq_qos_add() about freezing queue & using
+	 * ->queue_lock.
+	 */
+	blk_mq_freeze_queue(q);
+
+	spin_lock_irq(&q->queue_lock);
 	for (cur = &q->rq_qos; *cur; cur = &(*cur)->next) {
 		if (*cur == rqos) {
 			*cur = rqos->next;
 			break;
 		}
 	}
+	spin_unlock_irq(&q->queue_lock);
+
+	blk_mq_unfreeze_queue(q);
 
 	blk_mq_debugfs_unregister_rqos(rqos);
 }
-- 
2.31.1

