Return-Path: <SRS0=nPog=C6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30F21C43464
	for <linux-block@archiver.kernel.org>; Mon, 21 Sep 2020 10:57:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F17A9207BC
	for <linux-block@archiver.kernel.org>; Mon, 21 Sep 2020 10:57:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="p/tFl1wJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726470AbgIUK5n (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Sep 2020 06:57:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726402AbgIUK5m (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Sep 2020 06:57:42 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B20A4C0613CF
        for <linux-block@vger.kernel.org>; Mon, 21 Sep 2020 03:57:42 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id v14so6935321pjd.4
        for <linux-block@vger.kernel.org>; Mon, 21 Sep 2020 03:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VV3gcZz9qKuPs84N2Es2cgBs4xeGVyPPTTCXAIYm92E=;
        b=p/tFl1wJaUv7yfJ87eFifY1+yrVg2gZlLqsFiDG8DDpzFiW7e5fqWgNZlNl3B9JKIR
         oSMzggHh8atAmbdRDvqqO7FnjHHYui8oVKoVxSucemnbfibay6KrSxnVDU2EkXkEGW4Y
         erB3UWjtDfpzD9Zz+IWCIiEcguahPxD/h//nZbQraP7eAkSJhlh/HM7FeSs/xERHv7eP
         lf2YZ1droNtH2qzvC0cIp0RrH0F1T1HRcuZ+slaTToT5BSNnJXJl4/qPv7EH1fB9oS9t
         5wdtn8yUNFLmP7oeD+MQqdMPjVxBb4fShfseXwiekAyu8vGHXU3aNAdY+c1xKiJIk61o
         NssA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VV3gcZz9qKuPs84N2Es2cgBs4xeGVyPPTTCXAIYm92E=;
        b=drTjQKwLYCs7lML683PZksHNwExdNSuGI+ZVBlKFPZfbjIcIFOT35mujqovzRgeCoz
         PuG2qL0WBjaeFzPDR5Kyxdm8Qof4dC9dd3EYvKB/cEOMsBcgMiuWlV8Qs7kaPFaJanJX
         yomqrCzMLbKGt2eN9YCmjSSoKGxm4lsPuUPUaI6SMzEGCkfgueI6B5tx03p084oBX8lI
         WgU2GL2018VTVUkAY+MONMLTTGEOkJM/Wgy4yEOMUgHci6MNqFZMVldIZTcYrsX348MP
         49AVUdOIsgcus5+9M/A2Le3UIpXoaQIi9bGnoIRxsrFMEfCCnYbBBtueygX98pH6a8g+
         heZA==
X-Gm-Message-State: AOAM532D9VhNtdEOcosmdLomSG4my5nbnF+wZFQkBxmEkdhLUJxYZoMA
        VTzGOsP7lesC4cX4AtZoCe1zmA==
X-Google-Smtp-Source: ABdhPJzDa8+tXiz85jqOT8FmjdYgP5pxuExLAwtOnDXeUK1RcH7HAQy0YNMXUInmpRpdmhT+wvTQbA==
X-Received: by 2002:a17:90b:8a:: with SMTP id bb10mr24508143pjb.108.1600685862352;
        Mon, 21 Sep 2020 03:57:42 -0700 (PDT)
Received: from box.bytedance.net ([61.120.150.73])
        by smtp.gmail.com with ESMTPSA id x62sm2792533pfx.20.2020.09.21.03.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 03:57:41 -0700 (PDT)
From:   Hou Pu <houpu@bytedance.com>
To:     josef@toxicpanda.com, axboe@kernel.dk
Cc:     mchristi@redhat.com, linux-block@vger.kernel.org,
        nbd@other.debian.org, Hou Pu <houpu@bytedance.com>
Subject: [PATCH 2/3] nbd: unify behavior in timeout no matter how many sockets is configured
Date:   Mon, 21 Sep 2020 18:57:17 +0800
Message-Id: <20200921105718.29006-3-houpu@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200921105718.29006-1-houpu@bytedance.com>
References: <20200921105718.29006-1-houpu@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When an nbd device is configured with multiple sockets, the request
is requeued to an active socket in xmit_timeout, the original socket
is closed if not.

Some time, the backend nbd server hang, thus all sockets will be
dropped and the nbd device is not usable. It would be better to have an
option to wait for more time (just reset timer in nbd_xmit_timeout).
Like what we do if we only have one socket. This patch allows it.

Signed-off-by: Hou Pu <houpu@bytedance.com>
---
 drivers/block/nbd.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 538e9dcf5bf2..4c0bbb981cbc 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -400,8 +400,7 @@ static enum blk_eh_timer_return nbd_xmit_timeout(struct request *req,
 	    nbd->tag_set.timeout)
 		goto error_out;
 
-	if (config->num_connections > 1 ||
-	    (config->num_connections == 1 && nbd->tag_set.timeout)) {
+	if (nbd->tag_set.timeout) {
 		dev_err_ratelimited(nbd_to_dev(nbd),
 				    "Connection timed out, retrying (%d/%d alive)\n",
 				    atomic_read(&config->live_connections),
@@ -432,9 +431,7 @@ static enum blk_eh_timer_return nbd_xmit_timeout(struct request *req,
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
-- 
2.11.0

