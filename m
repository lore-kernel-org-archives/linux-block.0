Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C698C43381
	for <linux-block@archiver.kernel.org>; Wed, 13 Jan 2021 10:10:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44ECB233A2
	for <linux-block@archiver.kernel.org>; Wed, 13 Jan 2021 10:10:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbhAMKKU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Jan 2021 05:10:20 -0500
Received: from mx2.suse.de ([195.135.220.15]:44666 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727206AbhAMKKT (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Jan 2021 05:10:19 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 00D71B773;
        Wed, 13 Jan 2021 10:09:38 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id B76EA1E086D; Wed, 13 Jan 2021 11:09:37 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     <linux-block@vger.kernel.org>,
        Paolo Valente <paolo.valente@linaro.org>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 2/3] bfq: Use 'ttime' local variable
Date:   Wed, 13 Jan 2021 11:09:26 +0100
Message-Id: <20210113100937.8278-2-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200605140837.5394-1-jack@suse.cz>
References: <20200605140837.5394-1-jack@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Use local variable 'ttime' instead of dereferencing bfqq.

Acked-by: Paolo Valente <paolo.valente@linaro.org>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 block/bfq-iosched.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index dc5f12d0d482..d0b744eae1a3 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -5199,7 +5199,7 @@ static void bfq_update_io_thinktime(struct bfq_data *bfqd,
 
 	elapsed = min_t(u64, elapsed, 2ULL * bfqd->bfq_slice_idle);
 
-	ttime->ttime_samples = (7*bfqq->ttime.ttime_samples + 256) / 8;
+	ttime->ttime_samples = (7*ttime->ttime_samples + 256) / 8;
 	ttime->ttime_total = div_u64(7*ttime->ttime_total + 256*elapsed,  8);
 	ttime->ttime_mean = div64_ul(ttime->ttime_total + 128,
 				     ttime->ttime_samples);
-- 
2.26.2

