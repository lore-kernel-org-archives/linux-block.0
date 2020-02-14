Return-Path: <SRS0=urI+=4C=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0533AC3B1A6
	for <linux-block@archiver.kernel.org>; Fri, 14 Feb 2020 17:13:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C98C724649
	for <linux-block@archiver.kernel.org>; Fri, 14 Feb 2020 17:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581700403;
	bh=sgwlTZtHceOcXQlBCBMlRKJUHnRjwhhrQxZY8HOsp7I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PvpWY/Q7SBUpoQWzPjZvgLsL4foW48nu7rP4iZE9ePeEIel8siE77vmC3OHGh9lq7
	 eFyBxciEv4coDWhahBGlGwyxlnVLking+PRwtyRkvRY75jr9vJVdfT3/VIVTK4ENt5
	 uosaQomLyKtCwZRAl81fVaVsLnwhGh7SkGQCJMas=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391687AbgBNRNS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 14 Feb 2020 12:13:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:40682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403794AbgBNQMw (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Feb 2020 11:12:52 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7AC80246A1;
        Fri, 14 Feb 2020 16:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581696772;
        bh=sgwlTZtHceOcXQlBCBMlRKJUHnRjwhhrQxZY8HOsp7I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0MuvGpfvGcxxNRBc4GHEmXp7TFr83xOhs66f19Zvs1BqQ7cNoxxOSmdqngb7wC77x
         G+a8XBBJqbyM/IVkkTbsTBRYPDauDPTOIoQb8lXz+KtfMwyZ3u03o5k3UTxH82JgzZ
         v6LBh3VTNjslwmpHjkWM+iLe1U63ZORSqjgYtEhs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sun Ke <sunke32@huawei.com>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>, linux-block@vger.kernel.org,
        nbd@other.debian.org
Subject: [PATCH AUTOSEL 4.19 050/252] nbd: add a flush_workqueue in nbd_start_device
Date:   Fri, 14 Feb 2020 11:08:25 -0500
Message-Id: <20200214161147.15842-50-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214161147.15842-1-sashal@kernel.org>
References: <20200214161147.15842-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Sun Ke <sunke32@huawei.com>

[ Upstream commit 5c0dd228b5fc30a3b732c7ae2657e0161ec7ed80 ]

When kzalloc fail, may cause trying to destroy the
workqueue from inside the workqueue.

If num_connections is m (2 < m), and NO.1 ~ NO.n
(1 < n < m) kzalloc are successful. The NO.(n + 1)
failed. Then, nbd_start_device will return ENOMEM
to nbd_start_device_ioctl, and nbd_start_device_ioctl
will return immediately without running flush_workqueue.
However, we still have n recv threads. If nbd_release
run first, recv threads may have to drop the last
config_refs and try to destroy the workqueue from
inside the workqueue.

To fix it, add a flush_workqueue in nbd_start_device.

Fixes: e9e006f5fcf2 ("nbd: fix max number of supported devs")
Signed-off-by: Sun Ke <sunke32@huawei.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/nbd.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index b9d321bdaa8a7..226103af30f05 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1216,6 +1216,16 @@ static int nbd_start_device(struct nbd_device *nbd)
 		args = kzalloc(sizeof(*args), GFP_KERNEL);
 		if (!args) {
 			sock_shutdown(nbd);
+			/*
+			 * If num_connections is m (2 < m),
+			 * and NO.1 ~ NO.n(1 < n < m) kzallocs are successful.
+			 * But NO.(n + 1) failed. We still have n recv threads.
+			 * So, add flush_workqueue here to prevent recv threads
+			 * dropping the last config_refs and trying to destroy
+			 * the workqueue from inside the workqueue.
+			 */
+			if (i)
+				flush_workqueue(nbd->recv_workq);
 			return -ENOMEM;
 		}
 		sk_set_memalloc(config->socks[i]->sock->sk);
-- 
2.20.1

