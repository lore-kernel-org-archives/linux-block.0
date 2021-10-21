Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D48C4C433EF
	for <linux-block@archiver.kernel.org>; Thu, 21 Oct 2021 22:51:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B22EA61359
	for <linux-block@archiver.kernel.org>; Thu, 21 Oct 2021 22:51:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbhJUWxm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Oct 2021 18:53:42 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:57374 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229567AbhJUWxl (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Oct 2021 18:53:41 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4Hb2lb3tbrz5Y;
        Fri, 22 Oct 2021 00:51:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1634856684; bh=lHHnRAA8YLV9uPJ7CrD5WKHXnh3ph4RCyZ2dlYvGX+0=;
        h=Date:From:Subject:To:Cc:From;
        b=m7le8OCLrkH6rybhlZq/HqAvBjFNaosEB2GQ6A4ljIgcX2emA0CUoBa+cIPaz/rMf
         AhPUyHbxvPW1bZUGg4UK3JjtRZtcc0iwanowHISBp9kFUHk5cjPqGdRldzc+JAIeqM
         Uqm91y41Xj6nu0kehiHKz09q26LWCYrVvIO2/lWZrDWIR84DX4J5yk968HrZI6Eka5
         3grcJEib0cbEi7Tcccfs0shUFktMCT5B2Q+RKrtoLt0PqaGEpJ2ePdaNffq0Z9AuIH
         lLR5Bs25g7JhFs4kEEaS/jg4838r47CnFRoggiIJopvR2DBOf5pVVgRKryqq5YkDUG
         X9aplhRG3AjFQ==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.103.3 at mail
Date:   Fri, 22 Oct 2021 00:51:23 +0200
Message-Id: <8a6b11c6ada5d55bdb2b1f8319e47bbf5192654b.1634856658.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH 1/2] block: parse cmdline partitions first
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>
Cc:     linux-block@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Make sure cmdline-provided partitions can override anything that's
on a storage device.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 block/partitions/core.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/block/partitions/core.c b/block/partitions/core.c
index 66ef9bc6d6a1..b4dac3077dce 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -15,6 +15,13 @@
 #include "check.h"
 
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
@@ -42,9 +49,6 @@ static int (*check_part[])(struct parsed_partitions *) = {
 	adfspart_check_ADFS,
 #endif
 
-#ifdef CONFIG_CMDLINE_PARTITION
-	cmdline_partition,
-#endif
 #ifdef CONFIG_EFI_PARTITION
 	efi_partition,		/* this must come before msdos */
 #endif
-- 
2.30.2

