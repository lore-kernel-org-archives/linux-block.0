Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECA7CC19F28
	for <linux-block@archiver.kernel.org>; Wed, 27 Jul 2022 14:16:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231430AbiG0OQs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Jul 2022 10:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232194AbiG0OQs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Jul 2022 10:16:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 686CED8F
        for <linux-block@vger.kernel.org>; Wed, 27 Jul 2022 07:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658931406;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XEhesPYI0p2itVSo4pLy2zsLtDUbw7fMnqfPqU5mzas=;
        b=HlpEhiqSoydjBbE1Opx1gUZD7cI8xzGuDlLo6SYuN/1oY//KM90oLdhuHeIYCPnsF786QA
        zEDdPO+CaA1x9AMsfX5RStr6niAwe9Qe5skQ3tw29k0XWEx5NIMBnzBnQg/7xbRSy3/6Mx
        0ZHOTDsPc8ZKiDIaeALtdX03s2gtYnM=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-574-nQrf2o-xMXSU6KgMYuP6pA-1; Wed, 27 Jul 2022 10:16:41 -0400
X-MC-Unique: nQrf2o-xMXSU6KgMYuP6pA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C0B4E280EE28;
        Wed, 27 Jul 2022 14:16:40 +0000 (UTC)
Received: from localhost (ovpn-8-32.pek2.redhat.com [10.72.8.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B67D22026D64;
        Wed, 27 Jul 2022 14:16:39 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 1/5] ublk_drv: avoid to leak ublk device in case that add_disk fails
Date:   Wed, 27 Jul 2022 22:16:24 +0800
Message-Id: <20220727141628.985429-2-ming.lei@redhat.com>
In-Reply-To: <20220727141628.985429-1-ming.lei@redhat.com>
References: <20220727141628.985429-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

->free_disk is only called after disk is added successfully, so
not hold ublk device reference count until add_disk is done.

Fixes: 6d9e6dfdf3b2 ("ublk: defer disk allocation")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 255b2de46a24..b30d6c3355e8 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -215,8 +215,11 @@ static void ublk_free_disk(struct gendisk *disk)
 {
 	struct ublk_device *ub = disk->private_data;
 
-	clear_bit(UB_STATE_USED, &ub->state);
-	put_device(&ub->cdev_dev);
+	/* only called for added/used disk */
+	if (test_bit(UB_STATE_USED, &ub->state)) {
+		clear_bit(UB_STATE_USED, &ub->state);
+		put_device(&ub->cdev_dev);
+	}
 }
 
 static const struct block_device_operations ub_fops = {
@@ -1181,12 +1184,12 @@ static int ublk_ctrl_start_dev(struct io_uring_cmd *cmd)
 
 	ub->dev_info.ublksrv_pid = ublksrv_pid;
 	ub->ub_disk = disk;
-	get_device(&ub->cdev_dev);
 	ret = add_disk(disk);
 	if (ret) {
 		put_disk(disk);
 		goto out_unlock;
 	}
+	get_device(&ub->cdev_dev);
 	set_bit(UB_STATE_USED, &ub->state);
 	ub->dev_info.state = UBLK_S_DEV_LIVE;
 out_unlock:
-- 
2.31.1

