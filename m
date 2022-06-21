Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08364CCA473
	for <linux-block@archiver.kernel.org>; Tue, 21 Jun 2022 10:25:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348556AbiFUKZH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 Jun 2022 06:25:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348528AbiFUKZB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Jun 2022 06:25:01 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7D7328726
        for <linux-block@vger.kernel.org>; Tue, 21 Jun 2022 03:25:00 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id B095521E2A;
        Tue, 21 Jun 2022 10:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655807097; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4kC6rjFDlsoZbHR5CLGsg9tbqVMXxLLOhXzA+rqhzIU=;
        b=AhFVhZPxenMh9p2/aqGmnVh7NyyLjRjh6+nWtJdeaz88iNgryCf9pinRLmvwbwddnAb5JX
        HIQjNX5oqhBV6gefnXcGVfcrG7UQWcvVe6ZccbIPZKi9v13JYQuyyXEV+HdQtGPjuM/ifm
        5vXFjz1M32jiziFH59eN3DvQnharQp0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655807097;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4kC6rjFDlsoZbHR5CLGsg9tbqVMXxLLOhXzA+rqhzIU=;
        b=5Is+O+V3z2Uio1pV5sTJ+VTEZU0D6pE762g+NW58JApAjHjKxWes4r0ptkvHni1yjJpE1w
        yBqylhDz+/e+xoDQ==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 9B1112C152;
        Tue, 21 Jun 2022 10:24:57 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 14303A0640; Tue, 21 Jun 2022 12:24:56 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     <linux-block@vger.kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Niklas Cassel <Niklas.Cassel@wdc.com>, Jan Kara <jack@suse.cz>
Subject: [PATCH 9/9] block: Always initialize bio IO priority on submit
Date:   Tue, 21 Jun 2022 12:24:46 +0200
Message-Id: <20220621102455.13183-9-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220621102201.26337-1-jack@suse.cz>
References: <20220621102201.26337-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1077; h=from:subject; bh=LJzShUwYAe4N1tAr4q1jrBbjZR2RONUIkCyA8INg9kM=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBisZxtKkrEjuXUIhwRb0SFwOaiQQsBJGvIZqjb7Gez IEYeUoKJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYrGcbQAKCRCcnaoHP2RA2ecGB/ 9K3Kgp1h6Bu8oSzveKILh6N61qDhuateivPoOOESKFXKd/LpdqFYRqSOJAsJ3/cx6CjjhDZxAd3sb4 qIm+JfUsyxKkHdn4TtxKqcw5uszl7nV4ZyNnDI/M0KJ7RvPW4o9mWadWkPnVSaIColADS7ENOiAPIJ 9AQwaf8/OGppYAPZN1qaYtKWLvB5NamAG4MxNncVc8vKpk99h7UGos+yhryXBqz6/chpT4nkO0WeF6 MKSJI7Am5gxfnfXXxgOcfUHCp4Ew++h/Ixnq09p+r08RUYRY32MHlp4VGVozS5b0Ih9O6f3E0XPdul MarnD4ii2lry12Od8e5pjr0J+QWDNU
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

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
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

