Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14F93C433EF
	for <linux-block@archiver.kernel.org>; Fri, 18 Mar 2022 13:02:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234171AbiCRNDp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Mar 2022 09:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236445AbiCRNDp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Mar 2022 09:03:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1A22A2D88B4
        for <linux-block@vger.kernel.org>; Fri, 18 Mar 2022 06:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647608546;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3W0M/BBfzZbsqqK200rXuJccKS6ccAxcTmDqI4IZ2l4=;
        b=S92+e5u/oULKLPOJpMkqVueVq8AVkDbRWgkiXL0xwvpHgrK9tPnh0R0V8owVSmlCmbYsMo
        opweSpIZpuD6jR29ruW2mPj+azz0w8n2VVvbQcggK+7wb6rcT4U6u/epwXqRVqq+XoNPtU
        Zkm9y1uUrelrr3rvNmgOKvPjnNQ2cFg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-586-EP2z1a7XOnS9MPqbQun0qg-1; Fri, 18 Mar 2022 09:02:23 -0400
X-MC-Unique: EP2z1a7XOnS9MPqbQun0qg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9ADB218E0042;
        Fri, 18 Mar 2022 13:02:22 +0000 (UTC)
Received: from localhost (ovpn-8-20.pek2.redhat.com [10.72.8.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AD7BA2EFA3;
        Fri, 18 Mar 2022 13:02:21 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Yu Kuai <yukuai3@huawei.com>, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 2/3] block: let blkcg_gq grab request queue's refcnt
Date:   Fri, 18 Mar 2022 21:01:43 +0800
Message-Id: <20220318130144.1066064-3-ming.lei@redhat.com>
In-Reply-To: <20220318130144.1066064-1-ming.lei@redhat.com>
References: <20220318130144.1066064-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In the whole lifetime of blkcg_gq instance, ->q will be referred, such
as, ->pd_free_fn() is called in blkg_free, and throtl_pd_free() still
may touch the request queue via &tg->service_queue.pending_timer which
is handled by throtl_pending_timer_fn(), so it is reasonable to grab
request queue's refcnt by blkcg_gq instance.

Previously blkcg_exit_queue() is called from blk_release_queue, and it
is hard to avoid the use-after-free. But recently commit 1059699f87eb ("block:
move blkcg initialization/destroy into disk allocation/release handler")
is merged to for-5.18/block, it becomes simple to fix the issue by simply
grabbing request queue's refcnt.

Reported-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-cgroup.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index fa063c6c0338..d53b0d69dd73 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -82,6 +82,8 @@ static void blkg_free(struct blkcg_gq *blkg)
 		if (blkg->pd[i])
 			blkcg_policy[i]->pd_free_fn(blkg->pd[i]);
 
+	if (blkg->q)
+		blk_put_queue(blkg->q);
 	free_percpu(blkg->iostat_cpu);
 	percpu_ref_exit(&blkg->refcnt);
 	kfree(blkg);
@@ -167,6 +169,9 @@ static struct blkcg_gq *blkg_alloc(struct blkcg *blkcg, struct request_queue *q,
 	if (!blkg->iostat_cpu)
 		goto err_free;
 
+	if (!blk_get_queue(q))
+		goto err_free;
+
 	blkg->q = q;
 	INIT_LIST_HEAD(&blkg->q_node);
 	spin_lock_init(&blkg->async_bio_lock);
-- 
2.31.1

