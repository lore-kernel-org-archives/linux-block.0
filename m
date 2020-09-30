Return-Path: <SRS0=Yhvv=DH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25A85C2D0A8
	for <linux-block@archiver.kernel.org>; Wed, 30 Sep 2020 03:24:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEC64207C3
	for <linux-block@archiver.kernel.org>; Wed, 30 Sep 2020 03:24:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="bMreQqfc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729888AbgI3DYQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Sep 2020 23:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbgI3DYP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Sep 2020 23:24:15 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C70E1C061755
        for <linux-block@vger.kernel.org>; Tue, 29 Sep 2020 20:24:15 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id d6so185954pfn.9
        for <linux-block@vger.kernel.org>; Tue, 29 Sep 2020 20:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9wLhhzcNS0P7UTjgkUlOAA40Hjt+i5A3fNAKc5EV9IU=;
        b=bMreQqfcbkAaFUufvshrQLLdhWLR8aHn8fvuFYB7ItTx9MFBCrHnqETUQscEeDZguQ
         VuKESavl8M+a6gJYh8tta2nekBBvaBKjyEPOh+3emBsSDbZrql3HxhvqvC5dj7egPnJ4
         IjlE0Ijj7EEPJwTeZ2ZN6Q2MU9z5mk5P3fITEb9tuQ1BrFK4VvP4Plu2veA6iAloOspC
         /B/xlFo4ems6RjgmXF989iyaFbNxB6fIdsIRe2JUew8KSAodmCKXH+L0aCPZJU9Tuu1w
         oWx9qmOKJZB+caqOiOItnuZWzcMt7vOS3hPorX93YScwzw1vwdydvoJ9FIfB/UVRJUe5
         doxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9wLhhzcNS0P7UTjgkUlOAA40Hjt+i5A3fNAKc5EV9IU=;
        b=SwM8N4xhuaSZ0zbEKS/jpIkF2LwpZ7nR+NAEWxY0ECF3JNRGd6PakHPMDYLh5u8kkM
         /gRH2lcRaN8DEm3BXM6zDNx8b3UJQpiNCmzIbesK6kmqetG13bqlvEeYltV4mMCyGRzx
         vnR7IqGpbjOn5woi671zR0MYuudqFkg5b1SnwhSyJfLuoJWXmDf65UJLytAbu6FKkJ1S
         omcMl75uWFEZSga5kXrREe1obdemlIP4lN/l9XoSi6vODIwDh4aPvGs5unMBHqW9Y0EN
         p8Jfsx/iJuDDP6hOctNYdty3isivuBrF7WW7IaimCTBwKRh0NJBSrOxcmOY7Dyp5nNRi
         DwLw==
X-Gm-Message-State: AOAM532ts1ciC09kE95UjU2LwlKp05hD9o0X6CEMtbvaFipSAX3qAPsA
        //jXYn1LB6O9+2df+d1Azxxalw==
X-Google-Smtp-Source: ABdhPJx71yNZKQA9Fyjo7oc8K5qPHFlVHthykn+5x0JlCt42+167tBVty2nNOdZR3pJW9FCXTKRBXg==
X-Received: by 2002:a65:4c8e:: with SMTP id m14mr539963pgt.129.1601436255395;
        Tue, 29 Sep 2020 20:24:15 -0700 (PDT)
Received: from box.bytedance.net ([61.120.150.78])
        by smtp.gmail.com with ESMTPSA id w195sm226105pff.74.2020.09.29.20.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 20:24:14 -0700 (PDT)
From:   Hou Pu <houpu@bytedance.com>
To:     josef@toxicpanda.com, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        Hou Pu <houpu@bytedance.com>
Subject: [PATCH v3 1/2] nbd: return -ETIMEDOUT when NBD_DO_IT ioctl returns
Date:   Wed, 30 Sep 2020 11:23:49 +0800
Message-Id: <20200930032350.3936-2-houpu@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200930032350.3936-1-houpu@bytedance.com>
References: <20200930032350.3936-1-houpu@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We used to return -ETIMEDOUT if io timeout happened. But since
commit d970958b2d24 ("nbd: enable replace socket if only one
connection is configured"), user space would not get -ETIMEDOUT.
This commit fixes this. Only return -ETIMEDOUT if only one socket
is configured by ioctl and the user specified a non-zero timeout
value.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Hou Pu <houpu@bytedance.com>
---
 drivers/block/nbd.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index ce7e9f223b20..538e9dcf5bf2 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -395,6 +395,11 @@ static enum blk_eh_timer_return nbd_xmit_timeout(struct request *req,
 	}
 	config = nbd->config;
 
+	if (!test_bit(NBD_RT_BOUND, &config->runtime_flags) &&
+	    config->num_connections == 1 &&
+	    nbd->tag_set.timeout)
+		goto error_out;
+
 	if (config->num_connections > 1 ||
 	    (config->num_connections == 1 && nbd->tag_set.timeout)) {
 		dev_err_ratelimited(nbd_to_dev(nbd),
@@ -455,6 +460,7 @@ static enum blk_eh_timer_return nbd_xmit_timeout(struct request *req,
 		return BLK_EH_RESET_TIMER;
 	}
 
+error_out:
 	dev_err_ratelimited(nbd_to_dev(nbd), "Connection timed out\n");
 	set_bit(NBD_RT_TIMEDOUT, &config->runtime_flags);
 	cmd->status = BLK_STS_IOERR;
-- 
2.11.0

