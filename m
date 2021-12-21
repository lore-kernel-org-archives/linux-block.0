Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5FB1C433EF
	for <linux-block@archiver.kernel.org>; Tue, 21 Dec 2021 04:04:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbhLUEE4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Dec 2021 23:04:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:52673 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230350AbhLUEE4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Dec 2021 23:04:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640059495;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=YBn+RhZfQ2Sc4MwU8DnefiNeMHuUDJY1XjO3o37cPp4=;
        b=KufgsCHHFsCddTB9E0uv4w2ZVf+HoCOr4aUkNVMOAy63NE/f9sfoDXqwmoyMdXXDGaTA42
        reUU0xMUtd/Eb9hwBx9rcmqqgWSJOD+At9lGWEg2fz+iYJz+Jvst+rBRTE3VlofPyAu3pV
        vhTWH0TG88MCLT+EIQamb2iV5yn1WLk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-113-6DZzXxAAM-qHd2dqgczfBg-1; Mon, 20 Dec 2021 23:04:52 -0500
X-MC-Unique: 6DZzXxAAM-qHd2dqgczfBg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1EE2F10066FE;
        Tue, 21 Dec 2021 04:04:51 +0000 (UTC)
Received: from localhost (ovpn-8-30.pek2.redhat.com [10.72.8.30])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A3D8F7E67D;
        Tue, 21 Dec 2021 04:04:37 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH] block: call blk_exit_queue() before freeing q->stats
Date:   Tue, 21 Dec 2021 12:04:36 +0800
Message-Id: <20211221040436.1333880-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

blk_stat_disable_accounting() is added in commit 68497092bde9
("block: make queue stat accounting a reference"), and called in
kyber_exit_sched().

So we have to free q->stats after elevator is unloaded from
blk_exit_queue() in blk_release_queue(). Otherwise kernel panic
is caused.

Fixes: 68497092bde9 ("block: make queue stat accounting a reference")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-sysfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 3e6357321225..e20eadfcf5c8 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -791,11 +791,11 @@ static void blk_release_queue(struct kobject *kobj)
 		blk_stat_remove_callback(q, q->poll_cb);
 	blk_stat_free_callback(q->poll_cb);
 
+	blk_exit_queue(q);
+
 	blk_free_queue_stats(q->stats);
 	kfree(q->poll_stat);
 
-	blk_exit_queue(q);
-
 	blk_queue_free_zone_bitmaps(q);
 
 	if (queue_is_mq(q))
-- 
2.31.1

