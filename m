Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A082CD8C8B
	for <linux-block@archiver.kernel.org>; Tue, 10 Oct 2023 14:23:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232966AbjJJOXt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 Oct 2023 10:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232779AbjJJOXs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Oct 2023 10:23:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F36EBA9
        for <linux-block@vger.kernel.org>; Tue, 10 Oct 2023 07:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696947781;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=eanIYdQ/OkURqG898KbJm4DzgfTGcpyCx3WajorKeyU=;
        b=GPa5lUcH8SPu4ADyQCCDGjImbD0X207efKzOOodRUgAXpqB2kZWJQReUbf9zMBGsHbJQ4B
        PuiYWfhmUYgyLrQIkhQEjbT46lISScXWwgSBSpu7hXWpBjJUxgd7jep/fKZgOWqNuT9nje
        MbC7Ukh8Pwc7FSM/Gu/4Ka+UmSbM9Y8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-101-Ztn_c7GENNWS0tBFcB0GLA-1; Tue, 10 Oct 2023 10:22:51 -0400
X-MC-Unique: Ztn_c7GENNWS0tBFcB0GLA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D87EC1C068DC;
        Tue, 10 Oct 2023 14:22:34 +0000 (UTC)
Received: from localhost (unknown [10.72.120.3])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 034B125C3;
        Tue, 10 Oct 2023 14:22:33 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        linux-kernel@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Andrew Theurer <atheurer@redhat.com>,
        Joe Mario <jmario@redhat.com>, Sebastian Jug <sejug@redhat.com>
Subject: [PATCH] blk-mq: add module parameter to not run block kworker on isolated CPUs
Date:   Tue, 10 Oct 2023 22:22:16 +0800
Message-ID: <20231010142216.1114752-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Kernel parameter of `isolcpus=` is used for isolating CPUs for specific
task, and user often won't want block IO to disturb these CPUs, also long
IO latency may be caused if blk-mq kworker is scheduled on these isolated
CPUs.

Kernel workqueue only respects this limit for WQ_UNBOUND, for bound wq,
the responsibility should be on wq user.

Add one block layer parameter for not running block kworker on isolated
CPUs.

Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Andrew Theurer <atheurer@redhat.com>
Cc: Joe Mario <jmario@redhat.com>
Cc: Sebastian Jug <sejug@redhat.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index ec922c6bccbe..c53b5b522053 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -29,6 +29,7 @@
 #include <linux/prefetch.h>
 #include <linux/blk-crypto.h>
 #include <linux/part_stat.h>
+#include <linux/sched/isolation.h>
 
 #include <trace/events/block.h>
 
@@ -42,6 +43,13 @@
 #include "blk-rq-qos.h"
 #include "blk-ioprio.h"
 
+static bool respect_cpu_isolation;
+module_param(respect_cpu_isolation, bool, 0444);
+MODULE_PARM_DESC(respect_cpu_isolation,
+		"Don't schedule blk-mq worker on isolated CPUs passed in "
+		"isolcpus= or nohz_full=. User need to guarantee to not run "
+		"block IO on isolated CPUs (default: false)");
+
 static DEFINE_PER_CPU(struct llist_head, blk_cpu_done);
 static DEFINE_PER_CPU(call_single_data_t, blk_cpu_csd);
 
@@ -3926,6 +3934,13 @@ static void blk_mq_map_swqueue(struct request_queue *q)
 		 */
 		sbitmap_resize(&hctx->ctx_map, hctx->nr_ctx);
 
+		if (respect_cpu_isolation) {
+			cpumask_and(hctx->cpumask, hctx->cpumask,
+					housekeeping_cpumask(HK_TYPE_DOMAIN));
+			cpumask_and(hctx->cpumask, hctx->cpumask,
+					housekeeping_cpumask(HK_TYPE_WQ));
+		}
+
 		/*
 		 * Initialize batch roundrobin counts
 		 */
-- 
2.41.0

