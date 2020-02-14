Return-Path: <SRS0=urI+=4C=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94A4CC2BA83
	for <linux-block@archiver.kernel.org>; Fri, 14 Feb 2020 15:51:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 609B524684
	for <linux-block@archiver.kernel.org>; Fri, 14 Feb 2020 15:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581695494;
	bh=3IvopkT27FOsq+8sijVVp9M6p5tv3XeeY25VMCYj45M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jioQUlz02EghWaKJZlJf0yCRH7JDk6mbD6qtBbQgIz1ITwcmmPeQ2UGaana8k94RP
	 YgW4OerHIBYkFVXzKJq87jPkFNH3SJVJAyBVYs9Gm9R6DyOdzSjCRnrOTk6LCYnQlg
	 D8jHD4zfX5mJInag5IOA7y9xYXmK/gCW3gpgaCUw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730800AbgBNPvd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 14 Feb 2020 10:51:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:56600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729475AbgBNPvc (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Feb 2020 10:51:32 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8F02E2168B;
        Fri, 14 Feb 2020 15:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581695492;
        bh=3IvopkT27FOsq+8sijVVp9M6p5tv3XeeY25VMCYj45M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b7N866QrqQhcnRKzCjYfVZCZo+lB9vPBKfoL8I7VpdU8vKFFmzGBmymXlw6z95l0B
         YJU2lK7tiP9mrMLxB2xKdEZXxnbLxbW1XjZ3E0AwjKRlMv4whD9s11CVqBwBshwacb
         zzwH3Obhyo3Ysq0XTLxCkHxRfz8eUaFF4+houn+s=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sun Ke <sunke32@huawei.com>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>, linux-block@vger.kernel.org,
        nbd@other.debian.org
Subject: [PATCH AUTOSEL 5.5 121/542] nbd: add a flush_workqueue in nbd_start_device
Date:   Fri, 14 Feb 2020 10:41:53 -0500
Message-Id: <20200214154854.6746-121-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214154854.6746-1-sashal@kernel.org>
References: <20200214154854.6746-1-sashal@kernel.org>
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
index b4607dd961852..78181908f0df6 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1265,6 +1265,16 @@ static int nbd_start_device(struct nbd_device *nbd)
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

