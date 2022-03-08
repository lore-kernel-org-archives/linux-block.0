Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B845C433EF
	for <linux-block@archiver.kernel.org>; Tue,  8 Mar 2022 07:33:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343851AbiCHHeV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Mar 2022 02:34:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241341AbiCHHeU (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Mar 2022 02:34:20 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2DD9A34B92
        for <linux-block@vger.kernel.org>; Mon,  7 Mar 2022 23:33:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646724803;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vEicHx1bODbRZlu9MW1uDl2F5CrjacllCNCO4NRo2NQ=;
        b=a8hBFaQxkGNaoMyoGjOTwxb84NlrgDgMVP+zxLaGL45GQmrLHQL02IE/Jzz9JDgCLWYK9I
        yzbaSJqz9smKw3K56tz8oDDzA/ETfjGYLnqBz6Dpqz/DwMdR9hVa4XKECs+ezruayLXz1g
        SuvXH0XLlK3TVXYA2LM+/Eh6lDr+rK8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-607-Hl-jX6NAO-aXVZqQnT719g-1; Tue, 08 Mar 2022 02:33:20 -0500
X-MC-Unique: Hl-jX6NAO-aXVZqQnT719g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ED34C180FD76;
        Tue,  8 Mar 2022 07:33:18 +0000 (UTC)
Received: from localhost (ovpn-8-34.pek2.redhat.com [10.72.8.34])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9F10F101E68B;
        Tue,  8 Mar 2022 07:33:06 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Yu Kuai <yukuai3@huawei.com>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH V4 4/6] block: mtip32xx: don't touch q->queue_hw_ctx
Date:   Tue,  8 Mar 2022 15:32:17 +0800
Message-Id: <20220308073219.91173-5-ming.lei@redhat.com>
In-Reply-To: <20220308073219.91173-1-ming.lei@redhat.com>
References: <20220308073219.91173-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

q->queue_hw_ctx is really one blk-mq internal structure for retrieving
hctx via its index, not supposed to be used by drivers. Meantime drivers
can get the tags structure easily from tagset.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
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

