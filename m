Return-Path: <SRS0=nPog=C6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E373C43463
	for <linux-block@archiver.kernel.org>; Mon, 21 Sep 2020 10:57:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE1AB20874
	for <linux-block@archiver.kernel.org>; Mon, 21 Sep 2020 10:57:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="dvinSlht"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbgIUK5n (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Sep 2020 06:57:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726470AbgIUK5g (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Sep 2020 06:57:36 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E75FC061755
        for <linux-block@vger.kernel.org>; Mon, 21 Sep 2020 03:57:36 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id z18so8944813pfg.0
        for <linux-block@vger.kernel.org>; Mon, 21 Sep 2020 03:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nQ1pzbZrgzJJQpMDYQTBcOdTlRrGz+dy3qDGLfhCAfw=;
        b=dvinSlht/xTwKBw4s0KvbDkqLUHzosRMqfsm+WjozkbupmcThFf8lZ0VthOnskuC58
         5E+9l3m4568A4Gfy8emNp1jXKRZLzkydnMlbQWmfgCxl6FtgIW7kAitgpWTSjjU38nYr
         eOLCpSuf3c8CcQJ4XHfSEFtvfQwRTmQaMrg2SlN0kyALE72BjlfRsw5aEMn+zp9RWOzR
         mZnAjzIBRRhW2rZb0DJAdFgoDFLnilRHrNMoaI3mXBDW8VY7FXmI+1wmXXVaO7INbHgS
         mnXitdoNVh2rjhd9n1RIvb3cThZQ2u+qp0IEzdjiZ2cUT/w+xnZZlP874OQqLlvqv029
         wqqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nQ1pzbZrgzJJQpMDYQTBcOdTlRrGz+dy3qDGLfhCAfw=;
        b=TSpy7G+MIAv7IkrR1UOYigsVLFSDI+PtIWrc7jBM503GpLayKAR1hCfDaeLuTmmXta
         WMBX2Fyx0cfDVKq5Vye247wVAxXnzG89TXszfWWkxvKbdbZUHpKcMV53y6vXEHKrLH4P
         HnQKVWFk9j8xir0Xg8n/L8jjE9/IpJ8VNc2XcTki7SV5rsIi0josZxwGpyb8jJbwmquv
         zmOI5i24Ur4VyWkOwffPLibcG1Oex+IbhYjypRD7Tdkueh80IIBxv12WPNxE5Y7fZ9Oy
         Nnxx3StMuLHlm3nYkNdE2q41JsuqdNSTUmTPz2jI0jYPSDH65ZE/RdB2DlRuWvOrU9aF
         dSYw==
X-Gm-Message-State: AOAM532kr0PyhacnA42cp5Cah4zbF2IVaD/I9XLwpt5JMwwZyDArVYqi
        VWlyvwNoMdMSpXxzAHfU4iLSBA==
X-Google-Smtp-Source: ABdhPJxlvlSQ9dGrlkhKk5ujWZXT/32fv2UlF4rF9hLObyIKyrM5ywK2vvscU2bBidBZYC4NUc5rgg==
X-Received: by 2002:a63:2209:: with SMTP id i9mr31842480pgi.130.1600685856136;
        Mon, 21 Sep 2020 03:57:36 -0700 (PDT)
Received: from box.bytedance.net ([61.120.150.73])
        by smtp.gmail.com with ESMTPSA id x62sm2792533pfx.20.2020.09.21.03.57.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 03:57:35 -0700 (PDT)
From:   Hou Pu <houpu@bytedance.com>
To:     josef@toxicpanda.com, axboe@kernel.dk
Cc:     mchristi@redhat.com, linux-block@vger.kernel.org,
        nbd@other.debian.org, Hou Pu <houpu@bytedance.com>
Subject: [PATCH 1/3] nbd: return -ETIMEDOUT when NBD_DO_IT ioctl returns
Date:   Mon, 21 Sep 2020 18:57:16 +0800
Message-Id: <20200921105718.29006-2-houpu@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200921105718.29006-1-houpu@bytedance.com>
References: <20200921105718.29006-1-houpu@bytedance.com>
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

