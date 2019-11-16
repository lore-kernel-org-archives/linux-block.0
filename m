Return-Path: <SRS0=wO3m=ZI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29E8EC432C3
	for <linux-block@archiver.kernel.org>; Sat, 16 Nov 2019 16:14:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0231F214DE
	for <linux-block@archiver.kernel.org>; Sat, 16 Nov 2019 16:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573920878;
	bh=E2ZUTU5HCdCqmIb+dDMKUbL0XKlBuy6jI6sjlPvGW1I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=O+IbjoRttCMph46FF4BuFMsmbQRsnzcYtRISA3W7i0603slyc4dBBuzv2WNoG4xkG
	 XpG5UnWYYuZMExs5b+TYtDVoL74+AH+RM9DgT7OUKXp8tQfFjROplq1e/KiLNOhWLf
	 DryfLqZh1dNo0IDvBMuoL3L3cEkp2oP02LWUue2M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730001AbfKPQOg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 16 Nov 2019 11:14:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:54448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728971AbfKPPrm (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 16 Nov 2019 10:47:42 -0500
Received: from sasha-vm.mshome.net (unknown [50.234.116.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D16D12086A;
        Sat, 16 Nov 2019 15:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573919262;
        bh=E2ZUTU5HCdCqmIb+dDMKUbL0XKlBuy6jI6sjlPvGW1I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z8HRnp8fzfUJd03rIyjBmyYIRevvxwosSi0mK8hYoiHSvJ9wrjug0Gz0oMesyECeI
         ME6mqaBrlT3jWz6y5o+iDn7ZCIyc1VZHTFd5sUHmHH6yhfT+sy0qr56tcBo5a+TMZG
         aIAFMRdG25yFU/F/IYSApwt1ZGXrGrF5cgLLUx6s=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 012/150] skd: fixup usage of legacy IO API
Date:   Sat, 16 Nov 2019 10:45:10 -0500
Message-Id: <20191116154729.9573-12-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191116154729.9573-1-sashal@kernel.org>
References: <20191116154729.9573-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Jens Axboe <axboe@kernel.dk>

[ Upstream commit 6d1f9dfde7343c4ebfb8f84dcb333af571bb3b22 ]

We need to be using the mq variant of request requeue here.

Fixes: ca33dd92968b ("skd: Convert to blk-mq")
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/skd_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/skd_main.c b/drivers/block/skd_main.c
index 64d0fc17c1742..95649025cde77 100644
--- a/drivers/block/skd_main.c
+++ b/drivers/block/skd_main.c
@@ -1417,7 +1417,7 @@ static void skd_resolve_req_exception(struct skd_device *skdev,
 
 	case SKD_CHECK_STATUS_BUSY_IMMINENT:
 		skd_log_skreq(skdev, skreq, "retry(busy)");
-		blk_requeue_request(skdev->queue, req);
+		blk_mq_requeue_request(req, true);
 		dev_info(&skdev->pdev->dev, "drive BUSY imminent\n");
 		skdev->state = SKD_DRVR_STATE_BUSY_IMMINENT;
 		skdev->timer_countdown = SKD_TIMER_MINUTES(20);
@@ -1427,7 +1427,7 @@ static void skd_resolve_req_exception(struct skd_device *skdev,
 	case SKD_CHECK_STATUS_REQUEUE_REQUEST:
 		if ((unsigned long) ++req->special < SKD_MAX_RETRIES) {
 			skd_log_skreq(skdev, skreq, "retry");
-			blk_requeue_request(skdev->queue, req);
+			blk_mq_requeue_request(req, true);
 			break;
 		}
 		/* fall through */
-- 
2.20.1

