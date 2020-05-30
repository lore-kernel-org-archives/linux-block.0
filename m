Return-Path: <SRS0=VeZL=7M=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B469C433DF
	for <linux-block@archiver.kernel.org>; Sat, 30 May 2020 13:52:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2793D2074A
	for <linux-block@archiver.kernel.org>; Sat, 30 May 2020 13:52:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SlhjyI+x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728802AbgE3Nwn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 30 May 2020 09:52:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24368 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727851AbgE3Nwn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 30 May 2020 09:52:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590846762;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RZFNt1hadCoJ/rVa7DrlrAla/TA2GyNDp9Z67ysi2po=;
        b=SlhjyI+xb2HF6r28EkhJ0Yje/DkhYWqUhaSUT3syzst0xJpAMJiWFPm7906NEx8fhDl19d
        Y3ZmRCety33kqe8YuOCfoIwk6jqS94p5ar84Vx5CyZUvjYb9C9/lhGwv4gDGtKggPeksWW
        9NdpZUTy+Xcr87daq7tncvTJ8nhq1Qk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-335-SWXZSZYCNpaanBJ931uwgA-1; Sat, 30 May 2020 09:52:38 -0400
X-MC-Unique: SWXZSZYCNpaanBJ931uwgA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B2ACE1005512;
        Sat, 30 May 2020 13:52:36 +0000 (UTC)
Received: from localhost (ovpn-12-60.pek2.redhat.com [10.72.12.60])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0671A7B914;
        Sat, 30 May 2020 13:52:32 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>
Cc:     Alan Adamson <alan.adamson@oracle.com>,
        Dongli Zhang <dongli.zhang@oracle.com>,
        Ming Lei <ming.lei@redhat.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>,
        Max Gurtovoy <maxg@mellanox.com>
Subject: [PATCH V2 1/3] blk-mq: add API of blk_mq_queue_frozen
Date:   Sat, 30 May 2020 21:52:19 +0800
Message-Id: <20200530135221.1152749-2-ming.lei@redhat.com>
In-Reply-To: <20200530135221.1152749-1-ming.lei@redhat.com>
References: <20200530135221.1152749-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

blk_mq_freeze_queue_wait() isn't very flexible for some case, such as
error recovery: when blk_mq_freeze_queue_wait is called in error
recovery handler, new problem may be triggered on this controller, so
in-flight IO may not complete when blk_mq_freeze_queue_wait() is called.

And error recovery is often run in single context, so dead lock may be
triggered, because error recover handler can't move on.

Add one new API of blk_mq_queue_frozen(), error recovery handler may
use this helper to query if the queue has been frozen completely.
Meantime, the error recovery handler can check if there is hardware
failure happened. If yes, error recovery handler can break from current
handling, and run a fresh new recovery, so deadlock can be avoided.

This API will be used to improve error handling of nvme-pci's timeout
handler.

Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Keith Busch <kbusch@kernel.org>
Cc: Max Gurtovoy <maxg@mellanox.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c         | 6 ++++++
 include/linux/blk-mq.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index a5ff8140e52c..dc4e73d7ad02 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -148,6 +148,12 @@ void blk_mq_freeze_queue_wait(struct request_queue *q)
 }
 EXPORT_SYMBOL_GPL(blk_mq_freeze_queue_wait);
 
+bool blk_mq_queue_frozen(struct request_queue *q)
+{
+	return percpu_ref_is_zero(&q->q_usage_counter);
+}
+EXPORT_SYMBOL_GPL(blk_mq_queue_frozen);
+
 int blk_mq_freeze_queue_wait_timeout(struct request_queue *q,
 				     unsigned long timeout)
 {
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 43e38d21ca4a..1f867ad02c5c 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -518,6 +518,7 @@ void blk_freeze_queue_start(struct request_queue *q);
 void blk_mq_freeze_queue_wait(struct request_queue *q);
 int blk_mq_freeze_queue_wait_timeout(struct request_queue *q,
 				     unsigned long timeout);
+bool blk_mq_queue_frozen(struct request_queue *q);
 
 int blk_mq_map_queues(struct blk_mq_queue_map *qmap);
 void blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set, int nr_hw_queues);
-- 
2.25.2

