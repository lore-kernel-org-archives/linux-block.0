Return-Path: <SRS0=/0DQ=4Q=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 726C3C3F2CF
	for <linux-block@archiver.kernel.org>; Fri, 28 Feb 2020 06:41:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4447124672
	for <linux-block@archiver.kernel.org>; Fri, 28 Feb 2020 06:41:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gZPYkslw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725911AbgB1Glp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Feb 2020 01:41:45 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33064 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbgB1Glp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Feb 2020 01:41:45 -0500
Received: by mail-pg1-f193.google.com with SMTP id 6so1012957pgk.0
        for <linux-block@vger.kernel.org>; Thu, 27 Feb 2020 22:41:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pFbk0CMR9rqR5wOc+dREyts4vK3zZIT7ZWJKDdvwNTY=;
        b=gZPYkslwR6asDMMBWHIX7RLiF4RNpOUvH7AlQJxRW3PzcH3EmzLvnaozjmdPWKJvpa
         QNYWLkPgoHtB+s/qPI8OEFoJXbjO9/PNHuGwXN2riE5ChlenSyLyH5mGabip6t6wze1+
         W9X8npnAJ2Zvk61dQnTvUOojp4zL4gOzSrbaBl4nNc0dkqueyJoGJaohSUx7b9DSN8eZ
         71i8ewY75UU0rSGE3FGovecrNqhPCId4Xx/Y39+jVUojnzqwiwiJriCncumyjvzpsVXG
         iUsGEiDTG0rtc/V2zasxESbntcxMdTCNKfofPfUeaL+rV0cX7iVnXnXywV9qXUlrMv0Y
         ZZYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pFbk0CMR9rqR5wOc+dREyts4vK3zZIT7ZWJKDdvwNTY=;
        b=IGfgsyMtY+EQKFOySLH+07/jui41w2IgfPcdzQndiJJNw0kvwikY6Nb6709wHPnC6v
         ZobSYTVQWc3k5IypLNj9pIyNm9/x5zMl5gXOSS5kjg2ZHBJK2wrXYyPsLHcozFnho8ek
         yVvQbc7p560w4JD+iRW1STUPML7Y6xWM+XZVx9hemZ+gG7DeyuVOn+H77M7m79txVuTY
         EgOaUTIIQwF1i1GGt2g7CQM2FoQFWuN7Et0OyCLZXgizFS7ZI3Ax9qaGYEP+8I1d8Arb
         gGyhaeDwH812cCyjRlXUI2Pxm9lTLRkGYG+iAcp2oOo9G1IYqWTKHYzdrdTxBSUIT+GN
         oVRw==
X-Gm-Message-State: APjAAAVhZWJm45or4IL249MCtcsJROSs0hKFJdgCjQ8vIWAs+Lpt5DlF
        v2ywu/sx88E6V++1gXZYR0Q=
X-Google-Smtp-Source: APXvYqwsQnzf1RAv1/pL+rFWBHhjLmBX/RcAyHIovkt9vGDFx3S+hnVg5MsWf66qXgoWIQvcUp/9ow==
X-Received: by 2002:a63:f744:: with SMTP id f4mr3181104pgk.345.1582872103027;
        Thu, 27 Feb 2020 22:41:43 -0800 (PST)
Received: from debian.lc ([61.120.150.75])
        by smtp.gmail.com with ESMTPSA id w11sm9420707pfn.4.2020.02.27.22.41.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Feb 2020 22:41:42 -0800 (PST)
From:   Hou Pu <houpu.main@gmail.com>
X-Google-Original-From: Hou Pu <houpu@bytedance.com>
To:     josef@toxicpanda.com, axboe@kernel.dk, mchristi@redhat.com
Cc:     linux-block@vger.kernel.org, nbd@other.debian.org,
        Hou Pu <houpu@bytedance.com>
Subject: [PATCH 1/2] nbd: enable replace socket if only one connection is configured
Date:   Fri, 28 Feb 2020 01:40:29 -0500
Message-Id: <20200228064030.16780-2-houpu@bytedance.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200228064030.16780-1-houpu@bytedance.com>
References: <20200228064030.16780-1-houpu@bytedance.com>
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
 drivers/block/nbd.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 78181908f0df..83070714888b 100644
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
@@ -741,14 +744,12 @@ static struct nbd_cmd *nbd_read_stat(struct nbd_device *nbd, int index)
 				dev_err(disk_to_dev(nbd->disk), "Receive data failed (result %d)\n",
 					result);
 				/*
-				 * If we've disconnected or we only have 1
-				 * connection then we need to make sure we
+				 * If we've disconnected, we need to make sure we
 				 * complete this request, otherwise error out
 				 * and let the timeout stuff handle resubmitting
 				 * this request onto another connection.
 				 */
-				if (nbd_disconnected(config) ||
-				    config->num_connections <= 1) {
+				if (nbd_disconnected(config)) {
 					cmd->status = BLK_STS_IOERR;
 					goto out;
 				}
@@ -825,7 +826,7 @@ static int find_fallback(struct nbd_device *nbd, int index)
 
 	if (config->num_connections <= 1) {
 		dev_err_ratelimited(disk_to_dev(nbd->disk),
-				    "Attempted send on invalid socket\n");
+				    "Dead connection, failed to find a fallback\n");
 		return new_index;
 	}
 
-- 
2.11.0

