Return-Path: <SRS0=Yhvv=DH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EE18C2D0A8
	for <linux-block@archiver.kernel.org>; Wed, 30 Sep 2020 03:24:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAE1C20791
	for <linux-block@archiver.kernel.org>; Wed, 30 Sep 2020 03:24:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="iJm2dhvt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727206AbgI3DYV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Sep 2020 23:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbgI3DYV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Sep 2020 23:24:21 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14D2EC061755
        for <linux-block@vger.kernel.org>; Tue, 29 Sep 2020 20:24:21 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id x16so227772pgj.3
        for <linux-block@vger.kernel.org>; Tue, 29 Sep 2020 20:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6My0Z+fWlbEWCjwe75rZEWMn1qf7MfXmAiVkbDm86Ao=;
        b=iJm2dhvt5V1TJ8YNZv3BqDSfAm8v3C9qRUyHnODYrFUPyGDM3c+YB8vUc1Ckzo1EJh
         qr9Sub6bUW0h7SO2IuvlwSgBnWwZeq6V+ak47Z/RmNErDBUbxx7u2sk4ecZHUzCuH43M
         RcL8/htsxThtWatfcFFS0+8yqCyyUqr6mhZ40SaTMogAnjyamSJzyHqixCiX0WIZ399P
         0pW5xNPJXg9017EHQAzUH53tKVXvzmuY0aKLen1XAxPmA+ETxhXlEPXTMUBqQLOUkEOj
         a4d71/BqdOMKaoKQHrwkDJtxKjuMrl6KfS7tEaQ5EibWu3yVxh7Pb0pTGfesyG9PRvcR
         U7cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6My0Z+fWlbEWCjwe75rZEWMn1qf7MfXmAiVkbDm86Ao=;
        b=imcs05fFGyvTHBrEm44LGXkhp+7YSkm4BiGGCDmwz1BGt4+n03k7yZ/FAxOc6QltMH
         VtLLN+Yg7ZSK3th2gPAkNdjVeZxQE9Y88bYehgaEAPNu8/yeuWXLj7OMEClI+LY0xDIq
         ADp4fqRZOSXjOtJxOYlBKBLKLQlFcYKFoVonA8fqyVN+nUY/lCUebC1iGJRXQY0NFAVD
         fLiiLCCr/ALRQeLFb2y9Z7Jpm4IKWASJmjmcmTfWmNqRiZzQZcVJsZ3Nl+TwrZtVwdyR
         +DiAWGt6CvYSDIJnctF0XnEeHTN6LhFqroNWTgF8qVQLlXcLRRC0FBIvbUoSZXGIdLuw
         o81Q==
X-Gm-Message-State: AOAM5301bOZyR7fr3Rp1uYY7e5ioiEKArPm2PMsBpA5Ap6t0YVpviiL9
        dYCFmCcLRtURPE2Jh+ddoGlSbw==
X-Google-Smtp-Source: ABdhPJxDr9iPj4HinYZB+pxSlJHHYS/JVW/ShH8imjNF+0TR7HjIqXe5jMWJZpzhwFRfLYQ81tX//Q==
X-Received: by 2002:aa7:9f99:0:b029:13e:d13d:a134 with SMTP id z25-20020aa79f990000b029013ed13da134mr763143pfr.28.1601436260526;
        Tue, 29 Sep 2020 20:24:20 -0700 (PDT)
Received: from box.bytedance.net ([61.120.150.78])
        by smtp.gmail.com with ESMTPSA id w195sm226105pff.74.2020.09.29.20.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 20:24:20 -0700 (PDT)
From:   Hou Pu <houpu@bytedance.com>
To:     josef@toxicpanda.com, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        Hou Pu <houpu@bytedance.com>
Subject: [PATCH v3 2/2] nbd: introduce a client flag to do zero timeout handling
Date:   Wed, 30 Sep 2020 11:23:50 +0800
Message-Id: <20200930032350.3936-3-houpu@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200930032350.3936-1-houpu@bytedance.com>
References: <20200930032350.3936-1-houpu@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Introduce a dedicated client flag NBD_RT_WAIT_ON_TIMEOUT to reset
timer in nbd_xmit_timer instead of depending on tag_set.timeout == 0.
So that the timeout value could be configured by the user to
whatever they like instead of the default 30s. A smaller timeout
value allow us to detect if a new socket is reconfigured in a
shorter time. Thus the io could be requeued more quickly.

