Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54760C433EF
	for <linux-block@archiver.kernel.org>; Thu, 19 May 2022 10:52:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236888AbiESKws (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 19 May 2022 06:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236918AbiESKwn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 May 2022 06:52:43 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF4A1AEE34
        for <linux-block@vger.kernel.org>; Thu, 19 May 2022 03:52:39 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 5637C1F86B;
        Thu, 19 May 2022 10:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1652957558; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fg677vFI7lCltTpQm+6fkXpOi2PLcsYb0DZ0AhFMni0=;
        b=pfWiLddc4Y64Ic53l2Nu6M7s90z66iY/ZTea7+kb0PRrDdPwlVMUg7M3xBSna6Ux6f20Pq
        YTf38CuIQvYgI4p0KlI7uvZZhe+GCBcjzlOSnuaSbiJNJeYMtD7AXZJRXC/DrqISyZqhKR
        TbbrppaY2aB8mVQynsde1Qz4ocHWKtI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1652957558;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fg677vFI7lCltTpQm+6fkXpOi2PLcsYb0DZ0AhFMni0=;
        b=qx4HyaNRVVQgD0pVBtsUkKQXF0iJJN0K4D9KzfxRRrT+AbbWcbGxKtCDE8Yn9l6eFdbukL
        ZIpOHqQoSv08D9CA==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 491D02C142;
        Thu, 19 May 2022 10:52:38 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 8A4ACA0634; Thu, 19 May 2022 12:52:35 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     <linux-block@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 4/4] bfq: Remove bfq_requeue_request_body()
Date:   Thu, 19 May 2022 12:52:32 +0200
Message-Id: <20220519105235.31397-4-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220519104621.15456-1-jack@suse.cz>
References: <20220519104621.15456-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1145; h=from:subject; bh=YG1rQ0Gh4ujxaNXAwLRG4EsZFC+ssY7mez/N4UeBGtA=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBihiFvDIanD8kUTR5sGtO4m+5GYcCR93Oy+oAEFOgy AH3TN+qJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYoYhbwAKCRCcnaoHP2RA2eEhCA CFDNTzt5la2Kv+QSv++Jg2RFCq/BWDrbZniRe4bvOOZ6RE30SNwI+FcBGOvWqcNIvYzKW0eoZmDfwK CWFIeW9MIG8FDYM84IUIejYg3PIpsvl5w9iBeKsFC30b6RA18vYm8PpYUPVXMRZwn2Fem63aOhh4Pn MTmvsAx+veslEubMMsMV8GGPTQ9Xz91O42CMc67HaEoVoC9CQDw5GRftQkZwwLM2XocbGBZ/0G9wD5 JGuvNZBLp0zv4PdpCNzqM4U6vhbrNp4cLmGxxOICh4t+nnbgrCyPh+sDSURVNbpqPOP6VhytcGSDQY Lwks3JwaRb6gR2d/0fV1wSKPHr2gKD
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The function has only a single caller and two lines. Just remove it
since it is pointless and just harming readability.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 block/bfq-iosched.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 904fe56495ce..a1127dfe647e 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -6352,12 +6352,6 @@ static void bfq_completed_request(struct bfq_queue *bfqq, struct bfq_data *bfqd)
 		bfq_schedule_dispatch(bfqd);
 }
 
-static void bfq_finish_requeue_request_body(struct bfq_queue *bfqq)
-{
-	bfqq_request_freed(bfqq);
-	bfq_put_queue(bfqq);
-}
-
 /*
  * The processes associated with bfqq may happen to generate their
  * cumulative I/O at a lower rate than the rate at which the device
@@ -6554,7 +6548,8 @@ static void bfq_finish_requeue_request(struct request *rq)
 
 		bfq_completed_request(bfqq, bfqd);
 	}
-	bfq_finish_requeue_request_body(bfqq);
+	bfqq_request_freed(bfqq);
+	bfq_put_queue(bfqq);
 	RQ_BIC(rq)->requests--;
 	spin_unlock_irqrestore(&bfqd->lock, flags);
 
-- 
2.35.3

