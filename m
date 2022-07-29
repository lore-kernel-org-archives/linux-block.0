Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFDC0C19F2A
	for <linux-block@archiver.kernel.org>; Fri, 29 Jul 2022 07:30:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233974AbiG2HaS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 29 Jul 2022 03:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234558AbiG2HaR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 Jul 2022 03:30:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0BD5F1BE8B
        for <linux-block@vger.kernel.org>; Fri, 29 Jul 2022 00:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659079816;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7weNu4wXMUyPx/gw8OG/8ViMftBybrQYdLTMTR3ASuM=;
        b=ITUOlXWwF3oxZ4JRoZ/rTHYEXqtmX/h4NLux83UW9Gj/OeLm27NKZdBpgiVtcDIfy7G+9K
        Np1z+DwLo/1KeGBYU1f9SWqK94vAX9EFqcx5ObIzRCeJUuYeNQmSOG3WEMd6OW1qx8WQcw
        pJHS0XvqJRZa9w2aK2UY1J1l6BBtZlw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-80-n9t1dLj2P6C8hGiPYC7MPQ-1; Fri, 29 Jul 2022 03:30:14 -0400
X-MC-Unique: n9t1dLj2P6C8hGiPYC7MPQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EA2BD811E75;
        Fri, 29 Jul 2022 07:30:13 +0000 (UTC)
Received: from localhost (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2E8EE2166B26;
        Fri, 29 Jul 2022 07:30:12 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 2/5] ublk_drv: fix ublk device leak in case that add_disk fails
Date:   Fri, 29 Jul 2022 15:29:51 +0800
Message-Id: <20220729072954.1070514-3-ming.lei@redhat.com>
In-Reply-To: <20220729072954.1070514-1-ming.lei@redhat.com>
References: <20220729072954.1070514-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

->free_disk is only called after disk is added successfully, so
drop ublk device reference in case of add_disk() failure.

Fixes: 6d9e6dfdf3b2 ("ublk: defer disk allocation")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 7ece4c2ef062..00b04f395de0 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1190,6 +1190,11 @@ static int ublk_ctrl_start_dev(struct io_uring_cmd *cmd)
 	get_device(&ub->cdev_dev);
 	ret = add_disk(disk);
 	if (ret) {
+		/*
+		 * has to drop the reference since ->free_disk won't be
+		 * called in case of add_disk failure
+		 */
+		ublk_put_device(ub);
 		put_disk(disk);
 		goto out_unlock;
 	}
-- 
2.31.1

