Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1122EC27C40
	for <linux-block@archiver.kernel.org>; Thu, 24 Aug 2023 05:23:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239091AbjHXFXC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Aug 2023 01:23:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239764AbjHXFXB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Aug 2023 01:23:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41259198
        for <linux-block@vger.kernel.org>; Wed, 23 Aug 2023 22:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692854533;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=A6Qew4bwWT29eWgkRsHjhp0JvjbaDuH4zLYS/iTSxH4=;
        b=bylAz6g+4Bylht6dp9bo1WFabS7v8dc+r3fR8z9WBeok4N0TEwcXp7ehl3Q0s2ZoxEx2dn
        K0LT9j4l5W4l9uiFX4RtPDvUKHcqS44aq54b+diII4NCGMpL9nPkvK29rURmEtl1fvKAa1
        Yj6ozr1XA8MjtX6ucTFrnkBU0jH5Z6A=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-37-F2u2yJYrPtuQeoXas7tLbA-1; Thu, 24 Aug 2023 01:22:11 -0400
X-MC-Unique: F2u2yJYrPtuQeoXas7tLbA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2A32B800270;
        Thu, 24 Aug 2023 05:22:11 +0000 (UTC)
Received: from localhost (unknown [10.72.120.8])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 66A8940C2073;
        Thu, 24 Aug 2023 05:22:10 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 6.1 -stable] ublk: remove check IO_URING_F_SQE128 in ublk_ch_uring_cmd
Date:   Thu, 24 Aug 2023 13:22:03 +0800
Message-Id: <20230824052203.1751458-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

commit 9c7c4bc986932218fd0df9d2a100509772028fb1 upstream

sizeof(struct ublksrv_io_cmd) is 16bytes, which can be held in 64byte SQE,
so not necessary to check IO_URING_F_SQE128.

With this change, we get chance to save half SQ ring memory.

Fixed: 71f28f3136af ("ublk_drv: add io_uring based userspace block driver")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Link: https://lore.kernel.org/r/20230220041413.1524335-1-ming.lei@redhat.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
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
2.40.1

