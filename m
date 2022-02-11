Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5F3CC433EF
	for <linux-block@archiver.kernel.org>; Fri, 11 Feb 2022 10:12:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232558AbiBKKMt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 11 Feb 2022 05:12:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348821AbiBKKMs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Feb 2022 05:12:48 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2FE0B2D3
        for <linux-block@vger.kernel.org>; Fri, 11 Feb 2022 02:12:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644574367;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n2RhEKr6bE6xxFpA9RLULifB9nfGHMVrq/H4Lw2gca4=;
        b=iby4BodSCCxHrsVvz6rjmrcAn8dFy0sAgmQCkcoNRYgJWeCweEbB/UY+JiyresiIyBniST
        dJ0iXsOEFUAk373EvB+8Df5YnoTIa3wt3jjV4drdL44UrBetGXiMKyyPJcbsG+KPypTRYa
        +xNiRhrlcTxgveRNkFdqi01T1jNt0zw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-532-5uI17IfsMWyyrADh1wC53A-1; Fri, 11 Feb 2022 05:12:44 -0500
X-MC-Unique: 5uI17IfsMWyyrADh1wC53A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0EBAD64146;
        Fri, 11 Feb 2022 10:12:43 +0000 (UTC)
Received: from localhost (ovpn-8-26.pek2.redhat.com [10.72.8.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4D79228567;
        Fri, 11 Feb 2022 10:12:42 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 2/3] block: move initialization of q->blkg_list into blkcg_init_queue
Date:   Fri, 11 Feb 2022 18:11:48 +0800
Message-Id: <20220211101149.2368042-3-ming.lei@redhat.com>
In-Reply-To: <20220211101149.2368042-1-ming.lei@redhat.com>
References: <20220211101149.2368042-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

q->blkg_list is only used by blkcg code, so move it into
blkcg_init_queue.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-cgroup.c | 2 ++
 block/blk-core.c   | 3 ---
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 671debbae941..35deaceba1f0 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1175,6 +1175,8 @@ int blkcg_init_queue(struct request_queue *q)
 	bool preloaded;
 	int ret;
 
+	INIT_LIST_HEAD(&q->blkg_list);
+
 	new_blkg = blkg_alloc(&blkcg_root, q, GFP_KERNEL);
 	if (!new_blkg)
 		return -ENOMEM;
diff --git a/block/blk-core.c b/block/blk-core.c
index be8812f5489d..ff972b968f25 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -476,9 +476,6 @@ struct request_queue *blk_alloc_queue(int node_id, bool alloc_srcu)
 	timer_setup(&q->timeout, blk_rq_timed_out_timer, 0);
 	INIT_WORK(&q->timeout_work, blk_timeout_work);
 	INIT_LIST_HEAD(&q->icq_list);
-#ifdef CONFIG_BLK_CGROUP
-	INIT_LIST_HEAD(&q->blkg_list);
-#endif
 
 	kobject_init(&q->kobj, &blk_queue_ktype);
 
-- 
2.31.1

