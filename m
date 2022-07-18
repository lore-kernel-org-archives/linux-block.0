Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87F4AC433EF
	for <linux-block@archiver.kernel.org>; Mon, 18 Jul 2022 16:09:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233919AbiGRQJM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Jul 2022 12:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234658AbiGRQJG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Jul 2022 12:09:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C65A128E3B
        for <linux-block@vger.kernel.org>; Mon, 18 Jul 2022 09:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658160544;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=LbfFJyGXhyiH+sON0cRK8sRP8rbAXaaOwN8jSvUzmjU=;
        b=LuLyAp0X3i76fFqEkHJVMxVDdbvueRlUSyxYz/AFvtfHm+P/q7v1CUOQE4/AZRFxyNZ3rb
        buJQk7w2U87bNCT5Qf7p7h7WT0RJDuOAfuY7XL83G/CryYGpAYGYh/tbZwjUOsWBzCTOdB
        HE2jMSDCVEaaK4LYu3g7BACfPAKqNJc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-215-hofuAGtqOnm3Souywp578w-1; Mon, 18 Jul 2022 12:09:01 -0400
X-MC-Unique: hofuAGtqOnm3Souywp578w-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 244B2801231;
        Mon, 18 Jul 2022 16:09:01 +0000 (UTC)
Received: from localhost (ovpn-8-29.pek2.redhat.com [10.72.8.29])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AC3CD401E7B;
        Mon, 18 Jul 2022 16:08:59 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>
Subject: [for-5.20/block PATCH] mmc: fix disk/queue leak in case of adding disk failure
Date:   Tue, 19 Jul 2022 00:08:51 +0800
Message-Id: <20220718160851.312972-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In case of adding disk failure, the disk needs to be released, otherwise
disk/queue is leaked.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/mmc/core/block.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index bda6c67ce93f..e08e22f0a7c5 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -2505,10 +2505,11 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
 		dev_set_drvdata(&card->dev, md);
 	ret = device_add_disk(md->parent, md->disk, mmc_disk_attr_groups);
 	if (ret)
-		goto err_cleanup_queue;
+		goto err_put_disk;
 	return md;
 
- err_cleanup_queue:
+ err_put_disk:
+	put_disk(md->disk);
 	blk_mq_free_tag_set(&md->queue.tag_set);
  err_kfree:
 	kfree(md);
-- 
2.31.1

