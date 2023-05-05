Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1D18C77B7F
	for <linux-block@archiver.kernel.org>; Fri,  5 May 2023 15:32:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232805AbjEEPcy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 5 May 2023 11:32:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232791AbjEEPcy (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 5 May 2023 11:32:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B097C16081
        for <linux-block@vger.kernel.org>; Fri,  5 May 2023 08:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1683300712;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=m771tZnAfiVdyW7RSw1XPML/LXIdC9bUQefqSkwjiZs=;
        b=Wr+SMm8YkmPmY9JO9EFH2axLYdZLkC3qyGWjzSMQTRRpvePm3PA/iw4r6MUxzWoh796OfM
        GRkarl7m6nMAF1JOxmmaLQzYAq3ymhTGkBUWoFf0rNpSXTTKMjZScTrNmGIOWW0Psmsaw4
        8Gorb7OsHfzqfr2eUJIHqc6MbUfY7OA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-91-DAEKEuurM0y2bY_usOKtgg-1; Fri, 05 May 2023 11:31:49 -0400
X-MC-Unique: DAEKEuurM0y2bY_usOKtgg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3FFCC101A531;
        Fri,  5 May 2023 15:31:49 +0000 (UTC)
Received: from localhost (ovpn-8-20.pek2.redhat.com [10.72.8.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5BCB01121331;
        Fri,  5 May 2023 15:31:48 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH] ublk: fix command op code check
Date:   Fri,  5 May 2023 23:31:42 +0800
Message-Id: <20230505153142.1258336-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In case of CONFIG_BLKDEV_UBLK_LEGACY_OPCODES, type of cmd opcode could
be 0 or 'u'; and type can only be 'u' if CONFIG_BLKDEV_UBLK_LEGACY_OPCODES
isn't set.

So fix the wrong check.

Fixes: 2d786e66c966 ("block: ublk: switch to ioctl command encoding")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 72a5cde9a5af..92cb2eb384f2 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1281,7 +1281,7 @@ static inline int ublk_check_cmd_op(u32 cmd_op)
 {
 	u32 ioc_type = _IOC_TYPE(cmd_op);
 
-	if (IS_ENABLED(CONFIG_BLKDEV_UBLK_LEGACY_OPCODES) && ioc_type != 'u')
+	if (!IS_ENABLED(CONFIG_BLKDEV_UBLK_LEGACY_OPCODES) && ioc_type != 'u')
 		return -EOPNOTSUPP;
 
 	if (ioc_type != 'u' && ioc_type != 0)
-- 
2.38.1

