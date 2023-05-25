Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29A6DC7EE2F
	for <linux-block@archiver.kernel.org>; Thu, 25 May 2023 18:44:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242209AbjEYSoj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 May 2023 14:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242258AbjEYSnv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 May 2023 14:43:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D70F2682;
        Thu, 25 May 2023 11:40:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CE28E64947;
        Thu, 25 May 2023 18:38:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 715E7C4339C;
        Thu, 25 May 2023 18:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685039930;
        bh=YWmMkh8l0UbNdG6QgZ4XM8b+KLeWJUU4FDAk16KjKIg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WF5eyJUnzbmILfvi7nTMtKooC0guNxKiZkekJuPwtsIfQTG854KZO5zbG3cV5RtPc
         ur32MxsjehvBoRwn9geeDdUE5sg0pWCfysesoNyvTjYdUDi5HJdDu/zSL8QFNsMe/w
         /QBI4l9CgahJ10inM1PEa55Y/NN0unSDnIfEPrUGb6mmFLufSkfwO+Nuknv5JrBjzZ
         B9vo2SvGtbjRhiZZZ3uWbEmPjysjzLeo4Ajku61ImVfCA2vA+GApwULRM23q14s2RP
         DMMoZG9ViKYjpBRvcrwhvX2sgY94i2UDb7RPL1AVki1hOwmQQ9bLbooGCe3JlNZWNm
         zxoNBvII8qaYQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ming Lei <ming.lei@redhat.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Ziyang Zhang <ZiyangZhang@linux.alibaba.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 55/57] ublk: fix AB-BA lockdep warning
Date:   Thu, 25 May 2023 14:36:05 -0400
Message-Id: <20230525183607.1793983-55-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230525183607.1793983-1-sashal@kernel.org>
References: <20230525183607.1793983-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Ming Lei <ming.lei@redhat.com>

[ Upstream commit ac5902f84bb546c64aea02c439c2579cbf40318f ]

When handling UBLK_IO_FETCH_REQ, ctx->uring_lock is grabbed first, then
ub->mutex is acquired.

When handling UBLK_CMD_STOP_DEV or UBLK_CMD_DEL_DEV, ub->mutex is
grabbed first, then calling io_uring_cmd_done() for canceling uring
command, in which ctx->uring_lock may be required.

Real deadlock only happens when all the above commands are issued from
same uring context, and in reality different uring contexts are often used
for handing control command and IO command.

Fix the issue by using io_uring_cmd_complete_in_task() to cancel command
in ublk_cancel_dev(ublk_cancel_queue).

Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Closes: https://lore.kernel.org/linux-block/becol2g7sawl4rsjq2dztsbc7mqypfqko6wzsyoyazqydoasml@rcxarzwidrhk
Cc: Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Tested-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Link: https://lore.kernel.org/r/20230517133408.210944-1-ming.lei@redhat.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/ublk_drv.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index c0cbc5f3eb266..c56d1c6d8e58d 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -1045,6 +1045,11 @@ static inline bool ublk_queue_ready(struct ublk_queue *ubq)
 	return ubq->nr_io_ready == ubq->q_depth;
 }
 
+static void ublk_cmd_cancel_cb(struct io_uring_cmd *cmd, unsigned issue_flags)
+{
+	io_uring_cmd_done(cmd, UBLK_IO_RES_ABORT, 0, issue_flags);
+}
+
 static void ublk_cancel_queue(struct ublk_queue *ubq)
 {
 	int i;
@@ -1056,8 +1061,8 @@ static void ublk_cancel_queue(struct ublk_queue *ubq)
 		struct ublk_io *io = &ubq->ios[i];
 
 		if (io->flags & UBLK_IO_FLAG_ACTIVE)
-			io_uring_cmd_done(io->cmd, UBLK_IO_RES_ABORT, 0,
-						IO_URING_F_UNLOCKED);
+			io_uring_cmd_complete_in_task(io->cmd,
+						      ublk_cmd_cancel_cb);
 	}
 
 	/* all io commands are canceled */
-- 
2.39.2

