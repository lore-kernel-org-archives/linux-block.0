Return-Path: <SRS0=89dG=QE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 974FEC282C8
	for <linux-block@archiver.kernel.org>; Mon, 28 Jan 2019 17:02:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 672BF2175B
	for <linux-block@archiver.kernel.org>; Mon, 28 Jan 2019 17:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548694977;
	bh=uXlKz46DVC94iM1WuhpC5ObdCWuBjQtPeWi1r4OfR3g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xslKmrhTK0FiYwKadEJYbmM1qO2tmchrb/W1TzzB44DAOKDPME7xprwS0VAVbbExw
	 tHr1l4IRI8H3UHVLrxFRKfUW5LcroHxwy3DfGqZgmkUbwWN8po3QeGHPXeRnPg1aFE
	 /YeHuIMRvxW0FvlO4Wrk6rBwISeD9YC+JMcgPaEg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733216AbfA1RCu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Jan 2019 12:02:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:43246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387564AbfA1QOG (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Jan 2019 11:14:06 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5057920855;
        Mon, 28 Jan 2019 16:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548692045;
        bh=uXlKz46DVC94iM1WuhpC5ObdCWuBjQtPeWi1r4OfR3g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Pd/VN9xVJRTjxbovmowHptiH/D5y0q5UXjB20306hOLejXVSQ9KVK2xd3mGR6xLrb
         Vk3D0P4aTGeWp+wtpCM2sl4rZM0WEwGIGDpUTMni5g8fgVptUGe7rWX1eUPBn825qS
         I/QdUpyYP1SaPG+BNuwj1hVQbpkwWShnaTbolAsc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Young Xiao <YangX92@hotmail.com>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>, linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 051/170] sunvdc: Do not spin in an infinite loop when vio_ldc_send() returns EAGAIN
Date:   Mon, 28 Jan 2019 11:10:01 -0500
Message-Id: <20190128161200.55107-51-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128161200.55107-1-sashal@kernel.org>
References: <20190128161200.55107-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Young Xiao <YangX92@hotmail.com>

[ Upstream commit a11f6ca9aef989b56cd31ff4ee2af4fb31a172ec ]

__vdc_tx_trigger should only loop on EAGAIN a finite
number of times.

See commit adddc32d6fde ("sunvnet: Do not spin in an
infinite loop when vio_ldc_send() returns EAGAIN") for detail.

Signed-off-by: Young Xiao <YangX92@hotmail.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/sunvdc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/block/sunvdc.c b/drivers/block/sunvdc.c
index ad9749463d4f..ed4d6276e94f 100644
--- a/drivers/block/sunvdc.c
+++ b/drivers/block/sunvdc.c
@@ -41,6 +41,8 @@ MODULE_VERSION(DRV_MODULE_VERSION);
 #define WAITING_FOR_GEN_CMD	0x04
 #define WAITING_FOR_ANY		-1
 
+#define	VDC_MAX_RETRIES	10
+
 static struct workqueue_struct *sunvdc_wq;
 
 struct vdc_req_entry {
@@ -427,6 +429,7 @@ static int __vdc_tx_trigger(struct vdc_port *port)
 		.end_idx		= dr->prod,
 	};
 	int err, delay;
+	int retries = 0;
 
 	hdr.seq = dr->snd_nxt;
 	delay = 1;
@@ -439,6 +442,8 @@ static int __vdc_tx_trigger(struct vdc_port *port)
 		udelay(delay);
 		if ((delay <<= 1) > 128)
 			delay = 128;
+		if (retries++ > VDC_MAX_RETRIES)
+			break;
 	} while (err == -EAGAIN);
 
 	if (err == -ENOTCONN)
-- 
2.19.1

