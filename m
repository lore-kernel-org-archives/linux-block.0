Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9292C43219
	for <linux-block@archiver.kernel.org>; Thu, 25 Nov 2021 13:38:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355129AbhKYNmD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Nov 2021 08:42:03 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:58112 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355134AbhKYNkB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Nov 2021 08:40:01 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 4704E21B3A;
        Thu, 25 Nov 2021 13:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637847409; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Vius1EEBYV8AfvA99YGsUwfNIFCRRkmKCQ+JuMpvEOU=;
        b=u2eOa8O77iZXe6qb6PtruVQFyjKYJKfRj1fsfDDIBIGXK84kcBwNmI9htF7fUjEO+nxBvm
        9OKJuspbgym6Jq+FT0oL9Zh4UHR17FxpgRdqB6WB79GoSdq91/l5a2096ggwBehuY9AQxM
        MRsWjVye6cEoDBUzD+IRLpsRJzZH+Jw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637847409;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Vius1EEBYV8AfvA99YGsUwfNIFCRRkmKCQ+JuMpvEOU=;
        b=JnL8vI3g51hV1T91HyiN8jsDEE2omenpqAtWKmJp39Dpe49QQhYsgaNH5jw+hK4IMtA2f1
        xnxdTiOEzMeIxoDw==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 3BD88A3B90;
        Thu, 25 Nov 2021 13:36:49 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 081721F2CE7; Thu, 25 Nov 2021 14:36:46 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     <linux-block@vger.kernel.org>,
        Paolo Valente <paolo.valente@linaro.org>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 7/8] bfq: Log waker detections
Date:   Thu, 25 Nov 2021 14:36:40 +0100
Message-Id: <20211125133645.27483-7-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211125133131.14018-1-jack@suse.cz>
References: <20211125133131.14018-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1735; h=from:subject; bh=48k5vsNZ3Sdki/wMVpiTSWvwslFhPA7dwVOPCb4DhU0=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBhn5FnYr/kBJuZ/xs3R7Z8mOow+h8plCoQlzNpmmf6 iRfPUeKJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYZ+RZwAKCRCcnaoHP2RA2f5/CA DoyDIdmkenA/vW+o0wegm3xpLm9RqYi7N5ZdfO8yxy7SeEv1jp143meXiKshEoXblRSw9Gs4mbl/iR SlWmXLxnB0miU+LMPWXmTmalrxk2YFFPfDLAXm8g/Yy3YWHaTgzWjfMx6F9c2BQ/i+AZftdFvtiXb0 1YMpKTsacfycaT1KXtWYDPnqzue+NxNhI6QofZiwKILScF2m87hIxfb4cJtAIgY4yRIsbTiMETRgeY ygaN9uyQtgW5IKwJK6ghUTGTuwPmMB0yZ/j/oMkGpYceskcCtoSuBd3sM3cdCvBopfQmi9A13v8/5x /JWC278y3pyYiyrlg5Oq7NUMtkF9rQ
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Waker - wakee relationships are important in deciding whether one queue
can preempt the other one. Print information about detected waker-wakee
relationships so that scheduling decisions can be better understood from
block traces.

Acked-by: Paolo Valente <paolo.valente@linaro.org>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 block/bfq-iosched.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 83a2225e407b..69144003a694 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -2127,6 +2127,8 @@ static void bfq_update_io_intensity(struct bfq_queue *bfqq, u64 now_ns)
 static void bfq_check_waker(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 			    u64 now_ns)
 {
+	char waker_name[MAX_BFQQ_NAME_LENGTH];
+
 	if (!bfqd->last_completed_rq_bfqq ||
 	    bfqd->last_completed_rq_bfqq == bfqq ||
 	    bfq_bfqq_has_short_ttime(bfqq) ||
@@ -2154,12 +2156,18 @@ static void bfq_check_waker(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 			bfqd->last_completed_rq_bfqq;
 		bfqq->num_waker_detections = 1;
 		bfqq->waker_detection_started = now_ns;
+		bfq_bfqq_name(bfqq->tentative_waker_bfqq, waker_name,
+			      MAX_BFQQ_NAME_LENGTH);
+		bfq_log_bfqq(bfqd, bfqq, "set tenative waker %s", waker_name);
 	} else /* Same tentative waker queue detected again */
 		bfqq->num_waker_detections++;
 
 	if (bfqq->num_waker_detections == 3) {
 		bfqq->waker_bfqq = bfqd->last_completed_rq_bfqq;
 		bfqq->tentative_waker_bfqq = NULL;
+		bfq_bfqq_name(bfqq->waker_bfqq, waker_name,
+			      MAX_BFQQ_NAME_LENGTH);
+		bfq_log_bfqq(bfqd, bfqq, "set waker %s", waker_name);
 
 		/*
 		 * If the waker queue disappears, then
-- 
2.26.2

