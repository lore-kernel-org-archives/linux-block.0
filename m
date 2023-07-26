Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D906BC001DF
	for <linux-block@archiver.kernel.org>; Wed, 26 Jul 2023 14:46:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232389AbjGZOqL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Jul 2023 10:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231690AbjGZOqL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Jul 2023 10:46:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0BF51FC4
        for <linux-block@vger.kernel.org>; Wed, 26 Jul 2023 07:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690382722;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B2CSks647K74F8OgrfUZLcugtKavDMhi7yN3N8fBdzE=;
        b=YdwSNWpqw6UQRH+OhXMd0tDwJIXhgADxWKDYLcyOBRhtv0oC4wZxB7UP400xpp/RA99dm4
        Yd9jer0VKXhTcC93GooqPtB1CSkfZzjHCXnsCIHDcun7uWzfq1MV2eEuPmLgqZD3g/HhQr
        UQ7fKOBrJ6AUVzRMF5LVTkQSRdjwhgM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-84-jmnmFOEJOqCBRECw5Gh41Q-1; Wed, 26 Jul 2023 10:45:21 -0400
X-MC-Unique: jmnmFOEJOqCBRECw5Gh41Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CCBD6185A791;
        Wed, 26 Jul 2023 14:45:20 +0000 (UTC)
Received: from localhost (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E6F841121330;
        Wed, 26 Jul 2023 14:45:19 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        Stefano Garzarella <sgarzare@redhat.com>,
        German Maglione <gmaglione@redhat.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 2/3] ublk: fail to recover device if queue setup is interrupted
Date:   Wed, 26 Jul 2023 22:45:01 +0800
Message-Id: <20230726144502.566785-3-ming.lei@redhat.com>
In-Reply-To: <20230726144502.566785-1-ming.lei@redhat.com>
References: <20230726144502.566785-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In ublk_ctrl_end_recovery(), if wait_for_completion_interruptible() is
interrupted by signal, queues aren't setup successfully yet, so we
have to fail UBLK_CMD_END_USER_RECOVERY, otherwise kernel oops can be
triggered.

Fixes: c732a852b419 ("ublk_drv: add START_USER_RECOVERY and END_USER_RECOVERY support")
Reported-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 7938221f4f7e..9fcba3834e8d 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -2324,7 +2324,9 @@ static int ublk_ctrl_end_recovery(struct ublk_device *ub,
 	pr_devel("%s: Waiting for new ubq_daemons(nr: %d) are ready, dev id %d...\n",
 			__func__, ub->dev_info.nr_hw_queues, header->dev_id);
 	/* wait until new ubq_daemon sending all FETCH_REQ */
-	wait_for_completion_interruptible(&ub->completion);
+	if (wait_for_completion_interruptible(&ub->completion))
+		return -EINTR;
+
 	pr_devel("%s: All new ubq_daemons(nr: %d) are ready, dev id %d\n",
 			__func__, ub->dev_info.nr_hw_queues, header->dev_id);
 
-- 
2.40.1

