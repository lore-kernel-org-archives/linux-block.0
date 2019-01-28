Return-Path: <SRS0=89dG=QE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C030C282C8
	for <linux-block@archiver.kernel.org>; Mon, 28 Jan 2019 17:41:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FC892147A
	for <linux-block@archiver.kernel.org>; Mon, 28 Jan 2019 17:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548697275;
	bh=uGJnd4aanS4tvcAHWK+ahsiMQtVsc9lMcOjYVHuXS/Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ruT0qyPkSxl6nqkZJZG1Fi9bJRGV88cU/SRrJzJukiiusgXQjp+SWaX5ioqyEfC12
	 UohtYv5gjHn4zYtEhSgR+xSc+Q6hQMqQFVFUdYZnatPcyzxlfG6Gb733UZyiMR+S2l
	 YaG7iyN5QUPccGt3zM9oCceMuncc04LaeJFPr9pY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726919AbfA1Pve (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Jan 2019 10:51:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:38180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728419AbfA1Pvc (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Jan 2019 10:51:32 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C953F21741;
        Mon, 28 Jan 2019 15:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548690692;
        bh=uGJnd4aanS4tvcAHWK+ahsiMQtVsc9lMcOjYVHuXS/Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rAHZ4vMrOIZnlxmqM39zN3AvGDiSIKI+1x/Yb/6FRmCTBaGx5vxb6wk8wwYOyLBJ0
         ayrz+C4X0xJhL54KpWlI6wMueGrgfxLhK31qLO7VRRtsE+5+fSdcgT/yZ2CY4b+g+Y
         LiuDMPV7Ba33oirZM+M+C36Lr0lyXl3mESpdgmJs=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hua Su <suhua.tanke@gmail.com>,
        =?UTF-8?q?Matias=20Bj=C3=B8rling?= <mb@lightnvm.io>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 165/304] lightnvm: pblk: add lock protection to list operations
Date:   Mon, 28 Jan 2019 10:41:22 -0500
Message-Id: <20190128154341.47195-165-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128154341.47195-1-sashal@kernel.org>
References: <20190128154341.47195-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Hua Su <suhua.tanke@gmail.com>

[ Upstream commit fde201a466c6ad5efd72cb54fdf2cefa8b6c6ad7 ]

Protect the list_add on the pblk_line_init_bb() error
path in case this code is used for some other purpose
in the future.

Signed-off-by: Hua Su <suhua.tanke@gmail.com>
Reviewed-by: Javier González <javier@cnexlabs.com>
Signed-off-by: Matias Bjørling <mb@lightnvm.io>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/lightnvm/pblk-core.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index 6944aac43b01..247112e1db94 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -1295,15 +1295,22 @@ int pblk_line_recov_alloc(struct pblk *pblk, struct pblk_line *line)
 
 	ret = pblk_line_alloc_bitmaps(pblk, line);
 	if (ret)
-		return ret;
+		goto fail;
 
 	if (!pblk_line_init_bb(pblk, line, 0)) {
-		list_add(&line->list, &l_mg->free_list);
-		return -EINTR;
+		ret = -EINTR;
+		goto fail;
 	}
 
 	pblk_rl_free_lines_dec(&pblk->rl, line, true);
 	return 0;
+
+fail:
+	spin_lock(&l_mg->free_lock);
+	list_add(&line->list, &l_mg->free_list);
+	spin_unlock(&l_mg->free_lock);
+
+	return ret;
 }
 
 void pblk_line_recov_close(struct pblk *pblk, struct pblk_line *line)
-- 
2.19.1

