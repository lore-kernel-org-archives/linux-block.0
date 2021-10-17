Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03842C433EF
	for <linux-block@archiver.kernel.org>; Sun, 17 Oct 2021 01:35:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4A1E611C1
	for <linux-block@archiver.kernel.org>; Sun, 17 Oct 2021 01:35:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241284AbhJQBht (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 16 Oct 2021 21:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231837AbhJQBht (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 16 Oct 2021 21:37:49 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86D0DC061765
        for <linux-block@vger.kernel.org>; Sat, 16 Oct 2021 18:35:40 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id r134so12171465iod.11
        for <linux-block@vger.kernel.org>; Sat, 16 Oct 2021 18:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=bV//hRpD4HqQoa/SUF9A6qUUTt0qjW3gj+7fefZux3w=;
        b=TwfySlWgmGVFFE00agoZD1JBLije4xo67vN0fZOOxmHDiPVkEw0KbpGgUowiw+KJMj
         XV6FZVhz464UPjR2Aj3/h0ObsxBo9GyPQo+mVvUebsNyR5k4Uql8BuIberKoobBb3bEF
         lEFuvn+SCnGQkUR3T9gmnVj/0mDHvxlpWiAl2uK4ZKpcKYpV16OogvqsfCVHmI1MD1rI
         UB8CPlfASX8mBzgNVg/VYnRaVDPfysOBs0vfS+T7XeuRxiGBvzcCULp7HQYqza+WErnP
         fpwRpOALFJOdDH01Y3kzS8KGM5sDedaxcBGpxTHaT/OVeccTW5sHCWECzUS35sMNf9l4
         QCsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=bV//hRpD4HqQoa/SUF9A6qUUTt0qjW3gj+7fefZux3w=;
        b=heg4xhDAdQhyl+AFvRK4PdBL0C9GnFF8py3wPVst/7NtuqkCzv76Ytfv6t3hTA49KL
         qFUBV8ACI++VmGe2pJC0D8Jxu57ScXBLCZiUtXosJDLQOysFfxdF0T7IqIGiCfGgPW8i
         Awh7ZTF17YPPdPFTwfOKKU0Rz26kqMRMqEN95cSfBu9JAPrGnliQcVzpiqXNJqjn2Skg
         Z/o1KFCxRXiqcDGCEegfeEcFQwoOpu3sLr0LZ/riBbj4l40YNtiGSvOmQUaRIDtkxmSL
         CwRziFCbs2FESvyFFQ94YJHQ8+iWirF3m3fwew4YEIPBhZ3jDX35tzmwoH+0Amf0Eslc
         9SuQ==
X-Gm-Message-State: AOAM533TZ0WVxLugN2q0GDn/tF+OkUtkq5H8vro5Lb7tn3pFQeDVP/lR
        3yBeI9Y1X4Mpg+TO/9Dc7u0TgUnQxuOKPg==
X-Google-Smtp-Source: ABdhPJyfZkC0qiOF5iuBlOG+3QJY9dUPl8mz391pV5T+5K8Vy4Wu+b6iqhfRZ7NEel98JL61ryOqew==
X-Received: by 2002:a05:6602:1514:: with SMTP id g20mr9584985iow.9.1634434539795;
        Sat, 16 Oct 2021 18:35:39 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id i125sm4674929iof.7.2021.10.16.18.35.39
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Oct 2021 18:35:39 -0700 (PDT)
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] block: don't dereference request after flush insertion
Message-ID: <f2f17f46-ff3a-01c4-bfd4-8dec836ec343@kernel.dk>
Date:   Sat, 16 Oct 2021 19:35:39 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We could have a race here, where the request gets freed before we call
into blk_mq_run_hw_queue(). If this happens, we cannot rely on the state
of the request.

Grab the hardware context before inserting the flush.

Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 2197cfbf081f..22b30a89bf3a 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2468,9 +2468,10 @@ void blk_mq_submit_bio(struct bio *bio)
 	}
 
 	if (unlikely(is_flush_fua)) {
+		struct blk_mq_hw_ctx *hctx = rq->mq_hctx;
 		/* Bypass scheduler for flush requests */
 		blk_insert_flush(rq);
-		blk_mq_run_hw_queue(rq->mq_hctx, true);
+		blk_mq_run_hw_queue(hctx, true);
 	} else if (plug && (q->nr_hw_queues == 1 ||
 		   blk_mq_is_shared_tags(rq->mq_hctx->flags) ||
 		   q->mq_ops->commit_rqs || !blk_queue_nonrot(q))) {
-- 
Jens Axboe

