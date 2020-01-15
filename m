Return-Path: <SRS0=otcQ=3E=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9595BC33CB1
	for <linux-block@archiver.kernel.org>; Wed, 15 Jan 2020 11:45:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AB762073A
	for <linux-block@archiver.kernel.org>; Wed, 15 Jan 2020 11:45:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bIsmlBbS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729942AbgAOLpd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Jan 2020 06:45:33 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29388 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729841AbgAOLpc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Jan 2020 06:45:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579088732;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GIGCTzdDYq1+KsDcZr24JNbQfCD7EXIpfP9WxVSBIwI=;
        b=bIsmlBbSWM84WYBmkAt8t2v5LOVWGdVQ4vZP2oEkcKktOqMiSNaoo3hr7dxKvlMSb3huc2
        VgKbyaa95871M1aDK+UeOa+ae7TXbD7axYe3T5o9rzjibXT/8BU6o09ZSPywVDePdAMY1u
        h1Vl7NMa4R1OAwheIkL6eqIfJO3UcMU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-190-Lk5d-E-6PumC1vJSJWLjZg-1; Wed, 15 Jan 2020 06:45:31 -0500
X-MC-Unique: Lk5d-E-6PumC1vJSJWLjZg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A82CA593A5;
        Wed, 15 Jan 2020 11:45:29 +0000 (UTC)
Received: from localhost (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 93463811E7;
        Wed, 15 Jan 2020 11:45:26 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Keith Busch <keith.busch@intel.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH 1/6] blk-mq: add new state of BLK_MQ_S_INACTIVE
Date:   Wed, 15 Jan 2020 19:44:04 +0800
Message-Id: <20200115114409.28895-2-ming.lei@redhat.com>
In-Reply-To: <20200115114409.28895-1-ming.lei@redhat.com>
References: <20200115114409.28895-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add a new hw queue state of BLK_MQ_S_INACTIVE, which is set when all
CPUs of this hctx are offline.

Prepares for stopping hw queue when all CPUs of this hctx become offline.

Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Keith Busch <keith.busch@intel.com>
Cc: John Garry <john.garry@huawei.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq-debugfs.c | 1 +
 block/blk-mq.h         | 3 ++-
 include/linux/blk-mq.h | 3 +++
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index b3f2ba483992..d6de4f7f38cb 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -213,6 +213,7 @@ static const char *const hctx_state_name[] =3D {
 	HCTX_STATE_NAME(STOPPED),
 	HCTX_STATE_NAME(TAG_ACTIVE),
 	HCTX_STATE_NAME(SCHED_RESTART),
+	HCTX_STATE_NAME(INACTIVE),
 };
 #undef HCTX_STATE_NAME
=20
diff --git a/block/blk-mq.h b/block/blk-mq.h
index eaaca8fc1c28..fb5ea01f1366 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -167,7 +167,8 @@ static inline struct blk_mq_tags *blk_mq_tags_from_da=
ta(struct blk_mq_alloc_data
=20
 static inline bool blk_mq_hctx_stopped(struct blk_mq_hw_ctx *hctx)
 {
-	return test_bit(BLK_MQ_S_STOPPED, &hctx->state);
+	return test_bit(BLK_MQ_S_STOPPED, &hctx->state) ||
+		test_bit(BLK_MQ_S_INACTIVE, &hctx->state);
 }
=20
 static inline bool blk_mq_hw_queue_mapped(struct blk_mq_hw_ctx *hctx)
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 11cfd6470b1a..b669e776d4cb 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -397,6 +397,9 @@ enum {
 	BLK_MQ_S_TAG_ACTIVE	=3D 1,
 	BLK_MQ_S_SCHED_RESTART	=3D 2,
=20
+	/* hw queue is inactive after all its CPUs become offline */
+	BLK_MQ_S_INACTIVE	=3D 3,
+
 	BLK_MQ_MAX_DEPTH	=3D 10240,
=20
 	BLK_MQ_CPU_WORK_BATCH	=3D 8,
--=20
2.20.1

