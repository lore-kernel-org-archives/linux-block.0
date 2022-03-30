Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09347C433F5
	for <linux-block@archiver.kernel.org>; Wed, 30 Mar 2022 12:45:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242522AbiC3MrL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 30 Mar 2022 08:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245207AbiC3Mqy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Mar 2022 08:46:54 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E50827DE22
        for <linux-block@vger.kernel.org>; Wed, 30 Mar 2022 05:43:04 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 7094F1F86D;
        Wed, 30 Mar 2022 12:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1648644181; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9gbCrEQBuVqraNMaF2pon2hbUesKVBCAOTVxv1JIa08=;
        b=ETTyt026NxFyQ/KSPL/LEmBg2FGN8qMZwov+bwGztR0/F3BlFAV1rjXLgZzg6hzFuxUqNc
        FsrIN7jPuBV5vlkYiVF/vigQ6bKU+A7zRW7xem1CPFo4r4jkwikns8MO9FQjsIxpynYQu/
        FXtK5sns/00QKmW4vP3b8im82FiVV5Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1648644181;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9gbCrEQBuVqraNMaF2pon2hbUesKVBCAOTVxv1JIa08=;
        b=hn+7XQcovYcOn6lrjYatXI5eBjXVnygl38mChB1ki4Hs6xkoXQua9poNfFaKTRwDiPYsUf
        Q7HofhfSO8fhDfBw==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 60FC8A3B9E;
        Wed, 30 Mar 2022 12:43:01 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 7E518A061B; Wed, 30 Mar 2022 14:42:56 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-block@vger.kernel.org>
Cc:     Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>,
        "yukuai (C)" <yukuai3@huawei.com>, Jan Kara <jack@suse.cz>
Subject: [PATCH 5/9] bfq: Drop pointless unlock-lock pair
Date:   Wed, 30 Mar 2022 14:42:48 +0200
Message-Id: <20220330124255.24581-5-jack@suse.cz>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220330123438.32719-1-jack@suse.cz>
References: <20220330123438.32719-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=834; h=from:subject; bh=ejFMnc6iu4HXPPNauOehah8NddMt8WVB+Bu5b9CadRo=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBiRFBI1ecBINF//KLV7KHnO8abV3gJKrd0rHHIYHxL H4iYTp+JATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYkRQSAAKCRCcnaoHP2RA2T2MCA CaMaGTxUP0xKQIdFpG77UeFJcfQUAJTgZJjeajcCtWbDofVoNzNSvjkElFGEWd17FUqqDj0lctRK+Y 9xWEYSvZEjFwC8/wFmDvkI5ECWW770/d0KaVbx9S12DkPk357/FDSPFhG08cjxcSKLccvJPodYxndj 7hrtleLFkog7DtCZAW9AYPSjToPFPOHLw2De9PUkLzTWXDw07tfw3R69GZYEg9qnj3qoWdGFmXE/mY UmniuSrij9CACqCkrGnDCbZiwm2rNYCreUKnGVwJDFLko4P2NDixhYZemSKFs60NTLvUtmC3Gv1UWy 4CNAe3oCECIiwOECHR54u2X/n4djUS
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In bfq_insert_request() we unlock bfqd->lock only to call
trace_block_rq_insert() and then lock bfqd->lock again. This is really
pointless since tracing is disabled if we really care about performance
and even if the tracepoint is enabled, it is a quick call.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 block/bfq-iosched.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 1fc4d4628fba..19082e14f3c1 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -6150,11 +6150,8 @@ static void bfq_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
 		return;
 	}
 
-	spin_unlock_irq(&bfqd->lock);
-
 	trace_block_rq_insert(rq);
 
-	spin_lock_irq(&bfqd->lock);
 	bfqq = bfq_init_rq(rq);
 	if (!bfqq || at_head) {
 		if (at_head)
-- 
2.34.1

