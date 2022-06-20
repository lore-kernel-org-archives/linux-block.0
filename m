Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D74FDCCA479
	for <linux-block@archiver.kernel.org>; Mon, 20 Jun 2022 16:12:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243015AbiFTQL7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Jun 2022 12:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242487AbiFTQL5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Jun 2022 12:11:57 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAD6E20BCE
        for <linux-block@vger.kernel.org>; Mon, 20 Jun 2022 09:11:55 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id A4F1B21B87;
        Mon, 20 Jun 2022 16:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655741514; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j+EeqhSguiL/f3al2niBNE1UPdRtw82hjLXb6sHZejg=;
        b=SXjRm6PhN7z8ogbFREcrkzm/MSYzIL3pxyD/NpsA8Fpde9TNMuH5HjYPpFcPNFqrGzD9bf
        +/IompQcumaqbNazN/47rxPyemyU0jPqaAiDb30jUk5skQrShYk1aLM6RLOLV+prxF337W
        1nhlgEp+Joy9ouPt03POWf+sSPIiBtg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655741514;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j+EeqhSguiL/f3al2niBNE1UPdRtw82hjLXb6sHZejg=;
        b=JCnd9OmeGu9wx8gKMkJFvfLWZntoV+k+usU5RpU96bVjE9XVIVP56PO2ZZR0QqoEJFPCFM
        zIMMbi9ixZ/nzWDw==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 97FFA2C141;
        Mon, 20 Jun 2022 16:11:54 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 5F227A063D; Mon, 20 Jun 2022 18:11:53 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     <linux-block@vger.kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Niklas Cassel <Niklas.Cassel@wdc.com>, Jan Kara <jack@suse.cz>
Subject: [PATCH 7/8] block: Initialize bio priority earlier
Date:   Mon, 20 Jun 2022 18:11:48 +0200
Message-Id: <20220620161153.11741-7-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220620160726.19798-1-jack@suse.cz>
References: <20220620160726.19798-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=902; h=from:subject; bh=rGyU+5zciSS3AScSd4SNeEGsxv246Ub1JBy28bN6W3M=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBisJxExwClY9U8vYvn2qq0rBlvaWqphh7dAHT9ZZtf PVXXROWJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYrCcRAAKCRCcnaoHP2RA2VfcB/ 9j1S3iTl/cCZw6xS3rQUqDIcFwOg6RJ/w5XmmN34R63G/5myT3pof/aLTTHQlsvmms5VtzGza48kmb 5XF32xYvviYmEIPZS5D/2dhfFlw/4I9mGMh9BgpckoKRiUs6PfPeskydJedb94f7ojakkJSj2HMoYO YCCEAHZhMg+imC7rL43Zh+r0jLbxBJsEXswnoOLeiFQy2ds0tIaEfChFujxzXV6s5rQ/x2AjbU/cn6 vw4pIxyp1dnOTsxgLVBh+//HtfK2SZT7GatP3Ya5+/p08SUyl2OTxHARr6lghoFgkiTvrUxIux9IQ8 dM0KgTMRypNrEON0FGTjOotIp26LC0
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

