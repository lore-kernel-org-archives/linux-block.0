Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66CC4C0015E
	for <linux-block@archiver.kernel.org>; Wed, 26 Jul 2023 11:41:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234149AbjGZLlv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Jul 2023 07:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234173AbjGZLlc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Jul 2023 07:41:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D63C92D5E
        for <linux-block@vger.kernel.org>; Wed, 26 Jul 2023 04:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690371553;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=iqp1NPGoo93rPw8YIhOdL4DyJExhNrKui5D425mraPA=;
        b=BCaaV/iopb8X9VY2FFQhDFX9Fbxh7Bfz0u6YXv08jZPb+oPLO22o6/0eUh86GSpeXASQUQ
        I1OCSCX+xaUb+z4wXEOJr7WgSRDUsTGM1/WB4QEb67gy3kyuB8f0InEIy956MGw9v0ftg1
        c0vS0F9q7kul0bD/lZ/eo7BmX04YFiI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-636-rdG_LP34PIi0GtHn_hvl_g-1; Wed, 26 Jul 2023 07:39:11 -0400
X-MC-Unique: rdG_LP34PIi0GtHn_hvl_g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4DAF0856F66;
        Wed, 26 Jul 2023 11:39:11 +0000 (UTC)
Received: from localhost (unknown [10.72.120.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 88EF740C2063;
        Wed, 26 Jul 2023 11:39:10 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        German Maglione <gmaglione@redhat.com>
Subject: [PATCH] ublk: fail to start device if queue setup is interrupted
Date:   Wed, 26 Jul 2023 19:39:01 +0800
Message-Id: <20230726113901.546569-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In ublk_ctrl_start_dev(), if wait_for_completion_interruptible() is
interrupted by signal, queues aren't setup successfully yet, so we
have to fail UBLK_CMD_START_DEV, otherwise kernel oops can be triggered.

Reported by German when working for supporting ublk on qemu-storage-deamon
which requires single thread ublk daemon.

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

