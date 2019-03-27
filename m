Return-Path: <SRS0=uWmC=R6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5CC7C4360F
	for <linux-block@archiver.kernel.org>; Wed, 27 Mar 2019 18:59:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D2B1206B7
	for <linux-block@archiver.kernel.org>; Wed, 27 Mar 2019 18:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553713194;
	bh=Nlyv/P3XnIj8QnVwrFCdC9+n/KBHVGk/KMUPek5gJZs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=B2dVsS5ECbSxBqd8vLYI8iRkEgnNlyGvwTwaeyzk9bthTaVPrR13viGH7p2UWs3KY
	 8RUwS15w051fLYwfTidpUZWvnbPJ4LzufSGBSpKXbFvQYfPmbhzuzyfVpO4TikNQQD
	 EZsDhAGV1AxoEHmTJxgcQgrZP7sTJ3RIKSlpu7Hs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389732AbfC0SPA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Mar 2019 14:15:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:58356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389710AbfC0SPA (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Mar 2019 14:15:00 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CEA162184D;
        Wed, 27 Mar 2019 18:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553710498;
        bh=Nlyv/P3XnIj8QnVwrFCdC9+n/KBHVGk/KMUPek5gJZs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UvGebIwmofA7AMqyF7SsI7vcWQbRK5SC85J40eTnZpNo4Tx5BgSzSr+08BQ0AlcK9
         PjLBzeuuJUIby0N2yFtb86BS5CaTg0C+xZK+TlmjG+gWuq5zSE9pASqjtFk02rlho6
         tVJKcbF+7LViREL6z2B8vNyu3s6F1xG8T3lxUjqo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 145/192] block, bfq: fix in-service-queue check for queue merging
Date:   Wed, 27 Mar 2019 14:09:37 -0400
Message-Id: <20190327181025.13507-145-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327181025.13507-1-sashal@kernel.org>
References: <20190327181025.13507-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Paolo Valente <paolo.valente@linaro.org>

[ Upstream commit 058fdecc6de7cdecbf4c59b851e80eb2d6c5295f ]

When a new I/O request arrives for a bfq_queue, say Q, bfq checks
whether that request is close to
(a) the head request of some other queue waiting to be served, or
(b) the last request dispatched for the in-service queue (in case Q
itself is not the in-service queue)

If a queue, say Q2, is found for which the above condition holds, then
bfq merges Q and Q2, to hopefully get a more sequential I/O in the
resulting merged queue, and thus a possibly higher throughput.

Case (b) is checked by comparing the new request for Q with the last
request dispatched, assuming that the latter necessarily belonged to the
in-service queue. Unfortunately, this assumption is no longer always
correct, since commit d0edc2473be9 ("block, bfq: inject other-queue I/O
into seeky idle queues on NCQ flash").

When the assumption does not hold, queues that must not be merged may be
merged, causing unexpected loss of control on per-queue service
guarantees.

This commit solves this problem by adding an extra field, which stores
the actual last request dispatched for the in-service queue, and by
using this new field to correctly check case (b).

Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/bfq-iosched.c | 5 ++++-
 block/bfq-iosched.h | 3 +++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 653100fb719e..c5e2c5a01182 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -2215,7 +2215,8 @@ bfq_setup_cooperator(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 
 	if (in_service_bfqq && in_service_bfqq != bfqq &&
 	    likely(in_service_bfqq != &bfqd->oom_bfqq) &&
-	    bfq_rq_close_to_sector(io_struct, request, bfqd->last_position) &&
+	    bfq_rq_close_to_sector(io_struct, request,
+				   bfqd->in_serv_last_pos) &&
 	    bfqq->entity.parent == in_service_bfqq->entity.parent &&
 	    bfq_may_be_close_cooperator(bfqq, in_service_bfqq)) {
 		new_bfqq = bfq_setup_merge(bfqq, in_service_bfqq);
@@ -2755,6 +2756,8 @@ static void bfq_update_peak_rate(struct bfq_data *bfqd, struct request *rq)
 	bfq_update_rate_reset(bfqd, rq);
 update_last_values:
 	bfqd->last_position = blk_rq_pos(rq) + blk_rq_sectors(rq);
+	if (RQ_BFQQ(rq) == bfqd->in_service_queue)
+		bfqd->in_serv_last_pos = bfqd->last_position;
 	bfqd->last_dispatch = now_ns;
 }
 
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index a8a2e5aca4d4..d5e9e60cb1a5 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -469,6 +469,9 @@ struct bfq_data {
 	/* on-disk position of the last served request */
 	sector_t last_position;
 
+	/* position of the last served request for the in-service queue */
+	sector_t in_serv_last_pos;
+
 	/* time of last request completion (ns) */
 	u64 last_completion;
 
-- 
2.19.1

