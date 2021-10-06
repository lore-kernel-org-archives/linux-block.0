Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22186C4321E
	for <linux-block@archiver.kernel.org>; Wed,  6 Oct 2021 17:32:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E5A0610A0
	for <linux-block@archiver.kernel.org>; Wed,  6 Oct 2021 17:32:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239019AbhJFRd6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Oct 2021 13:33:58 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:41974 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238664AbhJFRdv (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Oct 2021 13:33:51 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 08DEC1FEEF;
        Wed,  6 Oct 2021 17:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1633541518; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KII/Hs2+ZKgN7DHZXgBjp+H0qWndFcwudaWYnhaH3NM=;
        b=C2JvP5XIaNPWg5RA+qt8gjwCuS8MttojqjidKt+PaYnzvNPd2/CBl5owVG8mLbDzvYt1kj
        fZ7CK3HN+ON3kltxoqJ9tgMn0jSXdGjmjYD0dJSWZN7XjIFQsEadGOKQL+VL1ROGk8vtSK
        +x5YbkmodVfcofhmNTGjMEvOMoEeEzQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1633541518;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KII/Hs2+ZKgN7DHZXgBjp+H0qWndFcwudaWYnhaH3NM=;
        b=b6i+obU2GH+0n5FUC5G1n6cogaskYUW0ZkSYyyJn5xkDMy3oAjUK2TPuy8x3ssPB8jE4hN
        dRXvSXSrOmh8bsDA==
Received: from quack2.suse.cz (unknown [10.163.28.18])
        by relay2.suse.de (Postfix) with ESMTP id E9001A3B90;
        Wed,  6 Oct 2021 17:31:57 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 74E881F2CA5; Wed,  6 Oct 2021 19:31:57 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     <linux-block@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>,
        =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 7/8] bfq: Log waker detections
Date:   Wed,  6 Oct 2021 19:31:46 +0200
Message-Id: <20211006173157.6906-7-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211006164110.10817-1-jack@suse.cz>
References: <20211006164110.10817-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1683; h=from:subject; bh=Zv1+Q1Zk8ItMBQD5wOXUUOnHDT2JltHFWFqe9XZ8yBs=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBhXd2B+QD2RFEJhUdcY7q++r8M7Ya1LTBF7Vx/aKPK qmds7nmJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYV3dgQAKCRCcnaoHP2RA2dTCB/ 9nesAouv+assQ9AoAOVqRMsq8BVmIdJPQFGYKbRsBMCCOiQQUb3+E8NpgIJhmul8uUESnaNkpEBxe4 987AMliHywu3Yda3lnklW1o2Y6SP89c63k+sjfw+Ge8LZj0hjJ2ngWHZWsXcA0mVtPlm58kW3udVOj qaeiOwZOUesl/2iifNPwz1VJEWZ5dWtFLtUeORnqOa4uoZHSfC/i1j1Lwk0QlIpALYnty6yOU1F9sK +I4Ubw2SpPi0WUGfXJMHV4qVFwAfGVirzRTj+DxnBGVrJcAjrVSyqHRy6rxPhVDZbVeZ2CoXra9LV1 uSZMVRYxaNNbnQjKbt91V+sBq7WDah
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Waker - wakee relationships are important in deciding whether one queue
can preempt the other one. Print information about detected waker-wakee
relationships so that scheduling decisions can be better understood from
block traces.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 block/bfq-iosched.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 6c5e9bafdb5d..886befc35b57 100644
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

