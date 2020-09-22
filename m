Return-Path: <SRS0=ZsbB=C7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE70CC4363D
	for <linux-block@archiver.kernel.org>; Tue, 22 Sep 2020 03:35:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C74F23A32
	for <linux-block@archiver.kernel.org>; Tue, 22 Sep 2020 03:35:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="QyobmZ6y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728780AbgIVDfR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Sep 2020 23:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728634AbgIVDfR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Sep 2020 23:35:17 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB48DC061755
        for <linux-block@vger.kernel.org>; Mon, 21 Sep 2020 20:35:16 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id k8so11193925pfk.2
        for <linux-block@vger.kernel.org>; Mon, 21 Sep 2020 20:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=URq/xhP9+fAfE1goafcar9I+Snu4Kh15c5GaXKmgMX0=;
        b=QyobmZ6y/WZK9DKhHrqjYkY7TxUeEvUTW/Wdbpp+CdU/igbpd3c6YEn715Exl1ZLXL
         0X4G1B9bAntz87g9YLBEvA7/UnSnLafOxGJLI6pgItnoYjx2Jz/OD9j3RjbztyHMrKF6
         ae+0IVjz0w8SkMq+XGoZm6v4IeF/YYHAhCJFZY4lp1tssGaO8b2JV7NgVEKFzRNlBMPP
         e+HzTIxf9oOP03VMhF8lSlMT/vSBaCwYuruTostMD6Fu4aCB54zJKVZLrFb4Cw7yApRS
         k4ueXYDFI1DWBXmv7YDew6Yjht83aQkop9tLR5vzcW6wz0b33cU1gyeZRrDKmheSsKTl
         0Vog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=URq/xhP9+fAfE1goafcar9I+Snu4Kh15c5GaXKmgMX0=;
        b=YS3qI6BQ54lQfv1D2eNjyON2rVT5LR/8Z/tt17JqpBZhqv+UEcRHL+rCeWKVfZMFkM
         RA5Jmpb71lru1/CbOrJdJyxaD49STPaRUufCAI3kaoQy4ipaC8+9rcwtltzfpDfyoy7N
         3NT7Qo9p6+chl3qXfIFQyQe4+k5ztLEIspaDFytrRojpsTg19RPVKXVeYbu7oziuVCsO
         +B80aztZv8n+pBJA9p7TD8RjZWaTCaG4HIT7FRGKsqIePfWnDUBF5EoycQ2fnJh0j/mj
         hmLh0Kmc5oKQrYU3R9S023JwqmPJSpfg5JZatMClUJMsJ9jAihCm/CLN9jMx0qS8dWTW
         VoZQ==
X-Gm-Message-State: AOAM533vQxYcWM2cm6lXvBeKMu8Ci18xoBCMMf9MSPUBCmdeaVkq22w4
        qoi+sdmBR8LUwa7re2j+jhp1uw==
X-Google-Smtp-Source: ABdhPJyAkdf0DsTCkYk9SBqH6P0qqTA0k5xGM1xE1IgtyvbIPAYbOyFHYIAuLvMPAFN1zdaQAU+huA==
X-Received: by 2002:aa7:961b:0:b029:13e:d13d:a140 with SMTP id q27-20020aa7961b0000b029013ed13da140mr2423868pfg.40.1600745716484;
        Mon, 21 Sep 2020 20:35:16 -0700 (PDT)
Received: from box.bytedance.net ([61.120.150.73])
        by smtp.gmail.com with ESMTPSA id mp3sm714859pjb.33.2020.09.21.20.35.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 20:35:15 -0700 (PDT)
From:   Hou Pu <houpu@bytedance.com>
To:     josef@toxicpanda.com, axboe@kernel.dk
Cc:     mchristi@redhat.com, linux-block@vger.kernel.org,
        nbd@other.debian.org, Hou Pu <houpu@bytedance.com>
Subject: [PATCH v2 2/2] nbd: introduce a client flag to do zero timeout handling
Date:   Tue, 22 Sep 2020 11:34:57 +0800
Message-Id: <20200922033457.46227-3-houpu@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200922033457.46227-1-houpu@bytedance.com>
References: <20200922033457.46227-1-houpu@bytedance.com>
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

