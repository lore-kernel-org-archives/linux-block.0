Return-Path: <SRS0=CCtz=CH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78531C433E7
	for <linux-block@archiver.kernel.org>; Sat, 29 Aug 2020 16:51:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59FC920791
	for <linux-block@archiver.kernel.org>; Sat, 29 Aug 2020 16:51:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="BGwJjWcb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728442AbgH2QvU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 29 Aug 2020 12:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbgH2QvO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 29 Aug 2020 12:51:14 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A027C061236
        for <linux-block@vger.kernel.org>; Sat, 29 Aug 2020 09:51:13 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id g6so947665pjl.0
        for <linux-block@vger.kernel.org>; Sat, 29 Aug 2020 09:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=ofhsCOuyJ/vtOSE492SKG55p+pRmR8fZAjetaJSmn18=;
        b=BGwJjWcbX1U9Fsb75ECfohoQToRniUHzGVs5YPOsMeG3h0jicw6Yk11HxVCB09S1qz
         /nCR+bLPM8eMttsKtSJeE3DRWTxeoFbcaI+fGtNilj9tcaT0YLuaUo/HPk3OpC75VwSj
         /dOoQoh92773JVZ/8XsDHYj8FWbSh/OY7p3CsZwHVHVgHFmiJX/3LGUgMQRaJN2MYaiU
         yDc6JKOSuWihr/qMTGVWlA0OTFQLeN8T93XVroq+nxQgonF51aHii4jR72CIeWrMedML
         nNlwA7j0NeTs4mDyV3hlHSz1Mxqx/TnSuKzb5ycUVzJWfhYu6Ekrd6KWvfpH+OZ0kePd
         0ynQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=ofhsCOuyJ/vtOSE492SKG55p+pRmR8fZAjetaJSmn18=;
        b=NjXfcqHmGti+Qju7ZnLPZg68vbNyBTTPkCR36KoSHXEVBqtFZgj8TY9DJwBAvsdMgV
         eZFu1K1qTm4NymuEmdbiGsj9ziXbkjhZvzpLX6BjPu3fVluU7EmE2rC/liWTILr6iLQH
         cLeEmTtjNBNEEUmYyIviL1oZPN7yeB+64Ozl7pgDBbpAvsl1+dekNCe37TMzPaMCFY4k
         ejCR6PmexTk0ICBM2yL+rk+a3R/7453/OazyWPiqi/3rC6oUpueTt54bXcKWh4L7xdEp
         erq3JFD8f8HfXFtCf4agd6qolmVLycMJmvNrRezcKwRvdcjeqvZvKLApLyUq2Uuvb5Vc
         CYuA==
X-Gm-Message-State: AOAM532wKTuqCbAz0juwTLxNahdVdWpbwt4YB/D1izIrDmY7X3a1uYc8
        BeGzZEpxN218oFjwGRuFz8EuxRylSCwmK1/4
X-Google-Smtp-Source: ABdhPJwwL6qV5mPMB4yBJcSjs1Kkeb4l3vQbZtO+vOv20DZGMOLKwh4PbQln8Zwvnf9rJhIZbS0ffA==
X-Received: by 2002:a17:902:ee93:: with SMTP id a19mr3176572pld.172.1598719872754;
        Sat, 29 Aug 2020 09:51:12 -0700 (PDT)
Received: from [192.168.1.182] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id n22sm2524228pjq.25.2020.08.29.09.51.11
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Aug 2020 09:51:12 -0700 (PDT)
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] block: fix -EAGAIN IOPOLL task/vm accounting
Message-ID: <d27ff6f0-9347-e880-fa9d-514e993014dc@kernel.dk>
Date:   Sat, 29 Aug 2020 10:51:11 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We currently increment the task/vm counts when we first attempt to queue a
bio. But this isn't necessarily correct - if the request allocation fails
with -EAGAIN, for example, and the caller retries, then we'll over-account
by as many retries as are done.

This can happen for polled IO, where we cannot wait for requests. Hence
retries can get aggressive, if we're running out of requests. If this
happens, then watching the IO rates in vmstat are incorrect as they count
every issue attempt as successful and hence the stats are inflated by
quite a lot potentially.

Add a bio flag to know if we've done accounting or not. This prevents
the same bio from being accounted potentially many times, when retried.

Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

diff --git a/block/blk-core.c b/block/blk-core.c
index d9d632639bd1..ff562a8cd9c9 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1236,7 +1236,7 @@ blk_qc_t submit_bio(struct bio *bio)
 	 * If it's a regular read/write or a barrier with data attached,
 	 * go through the normal accounting stuff before submission.
 	 */
-	if (bio_has_data(bio)) {
+	if (bio_has_data(bio) && !bio_flagged(bio, BIO_ACCOUNTED)) {
 		unsigned int count;
 
 		if (unlikely(bio_op(bio) == REQ_OP_WRITE_SAME))
@@ -1259,6 +1259,7 @@ blk_qc_t submit_bio(struct bio *bio)
 				(unsigned long long)bio->bi_iter.bi_sector,
 				bio_devname(bio, b), count);
 		}
+		bio_set_flag(bio, BIO_ACCOUNTED);
 	}
 
 	/*
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 63a39e47fc60..39bcc9326c7a 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -266,6 +266,7 @@ enum {
 				 * of this bio. */
 	BIO_CGROUP_ACCT,	/* has been accounted to a cgroup */
 	BIO_TRACKED,		/* set if bio goes through the rq_qos path */
+	BIO_ACCOUNTED,		/* task/vm stats have been done */
 	BIO_FLAG_LAST
 };
 
-- 
Jens Axboe

