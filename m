Return-Path: <SRS0=otcQ=3E=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60343C33CB1
	for <linux-block@archiver.kernel.org>; Wed, 15 Jan 2020 11:45:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D58F207E0
	for <linux-block@archiver.kernel.org>; Wed, 15 Jan 2020 11:45:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="auBB+fDb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729972AbgAOLpq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Jan 2020 06:45:46 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56430 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729841AbgAOLpq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Jan 2020 06:45:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579088744;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4yB1rP5CdD/m80oklmWxOkCBZOzw1FOyt7hdYlMUj5k=;
        b=auBB+fDbX1YmoTIW6eTIpLdQxYTdSzrIDip66gPw4ycD7GxJOGvIeAIrTGNERcqgXdIjKg
        nF9ITQ+bC7RiYW1sxHhBOGIlxqeX9RaqlRvm//B/myX4JcBAj8zMmD11dJ2a7hE2sb5DFf
        0lqg8mLyuEbGArpktbQc01vam346jSA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-347-_OWGEnSeMpGOsez4Gyhddg-1; Wed, 15 Jan 2020 06:45:41 -0500
X-MC-Unique: _OWGEnSeMpGOsez4Gyhddg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1C0D21005512;
        Wed, 15 Jan 2020 11:45:40 +0000 (UTC)
Received: from localhost (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 190F1675AF;
        Wed, 15 Jan 2020 11:45:36 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCH 3/6] blk-mq: stop to handle IO and drain IO before hctx becomes inactive
Date:   Wed, 15 Jan 2020 19:44:06 +0800
Message-Id: <20200115114409.28895-4-ming.lei@redhat.com>
In-Reply-To: <20200115114409.28895-1-ming.lei@redhat.com>
References: <20200115114409.28895-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Before one CPU becomes offline, check if it is the last online CPU
of hctx. If yes, mark this hctx as inactive, meantime wait for
completion of all in-flight IOs originated from this hctx.

This way guarantees that there isn't any inflight IO before shutdowning
the managed IRQ line.

Cc: John Garry <john.garry@huawei.com>
Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Keith Busch <keith.busch@intel.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq-tag.c |  2 +-
 block/blk-mq-tag.h |  2 ++
 block/blk-mq.c     | 40 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index fbacde454718..67eaf6c88a78 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -317,7 +317,7 @@ static void bt_tags_for_each(struct blk_mq_tags *tags=
, struct sbitmap_queue *bt,
  *		true to continue iterating tags, false to stop.
  * @priv:	Will be passed as second argument to @fn.
  */
-static void blk_mq_all_tag_busy_iter(struct blk_mq_tags *tags,
+void blk_mq_all_tag_busy_iter(struct blk_mq_tags *tags,
 		busy_tag_iter_fn *fn, void *priv)
 {
 	if (tags->nr_reserved_tags)
diff --git a/block/blk-mq-tag.h b/block/blk-mq-tag.h
index 15bc74acb57e..48c9d7e3a655 100644
--- a/block/blk-mq-tag.h
+++ b/block/blk-mq-tag.h
@@ -34,6 +34,8 @@ extern int blk_mq_tag_update_depth(struct blk_mq_hw_ctx=
 *hctx,
 extern void blk_mq_tag_wakeup_all(struct blk_mq_tags *tags, bool);
 void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_iter_fn *f=
n,
 		void *priv);
+void blk_mq_all_tag_busy_iter(struct blk_mq_tags *tags,
+		busy_tag_iter_fn *fn, void *priv);
=20
 static inline struct sbq_wait_state *bt_wait_ptr(struct sbitmap_queue *b=
t,
 						 struct blk_mq_hw_ctx *hctx)
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 0f55bb92b16f..6f9d2f5e0b53 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2244,8 +2244,46 @@ int blk_mq_alloc_rqs(struct blk_mq_tag_set *set, s=
truct blk_mq_tags *tags,
 	return -ENOMEM;
 }
=20
+static bool blk_mq_count_inflight_rq(struct request *rq, void *data,
+				     bool reserved)
+{
+	unsigned *count =3D data;
+
+	if ((blk_mq_rq_state(rq) =3D=3D MQ_RQ_IN_FLIGHT))
+		(*count)++;
+
+	return true;
+}
+
+static unsigned blk_mq_tags_inflight_rqs(struct blk_mq_tags *tags)
+{
+	unsigned count =3D 0;
+
+	blk_mq_all_tag_busy_iter(tags, blk_mq_count_inflight_rq, &count);
+
+	return count;
+}
+
+static void blk_mq_hctx_drain_inflight_rqs(struct blk_mq_hw_ctx *hctx)
+{
+	while (1) {
+		if (!blk_mq_tags_inflight_rqs(hctx->tags))
+			break;
+		msleep(5);
+	}
+}
+
 static int blk_mq_hctx_notify_online(unsigned int cpu, struct hlist_node=
 *node)
 {
+	struct blk_mq_hw_ctx *hctx =3D hlist_entry_safe(node,
+			struct blk_mq_hw_ctx, cpuhp_online);
+
+	if ((cpumask_next_and(-1, hctx->cpumask, cpu_online_mask) =3D=3D cpu) &=
&
+			(cpumask_next_and(cpu, hctx->cpumask, cpu_online_mask)
+			 >=3D nr_cpu_ids)) {
+		set_bit(BLK_MQ_S_INACTIVE, &hctx->state);
+		blk_mq_hctx_drain_inflight_rqs(hctx);
+        }
 	return 0;
 }
=20
@@ -2272,6 +2310,8 @@ static int blk_mq_hctx_notify_dead(unsigned int cpu=
, struct hlist_node *node)
 	}
 	spin_unlock(&ctx->lock);
=20
+	clear_bit(BLK_MQ_S_INACTIVE, &hctx->state);
+
 	if (list_empty(&tmp))
 		return 0;
=20
--=20
2.20.1

