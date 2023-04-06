Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6BE6C76196
	for <linux-block@archiver.kernel.org>; Thu,  6 Apr 2023 12:42:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237410AbjDFMmA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Apr 2023 08:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbjDFMl7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Apr 2023 08:41:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BBFB76A9
        for <linux-block@vger.kernel.org>; Thu,  6 Apr 2023 05:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680784874;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=9tkmzm/hquNGLWmsXzJCaOliFwRI9+JTQF9rbBxcXE4=;
        b=URKM1FFqLQQSfR8OX10XkQeFwciqycjNkM0uAqFRQ1RW52arBUsoTXvxPOifMaDnH3T6vL
        Od0x9VEAODv4AhwPc2RT2xeYhGVzWj03aEjLTDSDwSbeze1eVAdwOQ4UW9V2K7BbS0MXYz
        JgKwTKnj+oDZMKgaqCV96D9/B4pjztI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-78-oUk7kfGWO6Gz2WYL8_S7xA-1; Thu, 06 Apr 2023 08:41:13 -0400
X-MC-Unique: oUk7kfGWO6Gz2WYL8_S7xA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2C0BF101A531;
        Thu,  6 Apr 2023 12:41:13 +0000 (UTC)
Received: from localhost (ovpn-8-24.pek2.redhat.com [10.72.8.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 325684020C80;
        Thu,  6 Apr 2023 12:41:11 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH] block: ublk: make sure that block size is set correctly
Date:   Thu,  6 Apr 2023 20:40:59 +0800
Message-Id: <20230406124059.2035969-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

block size is one very key setting for block layer, and bad block size
could panic kernel easily.

Make sure that block size is set correctly.

Meantime if ublk_validate_params() fails, clear ub->params so that disk
is prevented from being added.

Fixes: 71f28f3136af ("ublk_drv: add io_uring based userspace block driver")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index f48d213fb65e..2899efa07fad 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -246,7 +246,7 @@ static int ublk_validate_params(const struct ublk_device *ub)
 	if (ub->params.types & UBLK_PARAM_TYPE_BASIC) {
 		const struct ublk_param_basic *p = &ub->params.basic;
 
-		if (p->logical_bs_shift > PAGE_SHIFT)
+		if (p->logical_bs_shift > PAGE_SHIFT || p->logical_bs_shift < 9)
 			return -EINVAL;
 
 		if (p->logical_bs_shift > p->physical_bs_shift)
@@ -1949,6 +1949,8 @@ static int ublk_ctrl_set_params(struct ublk_device *ub,
 		/* clear all we don't support yet */
 		ub->params.types &= UBLK_PARAM_TYPE_ALL;
 		ret = ublk_validate_params(ub);
+		if (ret)
+			ub->params.types = 0;
 	}
 	mutex_unlock(&ub->mutex);
 
-- 
2.38.1

