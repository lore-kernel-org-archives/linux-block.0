Return-Path: <SRS0=ya0H=4H=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B21EC34022
	for <linux-block@archiver.kernel.org>; Wed, 19 Feb 2020 06:32:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71EA2208C4
	for <linux-block@archiver.kernel.org>; Wed, 19 Feb 2020 06:32:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a7WbM4Kd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbgBSGci (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Feb 2020 01:32:38 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:52381 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbgBSGch (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Feb 2020 01:32:37 -0500
Received: by mail-pj1-f66.google.com with SMTP id ep11so2135148pjb.2
        for <linux-block@vger.kernel.org>; Tue, 18 Feb 2020 22:32:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GIqVMX3DyGkECipnIGRvXSYBH0RbpyXbsUDROYd/soc=;
        b=a7WbM4KdSNIddESKcsNZA/pa1SEh8uKGW+0DOSOQKDQQvBIsFWtRt6ML9av02t03Eq
         /4Fj+J/ApTKTgcAUk/imL8mTrM5UA5TtnXwVMEmO2dAKY1Y6yBmCDhjsi7g7V71op0FI
         vT4ihN9kcHHNoKC0vSlp1NB+hPMfVg6rA6fj35xhzT5zG4wLl8IuRxUfjarmAw3XfXkX
         a7jFLfqoDUcSOtQxK2wfbP5GEUlrtGinwH2Cnuw/35P09rx2B8zsPlgb3VfUu0gQKp24
         XflBEHyi9qPNg0AxnAcOVOsCpwyfBwH/47mlFw3nDPWyHPJE81lGpT+CfG60D52h9Qvt
         Yc9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GIqVMX3DyGkECipnIGRvXSYBH0RbpyXbsUDROYd/soc=;
        b=K4mg9bhUE3059Tkij8vRwh7oIvrOcvAvEwCAb+kyvUz2hGceoR0MCxb43th3YM3cO6
         rM3lGHQc6wwT8j96W9uJ746mMgHJH8odPXjQZ3/g/FbvidXxH8zFDJka4hfGO+Rh5ek7
         RRERAaUtpSX6YwaMyJl5OAWTxF/qKQwYO/s8SujP1aW04K5p90DQgKsEFlef6wp6SlKv
         i3m+REjQj8E60vZjLTRmjfRjyXWNjD0i9E4PdYFuKIVEpOi9EWAUet+RO6TK858uJd/k
         WzmelGLmHy+2xSUck4P91GBUr/mIA6fEwY56d7XYHysmbrPKc1hh6CBjDb8OjrI5GY6H
         VbYg==
X-Gm-Message-State: APjAAAWQEd67dy5G2K5tKgLu4VSgJcejL/WdQMljdkMSR8lKMPU0QmG3
        D6zG7tdpxQ7pCKoeGD/Y0Kc=
X-Google-Smtp-Source: APXvYqyg0oBKK7byB0Yhw0ShZPXiyOyIrdj6lzVTuW6ii1cE/rS1BMWyTZGiqKO2TVyQjKmoFAixHw==
X-Received: by 2002:a17:902:9890:: with SMTP id s16mr22405849plp.77.1582093957276;
        Tue, 18 Feb 2020 22:32:37 -0800 (PST)
Received: from debian.lc ([61.120.150.75])
        by smtp.gmail.com with ESMTPSA id e7sm1184487pfj.114.2020.02.18.22.32.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Feb 2020 22:32:36 -0800 (PST)
From:   Hou Pu <houpu.main@gmail.com>
X-Google-Original-From: Hou Pu <houpu@bytedance.com>
To:     josef@toxicpanda.com, axboe@kernel.dk, mchristi@redhat.com
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        Hou Pu <houpu@bytedance.com>
Subject: [PATCH 2/2] nbd: requeue command if the soecket is changed
Date:   Wed, 19 Feb 2020 01:31:07 -0500
Message-Id: <20200219063107.25550-3-houpu@bytedance.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200219063107.25550-1-houpu@bytedance.com>
References: <20200219063107.25550-1-houpu@bytedance.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In commit 2da22da5734 (nbd: fix zero cmd timeout handling v2),
it is allowed to reset timer when it fires if tag_set.timeout
is set to zero. If the server is shutdown and a new socket
is reconfigured, the request should be requeued to be processed by
new server instead of waiting for response from the old one.

Signed-off-by: Hou Pu <houpu@bytedance.com>
---
 drivers/block/nbd.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 8e348c9c49a4..7bbc5477066c 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -434,12 +434,22 @@ static enum blk_eh_timer_return nbd_xmit_timeout(struct request *req,
 		 * Userspace sets timeout=0 to disable socket disconnection,
 		 * so just warn and reset the timer.
 		 */
+		struct nbd_sock *nsock = config->socks[cmd->index];
 		cmd->retries++;
 		dev_info(nbd_to_dev(nbd), "Possible stuck request %p: control (%s@%llu,%uB). Runtime %u seconds\n",
 			req, nbdcmd_to_ascii(req_to_nbd_cmd_type(req)),
 			(unsigned long long)blk_rq_pos(req) << 9,
 			blk_rq_bytes(req), (req->timeout / HZ) * cmd->retries);
 
+		mutex_lock(&nsock->tx_lock);
+		if (cmd->cookie != nsock->cookie) {
+			nbd_requeue_cmd(cmd);
+			mutex_unlock(&nsock->tx_lock);
+			mutex_unlock(&cmd->lock);
+			nbd_config_put(nbd);
+			return BLK_EH_DONE;
+		}
+		mutex_unlock(&nsock->tx_lock);
 		mutex_unlock(&cmd->lock);
 		nbd_config_put(nbd);
 		return BLK_EH_RESET_TIMER;
-- 
2.11.0

