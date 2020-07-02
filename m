Return-Path: <SRS0=sMug=AN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLACK
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29EAEC433E0
	for <linux-block@archiver.kernel.org>; Thu,  2 Jul 2020 13:59:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F224220772
	for <linux-block@archiver.kernel.org>; Thu,  2 Jul 2020 13:59:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QCXofIv7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729514AbgGBN7O (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Jul 2020 09:59:14 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:24189 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726343AbgGBN7N (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 2 Jul 2020 09:59:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593698352;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=VP300vqh/YCGJ8Fee/Hc7TFjebVhfZVfnWMIQKgcXdg=;
        b=QCXofIv7hrMYzG/JOGLM54eHHuinLaYPar9vepkvAjl2A/o6jHW+OZvKEKcmP4qX/UEjsj
        V1ZdVIrScl8Iv0lOO474hQTSILt6dTi7gZCTJxF9eiyHjCJFy4mBTFpQ+nL7uis7WUmmTF
        2Jo1pr0zMFn8bOfg/gJm/YOIFWmW8R0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-78-zEu0AmdCN-mNq9oPj0rTYA-1; Thu, 02 Jul 2020 09:59:11 -0400
X-MC-Unique: zEu0AmdCN-mNq9oPj0rTYA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B9ECC186A219;
        Thu,  2 Jul 2020 13:59:09 +0000 (UTC)
Received: from localhost (ovpn-12-180.pek2.redhat.com [10.72.12.180])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 16D7210013D2;
        Thu,  2 Jul 2020 13:59:05 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Qian Cai <cai@lca.pw>, Sachin Sant <sachinp@linux.vnet.ibm.com>
Subject: [PATCH] blk-mq: avoid to account active request repeatedly
Date:   Thu,  2 Jul 2020 21:58:57 +0800
Message-Id: <20200702135857.2827982-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

One request may get driver tag several times, and active request is only
de-accounted in blk_mq_put_driver_tag() in case of io scheduler, and it
won't be done for none, so repeated accounting of active request may
happen.

Fix this issue by only accounting active request in case that RQF_MQ_INFLIGHT
isn't set.

Cc: Qian Cai <cai@lca.pw>
Tested-by: Sachin Sant <sachinp@linux.vnet.ibm.com>
Fixes: 37f4a24c2469 ("blk-mq: centralise related handling into blk_mq_get_driver_tag")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 6b36969220c1..656d92de9814 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1149,7 +1149,8 @@ static bool blk_mq_get_driver_tag(struct request *rq)
 	if (rq->tag == BLK_MQ_NO_TAG && !__blk_mq_get_driver_tag(rq))
 		return false;
 
-	if (hctx->flags & BLK_MQ_F_TAG_SHARED) {
+	if ((hctx->flags & BLK_MQ_F_TAG_SHARED) &&
+			!(rq->rq_flags & RQF_MQ_INFLIGHT)) {
 		rq->rq_flags |= RQF_MQ_INFLIGHT;
 		atomic_inc(&hctx->nr_active);
 	}
-- 
2.25.2

