Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B66A9C433E9
	for <linux-block@archiver.kernel.org>; Mon, 25 Jan 2021 17:22:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C55B22B3B
	for <linux-block@archiver.kernel.org>; Mon, 25 Jan 2021 17:22:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729603AbhAYRVx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Jan 2021 12:21:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728765AbhAYRVq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Jan 2021 12:21:46 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9E98C06174A
        for <linux-block@vger.kernel.org>; Mon, 25 Jan 2021 09:21:05 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id a12so3289038qkh.10
        for <linux-block@vger.kernel.org>; Mon, 25 Jan 2021 09:21:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VjbQBJvvk1x9RhHKts283wh1E1XENs+E9cWM4klUsv8=;
        b=IdUMp8vKZZyarCmt+37it4NBDMUzI9zAtlL6/P38VH7XdSvfueMB8GmnA8WVjX3EE0
         xr5Yd2xTlC0sdtPFE+zRttrxS4t6Gvk3EPAI+oXWQ6CnJFyKIKEIe9p9fgIv3RXPBOhG
         BAgfc55rUYqXsnZ5EFXopQBKXCK5MqvTEoLRJUr1Kool371yMPpiVjTgjuIM0HeiOwGi
         KbjPoPefu74uae0cWqHXyRLQE2w73OmId5kIwFatbFDNVauQpvF4pEenxIFq9O5vRhDd
         xmcNXzf9EZrZFnsX+gMWiytNnePrKKORDhaAmRZt+3RXpATpb+Izllf6/ABsRzcOrBR5
         fj7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VjbQBJvvk1x9RhHKts283wh1E1XENs+E9cWM4klUsv8=;
        b=ZmXQ8uPKi/Yw4UYkyIh9OygsS6ko8P5ncQLgl6u+qop/304EibEaY0AQ1lC7AvDKZW
         VsSPzKPCdYN+1bD3EbBndKfgX+qutiuv1JnX3eyvo8kEG2NCBcFofqXez3+tl9TwRRbB
         Mphy6buFCysWEJDUQKKSS32WbKQ/OfAE4OxrdnIEpkN1QOLlgtgSvKGydG2sAe9O7LhG
         dIPWU/0Hj/sLrb0jLtRW6TqH49F82fKrfz4bxmiQG8HfbVpGTIl2lNEXh4KZViE8i6l0
         7xa+D5u0nx7SwM85UcSYorDpZfKM1MoPvcQZwemugMWbOKLCh8/RcL5ZYMl0Cv0B9VYj
         INKw==
X-Gm-Message-State: AOAM53048OKH46HKFNfdZSc3JWSplHcQ9lzWc7jTCYBLPIHws9pPyNwO
        KLPRRro+O6XkL/rPsuFOm+eHlQ==
X-Google-Smtp-Source: ABdhPJwf2a443n85MWiyGE6ZUfYq6QwaJdNABw7AgzhCntBeNYvD5pGZ6lj5VZ/3XVu2lFy0sfOSrQ==
X-Received: by 2002:a37:ba84:: with SMTP id k126mr1794616qkf.306.1611595265056;
        Mon, 25 Jan 2021 09:21:05 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id d9sm4693414qko.84.2021.01.25.09.21.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 09:21:03 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     axboe@kernel.dk, nbd@other.debian.org, linux-block@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH] nbd: freeze the queue while we're adding connections
Date:   Mon, 25 Jan 2021 12:21:02 -0500
Message-Id: <24dff677353e2e30a71d8b66c4dffdbdf77c4dbd.1611595239.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When setting up a device, we can krealloc the config->socks array to add
new sockets to the configuration.  However if we happen to get a IO
request in at this point even though we aren't setup we could hit a UAF,
as we deref config->socks without any locking, assuming that the
configuration was setup already and that ->socks is safe to access it as
we have a reference on the configuration.

But there's nothing really preventing IO from occurring at this point of
the device setup, we don't want to incur the overhead of a lock to
access ->socks when it will never change while the device is running.
To fix this UAF scenario simply freeze the queue if we are adding
sockets.  This will protect us from this particular case without adding
any additional overhead for the normal running case.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 drivers/block/nbd.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 6727358e147d..e6ea5d344f87 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1022,6 +1022,12 @@ static int nbd_add_socket(struct nbd_device *nbd, unsigned long arg,
 	if (!sock)
 		return err;
 
+	/*
+	 * We need to make sure we don't get any errant requests while we're
+	 * reallocating the ->socks array.
+	 */
+	blk_mq_freeze_queue(nbd->disk->queue);
+
 	if (!netlink && !nbd->task_setup &&
 	    !test_bit(NBD_RT_BOUND, &config->runtime_flags))
 		nbd->task_setup = current;
@@ -1060,10 +1066,12 @@ static int nbd_add_socket(struct nbd_device *nbd, unsigned long arg,
 	nsock->cookie = 0;
 	socks[config->num_connections++] = nsock;
 	atomic_inc(&config->live_connections);
+	blk_mq_unfreeze_queue(nbd->disk->queue);
 
 	return 0;
 
 put_socket:
+	blk_mq_unfreeze_queue(nbd->disk->queue);
 	sockfd_put(sock);
 	return err;
 }
-- 
2.26.2

