Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C410DC4167B
	for <linux-block@archiver.kernel.org>; Tue, 23 Nov 2021 10:32:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235419AbhKWKfJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Nov 2021 05:35:09 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:49856 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235385AbhKWKfH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Nov 2021 05:35:07 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id B7DD9218DF;
        Tue, 23 Nov 2021 10:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637663518; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e4TLO3y3BQuWhOjUMzkDpS7bNGTA2cYfv2C3zauDytg=;
        b=IMNfNKds9jdM0/QyN+XkzXJ4z+etm9d180eQgVvvgfhOtPCEKmRNVMj3v5SNrirYKBVNkN
        RnSDbxV6x8LDdCZVqPiobIz0G1dcln7pLePdhX6qUvC3WJ2TSuIFKzm2biPlrF+kv1lkkc
        UQ8AhdUx89SmMaYxWONoQAJygAHYAGQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637663518;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e4TLO3y3BQuWhOjUMzkDpS7bNGTA2cYfv2C3zauDytg=;
        b=Vvbi4sGuMCUVI8j7nSaXAJxeG/kGGY3v8cTPkpEWXjqz/1x9jjT+1ST4dHPB+wOQfFL7sy
        0kKv+Kn/8e+p7MDg==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id A3532A3B8B;
        Tue, 23 Nov 2021 10:31:58 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 794A91E3B2F; Tue, 23 Nov 2021 11:31:58 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     <linux-block@vger.kernel.org>,
        Paolo Valente <paolo.valente@linaro.org>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH 7/8] bfq: Log waker detections
Date:   Tue, 23 Nov 2021 11:29:19 +0100
Message-Id: <20211123103158.17284-7-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20211123101109.20879-1-jack@suse.cz>
References: <20211123101109.20879-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1735; h=from:subject; bh=MWtZKXkWbZSQLmzHT/x3s1Vz1BjQSVD7S8zSHXwYzPI=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBhnMJ+hQ9SW7uyKiZlSQGwpaLKNUm6ie4BGuyvzJKA AzG8DT6JATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYZzCfgAKCRCcnaoHP2RA2cXvB/ 9TsoTKgsAhyq8WUb8DW4bZwlJJVxC62i+GvoMWdnoHAko66DMydyj6J+Ci/4bzYUlrdbXWZfH/vVj0 CrWfZmlsmvTIH/v7TI2XZtppIQj5M0gRw3Fyx3NjSjS1Eyb+nXbkkajsD5WnoZzsyHyS4kPuabS9ik zvtNytSM40JNL6j5SJ38QdxARsI/mqtPKOcPYvnQYGd0rZWzn7DV6dV4NjU70s3QNXf7LXeH3OYcCf SA8EKZer+esF6/EyGc58klL3+19OwDn6REMfHD1hdleUdwbkSpSL60U95qlJlzYi9ceHkzSyCcoQEF EanrFrcf8QzBLbLOj/Rlj/FW7BBy40
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
index 73eab70cefdb..3f1c8a080b71 100644
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

