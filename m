Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF37DC433EF
	for <linux-block@archiver.kernel.org>; Tue, 21 Jun 2022 21:00:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355655AbiFUVAr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 Jun 2022 17:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355902AbiFUU7J (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Jun 2022 16:59:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CBAF3337A;
        Tue, 21 Jun 2022 13:51:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3783F61884;
        Tue, 21 Jun 2022 20:51:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 157ABC36AE2;
        Tue, 21 Jun 2022 20:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655844662;
        bh=wuwlQqYU2Q0SetwhNRVtAbUs3o+sTJP/YdYjFmeP0nM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nqeQ4QDL5Rj3V5AGssC8Xe4ZSE5xa6ae8sSNndFaL0ifKZ5oDee8L71xB3MR4ZLlW
         SYhli1JBo0ZyYsIJznUJYdDZifLohn9n8eJOjhau1mRuUxbcRw9BDYXSa6VIdo5OpG
         CcL11S5fOXBs/i0deXSh/GrCm5LP9JWHskkJiQqBI49P2h0oeZdgHTBCoUNhs63T4S
         yiNzo8jQjkd6u5mEzC/eNtqOl0P7JIgVLjmKCfdONaqCWmw5hcSSi/ssnS0xBBgXpq
         zI92O2CfvifSh9FQM7iG4LvZV4btGZzLRpRUReT4wUSBbF6s6iT2hS/g+MV+Y9bFTQ
         bvra/e9sv1SAw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 15/17] blk-mq: protect q->elevator by ->sysfs_lock in blk_mq_elv_switch_none
Date:   Tue, 21 Jun 2022 16:50:38 -0400
Message-Id: <20220621205041.250426-15-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220621205041.250426-1-sashal@kernel.org>
References: <20220621205041.250426-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Ming Lei <ming.lei@redhat.com>

[ Upstream commit 5fd7a84a09e640016fe106dd3e992f5210e23dc7 ]

elevator can be tore down by sysfs switch interface or disk release, so
hold ->sysfs_lock before referring to q->elevator, then potential
use-after-free can be avoided.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Link: https://lore.kernel.org/r/20220616014401.817001-2-ming.lei@redhat.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-mq.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index b70488e4db94..95da44063e65 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3683,12 +3683,14 @@ static bool blk_mq_elv_switch_none(struct list_head *head,
 	if (!qe)
 		return false;
 
+	/* q->elevator needs protection from ->sysfs_lock */
+	mutex_lock(&q->sysfs_lock);
+
 	INIT_LIST_HEAD(&qe->node);
 	qe->q = q;
 	qe->type = q->elevator->type;
 	list_add(&qe->node, head);
 
-	mutex_lock(&q->sysfs_lock);
 	/*
 	 * After elevator_switch_mq, the previous elevator_queue will be
 	 * released by elevator_release. The reference of the io scheduler
-- 
2.35.1

