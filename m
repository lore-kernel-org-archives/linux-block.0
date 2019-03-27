Return-Path: <SRS0=uWmC=R6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 070A3C43381
	for <linux-block@archiver.kernel.org>; Wed, 27 Mar 2019 19:18:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD2D22064A
	for <linux-block@archiver.kernel.org>; Wed, 27 Mar 2019 19:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553714293;
	bh=M7gpAwpicE9RVF3LMLloeqU6+OyvD7pICDKzU6ZWqH8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CeGMXECvHVB8zg8enxioPbhS4ncFoSrEdoDyh6YYq7v41gjxiWgKBYXTCx4L45NlK
	 iPW2INFBQNXxlNTlo68MwaocW54fSe34nQlIsDzkaVuiK9julj3Tdw63CiKP7sztzI
	 miw3TjhKVvPb9H5NVZCAr8tBl+kaLdUo4KZnFYVI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387475AbfC0TSG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Mar 2019 15:18:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:50312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729540AbfC0SI3 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Mar 2019 14:08:29 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C00732063F;
        Wed, 27 Mar 2019 18:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553710108;
        bh=M7gpAwpicE9RVF3LMLloeqU6+OyvD7pICDKzU6ZWqH8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Hv9I5NzAwgLex21NJugYx9hIAcSWTMeEIfW9HCUND6jliamRG7f/omP5apFSbZJFk
         St8ZgSv15PSTIIU5heCQYz9wkmebDcJCWr7R4Kppez9GVYva/6+TXI3ZmK+pFx/nJ5
         3qHPF4Psf0PE5deC3qmkqQOPS/RvouuJgeG7CIcg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 5.0 198/262] block, bfq: fix in-service-queue check for queue merging
Date:   Wed, 27 Mar 2019 14:00:53 -0400
Message-Id: <20190327180158.10245-198-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327180158.10245-1-sashal@kernel.org>
References: <20190327180158.10245-1-sashal@kernel.org>
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
index cd307767a134..f010810c095f 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -2224,7 +2224,8 @@ bfq_setup_cooperator(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 
 	if (in_service_bfqq && in_service_bfqq != bfqq &&
 	    likely(in_service_bfqq != &bfqd->oom_bfqq) &&
-	    bfq_rq_close_to_sector(io_struct, request, bfqd->last_position) &&
+	    bfq_rq_close_to_sector(io_struct, request,
+				   bfqd->in_serv_last_pos) &&
 	    bfqq->entity.parent == in_service_bfqq->entity.parent &&
 	    bfq_may_be_close_cooperator(bfqq, in_service_bfqq)) {
 		new_bfqq = bfq_setup_merge(bfqq, in_service_bfqq);
@@ -2764,6 +2765,8 @@ static void bfq_update_peak_rate(struct bfq_data *bfqd, struct request *rq)
 	bfq_update_rate_reset(bfqd, rq);
 update_last_values:
 	bfqd->last_position = blk_rq_pos(rq) + blk_rq_sectors(rq);
+	if (RQ_BFQQ(rq) == bfqd->in_service_queue)
+		bfqd->in_serv_last_pos = bfqd->last_position;
 	bfqd->last_dispatch = now_ns;
 }
 
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index 0b02bf302de0..746bd570b85a 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -537,6 +537,9 @@ struct bfq_data {
 	/* on-disk position of the last served request */
 	sector_t last_position;
 
+	/* position of the last served request for the in-service queue */
+	sector_t in_serv_last_pos;
+
 	/* time of last request completion (ns) */
 	u64 last_completion;
 
-- 
2.19.1

