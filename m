Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 963FEC38A02
	for <linux-block@archiver.kernel.org>; Sat, 29 Oct 2022 01:06:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbiJ2BGA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Oct 2022 21:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbiJ2BF7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Oct 2022 21:05:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6693D30544
        for <linux-block@vger.kernel.org>; Fri, 28 Oct 2022 18:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667005492;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ooVLtjfNYWBjZWObT+wSmVvHXpGx45zcFYXUHRbmBWY=;
        b=PtZ5sR+Kv4B7MFgVu2CXx8NvX2Oghjpzs4LjMuAe0Hx647Zs/QJE8reB0wELyBZeBDjpgq
        wybrvFgiJMAVH/NbbsWxlJCQNqQSmonwV0Rsq7rMHtmQs2pHDfFLnSNsOOFINxXY2JD0+h
        uJMu6cgPBIoTvrUrndNrLU/w0kijb10=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-211-vm-aMlvdOje4ZrbG1Rri-g-1; Fri, 28 Oct 2022 21:04:51 -0400
X-MC-Unique: vm-aMlvdOje4ZrbG1Rri-g-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C1E20380670E;
        Sat, 29 Oct 2022 01:04:50 +0000 (UTC)
Received: from localhost (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D891F483EFB;
        Sat, 29 Oct 2022 01:04:49 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 1/4] ublk: return flag of UBLK_F_URING_CMD_COMP_IN_TASK in case of module
Date:   Sat, 29 Oct 2022 09:04:29 +0800
Message-Id: <20221029010432.598367-2-ming.lei@redhat.com>
In-Reply-To: <20221029010432.598367-1-ming.lei@redhat.com>
References: <20221029010432.598367-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

UBLK_F_URING_CMD_COMP_IN_TASK needs to be set and returned to userspace
if ublk driver is built as module, otherwise userspace may get wrong
flags shown.

Fixes: 71f28f3136af ("ublk_drv: add io_uring based userspace block driver")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 5afce6ffaadf..6b2f214f0d5c 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1658,6 +1658,9 @@ static int ublk_ctrl_add_dev(struct io_uring_cmd *cmd)
 	 */
 	ub->dev_info.flags &= UBLK_F_ALL;
 
+	if (!IS_BUILTIN(CONFIG_BLK_DEV_UBLK))
+		ub->dev_info.flags |= UBLK_F_URING_CMD_COMP_IN_TASK;
+
 	/* We are not ready to support zero copy */
 	ub->dev_info.flags &= ~UBLK_F_SUPPORT_ZERO_COPY;
 
-- 
2.31.1

