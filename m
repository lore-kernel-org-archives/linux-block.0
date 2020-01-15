Return-Path: <SRS0=otcQ=3E=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45537C33CB2
	for <linux-block@archiver.kernel.org>; Wed, 15 Jan 2020 11:45:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B64D24679
	for <linux-block@archiver.kernel.org>; Wed, 15 Jan 2020 11:45:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cwH+FY6g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729841AbgAOLp4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Jan 2020 06:45:56 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52244 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730003AbgAOLp4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Jan 2020 06:45:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579088755;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pi3uBxnM04rartc9xrpVMB14GNLg2GCm0ojYkhvoEsU=;
        b=cwH+FY6gCd9ZhvTk7t9pyg5SGlDW2OwsyZygGLzZvucT0bwPEDRxdUdSv6w/U3SDGTnFrZ
        ac9l386h1goqBDazvHbuyLEAd3UWWgzR9h8/LkoeDzyvtuLJy13f6pdbndUhNU8r0M7fCF
        MpMmqtbDzEPen64dLlRK2do8nI8uXG0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-58-Z_lrkpQuMAiYWi6ggBaZMg-1; Wed, 15 Jan 2020 06:45:52 -0500
X-MC-Unique: Z_lrkpQuMAiYWi6ggBaZMg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CFF6C800D48;
        Wed, 15 Jan 2020 11:45:50 +0000 (UTC)
Received: from localhost (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E747C1CB;
        Wed, 15 Jan 2020 11:45:47 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCH 6/6] block: deactivate hctx when all its CPUs are offline when running queue
Date:   Wed, 15 Jan 2020 19:44:09 +0800
Message-Id: <20200115114409.28895-7-ming.lei@redhat.com>
In-Reply-To: <20200115114409.28895-1-ming.lei@redhat.com>
References: <20200115114409.28895-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When we select next cpu for running hw queue, all this hctx's CPUs may
become offline, so deactivate this hctx at that time.

So we can fix some corner case which can't be covered by deactivating
hctx in CPU hotplug handler, such as request may be requeued during
CPU hotplug, which handler can't found the requeued rquests and
re-submit them.

Cc: John Garry <john.garry@huawei.com>
Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Keith Busch <keith.busch@intel.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 93c835312d42..fada556880ca 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -43,6 +43,8 @@
 static void blk_mq_poll_stats_start(struct request_queue *q);
 static void blk_mq_poll_stats_fn(struct blk_stat_callback *cb);
=20
+static void blk_mq_hctx_deactivate(struct blk_mq_hw_ctx *hctx);
+
 static int blk_mq_poll_stats_bkt(const struct request *rq)
 {
 	int ddir, sectors, bucket;
@@ -1431,7 +1433,7 @@ static int blk_mq_hctx_next_cpu(struct blk_mq_hw_ct=
x *hctx)
 		 */
 		hctx->next_cpu =3D next_cpu;
 		hctx->next_cpu_batch =3D 1;
-		return WORK_CPU_UNBOUND;
+		return -1;
 	}
=20
 	hctx->next_cpu =3D next_cpu;
@@ -1450,6 +1452,8 @@ static int blk_mq_hctx_next_cpu(struct blk_mq_hw_ct=
x *hctx)
 static void __blk_mq_delay_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool=
 async,
 					unsigned long msecs)
 {
+	int cpu;
+
 	if (unlikely(blk_mq_hctx_stopped(hctx)))
 		return;
=20
@@ -1464,8 +1468,13 @@ static void __blk_mq_delay_run_hw_queue(struct blk=
_mq_hw_ctx *hctx, bool async,
 		put_cpu();
 	}
=20
-	kblockd_mod_delayed_work_on(blk_mq_hctx_next_cpu(hctx), &hctx->run_work=
,
-				    msecs_to_jiffies(msecs));
+	cpu =3D blk_mq_hctx_next_cpu(hctx);
+
+	if (likely(cpu >=3D 0))
+		kblockd_mod_delayed_work_on(cpu, &hctx->run_work,
+				msecs_to_jiffies(msecs));
+	else
+		blk_mq_hctx_deactivate(hctx);
 }
=20
 /**
--=20
2.20.1

