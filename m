Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1A41EB8FD3
	for <linux-block@archiver.kernel.org>; Wed,  6 Sep 2023 13:31:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239837AbjIFNbR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Sep 2023 09:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237261AbjIFNbQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Sep 2023 09:31:16 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2974E10D7
        for <linux-block@vger.kernel.org>; Wed,  6 Sep 2023 06:31:12 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-52bcd4db4e6so5296008a12.0
        for <linux-block@vger.kernel.org>; Wed, 06 Sep 2023 06:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20230601.gappssmtp.com; s=20230601; t=1694007070; x=1694611870; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZQEKqe3bDH27s4AsrbKUQCFmR3pSzTgTwp308wc1fxo=;
        b=TpPAb2WZoync7bkj+W8asv1tvuYlocWNvHOO95MypyoyFX/1mUOkh0uG3vk/R1CFkr
         bHWwfMnZGmpusMuV5QoG9cTWT5Awu9AQxrPUsmeGLrszO6/fmvco7+EMY53zli95p2kp
         +3BKaOC1ywWm5+NqAAkeIYkiTfrAVzpwLwylfFDN2XxY6i5sfTAekA/Ha8qWXeNKAD6j
         W/ocAfgR8RDcShVCi59SIyhWL9PYsjiIMNjtScOVeVyS8vYsIwmlwb+j5cCNnPBEjfwn
         NmQ3twANGAUPa69tPs87TSMu9E2dNd4VK2GkuXwvvGSViSt7+N7YB/Oa7HnoHih9cxC5
         rtcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694007070; x=1694611870;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZQEKqe3bDH27s4AsrbKUQCFmR3pSzTgTwp308wc1fxo=;
        b=kJNN/kBSNJRoZ1owhzpMQXqUHyxE92WLS50/viUn/D7X/+2+0PV36cYB2htsgUzZLA
         lqJO8F2jAO348RDujGMP3K0XBOYEEN2Vqs3N5w4yUm6YRonmz+m4Nwj6ffry6y4EtcAo
         NLByigjPjJS7NyhKFHBOhYu/5DT/279PSx8F3SiNuBkL6QOLEPzk9PL2RvXJZ+kqO1CT
         OX2OR/V2dB0e36rrLjKzEtjVjil1x3QGjn/QBs0NndtVEjZPI/jygUcDeHQJxp44sarN
         BVq5+5zhcdrs0eCS7nHocvxh+tkJDHS4uDtdIfqWUrBXJ4PkuLQRObyJL8X2i+E7k3lc
         5XzA==
X-Gm-Message-State: AOJu0YxAc/SFxqC4JK1JFZLazR/uQy/UZ9JA5Jt62O6IhDpmpYqO1Xs4
        rilVzRiu2AhOQpbkDYi9b1V40eVRg8B7xuSHzaMMA+JS
X-Google-Smtp-Source: AGHT+IHxQ1RmQuQHmgQQmnWbUnYbPKmInDa2Y2sq1quXXuZPSayEmNlnZxowArje3NTqDDs5B/wckw==
X-Received: by 2002:a17:906:1044:b0:99b:c86b:1d25 with SMTP id j4-20020a170906104400b0099bc86b1d25mr2395858ejj.26.1694007070656;
        Wed, 06 Sep 2023 06:31:10 -0700 (PDT)
Received: from localhost.localdomain (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id gh4-20020a170906e08400b009875a6d28b0sm8983369ejb.51.2023.09.06.06.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 06:31:10 -0700 (PDT)
From:   =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        linux-block@vger.kernel.org,
        Linux regression tracking <regressions@leemhuis.info>,
        Serguei Ivantsov <manowar@gsc-game.com>,
        David Howells <dhowells@redhat.com>,
        =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>, stable@vger.kernel.org
Subject: [PATCH] drbd: swap bvec_set_page len and offset
Date:   Wed,  6 Sep 2023 15:30:34 +0200
Message-ID: <20230906133034.948817-1-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

bvec_set_page has the following signature:

static inline void bvec_set_page(struct bio_vec *bv, struct page *page,
		unsigned int len, unsigned int offset)

However, the usage in DRBD swaps the len and offset parameters. This
leads to a bvec with length=0 instead of the intended length=4096, which
causes sock_sendmsg to return -EIO.

This leaves DRBD unable to transmit any pages and thus completely
broken.

Swapping the parameters fixes the regression.

Fixes: eeac7405c735 ("drbd: Use sendmsg(MSG_SPLICE_PAGES) rather than sendpage()")
Reported-by: Serguei Ivantsov <manowar@gsc-game.com>
Link: https://lore.kernel.org/regressions/CAKH+VT3YLmAn0Y8=q37UTDShqxDLsqPcQ4hBMzY7HPn7zNx+RQ@mail.gmail.com/
Cc: stable@vger.kernel.org
Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
 drivers/block/drbd/drbd_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 79ab532aabaf..6bc86106c7b2 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -1557,7 +1557,7 @@ static int _drbd_send_page(struct drbd_peer_device *peer_device, struct page *pa
 	do {
 		int sent;
 
-		bvec_set_page(&bvec, page, offset, len);
+		bvec_set_page(&bvec, page, len, offset);
 		iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, &bvec, 1, len);
 
 		sent = sock_sendmsg(socket, &msg);
-- 
2.41.0

