Return-Path: <SRS0=+SaT=EC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0500C55178
	for <linux-block@archiver.kernel.org>; Tue, 27 Oct 2020 00:17:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7ED1320754
	for <linux-block@archiver.kernel.org>; Tue, 27 Oct 2020 00:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603757879;
	bh=c11EneuP3V49NdoMUXc1xnuJywK1mgmMEIcfrSMuBjQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CUpN51Ddrhk0ZP9z+jb3HlxG0rSs2eDRZThHHWh7hMkTCOalupbd98qAPzu9Qmr8B
	 PYWrfKpPPu5/hrDfSv35L0svEJhruUbvG510I7bdtQ4WFHjHpNsGeCYsoUE61U5xFE
	 3w4ir0rUBqLyr7eKhnyfmH4Go3YBeWQRvZs/M1+k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440652AbgJ0AQq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Oct 2020 20:16:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:59686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2411566AbgJ0AKj (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Oct 2020 20:10:39 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 80F26218AC;
        Tue, 27 Oct 2020 00:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603757439;
        bh=c11EneuP3V49NdoMUXc1xnuJywK1mgmMEIcfrSMuBjQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NRIC8Y5f4bkSexXKCxis3PuplMu3UbbdfXNj7lIpn5h1D4CvEI53QtnZ5BVWbzdLA
         sdm1GimvSNna3WQ9qZ5QiecOecFdsvscrSSFWKPHz67cq7YhEkOY74GVOTtKYET5Jp
         X9NYXMXYoLQHpv+3od5Ah1qRBUuPv3PYLddJi4Qg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Xiubo Li <xiubli@redhat.com>, Josef Bacik <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        linux-block@vger.kernel.org, nbd@other.debian.org
Subject: [PATCH AUTOSEL 4.14 44/46] nbd: make the config put is called before the notifying the waiter
Date:   Mon, 26 Oct 2020 20:09:43 -0400
Message-Id: <20201027000946.1026923-44-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201027000946.1026923-1-sashal@kernel.org>
References: <20201027000946.1026923-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Xiubo Li <xiubli@redhat.com>

[ Upstream commit 87aac3a80af5cbad93e63250e8a1e19095ba0d30 ]

There has one race case for ceph's rbd-nbd tool. When do mapping
it may fail with EBUSY from ioctl(nbd, NBD_DO_IT), but actually
the nbd device has already unmaped.

It dues to if just after the wake_up(), the recv_work() is scheduled
out and defers calling the nbd_config_put(), though the map process
has exited the "nbd->recv_task" is not cleared.

Signed-off-by: Xiubo Li <xiubli@redhat.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/nbd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index f22fad977c913..cdf62fb94fb15 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -725,9 +725,9 @@ static void recv_work(struct work_struct *work)
 
 		blk_mq_complete_request(blk_mq_rq_from_pdu(cmd));
 	}
+	nbd_config_put(nbd);
 	atomic_dec(&config->recv_threads);
 	wake_up(&config->recv_wq);
-	nbd_config_put(nbd);
 	kfree(args);
 }
 
-- 
2.25.1

