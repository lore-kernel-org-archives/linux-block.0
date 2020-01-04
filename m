Return-Path: <SRS0=MEbK=2Z=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E708FC2D0C2
	for <linux-block@archiver.kernel.org>; Sat,  4 Jan 2020 16:24:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B335024654
	for <linux-block@archiver.kernel.org>; Sat,  4 Jan 2020 16:24:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="kC0TUgMw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726083AbgADQYW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 4 Jan 2020 11:24:22 -0500
Received: from rere.qmqm.pl ([91.227.64.183]:23893 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726016AbgADQYW (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 4 Jan 2020 11:24:22 -0500
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 47qnCl6JwHzGW;
        Sat,  4 Jan 2020 17:24:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1578155060; bh=0Ibkxtl3RMglzBvk5sTiwiF51FZCh2BbOtGA/FEpe/c=;
        h=Date:From:Subject:To:Cc:From;
        b=kC0TUgMw/wFF8OMRJHdIQDOzxU0Deg6UcNU+t2n5gu2+Tvt1SCZj8JiCf4/vlJBFF
         Dfwso0e+m7V+BtPchWNrdkLy/kIw8rQhYWZfOndKrMrhLpgVxGs3c89pYzVMXUCfAt
         woux21TrLbT5eLVKdzg7RALch83A19Z/PtZFctldisDme8/HOaOOdHsR+/MJqNFpM7
         Y726YMMgtnBrJKCsUsKby6mjTJqIjz3fsTP2gB3+Gd9+0+PO/6xrml2K9F7l6UBy3E
         O8jpOK8/U332q0NprBRcqxnq8bDnrO8yxyPjrFkrM4S5CitLYdqfRfjgjKsseIpktP
         iY+k/9v6W2CNg==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.101.4 at mail
Date:   Sat, 04 Jan 2020 17:24:18 +0100
Message-Id: <6e542430795eeddb718db88cb08224d2e1bc6b4b.1578154967.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH 1/2] block: parse cmdline partitions first
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Make sure cmdline-provided partitions override anything that is
on the disk.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 block/partitions/check.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/block/partitions/check.c b/block/partitions/check.c
index ffe408fead0c..f0b6454b7767 100644
--- a/block/partitions/check.c
+++ b/block/partitions/check.c
@@ -40,6 +40,13 @@
 int warn_no_part = 1; /*This is ugly: should make genhd removable media aware*/
 
 static int (*check_part[])(struct parsed_partitions *) = {
+	/*
+	 * Let cmdline override whatever there is on disk.
+	 */
+#ifdef CONFIG_CMDLINE_PARTITION
+	cmdline_partition,
+#endif
+
 	/*
 	 * Probe partition formats with tables at disk address 0
 	 * that also have an ADFS boot block at 0xdc0.
@@ -67,9 +74,6 @@ static int (*check_part[])(struct parsed_partitions *) = {
 	adfspart_check_ADFS,
 #endif
 
-#ifdef CONFIG_CMDLINE_PARTITION
-	cmdline_partition,
-#endif
 #ifdef CONFIG_EFI_PARTITION
 	efi_partition,		/* this must come before msdos */
 #endif
-- 
2.20.1

