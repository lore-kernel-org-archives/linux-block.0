Return-Path: <SRS0=1fuv=XR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60DE8C49ED7
	for <linux-block@archiver.kernel.org>; Sun, 22 Sep 2019 19:17:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 320BC214D9
	for <linux-block@archiver.kernel.org>; Sun, 22 Sep 2019 19:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569179835;
	bh=J2DOie5+rJ5lNglv194L5tZNcZlQOsaZ5mRHla4X5YE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XT1rZO6nVMtJ3zIF04v9HaeYoQu5msjakR+CR6s+R/dmzZe+uNCgSL6ozBV76A8QF
	 nzTrGZCS/szIKkHDdG0sZqIbK5XH66ullPjL0W7LgC3tzRzldyKAPh2DOsRhXvcicq
	 90bKDwbJvddoFvzpOAT57Y2sY5C0T89zBsxMiRtg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405654AbfIVTRO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 22 Sep 2019 15:17:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:57394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729374AbfIVSzt (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 22 Sep 2019 14:55:49 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9986E208C2;
        Sun, 22 Sep 2019 18:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569178549;
        bh=J2DOie5+rJ5lNglv194L5tZNcZlQOsaZ5mRHla4X5YE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CbcYBRZLgIAoNmlbfqk9/yCzd6dcR2SKCeUZ15akoGeoxpA8jijtzQZllFtUP/cqz
         3CpX4cYE0oFpghCUH9c6UdpihHkH4pIsKDivllzjduiPSeEUAGxomZcWVfXPY975OT
         Nr6CZ3n3bizNuLa2EcGtFKZxpWVsNLZZw2sTKftc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Mike Christie <mchristi@redhat.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        linux-block@vger.kernel.org, nbd@other.debian.org
Subject: [PATCH AUTOSEL 4.19 067/128] nbd: add missing config put
Date:   Sun, 22 Sep 2019 14:53:17 -0400
Message-Id: <20190922185418.2158-67-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190922185418.2158-1-sashal@kernel.org>
References: <20190922185418.2158-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Mike Christie <mchristi@redhat.com>

[ Upstream commit 887e975c4172d0d5670c39ead2f18ba1e4ec8133 ]

Fix bug added with the patch:

commit 8f3ea35929a0806ad1397db99a89ffee0140822a
Author: Josef Bacik <josef@toxicpanda.com>
Date:   Mon Jul 16 12:11:35 2018 -0400

    nbd: handle unexpected replies better

where if the timeout handler runs when the completion path is and we fail
to grab the mutex in the timeout handler we will leave a config reference
and cannot free the config later.

Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Mike Christie <mchristi@redhat.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/nbd.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index fa60f265ee506..b1c7009de1f4d 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -353,8 +353,10 @@ static enum blk_eh_timer_return nbd_xmit_timeout(struct request *req,
 	}
 	config = nbd->config;
 
-	if (!mutex_trylock(&cmd->lock))
+	if (!mutex_trylock(&cmd->lock)) {
+		nbd_config_put(nbd);
 		return BLK_EH_RESET_TIMER;
+	}
 
 	if (config->num_connections > 1) {
 		dev_err_ratelimited(nbd_to_dev(nbd),
-- 
2.20.1

