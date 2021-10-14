Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9173AC4332F
	for <linux-block@archiver.kernel.org>; Thu, 14 Oct 2021 18:07:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79F0361166
	for <linux-block@archiver.kernel.org>; Thu, 14 Oct 2021 18:07:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233884AbhJNSKD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Oct 2021 14:10:03 -0400
Received: from smtp02.smtpout.orange.fr ([80.12.242.124]:57185 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233870AbhJNSJ7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Oct 2021 14:09:59 -0400
Received: from pop-os.home ([92.140.161.106])
        by smtp.orange.fr with ESMTPA
        id b58xmB1SVBazob58xmY4d7; Thu, 14 Oct 2021 20:07:52 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Thu, 14 Oct 2021 20:07:52 +0200
X-ME-IP: 92.140.161.106
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     axboe@kernel.dk, liushixin2@huawei.com, bhelgaas@google.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] mtip32xx: Remove redundant 'flush_workqueue()' calls
Date:   Thu, 14 Oct 2021 20:07:50 +0200
Message-Id: <0fea349c808c6cfbf549b0e33701320c7860c8b7.1634234221.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

'destroy_workqueue()' already drains the queue before destroying it, so
there is no need to flush it explicitly.

Remove the redundant 'flush_workqueue()' calls.

This was generated with coccinelle:

@@
expression E;
@@
- 	flush_workqueue(E);
	destroy_workqueue(E);

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/block/mtip32xx/mtip32xx.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/mtip32xx.c
index d0b40309f47e..c91b9010c1a6 100644
--- a/drivers/block/mtip32xx/mtip32xx.c
+++ b/drivers/block/mtip32xx/mtip32xx.c
@@ -4063,7 +4063,6 @@ static int mtip_pci_probe(struct pci_dev *pdev,
 
 msi_initialize_err:
 	if (dd->isr_workq) {
-		flush_workqueue(dd->isr_workq);
 		destroy_workqueue(dd->isr_workq);
 		drop_cpu(dd->work[0].cpu_binding);
 		drop_cpu(dd->work[1].cpu_binding);
@@ -4121,7 +4120,6 @@ static void mtip_pci_remove(struct pci_dev *pdev)
 	mtip_block_remove(dd);
 
 	if (dd->isr_workq) {
-		flush_workqueue(dd->isr_workq);
 		destroy_workqueue(dd->isr_workq);
 		drop_cpu(dd->work[0].cpu_binding);
 		drop_cpu(dd->work[1].cpu_binding);
-- 
2.30.2

