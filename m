Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2277FC77B72
	for <linux-block@archiver.kernel.org>; Thu, 20 Apr 2023 11:24:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234301AbjDTLYE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Apr 2023 07:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234047AbjDTLXm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Apr 2023 07:23:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA639B750
        for <linux-block@vger.kernel.org>; Thu, 20 Apr 2023 04:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681989629;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=d2n7fnjsQvwaWtsjGf1IgInvHC2ml3w9pgOGz8iRVDw=;
        b=Ze9vpKAS1RNyq05cNng0z1SMLQfhJf2f4vT+jsAYK9OHs0SlsIJbBnhSqbWXOQjeVT60pW
        21aQSHlWcoXmFMezrCDpz7Np+WxJoqv0XZpibsXJ8QxgQKsNalkYlbQvOFnfcd5sFYCVco
        B0vtPSsYpvdpNMycBKn89pzB5qfGlsA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-115-U-bYexGrNW2mgQ6DMJVpMg-1; Thu, 20 Apr 2023 07:20:28 -0400
X-MC-Unique: U-bYexGrNW2mgQ6DMJVpMg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CA5BF8996F3;
        Thu, 20 Apr 2023 11:20:27 +0000 (UTC)
Received: from localhost (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 052C451E3;
        Thu, 20 Apr 2023 11:20:26 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Xiao Ni <xni@redhat.com>, Yi Zhang <yi.zhang@redhat.com>
Subject: [PATCH] Revert "block: Merge bio before checking ->cached_rq"
Date:   Thu, 20 Apr 2023 19:20:18 +0800
Message-Id: <20230420112018.1108058-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This reverts commit 23f3e3272e7a4d9fb870485cd6df1e4f9539282c.

blk-mq sched bio merge still needs request to grab queue usage counter,
so we can't simply call blk_mq_attempt_bio_merge() when queue usage
counter isn't held.

Fixes: 23f3e3272e7a ("block: Merge bio before checking ->cached_rq")
Cc: Xiao Ni <xni@redhat.com>
Reported-by: Yi Zhang <yi.zhang@redhat.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index cf1a39adf9a5..27a628a8ee88 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2880,16 +2880,15 @@ static inline struct request *blk_mq_get_cached_request(struct request_queue *q,
 
 	if (!plug)
 		return NULL;
+	rq = rq_list_peek(&plug->cached_rq);
+	if (!rq || rq->q != q)
+		return NULL;
 
 	if (blk_mq_attempt_bio_merge(q, *bio, nsegs)) {
 		*bio = NULL;
 		return NULL;
 	}
 
-	rq = rq_list_peek(&plug->cached_rq);
-	if (!rq || rq->q != q)
-		return NULL;
-
 	type = blk_mq_get_hctx_type((*bio)->bi_opf);
 	hctx_type = rq->mq_hctx->type;
 	if (type != hctx_type &&
-- 
2.39.2

