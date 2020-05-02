Return-Path: <SRS0=Yh1G=6Q=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47D75C3A5A9
	for <linux-block@archiver.kernel.org>; Sat,  2 May 2020 23:56:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1ECC620757
	for <linux-block@archiver.kernel.org>; Sat,  2 May 2020 23:56:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AJKkMKv+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726580AbgEBX4L (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 2 May 2020 19:56:11 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:29386 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725798AbgEBX4L (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 2 May 2020 19:56:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588463770;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ALPAdvtUh5zZQ0CekDAR2jJsyxPgrFmti13KYPrz2fU=;
        b=AJKkMKv+e1mySYT0T9bc16TMN3Jo6z8A/hEUW+yZfnkeugL6Ty+/s46Oz6E+wqP9FXK4HU
        8hcLpYftU8kmLxoSlxAv7+hcB05FbquYK1yaFFrNGu7+qeOHics775DUre0qjErR7mlCFJ
        6RBZWTQFSzX48jN+UdMkcvPzfZuOZso=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-4-OP0JVzyqMZC5S6kqtPqvXg-1; Sat, 02 May 2020 19:56:08 -0400
X-MC-Unique: OP0JVzyqMZC5S6kqtPqvXg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E251345F;
        Sat,  2 May 2020 23:56:06 +0000 (UTC)
Received: from localhost (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DC4E26B8D7;
        Sat,  2 May 2020 23:56:02 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH V9 09/11] blk-mq: add blk_mq_hctx_handle_dead_cpu for handling cpu dead
Date:   Sun,  3 May 2020 07:54:52 +0800
Message-Id: <20200502235454.1118520-10-ming.lei@redhat.com>
In-Reply-To: <20200502235454.1118520-1-ming.lei@redhat.com>
References: <20200502235454.1118520-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add helper of blk_mq_hctx_handle_dead_cpu for handling cpu dead,
and prepare for handling inactive hctx.

No functional change.

Cc: John Garry <john.garry@huawei.com>
Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 4a2250ac4fbb..73e1a1d4c1c5 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2382,22 +2382,13 @@ static int blk_mq_hctx_notify_online(unsigned int=
 cpu, struct hlist_node *node)
 	return 0;
 }
=20
-/*
- * 'cpu' is going away. splice any existing rq_list entries from this
- * software queue to the hw queue dispatch list, and ensure that it
- * gets run.
- */
-static int blk_mq_hctx_notify_dead(unsigned int cpu, struct hlist_node *=
node)
+static void blk_mq_hctx_handle_dead_cpu(struct blk_mq_hw_ctx *hctx,
+		unsigned int cpu)
 {
-	struct blk_mq_hw_ctx *hctx =3D hlist_entry_safe(node,
-			struct blk_mq_hw_ctx, cpuhp_dead);
 	struct blk_mq_ctx *ctx;
 	LIST_HEAD(tmp);
 	enum hctx_type type;
=20
-	if (!cpumask_test_cpu(cpu, hctx->cpumask))
-		return 0;
-
 	ctx =3D __blk_mq_get_ctx(hctx->queue, cpu);
 	type =3D hctx->type;
=20
@@ -2409,13 +2400,27 @@ static int blk_mq_hctx_notify_dead(unsigned int c=
pu, struct hlist_node *node)
 	spin_unlock(&ctx->lock);
=20
 	if (list_empty(&tmp))
-		return 0;
+		return;
=20
 	spin_lock(&hctx->lock);
 	list_splice_tail_init(&tmp, &hctx->dispatch);
 	spin_unlock(&hctx->lock);
=20
 	blk_mq_run_hw_queue(hctx, true);
+}
+
+/*
+ * 'cpu' is going away. splice any existing rq_list entries from this
+ * software queue to the hw queue dispatch list, and ensure that it
+ * gets run.
+ */
+static int blk_mq_hctx_notify_dead(unsigned int cpu, struct hlist_node *=
node)
+{
+	struct blk_mq_hw_ctx *hctx =3D hlist_entry_safe(node,
+			struct blk_mq_hw_ctx, cpuhp_dead);
+
+	if (cpumask_test_cpu(cpu, hctx->cpumask))
+		blk_mq_hctx_handle_dead_cpu(hctx, cpu);
 	return 0;
 }
=20
--=20
2.25.2