In multiple sockets configuration, the user could also disable
dropping the socket in timeout by setting this flag.

The tag_set.timeout == 0 setting still works like before.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Hou Pu <houpu@bytedance.com>
---
 drivers/block/nbd.c      | 27 ++++++++++++++++++++++-----
 include/uapi/linux/nbd.h |  4 ++++
 2 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 538e9dcf5bf2..2d32e31b7b96 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -80,6 +80,7 @@ struct link_dead_args {
 #define NBD_RT_BOUND			5
 #define NBD_RT_DESTROY_ON_DISCONNECT	6
 #define NBD_RT_DISCONNECT_ON_CLOSE	7
+#define NBD_RT_WAIT_ON_TIMEOUT		8
 
 #define NBD_DESTROY_ON_DISCONNECT	0
 #define NBD_DISCONNECT_REQUESTED	1
@@ -378,6 +379,16 @@ static u32 req_to_nbd_cmd_type(struct request *req)
 	}
 }
 
+static inline bool wait_on_timeout(struct nbd_device *nbd,
+				   struct nbd_config *config)
+{
+	if (test_bit(NBD_RT_WAIT_ON_TIMEOUT, &config->runtime_flags) ||
+	    (config->num_connections == 1 && nbd->tag_set.timeout == 0))
+		return true;
+	else
+		return false;
+}
+
 static enum blk_eh_timer_return nbd_xmit_timeout(struct request *req,
 						 bool reserved)
 {
@@ -400,8 +411,7 @@ static enum blk_eh_timer_return nbd_xmit_timeout(struct request *req,
 	    nbd->tag_set.timeout)
 		goto error_out;
 
-	if (config->num_connections > 1 ||
-	    (config->num_connections == 1 && nbd->tag_set.timeout)) {
+	if (!wait_on_timeout(nbd, config)) {
 		dev_err_ratelimited(nbd_to_dev(nbd),
 				    "Connection timed out, retrying (%d/%d alive)\n",
 				    atomic_read(&config->live_connections),
@@ -432,9 +442,7 @@ static enum blk_eh_timer_return nbd_xmit_timeout(struct request *req,
 			nbd_config_put(nbd);
 			return BLK_EH_DONE;
 		}
-	}
-
-	if (!nbd->tag_set.timeout) {
+	} else {
 		/*
 		 * Userspace sets timeout=0 to disable socket disconnection,
 		 * so just warn and reset the timer.
@@ -1956,6 +1964,9 @@ static int nbd_genl_connect(struct sk_buff *skb, struct genl_info *info)
 			set_bit(NBD_RT_DISCONNECT_ON_CLOSE,
 				&config->runtime_flags);
 		}
+		if (flags & NBD_CFLAG_WAIT_ON_TIMEOUT)
+			set_bit(NBD_RT_WAIT_ON_TIMEOUT,
+				&config->runtime_flags);
 	}
 
 	if (info->attrs[NBD_ATTR_SOCKETS]) {
@@ -2139,6 +2150,12 @@ static int nbd_genl_reconfigure(struct sk_buff *skb, struct genl_info *info)
 			clear_bit(NBD_RT_DISCONNECT_ON_CLOSE,
 					&config->runtime_flags);
 		}
+		if (flags & NBD_CFLAG_WAIT_ON_TIMEOUT)
+			set_bit(NBD_RT_WAIT_ON_TIMEOUT,
+				&config->runtime_flags);
+		else
+			clear_bit(NBD_RT_WAIT_ON_TIMEOUT,
+				  &config->runtime_flags);
 	}
 
 	if (info->attrs[NBD_ATTR_SOCKETS]) {
diff --git a/include/uapi/linux/nbd.h b/include/uapi/linux/nbd.h
index 20d6cc91435d..cc3abfb92de5 100644
--- a/include/uapi/linux/nbd.h
+++ b/include/uapi/linux/nbd.h
@@ -56,6 +56,10 @@ enum {
 #define NBD_CFLAG_DISCONNECT_ON_CLOSE (1 << 1) /* disconnect the nbd device on
 						*  close by last opener.
 						*/
+#define NBD_CFLAG_WAIT_ON_TIMEOUT (1 << 2) /* do not fallback to other sockets
+					    * in io timeout, instead just reset
+					    * timer and wait.
+					    */
 
 /* userspace doesn't need the nbd_device structure */
 
-- 
2.11.0

