Return-Path: <SRS0=ocaT=2I=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B86C0C43603
	for <linux-block@archiver.kernel.org>; Wed, 18 Dec 2019 07:20:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E126206B7
	for <linux-block@archiver.kernel.org>; Wed, 18 Dec 2019 07:20:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M1gh7Go+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbfLRHUY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 18 Dec 2019 02:20:24 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:22617 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726747AbfLRHUW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Dec 2019 02:20:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576653622;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P74QapSDHWSEWo88gTuk8f2XOflcdzvr25rHKrQFEEg=;
        b=M1gh7Go+AGEjHq43BqhMjIOD5RohNSAwn1M+jsl7tQBw3F1TNskVwjysLP2T6nsOD1dpbk
        xFMHsiVR3HSDYyY2+kRjfLKCXNzMeFAUMjrHd8DLYfeDeN9568n8/Q+I7qPvdV4FGW1OCU
        AQVZs+8DGFWF3ePbNC9/rG7Yz8j+wDw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-409-9gNqsdt8N4qDTAlc4jdPZg-1; Wed, 18 Dec 2019 02:20:18 -0500
X-MC-Unique: 9gNqsdt8N4qDTAlc4jdPZg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EDEFA8024CF;
        Wed, 18 Dec 2019 07:20:16 +0000 (UTC)
Received: from localhost (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 596156888B;
        Wed, 18 Dec 2019 07:20:12 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>, Long Li <longli@microsoft.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        John Garry <john.garry@huawei.com>,
        Hannes Reinecke <hare@suse.com>
Subject: [RFC PATCH 3/3] blk-mq: complete request in rescuer process context in case of irq flood
Date:   Wed, 18 Dec 2019 15:19:42 +0800
Message-Id: <20191218071942.22336-4-ming.lei@redhat.com>
In-Reply-To: <20191218071942.22336-1-ming.lei@redhat.com>
References: <20191218071942.22336-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When irq flood is detected, complete requests in the percpu rescuer
context for avoiding lockup cpu.

IO interrupt flood might be triggered in the following situations:

1) the storage device is quicker to handle IO than single CPU core

2) N:1 queue mapping, single CPU core is saturated by handling IO interru=
pts
from multiple storage disks or multiple HBAs

Cc: Long Li <longli@microsoft.com>
Cc: Ingo Molnar <mingo@redhat.com>,
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Keith Busch <keith.busch@intel.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: John Garry <john.garry@huawei.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Hannes Reinecke <hare@suse.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 68 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 67 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 323c9cb28066..a7fe00f1a313 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -40,6 +40,14 @@
 #include "blk-mq-sched.h"
 #include "blk-rq-qos.h"
=20
+struct blk_mq_comp_rescuer {
+	struct list_head head;
+	bool running;
+	struct work_struct work;
+};
+
+static DEFINE_PER_CPU(struct blk_mq_comp_rescuer, blk_mq_comp_rescuer);
+
 static void blk_mq_poll_stats_start(struct request_queue *q);
 static void blk_mq_poll_stats_fn(struct blk_stat_callback *cb);
=20
@@ -624,6 +632,50 @@ static void hctx_lock(struct blk_mq_hw_ctx *hctx, in=
t *srcu_idx)
 		*srcu_idx =3D srcu_read_lock(hctx->srcu);
 }
=20
+static void blk_mq_complete_rq_in_rescuer(struct request *rq)
+{
+	struct blk_mq_comp_rescuer *rescuer;
+	unsigned long flags;
+
+	WARN_ON(!in_interrupt());
+
+	local_irq_save(flags);
+	rescuer =3D this_cpu_ptr(&blk_mq_comp_rescuer);
+	list_add_tail(&rq->queuelist, &rescuer->head);
+	if (!rescuer->running) {
+		rescuer->running =3D true;
+		kblockd_schedule_work(&rescuer->work);
+	}
+	local_irq_restore(flags);
+
+}
+
+static void blk_mq_complete_rescue_work(struct work_struct *work)
+{
+	struct blk_mq_comp_rescuer *rescuer =3D
+		container_of(work, struct blk_mq_comp_rescuer, work);
+	struct list_head local_list;
+
+	local_irq_disable();
+ run_again:
+	list_replace_init(&rescuer->head, &local_list);
+	local_irq_enable();
+
+	while (!list_empty(&local_list)) {
+		struct request *rq =3D list_entry(local_list.next,
+				struct request, queuelist);
+		list_del_init(&rq->queuelist);
+		__blk_mq_complete_request(rq);
+		cond_resched();
+	}
+
+	local_irq_disable();
+	if (!list_empty(&rescuer->head))
+		goto run_again;
+	rescuer->running =3D false;
+	local_irq_enable();
+}
+
 /**
  * blk_mq_complete_request - end I/O on a request
  * @rq:		the request being processed
@@ -636,7 +688,11 @@ bool blk_mq_complete_request(struct request *rq)
 {
 	if (unlikely(blk_should_fake_timeout(rq->q)))
 		return false;
-	__blk_mq_complete_request(rq);
+
+	if (likely(!irq_is_flood() || !in_interrupt()))
+		__blk_mq_complete_request(rq);
+	else
+		blk_mq_complete_rq_in_rescuer(rq);
 	return true;
 }
 EXPORT_SYMBOL(blk_mq_complete_request);
@@ -3525,6 +3581,16 @@ EXPORT_SYMBOL(blk_mq_rq_cpu);
=20
 static int __init blk_mq_init(void)
 {
+	int i;
+
+	for_each_possible_cpu(i) {
+		struct blk_mq_comp_rescuer *rescuer =3D
+			&per_cpu(blk_mq_comp_rescuer, i);
+
+		INIT_LIST_HEAD(&rescuer->head);
+		INIT_WORK(&rescuer->work, blk_mq_complete_rescue_work);
+	}
+
 	cpuhp_setup_state_multi(CPUHP_BLK_MQ_DEAD, "block/mq:dead", NULL,
 				blk_mq_hctx_notify_dead);
 	return 0;
--=20
2.20.1

