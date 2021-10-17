Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0397EC433FE
	for <linux-block@archiver.kernel.org>; Sun, 17 Oct 2021 01:38:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7BE860F6F
	for <linux-block@archiver.kernel.org>; Sun, 17 Oct 2021 01:38:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244797AbhJQBkJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 16 Oct 2021 21:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244805AbhJQBkI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 16 Oct 2021 21:40:08 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AD84C061769
        for <linux-block@vger.kernel.org>; Sat, 16 Oct 2021 18:37:58 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id h196so12231578iof.2
        for <linux-block@vger.kernel.org>; Sat, 16 Oct 2021 18:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yQAe4HYfRH7pUFfAqcx+7kBeOw5mlgfuJcq+bQmlNjE=;
        b=kNOKxVG3y2w+wD1ABwgiTuJbI5+NWGZrG/ZLoG0+lwqR3yILP1XnxqYmpvgCfoS1O3
         uHK9nbIofmerJoqqh7j/CUo0r4I/IWZ4OBv93b2pC8MsqfA3Qn+eoykRrvYC69MsUn9j
         I8qZibvBSRL1aDeCPTL/NUVW6l0tKCaCyOKu94pn2Hhp6hkf/df2McNvCYaxU0G2h1Sl
         ybY74YCjIrlWLg9v0UdTIuv8MjRde29lQe+nvhDw4N0nRXS8hDla8LOafTzF6809rVvJ
         DQRuh7IqFVfZlEqaGiBAIxF8eK9Zb01AvQwr1LbZznKOcpnDUuZwOBSc39myo0FJJa5G
         OhcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yQAe4HYfRH7pUFfAqcx+7kBeOw5mlgfuJcq+bQmlNjE=;
        b=LmhYIy5oRkbuu28rZrauelvhbq4YecpuXENwyfUiBKomNFVT8PIw++nXcqzSyRTVt/
         1wc2FrlEX4hUUSju8LOWJyLK+9XzNiM8wFk96kl9WhZ7KsWtixvh6+E1c97iqCR08mmV
         gpxBpVAYgbKigFE4a5Q4Q7AOSdToDSSZSRe6nZ8sO+zEpUaeNGIzRJNXI++yCaRcuoiU
         ZyZRYzYVGKpo4BZWSHGp2nz6K0PYcj30gKCUEuJV4JIhvbMNtKtI42+6LZ6ktI3t1Tpy
         itaub5rIEDL6ouNdh9R36zFcNUP8x5yXV7j65+3aDj0iMZDSEOPSNPhEU9onZ83WKe6a
         BePw==
X-Gm-Message-State: AOAM532AvCbAodBHNooJ6cVLou537RT3jxEw33kri8lKAvCZXGck74Yb
        O01gPHw/zQ1UCimaIQSMsxuB0uTK1511Yw==
X-Google-Smtp-Source: ABdhPJxGM4nBzyEIdkVZ3U6DKaiZjchOAOZ6H4v8Ru4ZpVblPJr9vU3hfKdYOEgdPl2/QboFW6NuTw==
X-Received: by 2002:a05:6638:220c:: with SMTP id l12mr14031723jas.149.1634434677954;
        Sat, 16 Oct 2021 18:37:57 -0700 (PDT)
Received: from localhost.localdomain ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id j17sm4934383ilq.1.2021.10.16.18.37.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Oct 2021 18:37:57 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 09/14] block: only mark bio as tracked if it really is tracked
Date:   Sat, 16 Oct 2021 19:37:43 -0600
Message-Id: <20211017013748.76461-10-axboe@kernel.dk>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211017013748.76461-1-axboe@kernel.dk>
References: <20211017013748.76461-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We set BIO_TRACKED unconditionally when rq_qos_throttle() is called, even
though we may not even have an rq_qos handler. Only mark it as TRACKED if
it really is potentially tracked.

This saves considerable time for the case where the bio isn't tracked:

     2.64%     -1.65%  [kernel.vmlinux]  [k] bio_endio

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-rq-qos.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/block/blk-rq-qos.h b/block/blk-rq-qos.h
index f000f83e0621..3cfbc8668cba 100644
--- a/block/blk-rq-qos.h
+++ b/block/blk-rq-qos.h
@@ -189,9 +189,10 @@ static inline void rq_qos_throttle(struct request_queue *q, struct bio *bio)
 	 * BIO_TRACKED lets controllers know that a bio went through the
 	 * normal rq_qos path.
 	 */
-	bio_set_flag(bio, BIO_TRACKED);
-	if (q->rq_qos)
+	if (q->rq_qos) {
+		bio_set_flag(bio, BIO_TRACKED);
 		__rq_qos_throttle(q->rq_qos, bio);
+	}
 }
 
 static inline void rq_qos_track(struct request_queue *q, struct request *rq,
-- 
2.33.1

