Return-Path: <SRS0=YBka=5Z=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB31BC2BB55
	for <linux-block@archiver.kernel.org>; Thu,  9 Apr 2020 17:09:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADD5A20768
	for <linux-block@archiver.kernel.org>; Thu,  9 Apr 2020 17:09:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbgDIRJb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 9 Apr 2020 13:09:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:44226 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726723AbgDIRJa (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 9 Apr 2020 13:09:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 14000AC53;
        Thu,  9 Apr 2020 17:09:29 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 92ED61E124D; Thu,  9 Apr 2020 19:09:28 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     <linux-block@vger.kernel.org>,
        Andreas Herrmann <aherrmann@suse.com>, Jan Kara <jack@suse.cz>
Subject: [PATCH 1/2] bfq: Fix check detecting whether waker queue should be selected
Date:   Thu,  9 Apr 2020 19:09:14 +0200
Message-Id: <20200409170915.30570-2-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200409170915.30570-1-jack@suse.cz>
References: <20200409170915.30570-1-jack@suse.cz>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The check in bfq_select_queue() checking whether a waker queue should be
selected has a bug and is checking bfqq->next_rq instead of
bfqq->waker_bfqq->next_rq to verify whether the waker queue has a
request to dispatch. This often results in the condition being false
(most notably when the current queue is idling waiting for next request)
and thus the waker queue logic is ineffective. Fix the condition.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 block/bfq-iosched.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 78ba57efd16b..18f85d474c9c 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -4498,7 +4498,7 @@ static struct bfq_queue *bfq_select_queue(struct bfq_data *bfqd)
 			bfqq = bfqq->bic->bfqq[0];
 		else if (bfq_bfqq_has_waker(bfqq) &&
 			   bfq_bfqq_busy(bfqq->waker_bfqq) &&
-			   bfqq->next_rq &&
+			   bfqq->waker_bfqq->next_rq &&
 			   bfq_serv_to_charge(bfqq->waker_bfqq->next_rq,
 					      bfqq->waker_bfqq) <=
 			   bfq_bfqq_budget_left(bfqq->waker_bfqq)
-- 
2.16.4

