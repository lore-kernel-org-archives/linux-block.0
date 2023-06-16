Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25449EB64D7
	for <linux-block@archiver.kernel.org>; Fri, 16 Jun 2023 13:24:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345547AbjFPNY5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Jun 2023 09:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345665AbjFPNY4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Jun 2023 09:24:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 570D13593
        for <linux-block@vger.kernel.org>; Fri, 16 Jun 2023 06:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686921843;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=fvyIBhCmIa02JifUqylvlN6bM+Xl3WwUs/XeMyD02Zs=;
        b=W/OHcrR7/SvIGVsQCUOXDD/0ifoaT7K+r2AtI1e6otYf3pvd7I+wa+4Uix87Gkbj7xHXYH
        rCSLrMWGkgw9gabGjmidLpNDF1+cmQvpgTGkzzeTD6yCevd1DMfFHQjSCHv+zSwx2n88xn
        jb7F/1vue2AjtvwQqU2lvwIb3Q2h+EI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-483-g6_Mvr7FM9-nZOPdrqpOEw-1; Fri, 16 Jun 2023 09:24:01 -0400
X-MC-Unique: g6_Mvr7FM9-nZOPdrqpOEw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4D1D085A5A6;
        Fri, 16 Jun 2023 13:24:01 +0000 (UTC)
Received: from localhost (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 842F548FB02;
        Fri, 16 Jun 2023 13:24:00 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Guangwu Zhang <guazhang@redhat.com>
Subject: [PATCH] blk-mq: fix NULL dereference on q->elevator in blk_mq_elv_switch_none
Date:   Fri, 16 Jun 2023 21:23:54 +0800
Message-Id: <20230616132354.415109-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

After grabbing q->sysfs_lock, q->elevator may become NULL because of
elevator switch.

Fix the NULL dereference on q->elevator by checking it with lock.

Reported-by: Guangwu Zhang <guazhang@redhat.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 850bfb844ed2..9516f65a50ea 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4608,9 +4608,6 @@ static bool blk_mq_elv_switch_none(struct list_head *head,
 {
 	struct blk_mq_qe_pair *qe;
 
-	if (!q->elevator)
-		return true;
-
 	qe = kmalloc(sizeof(*qe), GFP_NOIO | __GFP_NOWARN | __GFP_NORETRY);
 	if (!qe)
 		return false;
@@ -4618,6 +4615,12 @@ static bool blk_mq_elv_switch_none(struct list_head *head,
 	/* q->elevator needs protection from ->sysfs_lock */
 	mutex_lock(&q->sysfs_lock);
 
+	/* the check has to be done with holding sysfs_lock */
+	if (!q->elevator) {
+		kfree(qe);
+		goto unlock;
+	}
+
 	INIT_LIST_HEAD(&qe->node);
 	qe->q = q;
 	qe->type = q->elevator->type;
@@ -4625,6 +4628,7 @@ static bool blk_mq_elv_switch_none(struct list_head *head,
 	__elevator_get(qe->type);
 	list_add(&qe->node, head);
 	elevator_disable(q);
+unlock:
 	mutex_unlock(&q->sysfs_lock);
 
 	return true;
-- 
2.40.1

