Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72CA8C433EF
	for <linux-block@archiver.kernel.org>; Fri,  3 Dec 2021 02:39:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350905AbhLCCnT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Dec 2021 21:43:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:20393 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350764AbhLCCnT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 2 Dec 2021 21:43:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638499195;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=XDmcG16f1PFE6xYp9ePWLzHtC7r4uIgIdp5U9lVkP5E=;
        b=ETl1pRETX9Ilz0WaMOR9DpjzEOIPx1xdyR6/4AI7JnKuaHdJxxYtXMk4xQGETDzAPoonM7
        0GYDVH/CrXqH4BqiP2GDmS0H6bvUjQakCebtZY0hqIO2lgiK+EYffBMVDQl9hDrSCuIgha
        ru3+uLMimx1rG5o6Ongf+KbzJKJyAEw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-213-I1_seT3MPVuHpjA4N__I6g-1; Thu, 02 Dec 2021 21:39:54 -0500
X-MC-Unique: I1_seT3MPVuHpjA4N__I6g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6D49F1006AB2;
        Fri,  3 Dec 2021 02:39:53 +0000 (UTC)
Received: from localhost (ovpn-8-30.pek2.redhat.com [10.72.8.30])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 76A9E60843;
        Fri,  3 Dec 2021 02:39:39 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH] null_blk: allow zero poll queues
Date:   Fri,  3 Dec 2021 10:39:35 +0800
Message-Id: <20211203023935.3424042-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

There isn't any reason to not allow zero poll queues from user
viewpoint.

Also sometimes we need to compare io poll between poll mode and irq
mode, so not allowing poll queues is bad.

Fixes: 15dfc662ef31 ("null_blk: Fix handling of submit_queues and poll_queues attributes")
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/null_blk/main.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 54f7d490f8eb..b4ff5ae1f70c 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -340,9 +340,9 @@ static int nullb_update_nr_hw_queues(struct nullb_device *dev,
 		return 0;
 
 	/*
-	 * Make sure at least one queue exists for each of submit and poll.
+	 * Make sure at least one submit queue exists.
 	 */
-	if (!submit_queues || !poll_queues)
+	if (!submit_queues)
 		return -EINVAL;
 
 	/*
@@ -1917,8 +1917,6 @@ static int null_validate_conf(struct nullb_device *dev)
 
 	if (dev->poll_queues > g_poll_queues)
 		dev->poll_queues = g_poll_queues;
-	else if (dev->poll_queues == 0)
-		dev->poll_queues = 1;
 	dev->prev_poll_queues = dev->poll_queues;
 
 	dev->queue_mode = min_t(unsigned int, dev->queue_mode, NULL_Q_MQ);
-- 
2.31.1

