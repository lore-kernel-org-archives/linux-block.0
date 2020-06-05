Return-Path: <SRS0=tuS3=7S=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32CEEC433E1
	for <linux-block@archiver.kernel.org>; Fri,  5 Jun 2020 14:16:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1952520897
	for <linux-block@archiver.kernel.org>; Fri,  5 Jun 2020 14:16:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728241AbgFEOQd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 5 Jun 2020 10:16:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:42438 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728238AbgFEOQb (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 5 Jun 2020 10:16:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 14B53AEC8;
        Fri,  5 Jun 2020 14:16:33 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 521001E1283; Fri,  5 Jun 2020 16:16:29 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-block@vger.kernel.org>
Cc:     Paolo Valente <paolo.valente@linaro.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 2/3] bfq: Use 'ttime' local variable
Date:   Fri,  5 Jun 2020 16:16:17 +0200
Message-Id: <20200605141629.15347-2-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200605140837.5394-1-jack@suse.cz>
References: <20200605140837.5394-1-jack@suse.cz>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Use local variable 'ttime' instead of dereferencing bfqq.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 block/bfq-iosched.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 50017275915f..c66c3eaa9e26 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -5196,7 +5196,7 @@ static void bfq_update_io_thinktime(struct bfq_data *bfqd,
 
 	elapsed = min_t(u64, elapsed, 2ULL * bfqd->bfq_slice_idle);
 
-	ttime->ttime_samples = (7*bfqq->ttime.ttime_samples + 256) / 8;
+	ttime->ttime_samples = (7*ttime->ttime_samples + 256) / 8;
 	ttime->ttime_total = div_u64(7*ttime->ttime_total + 256*elapsed,  8);
 	ttime->ttime_mean = div64_ul(ttime->ttime_total + 128,
 				     ttime->ttime_samples);
-- 
2.16.4

