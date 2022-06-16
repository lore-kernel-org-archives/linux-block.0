Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7937DC433EF
	for <linux-block@archiver.kernel.org>; Thu, 16 Jun 2022 01:45:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245496AbiFPBod (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Jun 2022 21:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346690AbiFPBoQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Jun 2022 21:44:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1FD8927FC7
        for <linux-block@vger.kernel.org>; Wed, 15 Jun 2022 18:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655343855;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QsOdS3DR7iLYr2ypPb+YL+OARtOR5D6m11DGTRoTNmY=;
        b=SfMxAeM4Si/8NOYK5shCV5g2tfZPLYJUHlGDP+7/LUCGWrOH99wcMvzJ6ToUp6gzl7mXWF
        PzrFfIjNZlGftdKWaf4Mjz2b34xWfHf26CGNSrv71ZGrEfRMA8mX4O1X6C7BtdaTThqhZA
        lzwyh4dJsdoD8anwjzphpm839oVE+sg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-411-Au5TAjUeM2qp-osKpcQbJA-1; Wed, 15 Jun 2022 21:44:11 -0400
X-MC-Unique: Au5TAjUeM2qp-osKpcQbJA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 16CF783397B;
        Thu, 16 Jun 2022 01:44:11 +0000 (UTC)
Received: from localhost (ovpn-8-22.pek2.redhat.com [10.72.8.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4755140C141F;
        Thu, 16 Jun 2022 01:44:09 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 1/3] blk-mq: protect q->elevator by ->sysfs_lock in blk_mq_elv_switch_none
Date:   Thu, 16 Jun 2022 09:43:59 +0800
Message-Id: <20220616014401.817001-2-ming.lei@redhat.com>
In-Reply-To: <20220616014401.817001-1-ming.lei@redhat.com>
References: <20220616014401.817001-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

elevator can be tore down by sysfs switch interface or disk release, so
hold ->sysfs_lock before referring to q->elevator, then potential
use-after-free can be avoided.

Reviewed-by: Christoph Hellwig <hch@lst.de>
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

