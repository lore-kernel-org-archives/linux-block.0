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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA4C7C34022
	for <linux-block@archiver.kernel.org>; Wed, 19 Feb 2020 06:32:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1C3C208C4
	for <linux-block@archiver.kernel.org>; Wed, 19 Feb 2020 06:32:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jFZ0AiuW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726169AbgBSGcb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Feb 2020 01:32:31 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37822 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbgBSGcb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Feb 2020 01:32:31 -0500
Received: by mail-pl1-f193.google.com with SMTP id c23so9139233plz.4
        for <linux-block@vger.kernel.org>; Tue, 18 Feb 2020 22:32:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=apLZtF887Y+fbvHxJ4v5hcColYznZeKPq3aGWXCXGR4=;
        b=jFZ0AiuW5zeZdzlyX5WOh0W4tLv5fN4Rv/IeKDA/cwTqg58u1Es66GYbdIWX0qa34x
         jalI/LWAsLni7+8pcZsZ1tM9+GSxiA5gUu15B+zrg08bSHXwB1sf8nxDD8QXakDPBY2k
         oKE7lXWuJWQWij7JKvQxBwBowvg3E14wzCBZ6EFbdcK0Ch5717tjf3CJNWO/wewUMjDw
         jRLDzEDAV8IrKN5jWOzH6Fs6OjdFfWI3Kc2sWBIK287Ej9ABlWUG34GRZwbgrWfgbV67
         TKdqY1VqwDtvgQW86b+yYGXKvl9Hkw7wyvZ9PaIAwj5smhy+5tLRa5VAUsSmv1Bb7XR5
         EO2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=apLZtF887Y+fbvHxJ4v5hcColYznZeKPq3aGWXCXGR4=;
        b=JsC+hs8pOEy6/o+F61w1fi1lbfRzI9QytmDJ0KuwjuTNkmTXTwW4EvhYY1mG+T1O2N
         qgNF+oHfJOQibkN3WJ+8UuascIPJ5BLP2JaFzpUtX9B/UgLvxR1d9I8NpKyimSzPR/vS
         YbTUXrEgsDnrUr0Hme272hjEHdd5wHyKLrmR+Yq5w+T7nHAulHulIX+EwSRm+CcQg7WZ
         AVkD5ujjYQwrCOV2xdbgmk+JzSZ8+Vaetu6ErBpGfEL8QKkqfUEEiVjx2P1OcktHYR2o
         Jbig1/HZAaVULoOOUUee9wAFeSsBPOxmFr3XSKtpQPBuPWeF0Ti6/QukWw2XZC+Y8kW5
         qiGQ==
X-Gm-Message-State: APjAAAVmzSH/sLF7WfNtPGvokIQgPksez3/Gj0hN8jpXbF8aQB6vVurI
        eJ3Pk0utnDw2OlV3oOSkABM=
X-Google-Smtp-Source: APXvYqy/In4gi1EBsHZbSbUcRTtXKEp5X5nBPGyvvmvnrI9T4YO+kMVJhkVs7cCC3yfxQOhW8u79Zg==
X-Received: by 2002:a17:902:7004:: with SMTP id y4mr24683618plk.263.1582093950554;
        Tue, 18 Feb 2020 22:32:30 -0800 (PST)
Received: from debian.lc ([61.120.150.75])
        by smtp.gmail.com with ESMTPSA id e7sm1184487pfj.114.2020.02.18.22.32.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Feb 2020 22:32:30 -0800 (PST)
From:   Hou Pu <houpu.main@gmail.com>
X-Google-Original-From: Hou Pu <houpu@bytedance.com>
To:     josef@toxicpanda.com, axboe@kernel.dk, mchristi@redhat.com
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        Hou Pu <houpu@bytedance.com>
Subject: [PATCH 1/2] nbd: enable replace socket if only one connection is configured
Date:   Wed, 19 Feb 2020 01:31:06 -0500
Message-Id: <20200219063107.25550-2-houpu@bytedance.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200219063107.25550-1-houpu@bytedance.com>
References: <20200219063107.25550-1-houpu@bytedance.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Nbd server with multiple connections could be upgraded since
560bc4b (nbd: handle dead connections). But if only one conncection
is configured, after we take down nbd server, all inflight IO
would finally timeout and return error. We could requeue them
like what we do with multiple connections and wait for new socket
in submit path.

Signed-off-by: Hou Pu <houpu@bytedance.com>
---
 drivers/block/nbd.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 78181908f0df..8e348c9c49a4 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -395,16 +395,19 @@ static enum blk_eh_timer_return nbd_xmit_timeout(struct request *req,
 	}
 	config = nbd->config;
 
-	if (config->num_connections > 1) {
+	if (config->num_connections > 1 ||
+	    (config->num_connections == 1 && nbd->tag_set.timeout)) {
 		dev_err_ratelimited(nbd_to_dev(nbd),
 				    "Connection timed out, retrying (%d/%d alive)\n",
 				    atomic_read(&config->live_connections),
 				    config->num_connections);
 		/*
 		 * Hooray we have more connections, requeue this IO, the submit
-		 * path will put it on a real connection.
+		 * path will put it on a real connection. Or if only one
+		 * connection is configured, the submit path will wait util
+		 * a new connection is reconfigured or util dead timeout.
 		 */
-		if (config->socks && config->num_connections > 1) {
+		if (config->socks) {
 			if (cmd->index < config->num_connections) {
 				struct nbd_sock *nsock =
 					config->socks[cmd->index];
@@ -747,8 +750,7 @@ static struct nbd_cmd *nbd_read_stat(struct nbd_device *nbd, int index)
 				 * and let the timeout stuff handle resubmitting
 				 * this request onto another connection.
 				 */
-				if (nbd_disconnected(config) ||
-				    config->num_connections <= 1) {
+				if (nbd_disconnected(config)) {
 					cmd->status = BLK_STS_IOERR;
 					goto out;
 				}
@@ -825,7 +827,7 @@ static int find_fallback(struct nbd_device *nbd, int index)
 
 	if (config->num_connections <= 1) {
 		dev_err_ratelimited(disk_to_dev(nbd->disk),
-				    "Attempted send on invalid socket\n");
+				    "Dead connection, failed to find a fallback\n");
 		return new_index;
 	}
 
-- 
2.11.0

