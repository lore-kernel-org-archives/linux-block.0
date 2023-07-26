Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA540C001DC
	for <linux-block@archiver.kernel.org>; Wed, 26 Jul 2023 14:46:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232284AbjGZOqK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Jul 2023 10:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231690AbjGZOqJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Jul 2023 10:46:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C82F21BE4
        for <linux-block@vger.kernel.org>; Wed, 26 Jul 2023 07:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690382722;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ubuIe3q9MGMOKPcY81/KVYpwDDc7fEDYdgixySVerbg=;
        b=VM2l1b0g34KnVEjGJuuIf18xTWyZb3wsRlrylwFCBTb+ujcUsH3BzOjPY/RattnW3nORq/
        fUe1Mo0gQabxn5FxgQ8MFxu2dOkEO1Wl27M/dEj2Ldu7dODUiewjO+18DRa/dQuQncsxF/
        /52P2lIr8W9dt9uLbXt3UFDGcj0XxEo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-199-APcmxoKzOtem8TBgfO8pwg-1; Wed, 26 Jul 2023 10:45:17 -0400
X-MC-Unique: APcmxoKzOtem8TBgfO8pwg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 18F47803FDC;
        Wed, 26 Jul 2023 14:45:17 +0000 (UTC)
Received: from localhost (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3FF88492CAC;
        Wed, 26 Jul 2023 14:45:15 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        Stefano Garzarella <sgarzare@redhat.com>,
        German Maglione <gmaglione@redhat.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 1/3] ublk: fail to start device if queue setup is interrupted
Date:   Wed, 26 Jul 2023 22:45:00 +0800
Message-Id: <20230726144502.566785-2-ming.lei@redhat.com>
In-Reply-To: <20230726144502.566785-1-ming.lei@redhat.com>
References: <20230726144502.566785-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In ublk_ctrl_start_dev(), if wait_for_completion_interruptible() is
interrupted by signal, queues aren't setup successfully yet, so we
have to fail UBLK_CMD_START_DEV, otherwise kernel oops can be triggered.

Reported by German when working on qemu-storage-deamon which requires
single thread ublk daemon.

Fixes: 71f28f3136af ("ublk_drv: add io_uring based userspace block driver")
Reported-by: German Maglione <gmaglione@redhat.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 1c823750c95a..7938221f4f7e 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1847,7 +1847,8 @@ static int ublk_ctrl_start_dev(struct ublk_device *ub, struct io_uring_cmd *cmd)
 	if (ublksrv_pid <= 0)
 		return -EINVAL;
 
-	wait_for_completion_interruptible(&ub->completion);
+	if (wait_for_completion_interruptible(&ub->completion) != 0)
+		return -EINTR;
 
 	schedule_delayed_work(&ub->monitor_work, UBLK_DAEMON_MONITOR_PERIOD);
 
-- 
2.40.1

