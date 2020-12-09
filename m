Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 579C4C4167B
	for <linux-block@archiver.kernel.org>; Wed,  9 Dec 2020 13:09:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12E4D23BDF
	for <linux-block@archiver.kernel.org>; Wed,  9 Dec 2020 13:09:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731975AbgLINJR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Dec 2020 08:09:17 -0500
Received: from mx4.veeam.com ([104.41.138.86]:33946 "EHLO mx4.veeam.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731898AbgLINJC (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 9 Dec 2020 08:09:02 -0500
Received: from mail.veeam.com (prgmbx01.amust.local [172.24.0.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx4.veeam.com (Postfix) with ESMTPS id 3DC1EB9A70;
        Wed,  9 Dec 2020 16:01:51 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=veeam.com; s=mx4;
        t=1607518911; bh=0VJVTYnwywkBKk78AS5Fzh0t8RXgLPu9+5VtBk69i48=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=V+FoJBufCIi0qZlI0GhB6OJyIcYg5CmDMYCn6F6kR+4IE0gE0r+nRjT9krg1qGGBr
         xt5kZUEF6GLBvzba5maQ3J8RA7NJxgMTFlIn1JZSaY+mIaqeWVe0+tvmOVw2x5Q/D+
         zadgfM9C3J7rGm9TaxRKzgYzzIC+QS8hlVjtp3tc=
Received: from prgdevlinuxpatch01.amust.local (172.24.14.5) by
 prgmbx01.amust.local (172.24.0.171) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.721.2;
 Wed, 9 Dec 2020 14:01:50 +0100
From:   Sergei Shtepa <sergei.shtepa@veeam.com>
To:     <axboe@kernel.dk>, <johannes.thumshirn@wdc.com>,
        <koct9i@gmail.com>, <ming.lei@redhat.com>, <snitzer@redhat.com>,
        <hare@suse.de>, <josef@toxicpanda.com>, <steve@sk2.org>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <pavel.tide@veeam.com>, <sergei.shtepa@veeam.com>
Subject: [PATCH 3/3] block: blk_interposer - sample config
Date:   Wed, 9 Dec 2020 16:01:51 +0300
Message-ID: <1607518911-30692-4-git-send-email-sergei.shtepa@veeam.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1607518911-30692-1-git-send-email-sergei.shtepa@veeam.com>
References: <1607518911-30692-1-git-send-email-sergei.shtepa@veeam.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.24.14.5]
X-ClientProxiedBy: prgmbx02.amust.local (172.24.0.172) To prgmbx01.amust.local
 (172.24.0.171)
X-EsetResult: clean, is OK
X-EsetId: 37303A29C604D26A627160
X-Veeam-MMEX: True
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Attaches the blk_interposer sample to the kernel assembly.

Signed-off-by: Sergei Shtepa <sergei.shtepa@veeam.com>
---
 samples/Kconfig  | 7 +++++++
 samples/Makefile | 1 +
 2 files changed, 8 insertions(+)

diff --git a/samples/Kconfig b/samples/Kconfig
index 0ed6e4d71d87..72e2a9399e10 100644
--- a/samples/Kconfig
+++ b/samples/Kconfig
@@ -216,4 +216,11 @@ config SAMPLE_WATCH_QUEUE
 	  Build example userspace program to use the new mount_notify(),
 	  sb_notify() syscalls and the KEYCTL_WATCH_KEY keyctl() function.
 
+config SAMPLE_BLK_INTERPOSER
+	tristate "Builds the sample block layer interposer -- loadable module only"
+	depends on m
+	help
+	  Builds the sample block layer interposer kernel module to illustrate
+	  the use of blk_interposer feature.
+
 endif # SAMPLES
diff --git a/samples/Makefile b/samples/Makefile
index c3392a595e4b..953082c17249 100644
--- a/samples/Makefile
+++ b/samples/Makefile
@@ -29,3 +29,4 @@ obj-$(CONFIG_SAMPLE_INTEL_MEI)		+= mei/
 subdir-$(CONFIG_SAMPLE_WATCHDOG)	+= watchdog
 subdir-$(CONFIG_SAMPLE_WATCH_QUEUE)	+= watch_queue
 obj-$(CONFIG_DEBUG_KMEMLEAK_TEST)	+= kmemleak/
+obj-$(CONFIG_SAMPLE_BLK_INTERPOSER)	+= blk_interposer/
-- 
2.20.1

