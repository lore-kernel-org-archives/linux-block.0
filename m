Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC6F6C49EA5
	for <linux-block@archiver.kernel.org>; Fri, 25 Jun 2021 02:03:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1904613BD
	for <linux-block@archiver.kernel.org>; Fri, 25 Jun 2021 02:03:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232933AbhFYCFY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Jun 2021 22:05:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34920 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232917AbhFYCFY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Jun 2021 22:05:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624586583;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Xx33HKzU07j50m3jrrpZHdUPjnx0BHZNcVCbVhD8VRE=;
        b=RuqJw/yviUvNZAo4ffqtuiaDovIXi8uDbkRF1kpkiG8xOf17UxSuMtUPSMDhLnluRq8dJE
        McJdufX1rdps8GYyuAAfKCQItJs5OArOzCXntq3yAS2AAiRrbM2evIQkdHsP6WFoUt2Zee
        KXtAY+/YrbSW4ddSu6iuyV6yng/pqF8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-236-GXj0m8t6MG6zz21DTQo8Dg-1; Thu, 24 Jun 2021 22:03:01 -0400
X-MC-Unique: GXj0m8t6MG6zz21DTQo8Dg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 16D878018A5;
        Fri, 25 Jun 2021 02:03:00 +0000 (UTC)
Received: from localhost (ovpn-13-170.pek2.redhat.com [10.72.13.170])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A91275C1A3;
        Fri, 25 Jun 2021 02:02:56 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH RESEND] blk-mq: update hctx->dispatch_busy in case of real scheduler
Date:   Fri, 25 Jun 2021 10:02:48 +0800
Message-Id: <20210625020248.1630497-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Commit 6e6fcbc27e77 ("blk-mq: support batching dispatch in case of io")
starts to support io batching submission by using hctx->dispatch_busy.

However, blk_mq_update_dispatch_busy() isn't changed to update hctx->dispatch_busy
in that commit, so fix the issue by updating hctx->dispatch_busy in case
of real scheduler.

Reported-by: Jan Kara <jack@suse.cz>
Reviewed-by: Jan Kara <jack@suse.cz>
Fixes: 6e6fcbc27e77 ("blk-mq: support batching dispatch in case of io")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index df5dc3b756f5..8fe75ec2b052 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1252,9 +1252,6 @@ static void blk_mq_update_dispatch_busy(struct blk_mq_hw_ctx *hctx, bool busy)
 {
 	unsigned int ewma;
 
-	if (hctx->queue->elevator)
-		return;
-
 	ewma = hctx->dispatch_busy;
 
 	if (!ewma && !busy)
-- 
2.31.1

