Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42D15C43334
	for <linux-block@archiver.kernel.org>; Thu, 23 Jun 2022 07:48:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbiFWHsy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Jun 2022 03:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231230AbiFWHsp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Jun 2022 03:48:45 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 884642CE2E
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 00:48:42 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 60FA621D40;
        Thu, 23 Jun 2022 07:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655970521; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wvipttuSl4M+V7NYqqLGj6wiGpPYypJfA0Q3a/puHs8=;
        b=FurYDeENjsTWXxKZhTE+42dRDWSd+e3tuw2Z8IX3bRSbOLFQH4IMFCh+JwetwCR4t+y5/H
        WND4XT6F5ZvWliITgThp+Eal203n8Rt0s2hB7OC6oBgj3lx36zeKgz8Klb+5is0PZ+TdcV
        C1x7HOI9Xpahy3mGVRcUGdm0p9nPZQM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655970521;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wvipttuSl4M+V7NYqqLGj6wiGpPYypJfA0Q3a/puHs8=;
        b=pbSBJr2cvM14nqXQVzqH7wVZ9wdERBQ1vm6I0kLfurNAoTlWSWNpFMkE00u8ypsqzOWyjV
        lKXVZfVQtZzy0LBw==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id BA5042C16E;
        Thu, 23 Jun 2022 07:48:35 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id E8ABBA0640; Thu, 23 Jun 2022 09:48:40 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     <linux-block@vger.kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Niklas Cassel <Niklas.Cassel@wdc.com>, Jan Kara <jack@suse.cz>
Subject: [PATCH 9/9] block: Always initialize bio IO priority on submit
Date:   Thu, 23 Jun 2022 09:48:34 +0200
Message-Id: <20220623074840.5960-9-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220623074450.30550-1-jack@suse.cz>
References: <20220623074450.30550-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1139; h=from:subject; bh=Ug+rrkhsTkSRexpYAARxGdaSKp+1EVBfwusw2kUXiE8=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBitBrRepLkaXYqNWpW1kK+9fKw6BgoW+v5MzIBEaM6 DJuLwtKJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYrQa0QAKCRCcnaoHP2RA2XQuB/ 9LB3o/NhnOHgl80BRG64Cy8eFb4IrGgZR5MTMBhv5DdfvXwgrqq4uMFKpYLR56ufvHq1vBPzzN8f/C rDjd+DTkH8KHJNMgByxagZvRlDTMPFITOl/1uvmdqHz/gZNYl/hf2ezaFghJIhwRgYxeic3A61Tre3 d591rWmvmXCdBk9Bgj85TB96A9a5pMrGD11xzhNXdXJ44xPVu0XreBiUbGyvhxzunRGN8QFaWRc+FB GlYgjaXohO6qlCjlP+jAcnswQ7tGB8f1KkDDETAOrPam0b+7Tlmvl+QaJrEj+OUrHK9ZWMbtKLTyQu lxMwv8YlrX6qKWBLIVpghC9L9bFJuw
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
Tested-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
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

