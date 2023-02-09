Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C2A7C05027
	for <linux-block@archiver.kernel.org>; Thu,  9 Feb 2023 03:21:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232667AbjBIDVc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 8 Feb 2023 22:21:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232689AbjBIDVK (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 8 Feb 2023 22:21:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46D741351B
        for <linux-block@vger.kernel.org>; Wed,  8 Feb 2023 19:19:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675912781;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=4UDpAk2OyCUXN8GiJ3ngMVVytkMNtj2wvjz+TJWs2J8=;
        b=gtH023cYFX9mHXRQdDkG21iMCmWRSQPmg6/DCqq3bTh/WYPypGIhLBGfUtsQqdKEaASRQm
        0RG4v0BEtbEmLjnqM70eLyyQj+ppgoBOnJMP/ynYaxNeMYWs4OQuiisH3prIjwasKZ7Ud/
        RLajgsEchCXLvHEmqIcsLMKKNAUWzcA=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-25-hAt6WxVJMGOAKiK7qUCKfg-1; Wed, 08 Feb 2023 22:19:40 -0500
X-MC-Unique: hAt6WxVJMGOAKiK7qUCKfg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CEE101C04324;
        Thu,  9 Feb 2023 03:19:39 +0000 (UTC)
Received: from localhost.localdomain (ovpn-13-241.pek2.redhat.com [10.72.13.241])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AFEF440CF8E7;
        Thu,  9 Feb 2023 03:19:32 +0000 (UTC)
From:   Xiao Ni <xni@redhat.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, ming.lei@redhat.com
Subject: [PATCH 1/1] block: Merge bio before checking ->cached_rq
Date:   Thu,  9 Feb 2023 11:19:30 +0800
Message-Id: <20230209031930.27354-1-xni@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

It checks if plug->cached_rq is empty before merging bio. But the merge action
doesn't have relationship with plug->cached_rq, it trys to merge bio with
requests within plug->mq_list. Now it checks if ->cached_rq is empty before
merging bio. If it's empty, it will miss the merge chances. So move the merge
function before checking ->cached_rq.

Signed-off-by: Xiao Ni <xni@redhat.com>
---
 block/blk-mq.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 9c8dc70020bc..63bd7a34fe6f 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2894,15 +2894,16 @@ static inline struct request *blk_mq_get_cached_request(struct request_queue *q,
 
 	if (!plug)
 		return NULL;
-	rq = rq_list_peek(&plug->cached_rq);
-	if (!rq || rq->q != q)
-		return NULL;
 
 	if (blk_mq_attempt_bio_merge(q, *bio, nsegs)) {
 		*bio = NULL;
 		return NULL;
 	}
 
+	rq = rq_list_peek(&plug->cached_rq);
+	if (!rq || rq->q != q)
+		return NULL;
+
 	type = blk_mq_get_hctx_type((*bio)->bi_opf);
 	hctx_type = rq->mq_hctx->type;
 	if (type != hctx_type &&
-- 
2.32.0 (Apple Git-132)

