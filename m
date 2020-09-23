Return-Path: <SRS0=LQCZ=DA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55AEAC4727D
	for <linux-block@archiver.kernel.org>; Wed, 23 Sep 2020 20:06:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEF592376E
	for <linux-block@archiver.kernel.org>; Wed, 23 Sep 2020 20:06:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LuJ4Ssnh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbgIWUG4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Sep 2020 16:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbgIWUG4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Sep 2020 16:06:56 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0547AC0613CE
        for <linux-block@vger.kernel.org>; Wed, 23 Sep 2020 13:06:56 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id c18so1022272qtw.5
        for <linux-block@vger.kernel.org>; Wed, 23 Sep 2020 13:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=b1GPedUmV+xHqE19AdEGe3J9hxHKj4JY/Mf9HBzo3AU=;
        b=LuJ4SsnhygL9cBGQvs3a88HnDt5VYF+O9OkMP9fAX5K4p6cvVd4yY2Ib96kuJI87JV
         aMFxYjTS6u7j3HHyQozj+Ing2b8MRltkoPzrU4Oe0H6oMTcY8BhUnvzYrMKJUt5nzmzH
         SHCr7dcw8jvQpin8ZjWlT2b9yQ9fM6nRJvmJcF1wZ77HmwA6cX0o98pktZ2dkW0cFABD
         EBnarHB9VvfBZSRkRJ4CQsK/mFR6KB5HIutz+roWfyP88i7mqPIeJUXrceaAuESNSjJx
         sZ3eAiqdIWbJblYVkqSNgg9+H4MpIz9fuSNd2+B5IXEEXU0+dV1ICr75BrTb8mpmITUg
         Lqnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=b1GPedUmV+xHqE19AdEGe3J9hxHKj4JY/Mf9HBzo3AU=;
        b=lGzF1BoK9edE5vWuQmB/i3nVjgrOTOoHMA6zi4ZDJ0d4as+wfJTkabPwahZ4WR17ux
         3ANfB/DZudNQEZu95flHVsAwk4Z4kSlukUdFVVa1ZLPgScC6+8JdjH/lvd+VWqsCBMSG
         ULUDYZsUq7WYkMIWtO2CJIbNGznxgA+QoHNnaM5KbRRiyluEbnTNyKK0QZfZFg8f8Cyw
         w8TwDRoki8dlraILeJpk4zUIQREjDdRoq9fxhOhc9vEnkNrFsFMACZzoVCdimS5K4yiK
         Ct5n3EE5QhGK0CWAcmlWleocymMBRlv+TZI9a/OSjhgsZQlqc18mHjneDUdp6VDpzQvL
         HJHQ==
X-Gm-Message-State: AOAM530KcR8p/kk/G02V+bLfiHi6vqCkG5f9zQjgzgrEgxJJVC1dYJw8
        Hy4m77nx5a53fSLFRE7ZFJs=
X-Google-Smtp-Source: ABdhPJx41LGmclf/EGpONy2i3LwRl11CPMFga4MSTkS3RvRRLQ+Bctmu411+4a3NuZUU9uiBmckN9A==
X-Received: by 2002:aed:2646:: with SMTP id z64mr1896675qtc.194.1600891615205;
        Wed, 23 Sep 2020 13:06:55 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id a52sm620796qtc.22.2020.09.23.13.06.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 13:06:54 -0700 (PDT)
Sender: Mike Snitzer <snitzer@gmail.com>
From:   Mike Snitzer <snitzer@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>, hch@lst.de,
        dm-devel@redhat.com, linux-block@vger.kernel.org
Subject: [PATCH 1/2] block: add QUEUE_FLAG_NOWAIT
Date:   Wed, 23 Sep 2020 16:06:51 -0400
Message-Id: <20200923200652.11082-2-snitzer@redhat.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20200923200652.11082-1-snitzer@redhat.com>
References: <20200923200652.11082-1-snitzer@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add QUEUE_FLAG_NOWAIT to allow a block device to advertise support for
REQ_NOWAIT. Bio-based devices may set QUEUE_FLAG_NOWAIT where
applicable.

Update QUEUE_FLAG_MQ_DEFAULT to include QUEUE_FLAG_NOWAIT.  Also
update submit_bio_checks() to verify it is set for REQ_NOWAIT bios.

Reported-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
---
 block/blk-core.c       | 4 ++--
 include/linux/blkdev.h | 7 +++++--
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index ca3f0f00c943..e3adfa135a20 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -817,9 +817,9 @@ static noinline_for_stack bool submit_bio_checks(struct bio *bio)
 
 	/*
 	 * For a REQ_NOWAIT based request, return -EOPNOTSUPP
-	 * if queue is not a request based queue.
+	 * if queue does not support NOWAIT.
 	 */
-	if ((bio->bi_opf & REQ_NOWAIT) && !queue_is_mq(q))
+	if ((bio->bi_opf & REQ_NOWAIT) && !blk_queue_nowait(q))
 		goto not_supported;
 
 	if (should_fail_bio(bio))
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index be5ef6f4ba19..9723b497d435 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -618,10 +618,12 @@ struct request_queue {
 #define QUEUE_FLAG_PCI_P2PDMA	25	/* device supports PCI p2p requests */
 #define QUEUE_FLAG_ZONE_RESETALL 26	/* supports Zone Reset All */
 #define QUEUE_FLAG_RQ_ALLOC_TIME 27	/* record rq->alloc_time_ns */
-#define QUEUE_FLAG_HCTX_ACTIVE 28	/* at least one blk-mq hctx is active */
+#define QUEUE_FLAG_HCTX_ACTIVE	28	/* at least one blk-mq hctx is active */
+#define QUEUE_FLAG_NOWAIT       29	/* device supports NOWAIT */
 
 #define QUEUE_FLAG_MQ_DEFAULT	((1 << QUEUE_FLAG_IO_STAT) |		\
-				 (1 << QUEUE_FLAG_SAME_COMP))
+				 (1 << QUEUE_FLAG_SAME_COMP) |		\
+				 (1 << QUEUE_FLAG_NOWAIT))
 
 void blk_queue_flag_set(unsigned int flag, struct request_queue *q);
 void blk_queue_flag_clear(unsigned int flag, struct request_queue *q);
@@ -661,6 +663,7 @@ bool blk_queue_flag_test_and_set(unsigned int flag, struct request_queue *q);
 #define blk_queue_pm_only(q)	atomic_read(&(q)->pm_only)
 #define blk_queue_fua(q)	test_bit(QUEUE_FLAG_FUA, &(q)->queue_flags)
 #define blk_queue_registered(q)	test_bit(QUEUE_FLAG_REGISTERED, &(q)->queue_flags)
+#define blk_queue_nowait(q)	test_bit(QUEUE_FLAG_NOWAIT, &(q)->queue_flags)
 
 extern void blk_set_pm_only(struct request_queue *q);
 extern void blk_clear_pm_only(struct request_queue *q);
-- 
2.15.0

