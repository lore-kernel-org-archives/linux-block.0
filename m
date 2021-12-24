Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BEAEC433F5
	for <linux-block@archiver.kernel.org>; Fri, 24 Dec 2021 01:08:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231915AbhLXBIs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Dec 2021 20:08:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26500 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230130AbhLXBIs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Dec 2021 20:08:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640308127;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=L2HweA5yx0JUV8R/ix9WuhIsEqwY2v1CXamoZnqo6CE=;
        b=Ka7XlUd2+GcroI8KYHLcns9dOqKgc2gxSme/e2viray73vgOLg6sMnCAPnneBcQIfAruWv
        CVqBjcJZA8LLQV6dSTxDC8B5/1QH4j0tBSZlL1YUW9zelNzUtWP35B25wVNK2oXYILF8N8
        v8Z5AAQXngKTrywgxLBuXWIgvGHGELI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-248-DKCTurLENu6rDS5AL8XrBw-1; Thu, 23 Dec 2021 20:08:46 -0500
X-MC-Unique: DKCTurLENu6rDS5AL8XrBw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4E449102CB76;
        Fri, 24 Dec 2021 01:08:45 +0000 (UTC)
Received: from localhost (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BD47F5E4AE;
        Fri, 24 Dec 2021 01:08:40 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH] block: null_blk: only set set->nr_maps as 3 if active poll_queues is > 0
Date:   Fri, 24 Dec 2021 09:08:31 +0800
Message-Id: <20211224010831.1521805-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

It isn't correct to set set->nr_maps as 3 if g_poll_queues is > 0 since
we can change it via configfs for null_blk device created there, so only
set it as 3 if active poll_queues is > 0.

Fixes divide zero exception reported by Shinichiro.

Fixes: 2bfdbe8b7ebd ("null_blk: allow zero poll queues")
Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/null_blk/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 6be6ccd4a28f..13004beb48ca 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -1892,7 +1892,7 @@ static int null_init_tag_set(struct nullb *nullb, struct blk_mq_tag_set *set)
 	if (g_shared_tag_bitmap)
 		set->flags |= BLK_MQ_F_TAG_HCTX_SHARED;
 	set->driver_data = nullb;
-	if (g_poll_queues)
+	if (poll_queues)
 		set->nr_maps = 3;
 	else
 		set->nr_maps = 1;
-- 
2.31.1

