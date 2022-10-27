Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3016C38A2D
	for <linux-block@archiver.kernel.org>; Thu, 27 Oct 2022 08:57:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234282AbiJ0I5f (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Oct 2022 04:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234173AbiJ0I5e (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Oct 2022 04:57:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DEC4B03E3
        for <linux-block@vger.kernel.org>; Thu, 27 Oct 2022 01:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666861052;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=VsjYIRgooNe0W+o1o1Hlh6ktW6MVxVNGB3etGgKaZhU=;
        b=FyiadgYg7s9ReT4iPUTWfKotxMzt+11mXZS+/BUxPLWixcZTw/Q53N67dtt6IacHKyyJvS
        QJkKOrQzy2xB++Ovxb528axd032ab7Ht6khy2pDVlpqzPocS6UHylISx2EAlnT2ISu0K+o
        Lm94CyvL5TzMR+6lLaQ+Ynl6jNUdzx0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-401-20UCIlNMMNqwIpXiyZS0Sw-1; Thu, 27 Oct 2022 04:57:24 -0400
X-MC-Unique: 20UCIlNMMNqwIpXiyZS0Sw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0743D82DFC7;
        Thu, 27 Oct 2022 08:57:24 +0000 (UTC)
Received: from localhost (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 98C6820290A6;
        Thu, 27 Oct 2022 08:57:22 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        dm-devel@redhat.com, Mike Snitzer <snitzer@kernel.org>,
        Changhui Zhong <czhong@redhat.com>
Subject: [PATCH] blk-mq: don't add non-pt request with ->end_io to batch
Date:   Thu, 27 Oct 2022 16:57:09 +0800
Message-Id: <20221027085709.513175-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

dm-rq implements ->end_io callback for request issued to underlying queue,
and it isn't passthrough request.

Commit ab3e1d3bbab9 ("block: allow end_io based requests in the completion
batch handling") doesn't clear rq->bio and rq->__data_len for request
with ->end_io in blk_mq_end_request_batch(), and this way is actually
dangerous, but so far it is only for nvme passthrough request.

dm-rq needs to clean up remained bios in case of partial completion,
and req->bio is required, then use-after-free is triggered, so the
underlying clone request can't be completed in blk_mq_end_request_batch.

Fix panic by not adding such request into batch list, and the issue
can be triggered simply by exposing nvme pci to dm-mpath simply.

Fixes: ab3e1d3bbab9 ("block: allow end_io based requests in the completion batch handling")
Cc: dm-devel@redhat.com
Cc: Mike Snitzer <snitzer@kernel.org>
Reported-by: Changhui Zhong <czhong@redhat.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 include/linux/blk-mq.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index ba18e9bdb799..d6119c5d1069 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -853,7 +853,8 @@ static inline bool blk_mq_add_to_batch(struct request *req,
 				       struct io_comp_batch *iob, int ioerror,
 				       void (*complete)(struct io_comp_batch *))
 {
-	if (!iob || (req->rq_flags & RQF_ELV) || ioerror)
+	if (!iob || (req->rq_flags & RQF_ELV) || ioerror ||
+			(req->end_io && !blk_rq_is_passthrough(req)))
 		return false;
 
 	if (!iob->complete)
-- 
2.31.1

