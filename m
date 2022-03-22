Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D810BC433EF
	for <linux-block@archiver.kernel.org>; Tue, 22 Mar 2022 08:07:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbiCVIIy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Mar 2022 04:08:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiCVIIx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Mar 2022 04:08:53 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73D822C679
        for <linux-block@vger.kernel.org>; Tue, 22 Mar 2022 01:07:26 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id g19so17519872pfc.9
        for <linux-block@vger.kernel.org>; Tue, 22 Mar 2022 01:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HCeG+e3i+kXW9AfySwSJpDg7ddb/m+jr34UFwVRHhds=;
        b=tzNF8shRcdEElNv8CUpbtIR8J5Ve65fWjOhm2gwoKzZc+TPUpSwzhjFM/Lq7d4+VPw
         7/2r36VgjEstcRi1yF6eQINGiqt/V55Fv81++rEv9yl4uDOf6yKR8lqyoQzHo1Lrr2ox
         Zcv5bD2Q0twSiZZtnlWHDlmI2qdtHWa4ze/GNBHsmsJQ0QpHnOMHnJwAA++XKA5LxCxl
         4cJcJKp0AVir7a+kamNfJRWTNnlH+N++DnFDkxEQqVopDxj6lgiitl8bgbJNAIIoCYjG
         fn+vdoup2Ki9ep1+XoJBN2GPFnnSCbVugJW78GnnD11L216cj5NG4wlj+mZ1+5kMc8DX
         27XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HCeG+e3i+kXW9AfySwSJpDg7ddb/m+jr34UFwVRHhds=;
        b=deC9DMN9h3A2xiU5z1zimsZ+AUgwGx9Vnk3ASZMTcElATG8+z93NM9hmoiW1QHxSQQ
         kN3n8vxQsobrtTOkI9s1LwWGrNL7gzzyhVTsCwrtiL0vURmgcqOvmFjxdxgWS33mBx0g
         E+8+xySnrkb30shqFHm0JyaaVKBXhObrCp2+BzgKOIM5zzdsl/B+I9LeXPJ2iAHOariz
         eo8Bnmcf55tTh/xVqH5gK1+h0enKQG2NcZzOPlpfj6cAu+upxLkKQM6osTfX57QTtfp0
         DgcKL+0dgJcM3KAHxbynj09MDNcq0QgI4KdqxYgGJ1DL2nMPiHs7rmeCljfZqT+8T5tR
         pXVg==
X-Gm-Message-State: AOAM532jFmkrs7Yz7HS042Dj5umB4r+bI2pvrjo7d4RnPZmtMe+AY9It
        ayjunERw2gesgYuI6Qcxkvaj
X-Google-Smtp-Source: ABdhPJx7mcdP4faDjZ/NqyNvWtQ6EcoJ90TX7jmxYq6YyRVe3dGGpYo87cXoINNCwHOcL6tssWctXg==
X-Received: by 2002:a62:d0c1:0:b0:4fa:81f5:b9d4 with SMTP id p184-20020a62d0c1000000b004fa81f5b9d4mr15136194pfg.49.1647936445586;
        Tue, 22 Mar 2022 01:07:25 -0700 (PDT)
Received: from localhost ([139.177.225.235])
        by smtp.gmail.com with ESMTPSA id e12-20020a056a001a8c00b004fab88d7de8sm1901149pfv.132.2022.03.22.01.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 01:07:25 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     josef@toxicpanda.com, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        zero.xu@bytedance.com
Subject: [PATCH] nbd: Fix hung on disconnect request if socket is closed before
Date:   Tue, 22 Mar 2022 16:06:39 +0800
Message-Id: <20220322080639.142-1-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When userspace closes the socket before sending a disconnect
request, the following I/O requests will be blocked in
wait_for_reconnect() until dead timeout. This will cause the
following disconnect request also hung on blk_mq_quiesce_queue().
That means we have no way to disconnect a nbd device if there
are some I/O requests waiting for reconnecting until dead timeout.
It's not expected. So let's wake up the thread waiting for
reconnecting directly when a disconnect request is sent.

Reported-by: Xu Jianhai <zero.xu@bytedance.com>
Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
---
 drivers/block/nbd.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 5a1f98494ddd..284557041336 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -947,11 +947,15 @@ static int wait_for_reconnect(struct nbd_device *nbd)
 	struct nbd_config *config = nbd->config;
 	if (!config->dead_conn_timeout)
 		return 0;
-	if (test_bit(NBD_RT_DISCONNECTED, &config->runtime_flags))
+
+	if (!wait_event_timeout(config->conn_wait,
+				test_bit(NBD_RT_DISCONNECTED,
+					 &config->runtime_flags) ||
+				atomic_read(&config->live_connections) > 0,
+				config->dead_conn_timeout))
 		return 0;
-	return wait_event_timeout(config->conn_wait,
-				  atomic_read(&config->live_connections) > 0,
-				  config->dead_conn_timeout) > 0;
+
+	return !test_bit(NBD_RT_DISCONNECTED, &config->runtime_flags);
 }
 
 static int nbd_handle_cmd(struct nbd_cmd *cmd, int index)
@@ -2082,6 +2086,7 @@ static void nbd_disconnect_and_put(struct nbd_device *nbd)
 	mutex_lock(&nbd->config_lock);
 	nbd_disconnect(nbd);
 	sock_shutdown(nbd);
+	wake_up(&nbd->config->conn_wait);
 	/*
 	 * Make sure recv thread has finished, we can safely call nbd_clear_que()
 	 * to cancel the inflight I/Os.
-- 
2.20.1

