Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F242EB64DA
	for <linux-block@archiver.kernel.org>; Sat,  8 Jul 2023 02:03:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231587AbjGHCD4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Jul 2023 22:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjGHCDz (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 Jul 2023 22:03:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA92C1BD2
        for <linux-block@vger.kernel.org>; Fri,  7 Jul 2023 19:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688781791;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Cr1KhEfZDnW8sNlRiibrAasVrQeI9dwBgBviWGuEjYQ=;
        b=gfXslRQ36tqG/Ehmm5futLPuprFIkTs2bamJXfWRiCfjWCceAn9RcX0cmJRYB5D70hEcvN
        uEHUGdAegI1bLA2YLz1nTXDk74BpB2XJUQNTu7nEP3wdtFWpSZ4ccljKc2taD/YHcnAa7h
        Kd278EKdPxCZ88rYQvtZe5c/Yi60PIo=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-248-YGXwpiwoPM6g8Vc6RxmNqA-1; Fri, 07 Jul 2023 22:03:08 -0400
X-MC-Unique: YGXwpiwoPM6g8Vc6RxmNqA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D618A3806704;
        Sat,  8 Jul 2023 02:03:07 +0000 (UTC)
Received: from localhost (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 052D540C206F;
        Sat,  8 Jul 2023 02:03:06 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-nvme@lists.infradead.org
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Wen Xiong <wenxiong@linux.ibm.com>,
        Keith Busch <kbusch@kernel.org>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 1/2] blk-mq: add blk_mq_max_nr_hw_queues()
Date:   Sat,  8 Jul 2023 10:02:58 +0800
Message-Id: <20230708020259.1343736-2-ming.lei@redhat.com>
In-Reply-To: <20230708020259.1343736-1-ming.lei@redhat.com>
References: <20230708020259.1343736-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

blk_mq_alloc_tag_set() may return less nr_hw_queues in case of kdump
kernel. This way can cause trouble for driver, which needs to calculate
nr_hw_queues first.

If blk_mq_alloc_tag_set() reduces nr_hw_queues for kdump kernel, it
causes trouble for driver, cause real queue topo is actually changed,
then IO may be dispatched to wrong queue.

Prepare for fixing this kind of issue by applying the added helper, so
driver can take blk-mq max nr_hw_queues knowledge into account when
calculating io queues.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c         | 9 +++++++++
 include/linux/blk-mq.h | 1 +
 2 files changed, 10 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 5504719b970d..b764da69a416 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -140,6 +140,15 @@ void blk_mq_freeze_queue_wait(struct request_queue *q)
 }
 EXPORT_SYMBOL_GPL(blk_mq_freeze_queue_wait);
 
+/* Max nr_hw_queues for each hw queue type */
+unsigned int blk_mq_max_nr_hw_queues(void)
+{
+	if (is_kdump_kernel())
+		return 1;
+	return nr_cpu_ids;
+}
+EXPORT_SYMBOL_GPL(blk_mq_max_nr_hw_queues);
+
 int blk_mq_freeze_queue_wait_timeout(struct request_queue *q,
 				     unsigned long timeout)
 {
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 2b7fb8e87793..2407978fbc30 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -713,6 +713,7 @@ int blk_mq_alloc_sq_tag_set(struct blk_mq_tag_set *set,
 		const struct blk_mq_ops *ops, unsigned int queue_depth,
 		unsigned int set_flags);
 void blk_mq_free_tag_set(struct blk_mq_tag_set *set);
+unsigned int blk_mq_max_nr_hw_queues(void);
 
 void blk_mq_free_request(struct request *rq);
 int blk_rq_poll(struct request *rq, struct io_comp_batch *iob,
-- 
2.40.1

