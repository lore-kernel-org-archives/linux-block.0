Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D88D8C433EF
	for <linux-block@archiver.kernel.org>; Wed, 15 Jun 2022 02:37:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233149AbiFOChb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 Jun 2022 22:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbiFOCh2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Jun 2022 22:37:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 81AAD1838F
        for <linux-block@vger.kernel.org>; Tue, 14 Jun 2022 19:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655260646;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eWgbNpmz1do2H3rl+DBMbVtvWMFKGHNxVfJpzB8RB5o=;
        b=gpyuJJfylZmJpZhVkg3Zjdn4oigNsB3Qs5vYBBUBex2heFyWLJB4K9h2ZdCvzajQ93Xb9k
        a4J9mCsTwegh3GahfondeF1Vo/xT//WUBoZvcTDJpCKTQaZgu92mukUOOtYdcJziUK7HYo
        iSvUEQl2qYQS20Zr3Gvx5PlZjQlu/aw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-481-mlZHf8_6OE2JUCYfQZ-j-w-1; Tue, 14 Jun 2022 22:37:23 -0400
X-MC-Unique: mlZHf8_6OE2JUCYfQZ-j-w-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C4AC985A580;
        Wed, 15 Jun 2022 02:37:22 +0000 (UTC)
Received: from localhost (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E8C7A492C3B;
        Wed, 15 Jun 2022 02:37:21 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 1/3] blk-mq: protect q->elevator by ->sysfs_lock
Date:   Wed, 15 Jun 2022 10:37:10 +0800
Message-Id: <20220615023712.750122-2-ming.lei@redhat.com>
In-Reply-To: <20220615023712.750122-1-ming.lei@redhat.com>
References: <20220615023712.750122-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

elevator can be tore down by sysfs switch interface or disk release, so
hold ->sysfs_lock before referring to q->elevator, then potential
use-after-free can be avoided.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index e9bf950983c7..22a89c758f70 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4438,12 +4438,14 @@ static bool blk_mq_elv_switch_none(struct list_head *head,
 	if (!qe)
 		return false;
 
+	/* q->elevator needs protection from ->sysfs_lock */
+	mutex_lock(&q->sysfs_lock);
+
 	INIT_LIST_HEAD(&qe->node);
 	qe->q = q;
 	qe->type = q->elevator->type;
 	list_add(&qe->node, head);
 
-	mutex_lock(&q->sysfs_lock);
 	/*
 	 * After elevator_switch_mq, the previous elevator_queue will be
 	 * released by elevator_release. The reference of the io scheduler
-- 
2.31.1

