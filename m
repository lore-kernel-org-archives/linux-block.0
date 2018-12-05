Return-Path: <SRS0=VELz=OO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F130C04EB9
	for <linux-block@archiver.kernel.org>; Wed,  5 Dec 2018 20:24:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C4D020989
	for <linux-block@archiver.kernel.org>; Wed,  5 Dec 2018 20:24:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MKxW1lAM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C4D020989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728331AbeLEUYk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Dec 2018 15:24:40 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:40118 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727388AbeLEUYk (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Dec 2018 15:24:40 -0500
Received: by mail-qt1-f196.google.com with SMTP id k12so23824745qtf.7
        for <linux-block@vger.kernel.org>; Wed, 05 Dec 2018 12:24:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=icB+G85GZTRRdeXIVpg1MXe93D03U8a/VLdB+3cEmQw=;
        b=MKxW1lAM9NIpVnC9mpzbiT/XgEhB10AJ8M22AalW6ejgsSQPy645Q88JaO23kECVvs
         odXaeFxWLaTj92MuCOnUiqbQzHT123EmzWl6vd7DqgYpDE7R4UzVygNRWp/lqIOZsLUz
         bJPxFdYLPHu7qYkIr81N2ZS9td+otsSQfAtMrRtE6yEtYkWUPEnpmisNubV7kPH38TrH
         s+I1G5EVAMCaQtqpMgbBjDtLWhvGYu+0gnYL8KZSyn7xjtuLaPL8SryWsdOc4XRVuDqV
         QTNeNllowSdEt8jw2qbOSxDJ8vdxEJCAvBN7+M1tGzdJ4me5WmdbgSrVZn8ZKdrc1qDB
         G+mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=icB+G85GZTRRdeXIVpg1MXe93D03U8a/VLdB+3cEmQw=;
        b=tTmkWYQxEH2mHxFMzKb78QiKFn/mtP1TxRsFuFB5mdPKAX9eYkKjaIP4kCbGscOCYX
         Z9Ua09PnRnyc5tQCHXfEFB8/3tWDpfyOd+myicz81SRl/BsGYiz7xk9wMoSAD/rKIv7P
         H1QHpHrTWQmazcQ54TRlkp4/f0uTNwSsm1UCbLma38eo6mq0dUEeNZiTN0ojR5KCuuGG
         DgqDZj4TOSEIvGezcSStlGaHR6DIilrY2gh5KFdCNCHtfFMP/aBpKUQHERYUReJ1+Kh1
         F1nxj//UjUWol7tdOpFyEKk4zkjwXszlsrLkXQCYPPh1Qs0BNirODPGv3yHD7+r+j7rf
         S4xA==
X-Gm-Message-State: AA+aEWaIS2zx1yRkHm0kn5I9WqabtucdjFwNKNtFXlQHV4iaI4nciYGg
        T57ZhJJSyCqVJDZcPsAKW70=
X-Google-Smtp-Source: AFSGD/XSqS3NBGMeF90Gj8HHohgV61AoBK6P5YGtrjoR7bTr6Yd5NwoJRCc8rI3xie6T5TptgB2hBg==
X-Received: by 2002:a0c:c16b:: with SMTP id i40mr25240037qvh.28.1544041479128;
        Wed, 05 Dec 2018 12:24:39 -0800 (PST)
Received: from localhost (pool-68-160-144-192.bstnma.fios.verizon.net. [68.160.144.192])
        by smtp.gmail.com with ESMTPSA id c12sm15512621qka.42.2018.12.05.12.24.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 12:24:38 -0800 (PST)
From:   Mike Snitzer <snitzer@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, dm-devel@redhat.com,
        Mikulas Patocka <mpatocka@redhat.com>
Subject: [PATCH v3 2/7] dm rq: leverage blk_mq_queue_busy() to check for outstanding IO
Date:   Wed,  5 Dec 2018 15:24:28 -0500
Message-Id: <20181205202433.95823-3-snitzer@redhat.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20181205202433.95823-1-snitzer@redhat.com>
References: <20181205202433.95823-1-snitzer@redhat.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Now that request-based dm-multipath only supports blk-mq, make use of
the newly introduced blk_mq_queue_busy() to check for outstanding IO --
rather than (ab)using the block core's in_flight counters.

Signed-off-by: Mike Snitzer <snitzer@redhat.com>
---
 drivers/md/dm-rq.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/md/dm-rq.c b/drivers/md/dm-rq.c
index 1f1fe9a618ea..d2397d8fcbd1 100644
--- a/drivers/md/dm-rq.c
+++ b/drivers/md/dm-rq.c
@@ -130,11 +130,11 @@ static void rq_end_stats(struct mapped_device *md, struct request *orig)
  */
 static void rq_completed(struct mapped_device *md, int rw, bool run_queue)
 {
-	atomic_dec(&md->pending[rw]);
-
 	/* nudge anyone waiting on suspend queue */
-	if (!md_in_flight(md))
-		wake_up(&md->wait);
+	if (unlikely(waitqueue_active(&md->wait))) {
+		if (!blk_mq_queue_busy(md->queue))
+			wake_up(&md->wait);
+	}
 
 	/*
 	 * dm_put() must be at the end of this function. See the comment above
@@ -436,7 +436,6 @@ ssize_t dm_attr_rq_based_seq_io_merge_deadline_store(struct mapped_device *md,
 static void dm_start_request(struct mapped_device *md, struct request *orig)
 {
 	blk_mq_start_request(orig);
-	atomic_inc(&md->pending[rq_data_dir(orig)]);
 
 	if (unlikely(dm_stats_used(&md->stats))) {
 		struct dm_rq_target_io *tio = tio_from_request(orig);
-- 
2.18.0

