Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2527AC433FE
	for <linux-block@archiver.kernel.org>; Fri, 26 Nov 2021 08:38:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353015AbhKZIlO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 26 Nov 2021 03:41:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345642AbhKZIjO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 Nov 2021 03:39:14 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CDD5C06175E;
        Fri, 26 Nov 2021 00:27:55 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id p3-20020a05600c1d8300b003334fab53afso10112621wms.3;
        Fri, 26 Nov 2021 00:27:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TFFGSEi0aI46OZC49VEkfyouqRBb+2dZlC1EqSh5l0w=;
        b=Nh5wmHOIL6KT0awION/rlVICDnM945CPGZhOk/BzTwRYEj4atLUITAJgClakdPr4RE
         K3AAsZIXpBTlHAa3Yg3svXMLM8C2FmnQ3v1fVihx+sThfV9YSw/EQMlR+4N0ePOqAxHa
         BNiB+3iVHoO0oqd4vO7D8slMqmQb37YQQc0OJBiQSzlUDlg8me4AyH0UfAX5h675bfsM
         h9x/7TRzLxqSGZqf7bNdPCwmzBziS0ZOifNwYB2fJVWza6b2QwNHCSdgrewPPbXlSAyC
         Esp8AI6uRG/b1cqRxIS4aN0t1IQ9+ld124R3/aScA0PDyFBhIQoGpki6UMf2iEb17BM9
         UO8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TFFGSEi0aI46OZC49VEkfyouqRBb+2dZlC1EqSh5l0w=;
        b=TrAPVC96dMnftrhCQBt1puRFW5aaRV7Hn+aopfNI5XqghZFI1CN+2d9pNteVGWpJDT
         Mwv69iVU+hUPR3dIvC/mgS2vOwGp+w7AQ6Y4AEHFZeeuH67bGBAZexBhWRWoBWqu9XAq
         8ijN7tzgD8QgzzHEFmvXeNo4/uoZhMcs91BAQw71DKY1KC1PBfq0W4AoAkB8HP5deS44
         WKFBMoFikSD6pTbbrnqEUgufoRENaC4XxJheTC1ZO3SLY+HSjBbQrLGdm2FtKGqZPBGR
         W1DOwfnhjOqcfG1JefHj0V6+/ILaUCvOYEjbP1u1GyomEAq2SFSW9gkpiQsNufX0xroO
         94hQ==
X-Gm-Message-State: AOAM531/+xevvTy56uvtS7xKP6CzhOOjfNcppUPY/XK1EGTM2tRCwW9T
        gAJaA3tCEy6PXA==
X-Google-Smtp-Source: ABdhPJwf9rEkNqkL7bedTojk6VL+ew28c0wDt0PHxk014EfqPcavRhooRvdQKLbZJvi6kEimK1zSDA==
X-Received: by 2002:a1c:1c1:: with SMTP id 184mr14032412wmb.1.1637915273615;
        Fri, 26 Nov 2021 00:27:53 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id m17sm4744209wrz.22.2021.11.26.00.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Nov 2021 00:27:53 -0800 (PST)
From:   Colin Ian King <colin.i.king@googlemail.com>
X-Google-Original-From: Colin Ian King <colin.i.king@gmail.com>
To:     Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] bfq: Fix spelling mistake "tenative" -> "tentative"
Date:   Fri, 26 Nov 2021 08:27:52 +0000
Message-Id: <20211126082752.554055-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

There is a spelling mistake in a bfq_log_bfqq message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 block/bfq-iosched.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 85554b800970..db9eaec999b7 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -2158,7 +2158,7 @@ static void bfq_check_waker(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 		bfqq->waker_detection_started = now_ns;
 		bfq_bfqq_name(bfqq->tentative_waker_bfqq, waker_name,
 			      MAX_BFQQ_NAME_LENGTH);
-		bfq_log_bfqq(bfqd, bfqq, "set tenative waker %s", waker_name);
+		bfq_log_bfqq(bfqd, bfqq, "set tentative waker %s", waker_name);
 	} else /* Same tentative waker queue detected again */
 		bfqq->num_waker_detections++;
 
-- 
2.33.1

