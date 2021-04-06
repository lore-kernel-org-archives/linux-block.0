Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B70CAC433ED
	for <linux-block@archiver.kernel.org>; Tue,  6 Apr 2021 03:23:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D8216124B
	for <linux-block@archiver.kernel.org>; Tue,  6 Apr 2021 03:23:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240277AbhDFDXK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 5 Apr 2021 23:23:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58810 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230364AbhDFDXK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 5 Apr 2021 23:23:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617679382;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=xZtS9exMV0Q/o8g3fCz5HcTaKQTbu2EFynNJ1+xwKEo=;
        b=R0NYj4dQpUONDZA7gmL80rxUb4C92HivjMYKHNlwDsOGo5MPt+t8x5rtYnpA5nDrv6gcAp
        6c3Z2zWdGHxBrlBS1piwDleSeUiJ6zM2aeGI40WElvwXHyPc9BMJuIc0UHp68sRYpfCRS2
        Zi1g0JP3udnxWzCqWS9R0q8LyZis5xY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-445-sn6jPURDMWK-gfw0Pn2mUQ-1; Mon, 05 Apr 2021 23:19:44 -0400
X-MC-Unique: sn6jPURDMWK-gfw0Pn2mUQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E40AC1084C8C;
        Tue,  6 Apr 2021 03:19:42 +0000 (UTC)
Received: from localhost (ovpn-12-144.pek2.redhat.com [10.72.12.144])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 21C1E5C729;
        Tue,  6 Apr 2021 03:19:38 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Yanhui Ma <yama@redhat.com>,
        John Garry <john.garry@huawei.com>,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH] blk-mq: set default elevator as deadline in case of hctx shared tagset
Date:   Tue,  6 Apr 2021 11:19:33 +0800
Message-Id: <20210406031933.767228-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Yanhui found that write performance is degraded a lot after applying
hctx shared tagset on one test machine with megaraid_sas. And turns out
it is caused by none scheduler which becomes default elevator caused by
hctx shared tagset patchset.

Given more scsi HBAs will apply hctx shared tagset, and the similar
performance exists for them too.

So keep previous behavior by still using default mq-deadline for queues
which apply hctx shared tagset, just like before.

Fixes: 32bc15afed04 ("blk-mq: Facilitate a shared sbitmap per tagset")
Reported-by: Yanhui Ma <yama@redhat.com>
Cc: John Garry <john.garry@huawei.com>
Cc: Hannes Reinecke <hare@suse.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/elevator.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/elevator.c b/block/elevator.c
index 293c5c81397a..440699c28119 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -621,7 +621,8 @@ static inline bool elv_support_iosched(struct request_queue *q)
  */
 static struct elevator_type *elevator_get_default(struct request_queue *q)
 {
-	if (q->nr_hw_queues != 1)
+	if (q->nr_hw_queues != 1 &&
+			!blk_mq_is_sbitmap_shared(q->tag_set->flags))
 		return NULL;
 
 	return elevator_get(q, "mq-deadline", false);
-- 
2.29.2

