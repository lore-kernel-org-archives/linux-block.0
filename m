Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD3A5CCA473
	for <linux-block@archiver.kernel.org>; Wed, 15 Jun 2022 16:19:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354495AbiFOQTM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Jun 2022 12:19:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354872AbiFOQSQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Jun 2022 12:18:16 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8DBC55206
        for <linux-block@vger.kernel.org>; Wed, 15 Jun 2022 09:16:39 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id D872E21C47;
        Wed, 15 Jun 2022 16:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655309778; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j+EeqhSguiL/f3al2niBNE1UPdRtw82hjLXb6sHZejg=;
        b=EiqW3n3Vqbg3pIPHD9QFyoEirRKQDdc7AxYt4BS4rcRv/Y8WHztx1ftsBhnVcNQcPtZsmk
        Fb61VbDe1k6xNlhE8ROwxepfyZIN686Zoeo8aJMDrdZ7jWAG3IkzAMQlipU4T/jpneh/52
        Hon5Ftu9amrJ5OozNol1r7bQJfWsqjs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655309778;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j+EeqhSguiL/f3al2niBNE1UPdRtw82hjLXb6sHZejg=;
        b=EYn3I50TKUdZ8Kej01JPunnh1Oc5hbf4O5GrFjtMDxUw24HfAhic108+i3Mss7v4+Jzd2u
        jFTiFsWEAUBT2WCg==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id CA0CE2C14E;
        Wed, 15 Jun 2022 16:16:18 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id F137BA063B; Wed, 15 Jun 2022 18:16:16 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     <linux-block@vger.kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 7/8] block: Initialize bio priority earlier
Date:   Wed, 15 Jun 2022 18:16:10 +0200
Message-Id: <20220615161616.5055-7-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220615160437.5478-1-jack@suse.cz>
References: <20220615160437.5478-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=902; h=from:subject; bh=rGyU+5zciSS3AScSd4SNeEGsxv246Ub1JBy28bN6W3M=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBiqgXKxwClY9U8vYvn2qq0rBlvaWqphh7dAHT9ZZtf PVXXROWJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYqoFygAKCRCcnaoHP2RA2ac8CA DjA4K/cehTVACAcVUXlurJ8mGMJ+Wg6Hz57ae85hhIqYBEk3VN9RnO/3nMC96Og9HaeorlZrQanu0r W0k26DjSgg0/R9UtqGycogDxAyd4RGqBX5s0zOHItvtqqaZdVyJByRxrHaAiwAv7wOZ51sL7u74MNx sc56b1dPln5uEoiaQmccpVcPMzWoPwL2YW7mwhVrUwrnmcu3Krpl+8cMUh7q8ZbL2nu2aWrBWIN0Nz jf5sYEYmeyb/SxvrpQiDJ/2lDDUcFU7Hsv1wcsfpYGVpSLM5+410JZ+6SXLRTlIn0Zu5/QaF2l5rXl YOsXldG9F+jr57rGJIuFTybC5m9Fgf
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Bio's IO priority needs to be initialized before we try to merge the bio
with other bios. Otherwise we could merge bios which would otherwise
receive different IO priorities leading to possible QoS issues.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 block/blk-mq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 67a7bfa58b7c..e17d822e6051 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2825,6 +2825,8 @@ void blk_mq_submit_bio(struct bio *bio)
 	if (!bio_integrity_prep(bio))
 		return;
 
+	bio_set_ioprio(bio);
+
 	rq = blk_mq_get_cached_request(q, plug, &bio, nr_segs);
 	if (!rq) {
 		if (!bio)
@@ -2836,8 +2838,6 @@ void blk_mq_submit_bio(struct bio *bio)
 
 	trace_block_getrq(bio);
 
-	bio_set_ioprio(bio);
-
 	rq_qos_track(q, rq, bio);
 
 	blk_mq_bio_to_request(rq, bio, nr_segs);
-- 
2.35.3

