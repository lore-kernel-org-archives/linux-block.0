Return-Path: <SRS0=U0+/=T3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98FCBC04AB3
	for <linux-block@archiver.kernel.org>; Mon, 27 May 2019 15:02:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79D6E2183F
	for <linux-block@archiver.kernel.org>; Mon, 27 May 2019 15:02:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbfE0PCw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 May 2019 11:02:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:64810 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726115AbfE0PCv (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 May 2019 11:02:51 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3BE4A30C1AFA;
        Mon, 27 May 2019 15:02:51 +0000 (UTC)
Received: from localhost (ovpn-8-24.pek2.redhat.com [10.72.8.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2BD3E60BF3;
        Mon, 27 May 2019 15:02:44 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     linux-block@vger.kernel.org,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-scsi@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        John Garry <john.garry@huawei.com>,
        Keith Busch <keith.busch@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Don Brace <don.brace@microsemi.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Sathya Prakash <sathya.prakash@broadcom.com>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 2/5] blk-mq: introduce .complete_queue_affinity
Date:   Mon, 27 May 2019 23:02:04 +0800
Message-Id: <20190527150207.11372-3-ming.lei@redhat.com>
In-Reply-To: <20190527150207.11372-1-ming.lei@redhat.com>
References: <20190527150207.11372-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Mon, 27 May 2019 15:02:51 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Some SCSI devices support single hw queue(tags), meantime allow
multiple private complete queues for handling request delivery &
completion. And mapping between CPU and private completion queue is
setup via pci_alloc_irq_vectors_affinity(PCI_IRQ_AFFINITY), just
like normal blk-mq's queue mapping.

Introduce .complete_queue_affinity callback for getting the
complete queue's affinity, so that we can drain in-flight requests
delivered from the complete queue if last CPU of the completion queue
becomes offline.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 include/linux/blk-mq.h | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 15d1aa53d96c..56f2e2ed62a7 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -140,7 +140,8 @@ typedef int (poll_fn)(struct blk_mq_hw_ctx *);
 typedef int (map_queues_fn)(struct blk_mq_tag_set *set);
 typedef bool (busy_fn)(struct request_queue *);
 typedef void (complete_fn)(struct request *);
-
+typedef const struct cpumask *(hctx_complete_queue_affinity_fn)(
+		struct blk_mq_hw_ctx *, int);
 
 struct blk_mq_ops {
 	/*
@@ -207,6 +208,15 @@ struct blk_mq_ops {
 
 	map_queues_fn		*map_queues;
 
+	/*
+	 * Some SCSI devices support private complete queue, returns
+	 * affinity of the complete queue, and the passed 'cpu' parameter
+	 * has to be included in the complete queue's affinity cpumask, and
+	 * used to figure out the mapped reply queue. If NULL is returns,
+	 * it means this hctx hasn't private completion queues.
+	 */
+	hctx_complete_queue_affinity_fn *complete_queue_affinity;
+
 #ifdef CONFIG_BLK_DEBUG_FS
 	/*
 	 * Used by the debugfs implementation to show driver-specific
-- 
2.20.1

