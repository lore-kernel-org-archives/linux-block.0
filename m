Return-Path: <SRS0=/0DQ=4Q=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1FCCC3F2CF
	for <linux-block@archiver.kernel.org>; Fri, 28 Feb 2020 06:41:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 959CA24672
	for <linux-block@archiver.kernel.org>; Fri, 28 Feb 2020 06:41:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uJUpJU2r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726188AbgB1Glx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Feb 2020 01:41:53 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38332 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbgB1Glx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Feb 2020 01:41:53 -0500
Received: by mail-pg1-f194.google.com with SMTP id d6so1004891pgn.5
        for <linux-block@vger.kernel.org>; Thu, 27 Feb 2020 22:41:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5KmJo4otYeRbLM4RlIKP+D2Bfkxr9xULCptchKBXIUM=;
        b=uJUpJU2rWeNJwtMz6AioU9zpMF13wgcox4BvS/V1cKATdtE7zwzDDpqEltKC1jqaQ/
         EORemM4Vmgysuppoqp1wrG4N18YJkMaO40ug/eEC27v02Q3uhgxPFqnkoWOr8Q0vHwyd
         zEgdsmEnGNKLyBAyBGxDzvaQia5/oqnCNYBpj5dJeL64h3qjpHyDbu2GnNFeBcFGfpJp
         zVWnBZCeiuu0Plo9jTgfMPpRFoWfeVwIIxW42MKYtbLXnn6p8deGPd9PRVDdVDp584Nk
         Mve1GGt1QLdR0iruuJCD6Dddp/3+ZDIznEHt8Mba+zcEACdItUnzI5rW+zg9vQVW83S9
         iKJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5KmJo4otYeRbLM4RlIKP+D2Bfkxr9xULCptchKBXIUM=;
        b=WC23dzCwTSS7lChD301MLfk3JRxTvsYP+Ekkps8J4ETO5gaX2N0b9fjN8pncctDTuw
         e+jTb78bAnOeCYysVo9K0+SJkpjtrhF80BFEslCQg7vmjlEv4Byu6iXqvmdiDSfAmjAE
         Inr7o0Iws3QC/Z5JX+t+wwp7MQ9D+8YWD+BlGvFhvJ8b9vvZWoSFA6mo3IO0QGPzaCtX
         9gIkHqt0KgWWwWyQsF3pQbd3i1NFnaGpRnZQoDAuMXQNtSd+47L27mEwxICWReDz6a1r
         TYtEsm0ZrxPtmXGocG/MoNRMA99LCFCgIn8H13YOhEraXmywVQY705X2WgNZacDQKP6a
         R5Dg==
X-Gm-Message-State: APjAAAXQWALLi/xzVanRPRaZFL0BHJ564T7qjUUm0kLxrg/f/5dyvgW1
        o/d1O6NRnyV8th4GHS0gu20=
X-Google-Smtp-Source: APXvYqxqaaA/D+F+sHB9CnvSpWA6fIxsl6KP/ZVAv4GTG2RHn/4KRJbNGZS8RFjBIC5OmWAbwTWd7g==
X-Received: by 2002:a63:aa09:: with SMTP id e9mr3147464pgf.354.1582872111928;
        Thu, 27 Feb 2020 22:41:51 -0800 (PST)
Received: from debian.lc ([61.120.150.75])
        by smtp.gmail.com with ESMTPSA id w11sm9420707pfn.4.2020.02.27.22.41.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Feb 2020 22:41:51 -0800 (PST)
From:   Hou Pu <houpu.main@gmail.com>
X-Google-Original-From: Hou Pu <houpu@bytedance.com>
To:     josef@toxicpanda.com, axboe@kernel.dk, mchristi@redhat.com
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        Hou Pu <houpu@bytedance.com>
Subject: [PATCH 2/2] nbd: requeue command if the soecket is changed
Date:   Fri, 28 Feb 2020 01:40:30 -0500
Message-Id: <20200228064030.16780-3-houpu@bytedance.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200228064030.16780-1-houpu@bytedance.com>
References: <20200228064030.16780-1-houpu@bytedance.com>
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
index 83070714888b..43cff01a5a67 100644
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

