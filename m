Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2B1BC433EF
	for <linux-block@archiver.kernel.org>; Wed, 15 Jun 2022 16:19:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349414AbiFOQTP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Jun 2022 12:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355555AbiFOQSS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Jun 2022 12:18:18 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA08A48387
        for <linux-block@vger.kernel.org>; Wed, 15 Jun 2022 09:16:41 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id D8A6E21C53;
        Wed, 15 Jun 2022 16:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1655309778; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vTBV4GVJAyuQOnq7Eqd7AQEyBKr2b9T1PTHtj8WIfgs=;
        b=Ej03qcuyjOIrR3YiDk6zf+JIiyFUYC9G45VsAyngUP8HRXkLocPlcasElRuyWRGS7XWKFS
        02BzT0XzTHz3TL1P8CaFdiqLBlAhJ0Y3v+grqlfDk8oLIAOfux0VEOOzqwdR34/8iTELdN
        VGnriq5hVAv6JjGLcRyc6PGk+po+w98=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1655309778;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vTBV4GVJAyuQOnq7Eqd7AQEyBKr2b9T1PTHtj8WIfgs=;
        b=Fr0sxROVC5BHwqjjexPnWvBzfRguHNAbZdUi81bl8RxY2E3OzSws8WNY6Uj/zJYKewwp48
        nYJeIOEU6LLpVfCQ==
Received: from quack3.suse.cz (unknown [10.163.28.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id C9FE22C14B;
        Wed, 15 Jun 2022 16:16:18 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 040DBA063C; Wed, 15 Jun 2022 18:16:17 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     <linux-block@vger.kernel.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 8/8] block: Always initialize bio IO priority on submit
Date:   Wed, 15 Jun 2022 18:16:11 +0200
Message-Id: <20220615161616.5055-8-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220615160437.5478-1-jack@suse.cz>
References: <20220615160437.5478-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1090; h=from:subject; bh=294Oi1TS0R+sTtvAWIrlNByf+vKBwPZJ3GDBJ8IBplU=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBiqgXLlPdqbWvvzQGioc3zcit8ZN/sDhbTEpIOQJjs XJ5ngECJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYqoFywAKCRCcnaoHP2RA2WsOB/ 4sWcBtp2toW6eEGKFbcTPF0ZXam0cwn+aKd/9H+jlbRGJurJ1ZlbUdscETIWqvRQAssH/zP+r7OWv+ iZ2gMSnir1Bo5JsLA0XNHyBx176ltB3fOIzH5FHG1Ol5ECygLhBDwMZ0QjH3Gvr6FwaNvcJJ/cGbRo SLn6A6CywG/wd2hZz05AXz7o/eP3gj8Yf/VJZHYKLGwkMaXeywzCpg5VpNuou6TXXtGELlNITZvU4m BJIw5wBwKPOTMiatt5yiiNuvEdJC72wnaRzUw9b19kczzT54WJHPmZStviMCIr1g6VaFJ8K6sxFh4x mm7WKb+nhGq1KmR+42o0M69rQUr5P2
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
 block/blk-mq.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index e17d822e6051..e976f696babc 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2793,7 +2793,13 @@ static inline struct request *blk_mq_get_cached_request(struct request_queue *q,
 
 static void bio_set_ioprio(struct bio *bio)
 {
+	unsigned short ioprio_class;
+
 	blkcg_set_ioprio(bio);
+	ioprio_class = IOPRIO_PRIO_CLASS(bio->bi_ioprio);
+	/* Nobody set ioprio so far? Initialize it based on task's nice value */
+	if (ioprio_class == IOPRIO_CLASS_NONE)
+		bio->bi_ioprio = get_current_ioprio();
 }
 
 /**
-- 
2.35.3

