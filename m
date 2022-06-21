Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F3C0C433EF
	for <linux-block@archiver.kernel.org>; Tue, 21 Jun 2022 10:25:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346796AbiFUKZD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 Jun 2022 06:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348456AbiFUKZA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Jun 2022 06:25:00 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E14028997
        for <linux-block@vger.kernel.org>; Tue, 21 Jun 2022 03:24:59 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 9F4D221E18;
        Tue, 21 Jun 2022 10:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655807097; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TU+VB9FLVByEd3dua4vGm7KA60JO5fn9ySddRdhTlZk=;
        b=LHrflqPe7IuETS0m/lpSmvNz7clvubUxcObJQvKT5KPdbxcJxowJUjDi4VXUyvhukKb+rz
        WFi5uipZCo1GKu0mvuawVHKa+3vEjOZ4aijMCiw1cWYEHCyJbz1Rz/IN/K0xGGnGsi4wqO
        dh1MNtKFzy1QkKWqqS6q0ZOJvt/I2DE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655807097;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TU+VB9FLVByEd3dua4vGm7KA60JO5fn9ySddRdhTlZk=;
        b=pnqbrQ3r+sYE+GbYGNmOdCLHj8Gq4a49u/GK2Klu01mxnPDTq2uVVmJy/bWPZs5nfzoLm0
        5x8T8KSpig7QC4AQ==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 907FB2C149;
        Tue, 21 Jun 2022 10:24:57 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 0D1EDA063F; Tue, 21 Jun 2022 12:24:56 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     <linux-block@vger.kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Niklas Cassel <Niklas.Cassel@wdc.com>, Jan Kara <jack@suse.cz>
Subject: [PATCH 8/9] block: Initialize bio priority earlier
Date:   Tue, 21 Jun 2022 12:24:45 +0200
Message-Id: <20220621102455.13183-8-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220621102201.26337-1-jack@suse.cz>
References: <20220621102201.26337-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=966; h=from:subject; bh=ToM3nKfji8UyBGmYo0J4IX46p7CgkI9nwQg5TxlG+ms=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBisZxs0nH7AJLmGTjHh/hmBGnZkV5SUQeHqiNpZWRS BTqzHr6JATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYrGcbAAKCRCcnaoHP2RA2cE9B/ 4+LdMvrHkEVisL4mrugY+Cl0R+llEMg4OwwImzSlT3IsNQSGcSIgWXYzwuy/bBVQtNd4+M4z/DpDHl II1COAKK75lRfWdejT7pJcygGkSUSXunyCBLoDM0WL90pBw9Aj96bKD90o0E+kas6o4Q7SplQ61ucT ebKuOGHn+bv4EoPV20uQAOX/BDnoXJSGL80dDbGj6X5Jo9p9p92KDOOZLTrAdq6aQMKMyAv/zxQ05O ELKItcNG4Fgy4e7W/qM4Vbv/dHN/XMDtwuCITIoLMlg0nXV7+6N43p9jsHf2bg4B/XQi6TUQf7x2w6 uya0fYUyTKYTVxqnOCI+uc3c18WLfm
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Bio's IO priority needs to be initialized before we try to merge the bio
with other bios. Otherwise we could merge bios which would otherwise
receive different IO priorities leading to possible QoS issues.

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
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

