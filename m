Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18D85C77B73
	for <linux-block@archiver.kernel.org>; Thu, 20 Apr 2023 09:13:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233754AbjDTJNV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Apr 2023 05:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234261AbjDTJNN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Apr 2023 05:13:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 495FB5B8E
        for <linux-block@vger.kernel.org>; Thu, 20 Apr 2023 02:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681981900;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=5Tse1OBd3u9F60hu0ga9PRSiCenr2h+REyL1RNAeH/E=;
        b=RYIf+9qIn5o8RVwn43U05+4DIBYFZZ2OdzoAdM1M0GecxgbuHEjFt6YAJSNfbI1Py5r/dB
        4o/iPyCQNuRA/yBBKPszqO7I0H0qoHbpGdaUcIP8e7AL2L5a9+Emif9AHgWxcv0Q7yC6zs
        PsZTcauNaMmW2e+BfRnImPf6ORaVljs=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-397-bXsJN0sTPrS1l5zfgOIgDQ-1; Thu, 20 Apr 2023 05:11:36 -0400
X-MC-Unique: bXsJN0sTPrS1l5zfgOIgDQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5435629AA3B8;
        Thu, 20 Apr 2023 09:11:36 +0000 (UTC)
Received: from localhost (ovpn-8-16.pek2.redhat.com [10.72.8.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A1E1E1121315;
        Thu, 20 Apr 2023 09:11:16 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH] ublk: don't return 0 in case of any failure
Date:   Thu, 20 Apr 2023 17:11:04 +0800
Message-Id: <20230420091104.1092972-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Commit 2d786e66c966 ("block: ublk: switch to ioctl command encoding")
starts to reset local variable of 'ret' as zero, then if any failure
happens when handling the three IO commands, 0 can be returned to ublk
server.

Fix it by returning -EINVAL in case of command handling failure.

Cc: Christoph Hellwig <hch@lst.de>
Fixes: 2d786e66c966 ("block: ublk: switch to ioctl command encoding")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 5a03b765a6c1..cddfb33a5c3b 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1315,6 +1315,7 @@ static int ublk_ch_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags)
 	if (ret)
 		goto out;
 
+	ret = -EINVAL;
 	switch (_IOC_NR(cmd_op)) {
 	case UBLK_IO_FETCH_REQ:
 		/* UBLK_IO_FETCH_REQ is only allowed before queue is setup */
-- 
2.38.1

