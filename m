Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59753C433EF
	for <linux-block@archiver.kernel.org>; Tue, 15 Mar 2022 22:15:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346172AbiCOWQ4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Mar 2022 18:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345510AbiCOWQ4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Mar 2022 18:16:56 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F6215574F;
        Tue, 15 Mar 2022 15:15:42 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id r7so266767wmq.2;
        Tue, 15 Mar 2022 15:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LvmJVqdwrlWMkUS3ETMsrhpklEVgEBwydXDxUXvsw4Y=;
        b=kwXAy1bc0B18qwisUML/KSrBSAAR5AmmqDoFZt+icCfloKqtfsMrMaJZpa2gxSjAX5
         fbvbo4sEJc7XQoPxPGUkctEBGmtvmt3lfFTeAMyPJZZBfPAh+VOTyvr8eqRPD1TkzPoP
         NqNan8F9VcUHqDtLV5sGv6Sy42XGqQARPqNt3jF5ZagvK+GrbEtVCQ4MU+NLRe11jV+l
         em8nzdQarzjQ7hjybrExEGDVPZsxc9VfBB4xcyo1AOGYE9Av+4K2UDLq2XlzhEZsqcJN
         QvDeHq+3LqAZhnyw1mLEFU5yRpJonxncHSH2IzloUCMQpxuacqNBLM2F2gXUt2QvkMYk
         +pdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LvmJVqdwrlWMkUS3ETMsrhpklEVgEBwydXDxUXvsw4Y=;
        b=ER2Z2qWGYWz2Ve92bI0c2r7411wa7T5LCrbzfkoGltc+RBWyaHCTaAI1/8U3cW19zk
         h/JYuPyb2Ksm2ePyTRAI1tcpHnNVGew8AeuvTuEcV6Mn+KhaB+OOb2k0nG1OUDi8Iisq
         nIRew3Zk82DBv9gd5R0NT3WLssHb1/pSQgmCBeb3god/dsuWGCnkRGuTnf6o1En9CtLZ
         J08zdBBam6WVNQHn4k/Ymmkg8AqAFzfjuMqs+e0QI2lu6SPqVWcZFbOZHJSrSlEop/Kf
         YwxQMPqpvI6MJz1EAMEF7MkTc1NdlwbtE3OgWAi2GpsOE+AVuo6V03/ZLFoC9GMIt4z+
         +EJg==
X-Gm-Message-State: AOAM531qP/VWas9qDmZGUuOi/AXTHlDQ433EELS0xBadPRH7ofFAFEU/
        ElCABQPqJz13hnfjrLmRPkakp4lTDZ0tJA==
X-Google-Smtp-Source: ABdhPJytypUFMlvsSHibSN8JM1X8fOVUmKnATp66W/nZO8/7ST1zZRg+cR0zT/YNrBTbOXU+eYNy/g==
X-Received: by 2002:a1c:7c04:0:b0:388:6cd5:b45b with SMTP id x4-20020a1c7c04000000b003886cd5b45bmr5100136wmc.8.1647382541056;
        Tue, 15 Mar 2022 15:15:41 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id r13-20020a5d498d000000b001f0587248c4sm166448wrq.3.2022.03.15.15.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Mar 2022 15:15:40 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Paolo Valente <paolo.valente@linaro.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] block/bfq-iosched: Fix spelling mistake "tenative" -> "tentative"
Date:   Tue, 15 Mar 2022 22:15:39 +0000
Message-Id: <20220315221539.2959167-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.35.1
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
index 064f6b4c1c16..2e0dd68a3cbe 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -2153,7 +2153,7 @@ static void bfq_check_waker(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 		bfqq->waker_detection_started = now_ns;
 		bfq_bfqq_name(bfqq->tentative_waker_bfqq, waker_name,
 			      MAX_BFQQ_NAME_LENGTH);
-		bfq_log_bfqq(bfqd, bfqq, "set tenative waker %s", waker_name);
+		bfq_log_bfqq(bfqd, bfqq, "set tentative waker %s", waker_name);
 	} else /* Same tentative waker queue detected again */
 		bfqq->num_waker_detections++;
 
-- 
2.35.1

