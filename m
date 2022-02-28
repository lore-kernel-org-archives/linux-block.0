Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBA9EC433EF
	for <linux-block@archiver.kernel.org>; Mon, 28 Feb 2022 09:05:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbiB1JG3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Feb 2022 04:06:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233233AbiB1JG1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Feb 2022 04:06:27 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B262537BE8
        for <linux-block@vger.kernel.org>; Mon, 28 Feb 2022 01:05:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646039148;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NzsFN/g2PgU1prVe6xmejUJfLkdPQHqOJiqaNS6ULhc=;
        b=fMwO37EMy+THFZEMCQonT70iewr7cqwKy5upKNTFzPPtWkeKMzX6Hi7LSmqaONuizT2wdT
        7FHsXcmMmbHQPRFSj9uXLjw+7fFAuAmWUgLz0VJHKkioaDVBNkWqsJX8VsHtYHBsRr5GU8
        TZEeMdwWPPrxEgA5YN93Dk6TzpdEn+g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-60-mfRAB097MqSeTwC6KKzL0A-1; Mon, 28 Feb 2022 04:05:45 -0500
X-MC-Unique: mfRAB097MqSeTwC6KKzL0A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 418D41091DA3;
        Mon, 28 Feb 2022 09:05:44 +0000 (UTC)
Received: from localhost (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6C51A27CD3;
        Mon, 28 Feb 2022 09:05:42 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Yu Kuai <yukuai3@huawei.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 4/6] block: mtip32xx: don't touch q->queue_hw_ctx
Date:   Mon, 28 Feb 2022 17:04:28 +0800
Message-Id: <20220228090430.1064267-5-ming.lei@redhat.com>
In-Reply-To: <20220228090430.1064267-1-ming.lei@redhat.com>
References: <20220228090430.1064267-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

q->queue_hw_ctx is really one blk-mq internal structure for retrieving
hctx via its index, not supposed to be used by drivers. Meantime drivers
can get the tags structure easily from tagset.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/mtip32xx/mtip32xx.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/mtip32xx.c
index cba956881d55..2d43ab5b5cc0 100644
--- a/drivers/block/mtip32xx/mtip32xx.c
+++ b/drivers/block/mtip32xx/mtip32xx.c
@@ -160,9 +160,7 @@ static bool mtip_check_surprise_removal(struct driver_data *dd)
 static struct mtip_cmd *mtip_cmd_from_tag(struct driver_data *dd,
 					  unsigned int tag)
 {
-	struct blk_mq_hw_ctx *hctx = dd->queue->queue_hw_ctx[0];
-
-	return blk_mq_rq_to_pdu(blk_mq_tag_to_rq(hctx->tags, tag));
+	return blk_mq_rq_to_pdu(blk_mq_tag_to_rq(dd->tags.tags[0], tag));
 }
 
 /*
-- 
2.31.1

