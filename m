Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9040C4332F
	for <linux-block@archiver.kernel.org>; Wed,  4 Jan 2023 13:35:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231787AbjADNfF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 4 Jan 2023 08:35:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239551AbjADNeu (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 4 Jan 2023 08:34:50 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82F6F3AA9A
        for <linux-block@vger.kernel.org>; Wed,  4 Jan 2023 05:32:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672839163;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=UXhtq2BfoMv4ks6wMn18wccB8SuyC2oyyx5uojYC2t8=;
        b=d/3vudDAeOQYTSV0/lfqdwN5ttP2kIm1cfGZPyOUJayNdIwJnA4DhIfe5jrdlMEg71K2gF
        WTNY384aDD07JVYh+AtHatMA8kEe5MQHig7IcFoU1sk6FwnG8wAa6UUbBGINR+s8swrw++
        QvQwh7S76BUP6RVwjjLGOfktm8xaZ4c=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-26-aVP_sM_BPju_OEyEAUjYmw-1; Wed, 04 Jan 2023 08:32:42 -0500
X-MC-Unique: aVP_sM_BPju_OEyEAUjYmw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DDB0F18E0922;
        Wed,  4 Jan 2023 13:32:41 +0000 (UTC)
Received: from localhost (ovpn-8-26.pek2.redhat.com [10.72.8.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EBDB82166B30;
        Wed,  4 Jan 2023 13:32:40 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH] ublk: honor IO_URING_F_NONBLOCK for handling control command
Date:   Wed,  4 Jan 2023 21:32:35 +0800
Message-Id: <20230104133235.836536-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Most of control command handlers may sleep, so return -EAGAIN in case
of IO_URING_F_NONBLOCK to defer the handling into io wq context.

Fixes: 71f28f3136af ("ublk_drv: add io_uring based userspace block driver")
Reported-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index e9de9d846b73..17b677b5d3b2 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1992,6 +1992,9 @@ static int ublk_ctrl_uring_cmd(struct io_uring_cmd *cmd,
 	struct ublksrv_ctrl_cmd *header = (struct ublksrv_ctrl_cmd *)cmd->cmd;
 	int ret = -EINVAL;
 
+	if (issue_flags & IO_URING_F_NONBLOCK)
+		return -EAGAIN;
+
 	ublk_ctrl_cmd_dump(cmd);
 
 	if (!(issue_flags & IO_URING_F_SQE128))
-- 
2.38.1

