Return-Path: <SRS0=zBYI=YO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A43A2CA9EB7
	for <linux-block@archiver.kernel.org>; Mon, 21 Oct 2019 19:56:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 760392086D
	for <linux-block@archiver.kernel.org>; Mon, 21 Oct 2019 19:56:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="uy4N5ISy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727264AbfJUT4e (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Oct 2019 15:56:34 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:45040 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbfJUT4d (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Oct 2019 15:56:33 -0400
Received: by mail-qt1-f196.google.com with SMTP id z22so2503976qtq.11
        for <linux-block@vger.kernel.org>; Mon, 21 Oct 2019 12:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=PB32g4c6uKsJKr+PshalNj6YK9p7R+K1426kl66/DD4=;
        b=uy4N5ISyRi+PhtI1WNJWJ7K6UqSihuB5UunAhvOdCs1SjLfbLhTi94WgWgcE0iZWI9
         y4bDw9Ca8dmLVo3/9eonX2k+/QJmAuYcK9UbGRtCMXutiU5hQJvB2xOmkZbFlHnkh8Fx
         O0RqlDbX7g6k/bGGh+SA9wWYKTkVEMvONZJZaX6DFrlxQc3HkvkyuJZOjaqnZSWxHQ4z
         9qzMTFEbeIkwo+Eh4jqklsFvhgl79a9LM6dr+ztWikzl4E8vvguPvj4OcSPc9qNnlGbX
         BgfmUsEnA0RAFfv8PTStrOZ2w1LdKHfWGmCsHjHnRZ5OMWilRv+EXSc8YB6mH2LNg7/r
         rAcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PB32g4c6uKsJKr+PshalNj6YK9p7R+K1426kl66/DD4=;
        b=J5n9Ajes4ezNxXi4MfBmiwXrK8xs0cnmx9XoAZzcRhfY79y+28aP0nHzPaTvD4bvVf
         u3tkXfuzOiYx4khcBM+8UF2FkHqtO3GnfnzJdg8XBXo6PZh4P3eqOxg+SAArnqP8/ijZ
         ulxIO3oufaUAYuE18JJpJ7W8qFxJXf+lOQcONnojkIKcdqODiZsovlGo+9tcyTlnu8fv
         zYMFXTYsSbdDzLiRERpF4eBuAODFVpCsTevV1vXn48ir7Aow//ShAM8ODo3Lh1d6aitg
         2j/BQ1v2F5mjERk6hJQSH/n0Ax/Er+3LbeEshbmGZLUYgyiYBhyFgtMZYd2O71U6YVZM
         6gLw==
X-Gm-Message-State: APjAAAURgWFEgT2enOQcRLGeVGS/oLynQwBMEsYE03IJtOU5LeNcViz9
        v5tGcuri+XZq89ueX7ZSg1DDg5KqN+qoiw==
X-Google-Smtp-Source: APXvYqxBxLQO23FtAwkOCqWxxqVcL90+WPiI9CK+WkYrNq1ytchniQH3endTRmyibP7ecZPdyxIE/w==
X-Received: by 2002:ad4:5004:: with SMTP id s4mr4812140qvo.87.1571687792790;
        Mon, 21 Oct 2019 12:56:32 -0700 (PDT)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id r29sm7985889qtb.63.2019.10.21.12.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 12:56:32 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     axboe@kernel.dk, nbd@other.debian.org, linux-block@vger.kernel.org,
        kernel-team@fb.com, mchristi@redhat.com
Subject: [PATCH 1/2] nbd: protect cmd->status with cmd->lock
Date:   Mon, 21 Oct 2019 15:56:27 -0400
Message-Id: <20191021195628.19849-2-josef@toxicpanda.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191021195628.19849-1-josef@toxicpanda.com>
References: <20191021195628.19849-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We already do this for the most part, except in timeout and clear_req.
For the timeout case we take the lock after we grab a ref on the config,
but that isn't really necessary because we're safe to touch the cmd at
this point, so just move the order around.

For the clear_req cause this is initiated by the user, so again is safe.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 drivers/block/nbd.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index a8e3815295fe..8fb8913074b8 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -368,17 +368,16 @@ static enum blk_eh_timer_return nbd_xmit_timeout(struct request *req,
 	struct nbd_device *nbd = cmd->nbd;
 	struct nbd_config *config;
 
+	if (!mutex_trylock(&cmd->lock))
+		return BLK_EH_RESET_TIMER;
+
 	if (!refcount_inc_not_zero(&nbd->config_refs)) {
 		cmd->status = BLK_STS_TIMEOUT;
+		mutex_unlock(&cmd->lock);
 		goto done;
 	}
 	config = nbd->config;
 
-	if (!mutex_trylock(&cmd->lock)) {
-		nbd_config_put(nbd);
-		return BLK_EH_RESET_TIMER;
-	}
-
 	if (config->num_connections > 1) {
 		dev_err_ratelimited(nbd_to_dev(nbd),
 				    "Connection timed out, retrying (%d/%d alive)\n",
@@ -775,7 +774,10 @@ static bool nbd_clear_req(struct request *req, void *data, bool reserved)
 {
 	struct nbd_cmd *cmd = blk_mq_rq_to_pdu(req);
 
+	mutex_lock(&cmd->lock);
 	cmd->status = BLK_STS_IOERR;
+	mutex_unlock(&cmd->lock);
+
 	blk_mq_complete_request(req);
 	return true;
 }
-- 
2.21.0

