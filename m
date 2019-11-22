Return-Path: <SRS0=+obT=ZO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7458BC43141
	for <linux-block@archiver.kernel.org>; Fri, 22 Nov 2019 19:50:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D58220731
	for <linux-block@archiver.kernel.org>; Fri, 22 Nov 2019 19:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574452242;
	bh=wJrUhHjk0rRXaMfnAyG5/ZYULXbzaf4QEAGrizRThD0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=I1buMSBtwPG8v8fS68EHQOrMdDur4FIZpxTZumByer4DXhOk2eCde8IXOOjR+c9Aw
	 PQzOKTiZW0+b//qeJm+nfEVakZVq+RL8PazQvxDPMHnmRxJU0qPRpRY08B3+xzSk8s
	 gJGn/TFqaMJ2UkJMOqV8O0vGQc4o6Ga502KlZZDE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727184AbfKVTul (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Nov 2019 14:50:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:51318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727850AbfKVTuY (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Nov 2019 14:50:24 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8AB702072E;
        Fri, 22 Nov 2019 19:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574452224;
        bh=wJrUhHjk0rRXaMfnAyG5/ZYULXbzaf4QEAGrizRThD0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yD7Jg2M1KR34Uj7jN4D63EwhvQz2+mv6M3WyCGa6q8niecNeUC3pMxtTj7GgZZCSN
         2mYHuhzoSQcuirNWutT52VIuiYIZIP2PCik9yWswavk4b/N1AC6FdmtLSMfhttEumJ
         q5czlfwzxpHyT7/vG3o8OhM6Mau49u8EWDjixJZ0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Chuhong Yuan <hslester96@gmail.com>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>, linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 8/9] rsxx: add missed destroy_workqueue calls in remove
Date:   Fri, 22 Nov 2019 14:50:13 -0500
Message-Id: <20191122195014.25065-8-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191122195014.25065-1-sashal@kernel.org>
References: <20191122195014.25065-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Chuhong Yuan <hslester96@gmail.com>

[ Upstream commit dcb77e4b274b8f13ac6482dfb09160cd2fae9a40 ]

The driver misses calling destroy_workqueue in remove like what is done
when probe fails.
Add the missed calls to fix it.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/rsxx/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/block/rsxx/core.c b/drivers/block/rsxx/core.c
index d8b2488aaade1..620a3a67cdd52 100644
--- a/drivers/block/rsxx/core.c
+++ b/drivers/block/rsxx/core.c
@@ -1028,8 +1028,10 @@ static void rsxx_pci_remove(struct pci_dev *dev)
 
 	cancel_work_sync(&card->event_work);
 
+	destroy_workqueue(card->event_wq);
 	rsxx_destroy_dev(card);
 	rsxx_dma_destroy(card);
+	destroy_workqueue(card->creg_ctrl.creg_wq);
 
 	spin_lock_irqsave(&card->irq_lock, flags);
 	rsxx_disable_ier_and_isr(card, CR_INTR_ALL);
-- 
2.20.1

