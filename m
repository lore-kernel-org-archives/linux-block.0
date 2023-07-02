Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF9CEEB64DA
	for <linux-block@archiver.kernel.org>; Sun,  2 Jul 2023 19:44:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232405AbjGBToT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 2 Jul 2023 15:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232124AbjGBTnK (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 2 Jul 2023 15:43:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43AD42695;
        Sun,  2 Jul 2023 12:42:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4485960CBB;
        Sun,  2 Jul 2023 19:40:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9007C433CA;
        Sun,  2 Jul 2023 19:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688326843;
        bh=+fWCUl+j6Cp2TLiSq1tE+s2/tOafQ4TY0PboIMouVao=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SanmETBGG4c6EK0uGdVN0YlRUH9jWAEDSLPBUSWfT6OJ1gLOvhl2l5CsG/4f6uwY5
         iTJoF2Syeax/wFqXxCV7uKSFGoDFIN4VTERMnuS2+u/bJOECGgcNAmwV7Cq4b/4ScS
         RUOvGKSzzIk9dIZXcbQNxwYaBwYR+3laeWRAOAmmQKqeH+Vu3Qx8lWs7rEDeQ2QhWw
         XExhcFp8gjozhDCwvc0VCA7RakVD4y0PR0JXlbF3rGnENKc7Mo16SsWsn8ucCVmnlm
         oPDCFkpyol0osNiwkffLWVAfA8dGC/gXK4RPlKZ1WBhoczlYIzMi0IVEZ58jCFyl4z
         a3tMhpyk+AVOg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ming Lei <ming.lei@redhat.com>,
        Guangwu Zhang <guazhang@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 6.4 10/15] blk-mq: fix NULL dereference on q->elevator in blk_mq_elv_switch_none
Date:   Sun,  2 Jul 2023 15:40:15 -0400
Message-Id: <20230702194020.1776895-10-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230702194020.1776895-1-sashal@kernel.org>
References: <20230702194020.1776895-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.1
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Ming Lei <ming.lei@redhat.com>

[ Upstream commit 245165658e1c9f95c0fecfe02b9b1ebd30a1198a ]

After grabbing q->sysfs_lock, q->elevator may become NULL because of
elevator switch.

Fix the NULL dereference on q->elevator by checking it with lock.

Reported-by: Guangwu Zhang <guazhang@redhat.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Link: https://lore.kernel.org/r/20230616132354.415109-1-ming.lei@redhat.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-mq.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 850bfb844ed2f..9516f65a50ea4 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4608,9 +4608,6 @@ static bool blk_mq_elv_switch_none(struct list_head *head,
 {
 	struct blk_mq_qe_pair *qe;
 
-	if (!q->elevator)
-		return true;
-
 	qe = kmalloc(sizeof(*qe), GFP_NOIO | __GFP_NOWARN | __GFP_NORETRY);
 	if (!qe)
 		return false;
@@ -4618,6 +4615,12 @@ static bool blk_mq_elv_switch_none(struct list_head *head,
 	/* q->elevator needs protection from ->sysfs_lock */
 	mutex_lock(&q->sysfs_lock);
 
+	/* the check has to be done with holding sysfs_lock */
+	if (!q->elevator) {
+		kfree(qe);
+		goto unlock;
+	}
+
 	INIT_LIST_HEAD(&qe->node);
 	qe->q = q;
 	qe->type = q->elevator->type;
@@ -4625,6 +4628,7 @@ static bool blk_mq_elv_switch_none(struct list_head *head,
 	__elevator_get(qe->type);
 	list_add(&qe->node, head);
 	elevator_disable(q);
+unlock:
 	mutex_unlock(&q->sysfs_lock);
 
 	return true;
-- 
2.39.2

