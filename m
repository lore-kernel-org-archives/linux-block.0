Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE594C2FC39
	for <linux-block@archiver.kernel.org>; Thu, 17 Aug 2023 14:19:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351788AbjHQOTP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Aug 2023 10:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351804AbjHQOSu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Aug 2023 10:18:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD5C12102
        for <linux-block@vger.kernel.org>; Thu, 17 Aug 2023 07:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692281883;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=eYnFt28lNdZriUp21eHzMX+2y8ItViASJPhu+RHShGw=;
        b=ME2iU3WtBm4lUv0nQzaeIVgjmy95oXnzRMnvVatcFZro+oyXsUKxuix7tkqEkxjwT6w3F6
        W2SJp8OvYruMYF14vO48m1EM7PmZxAXC7Zz8UGiCfd2a6rC3ikCJ3Ee0BEgvU44pamdsNM
        4MjklkAAl/ej5RI1b1tklxMrFnaApwI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-206-LtV6zdAsOj-IhUeaKPR7Ww-1; Thu, 17 Aug 2023 10:18:01 -0400
X-MC-Unique: LtV6zdAsOj-IhUeaKPR7Ww-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 866F2101AA5F;
        Thu, 17 Aug 2023 14:18:00 +0000 (UTC)
Received: from localhost (unknown [10.72.120.3])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BFD6740C207A;
        Thu, 17 Aug 2023 14:17:58 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Yu Kuai <yukuai3@huawei.com>, xiaoli feng <xifeng@redhat.com>,
        Chunyu Hu <chuhu@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, Tejun Heo <tj@kernel.org>
Subject: [PATCH] blk-cgroup: hold queue_lock when removing blkg->q_node
Date:   Thu, 17 Aug 2023 22:17:51 +0800
Message-Id: <20230817141751.1128970-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When blkg is removed from q->blkg_list from blkg_free_workfn(), queue_lock
has to be held, otherwise, all kinds of bugs(list corruption, hard lockup,
..) can be triggered from blkg_destroy_all().

Fixes: f1c006f1c685 ("blk-cgroup: synchronize pd_free_fn() from blkg_free_workfn() and blkcg_deactivate_policy()")
Cc: Yu Kuai <yukuai3@huawei.com>
Cc: xiaoli feng <xifeng@redhat.com>
Cc: Chunyu Hu <chuhu@redhat.com>
Cc: Mike Snitzer <snitzer@kernel.org>
Cc: Tejun Heo <tj@kernel.org>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-cgroup.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index fc49be622e05..9faafcd10e17 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -136,7 +136,9 @@ static void blkg_free_workfn(struct work_struct *work)
 			blkcg_policy[i]->pd_free_fn(blkg->pd[i]);
 	if (blkg->parent)
 		blkg_put(blkg->parent);
+	spin_lock_irq(&q->queue_lock);
 	list_del_init(&blkg->q_node);
+	spin_unlock_irq(&q->queue_lock);
 	mutex_unlock(&q->blkcg_mutex);
 
 	blk_put_queue(q);
-- 
2.40.1

