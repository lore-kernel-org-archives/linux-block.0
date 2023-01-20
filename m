Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83869C05027
	for <linux-block@archiver.kernel.org>; Fri, 20 Jan 2023 14:59:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbjATO7j (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 20 Jan 2023 09:59:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjATO7i (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 20 Jan 2023 09:59:38 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F86141B72
        for <linux-block@vger.kernel.org>; Fri, 20 Jan 2023 06:59:38 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id z194so2535227iof.10
        for <linux-block@vger.kernel.org>; Fri, 20 Jan 2023 06:59:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g79y3EmdxzFEd4fz7beAPweEyim/twi3WlhlslEGvHU=;
        b=bL0KF9t7t+Go5SlGfxsYY5fmDeCP4RT9daz3nLfGRlcFxppCR1E8NxNWwqQd+4dvMN
         gT+W7UmpQ1zjKVrdQF1L9lqvZBk3ZucFaR/Lgm2UAmcsz0SiG7cqlx243LJhvO8KL5U8
         BRLOx+6HNHsAqf9xPsMlWyUAdvOKgnehfNuYiH5giJj3QfXSZWNGTA0GOiYrqjg+jQnk
         rQXcLMGb5DokIIWFsPFDExUibTcUCWjqZsLVg2HPg5xHxnuEuxM2fcMOEC9VzcyURrSl
         AdwmYnxJIu4H3/WrXaBAYbOeZo+tlDQNTXw6KY6oZEbSVZyt9H7Jyj/MXQPO4CAdvuOF
         twRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=g79y3EmdxzFEd4fz7beAPweEyim/twi3WlhlslEGvHU=;
        b=ANj+Bn1cCtbOqkiaNOKhOryPJBUG5OPGIJbyPzD8xbPEq5ZFdkTzXWPt4HxM7oFqT0
         obho2hzHSLmf2QHop1uDnR7zFRt/8wGFawNUuhCqUsmCShJ8JJmg/fuxFrcp9/RlFqDZ
         4y1zt7cJ3Uapw4j4a66RGxAgKC89VTAwSKjHWurmn5AbbnE0j+6IzZObBuUQpSmb43/R
         eMWJpqcvmR5MuPqpACp1/CSrr6aeRPoUVeTgTZ7P85Ae5bzBLiBQaolUrKTBu8rgQZWl
         WKcjrK4oaW9rQP6uFeydtYyLBZgAbtVAwqfYq3ej0ugSAw+pPD9hh9zGAwSk2DfAz3ON
         VjYQ==
X-Gm-Message-State: AFqh2kp3rsgZ4ZbWH7MtuC9pfJ4PpHlLgAr+uAyHsoFKUz2Htrm2PhRt
        HCTvsuWvFeTEcd+kPnMh2qG+SexlXOayA7wg
X-Google-Smtp-Source: AMrXdXuIgo2pKZ/KycQSckuY0XJqbqdJMqzT3i+cGe4EytDYyxdTwClKrxNI5jCrUO30pxc57uXq1Q==
X-Received: by 2002:a5d:97c9:0:b0:704:ad00:3844 with SMTP id k9-20020a5d97c9000000b00704ad003844mr2054235ios.1.1674226776985;
        Fri, 20 Jan 2023 06:59:36 -0800 (PST)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id s185-20020a0251c2000000b0038a56594026sm12623603jaa.66.2023.01.20.06.59.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Jan 2023 06:59:36 -0800 (PST)
Message-ID: <9590debc-ce87-f044-b687-59b551c24219@kernel.dk>
Date:   Fri, 20 Jan 2023 07:59:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: en-US
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc:     Keith Busch <kbusch@kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] block: treat poll queue enter similarly to timeouts
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We ran into an issue where a production workload would randomly grind to
a halt and not continue until the pending IO had timed out. This turned
out to be a complicated interaction between queue freezing and polled
IO:

1) You have an application that does polled IO. At any point in time,
   there may be polled IO pending.

2) You have a monitoring application that issues a passthrough command,
   which is marked with side effects such that it needs to freeze the
   queue.

3) Passthrough command is started, which calls blk_freeze_queue_start()
   on the device. At this point the queue is marked frozen, and any
   attempt to enter the queue will fail (for non-blocking) or block.

4) Now the driver calls blk_mq_freeze_queue_wait(), which will return
   when the queue is quiesced and pending IO has completed.

5) The pending IO is polled IO, but any attempt to poll IO through the
   normal iocb_bio_iopoll() -> bio_poll() will fail when it gets to
   bio_queue_enter() as the queue is frozen. Rather than poll and
   complete IO, the polling threads will sit in a tight loop attempting
   to poll, but failing to enter the queue to do so.

The end result is that progress for either application will be stalled
until all pending polled IO has timed out. This causes obvious huge
latency issues for the application doing polled IO, but also long delays
for passthrough command.

Fix this by treating queue enter for polled IO just like we do for
timeouts. This allows quick quiesce of the queue as we still poll and
complete this IO, while still disallowing queueing up new IO.

Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

diff --git a/block/blk-core.c b/block/blk-core.c
index 6fa82291210e..ccf9a7683a3c 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -869,7 +869,16 @@ int bio_poll(struct bio *bio, struct io_comp_batch *iob, unsigned int flags)
 	 */
 	blk_flush_plug(current->plug, false);
 
-	if (bio_queue_enter(bio))
+	/*
+	 * We need to be able to enter a frozen queue, similar to how
+	 * timeouts also need to do that. If that is blocked, then we can
+	 * have pending IO when a queue freeze is started, and then the
+	 * wait for the freeze to finish will wait for polled requests to
+	 * timeout as the poller is preventer from entering the queue and
+	 * completing them. As long as we prevent new IO from being queued,
+	 * that should be all that matters.
+	 */
+	if (!percpu_ref_tryget(&q->q_usage_counter))
 		return 0;
 	if (queue_is_mq(q)) {
 		ret = blk_mq_poll(q, cookie, iob, flags);

-- 
Jens Axboe

