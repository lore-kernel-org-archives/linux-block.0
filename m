Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC2F0C4332F
	for <linux-block@archiver.kernel.org>; Thu, 15 Dec 2022 02:17:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbiLOCRg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Dec 2022 21:17:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiLOCRf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Dec 2022 21:17:35 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD44E537DA
        for <linux-block@vger.kernel.org>; Wed, 14 Dec 2022 18:16:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671070608;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=B41vHQu3wkjdeVx/bVMUmGUCdCJAuukDi0ZM85456ts=;
        b=SrkaYsN+YFs09SoWE4Zh3CsVm9ABwLuPG8zvzWoo6FX7x/4xlk+d3ZMQMPCphlmwopY9Tb
        AfmlovGepTQF1WDcKhTKjB7cgaLb7PqSPG9dqsr+aOd4H9muA7RSaz9Tl48hkgxJwCxRSj
        e1KW5vX5Ksy2CNdZp4YC47QJ2wPUc2w=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-563-4RuOVaKiOFm1d5iPZyukxQ-1; Wed, 14 Dec 2022 21:16:42 -0500
X-MC-Unique: 4RuOVaKiOFm1d5iPZyukxQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C7F2B86C166;
        Thu, 15 Dec 2022 02:16:41 +0000 (UTC)
Received: from localhost (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E18412026D68;
        Thu, 15 Dec 2022 02:16:39 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Zhang Wensheng <zhangwensheng@huaweicloud.com>,
        Zhong Jinghua <zhongjinghua@huawei.com>,
        Hillf Danton <hdanton@sina.com>, Yu Kuai <yukuai3@huawei.com>,
        Dennis Zhou <dennis@kernel.org>
Subject: [PATCH] block: fix use-after-free of q->q_usage_counter
Date:   Thu, 15 Dec 2022 10:16:29 +0800
Message-Id: <20221215021629.74870-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

For blk-mq, queue release handler is usually called into after
blk_mq_freeze_queue_wait() returns. However, q_usage_counter->release()
handler may not be started yet at that time, so cause user-after-free.

Fix the issue by moving percpu_ref_exit() into blk_free_queue_rcu()
since ->release() is called with rcu read lock held, since it is
concluded that the race should be covered in caller per discussion
from the two links.

Reported-by: Zhang Wensheng <zhangwensheng@huaweicloud.com>
Reported-by: Zhong Jinghua <zhongjinghua@huawei.com>
Link: https://lore.kernel.org/linux-block/Y5prfOjyyjQKUrtH@T590/T/#u
Link: https://lore.kernel.org/lkml/Y4%2FmzMd4evRg9yDi@fedora/
Cc: Hillf Danton <hdanton@sina.com>
Cc: Yu Kuai <yukuai3@huawei.com>
Cc: Dennis Zhou <dennis@kernel.org>
Fixes: 2b0d3d3e4fcf ("percpu_ref: reduce memory footprint of percpu_ref in fast path")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-core.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 3866b6c4cd88..9321767470dc 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -254,14 +254,15 @@ EXPORT_SYMBOL_GPL(blk_clear_pm_only);
 
 static void blk_free_queue_rcu(struct rcu_head *rcu_head)
 {
-	kmem_cache_free(blk_requestq_cachep,
-			container_of(rcu_head, struct request_queue, rcu_head));
+	struct request_queue *q = container_of(rcu_head,
+			struct request_queue, rcu_head);
+
+	percpu_ref_exit(&q->q_usage_counter);
+	kmem_cache_free(blk_requestq_cachep, q);
 }
 
 static void blk_free_queue(struct request_queue *q)
 {
-	percpu_ref_exit(&q->q_usage_counter);
-
 	if (q->poll_stat)
 		blk_stat_remove_callback(q, q->poll_cb);
 	blk_stat_free_callback(q->poll_cb);
-- 
2.31.1

