Return-Path: <SRS0=otcQ=3E=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB48AC33CB1
	for <linux-block@archiver.kernel.org>; Wed, 15 Jan 2020 11:45:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90D7F2073A
	for <linux-block@archiver.kernel.org>; Wed, 15 Jan 2020 11:45:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PoKD9qw8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729977AbgAOLpv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Jan 2020 06:45:51 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:28869 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729841AbgAOLpv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Jan 2020 06:45:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579088750;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uDyl0U7OGoFom1XRfUJjNorROHJDALTFwRqPCy2hChY=;
        b=PoKD9qw8FLLu/DBDnqehzfoDtWROOVsDj9CbQ50hr2o2C1kQ0gHrJbFOBaBjMGdEjkKYW4
        FL83q8WIy4pKMjr8LWjtEuBBRbF5Wv3lFiXxYAIjy+3ttF31Ke0RSIg6pAZ6DpgOPNG1wk
        lzw3BPeSA7AACD3mqO7uTvA63iJ/cIU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-440-cASR6frIOwOyAGF1gZ_f6w-1; Wed, 15 Jan 2020 06:45:44 -0500
X-MC-Unique: cASR6frIOwOyAGF1gZ_f6w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E5290801E6C;
        Wed, 15 Jan 2020 11:45:42 +0000 (UTC)
Received: from localhost (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3ABDB1CB;
        Wed, 15 Jan 2020 11:45:41 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCH 4/6] blk-mq: re-submit IO in case that hctx is inactive
Date:   Wed, 15 Jan 2020 19:44:07 +0800
Message-Id: <20200115114409.28895-5-ming.lei@redhat.com>
In-Reply-To: <20200115114409.28895-1-ming.lei@redhat.com>
References: <20200115114409.28895-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When all CPUs in one hctx are offline and this hctx becomes inactive,
we shouldn't run this hw queue for completing request any more.

So steal bios from the request, and resubmit them, and finally free
the request in blk_mq_hctx_notify_dead().

Cc: John Garry <john.garry@huawei.com>
Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Keith Busch <keith.busch@intel.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 58 ++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 47 insertions(+), 11 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 6f9d2f5e0b53..3e52ba74661e 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2287,10 +2287,34 @@ static int blk_mq_hctx_notify_online(unsigned int=
 cpu, struct hlist_node *node)
 	return 0;
 }
=20
+static void blk_mq_resubmit_io(struct request *rq)
+{
+	struct bio_list list;
+	struct bio *bio;
+
+	bio_list_init(&list);
+	blk_steal_bios(&list, rq);
+
+	/*
+	 * Free the old empty request before submitting bio for avoiding
+	 * potential deadlock
+	 */
+	blk_mq_cleanup_rq(rq);
+	blk_mq_end_request(rq, 0);
+
+	while (true) {
+		bio =3D bio_list_pop(&list);
+		if (!bio)
+			break;
+
+		generic_make_request(bio);
+	}
+}
+
 /*
- * 'cpu' is going away. splice any existing rq_list entries from this
- * software queue to the hw queue dispatch list, and ensure that it
- * gets run.
+ * 'cpu' has gone away. If this hctx is inactive, we can't dispatch requ=
est
+ * to the hctx any more, so steal bios from requests of this hctx, and
+ * re-submit them to the request queue, and free these requests finally.
  */
 static int blk_mq_hctx_notify_dead(unsigned int cpu, struct hlist_node *=
node)
 {
@@ -2310,16 +2334,28 @@ static int blk_mq_hctx_notify_dead(unsigned int c=
pu, struct hlist_node *node)
 	}
 	spin_unlock(&ctx->lock);
=20
-	clear_bit(BLK_MQ_S_INACTIVE, &hctx->state);
-
-	if (list_empty(&tmp))
-		return 0;
+	if (!test_bit(BLK_MQ_S_INACTIVE, &hctx->state)) {
+		if (!list_empty(&tmp)) {
+			spin_lock(&hctx->lock);
+			list_splice_tail_init(&tmp, &hctx->dispatch);
+			spin_unlock(&hctx->lock);
+			blk_mq_run_hw_queue(hctx, true);
+		}
+	} else {
+		/* requests in dispatch list has to be re-submitted too */
+		spin_lock(&hctx->lock);
+		list_splice_tail_init(&hctx->dispatch, &tmp);
+		spin_unlock(&hctx->lock);
=20
-	spin_lock(&hctx->lock);
-	list_splice_tail_init(&tmp, &hctx->dispatch);
-	spin_unlock(&hctx->lock);
+		while (!list_empty(&tmp)) {
+			struct request *rq =3D list_entry(tmp.next,
+					struct request, queuelist);
+			list_del_init(&rq->queuelist);
+			blk_mq_resubmit_io(rq);
+		}
+		clear_bit(BLK_MQ_S_INACTIVE, &hctx->state);
+	}
=20
-	blk_mq_run_hw_queue(hctx, true);
 	return 0;
 }
=20
--=20
2.20.1

