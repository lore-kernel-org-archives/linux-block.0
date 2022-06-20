Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39D3FC43334
	for <linux-block@archiver.kernel.org>; Mon, 20 Jun 2022 16:12:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242503AbiFTQMD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Jun 2022 12:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243051AbiFTQL5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Jun 2022 12:11:57 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E10120BCF
        for <linux-block@vger.kernel.org>; Mon, 20 Jun 2022 09:11:56 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id A75141F913;
        Mon, 20 Jun 2022 16:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655741514; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=weAAY5vzMZxLYO8eCbj69OrJkVAZGGP14yJXmPoHuTY=;
        b=h7sHo5cUGkH3v2m2Lpt5X2qpldXEa8GDwcz7GR3Agb5Dsx5zmU4Y2H/UtfTvi//+82CsvI
        /idTaccCWtunV5eAJjGFVeQ/WQbeY/RW8rVBOqdnCOUZAOdkvqMOCtLkIUxYQqEICaiDRv
        NnGYNUp/lx5WT07isxwWnVj/9iD42tM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655741514;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=weAAY5vzMZxLYO8eCbj69OrJkVAZGGP14yJXmPoHuTY=;
        b=c8fVtA9aGYyobCe7fdPHMyX4Gl5YuX2TELnBMzgImY260ehTUK78lvDITCI7CZ5DbxG334
        THy621XzSFJUJkDA==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 9A1922C143;
        Mon, 20 Jun 2022 16:11:54 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 658ACA063E; Mon, 20 Jun 2022 18:11:53 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     <linux-block@vger.kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Niklas Cassel <Niklas.Cassel@wdc.com>, Jan Kara <jack@suse.cz>
Subject: [PATCH 8/8] block: Always initialize bio IO priority on submit
Date:   Mon, 20 Jun 2022 18:11:49 +0200
Message-Id: <20220620161153.11741-8-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220620160726.19798-1-jack@suse.cz>
References: <20220620160726.19798-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1013; h=from:subject; bh=qrJSja6cK1OVHuXY8zd4J5m/Hx2yD5nZJYW+nTm82wE=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBisJxF7tg/DFgZrptH3B9sVd5U2hBXDR2dXEahleS3 4cXvwIaJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYrCcRQAKCRCcnaoHP2RA2SB5CA CH1bIOQf6wUi6goASTjrQqs5pxHum+YYRO6hIpHg2qWWeYbspu3rizMrer3xAlDrGq6TVton1Z40+E heBC206049MbOOpyse1K18hPWCGMFk4sC8JOGHPxGu1cqfqXpNmWLY+ZrdsSIL44QqXMgKFjGtV/v7 /l6hTj94WF6NV+i8GBalPVR5ouGQffNEaTs3Qte3Gv/wESu5MC7GrmcLF4Wk5IyJWM9NPTtaMis+zH GYp54NXBD5yVjF8vc8GgGzpUafJUiyfPMRJzT6Db7yFaVZPWi5FGKmUVVRYPe11VFg2nmBXte80JF+ jwg7cDvL33GgdyKj2fc6i3D4b5fOhx
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Currently, IO priority set in task's IO context is not reflected in the
bio->bi_ioprio for most IO (only io_uring and direct IO set it). This
results in odd results where process is submitting some bios with one
priority and other bios with a different (unset) priority and due to
differing priorities bios cannot be merged. Make sure bio->bi_ioprio is
always set on bio submission.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 block/blk-mq.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index e17d822e6051..7548f8aebea8 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2793,6 +2793,9 @@ static inline struct request *blk_mq_get_cached_request(struct request_queue *q,
 
 static void bio_set_ioprio(struct bio *bio)
 {
+	/* Nobody set ioprio so far? Initialize it based on task's nice value */
+	if (IOPRIO_PRIO_CLASS(bio->bi_ioprio) == IOPRIO_CLASS_NONE)
+		bio->bi_ioprio = get_current_ioprio();
 	blkcg_set_ioprio(bio);
 }
 
-- 
2.35.3

