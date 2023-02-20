Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AE25C05027
	for <linux-block@archiver.kernel.org>; Mon, 20 Feb 2023 04:15:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbjBTEPP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 19 Feb 2023 23:15:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjBTEPO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 19 Feb 2023 23:15:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CFF6E07F
        for <linux-block@vger.kernel.org>; Sun, 19 Feb 2023 20:14:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676866466;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Ic8sikZywsnuPNBKW0DObN9Ojsq5BIgAI8jNU5naWUQ=;
        b=gkU9eTOXJFj7DueUw2VzIQ85rWl7e3CQ9928CNFsCgdNOHtNHJsvWnLofjhlUAP3JQoFg7
        /yGNrCj2wITjEiYJHQKUUVrTO+PgSvm1f7y3rB8CB022Wrm+M+UkCsJhhPB2OFxb2qOhIH
        LLn6F6w45OZYw81+b+fOlg6WmPGgo8g=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-478-RIKeU0hoOtGq8O3ys6493Q-1; Sun, 19 Feb 2023 23:14:25 -0500
X-MC-Unique: RIKeU0hoOtGq8O3ys6493Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D032B29AA2C5;
        Mon, 20 Feb 2023 04:14:24 +0000 (UTC)
Received: from localhost (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E7A0F2166B30;
        Mon, 20 Feb 2023 04:14:23 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH] ublk: remove check IO_URING_F_SQE128 in ublk_ch_uring_cmd
Date:   Mon, 20 Feb 2023 12:14:13 +0800
Message-Id: <20230220041413.1524335-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

sizeof(struct ublksrv_io_cmd) is 16bytes, which can be held in 64byte SQE,
so not necessary to check IO_URING_F_SQE128.

With this change, we get chance to save half SQ ring memory.

Fixed: 71f28f3136af ("ublk_drv: add io_uring based userspace block driver")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index f48d213fb65e..09d29fa53939 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1271,9 +1271,6 @@ static int ublk_ch_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags)
 			__func__, cmd->cmd_op, ub_cmd->q_id, tag,
 			ub_cmd->result);
 
-	if (!(issue_flags & IO_URING_F_SQE128))
-		goto out;
-
 	if (ub_cmd->q_id >= ub->dev_info.nr_hw_queues)
 		goto out;
 
-- 
2.38.1

