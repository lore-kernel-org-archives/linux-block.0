Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0A7EC77B7E
	for <linux-block@archiver.kernel.org>; Thu,  1 Jun 2023 15:17:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234789AbjFAPRW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 1 Jun 2023 11:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234971AbjFAPRE (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 1 Jun 2023 11:17:04 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2187A19D
        for <linux-block@vger.kernel.org>; Thu,  1 Jun 2023 08:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=lbZQIxtGvltk6tGm6fkQPEmgkJpyIOCCgi68KnMoOH4=; b=2y6yZeRsKHU3GjW/XNCM8RaEeg
        hLgsqrOyHGCTEVNhLxz0wtBy7ghWlgU+YJiIOeSU1wvlz8uVlVdlj9afP8V1VEmnN06vaCg3c6CWb
        N0k8yP5mnRKAfQOEv/D4zS0cYxJ0t8e8deTaYuUAgCYyIfgNgQTMsqtOVxFbAgdxObGR3JhTLFHNI
        rTmBcHne2w6jmbBgj42l9FrDhe9GUDSZdp/k08FnyF+jIV3gjBS1TPQYKfsAVNsDWLE5H7hIBr1Np
        /RqOLpPb672mg0kz6VsHEwq8dOXfID9Gxcy55f1PViwkAJStNGIRDcvhrJjNpoN+fjBGP2/JE2PoG
        7pyjgd1g==;
Received: from [2001:4bb8:182:6d06:eacb:c751:971:73eb] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q4k2i-003zin-1n;
        Thu, 01 Jun 2023 15:16:48 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
        christoph.boehmwalder@linbit.com
Cc:     drbd-dev@lists.linbit.com, linux-block@vger.kernel.org,
        axboe@kernel.dk
Subject: [PATCH] drbd: stop defining __KERNEL_SYSCALLS__
Date:   Thu,  1 Jun 2023 17:16:46 +0200
Message-Id: <20230601151646.1386867-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

__KERNEL_SYSCALLS__ hasn't been needed since Linux 2.6.19 so stop
defining it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/drbd/drbd_main.c     | 1 -
 drivers/block/drbd/drbd_receiver.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
index 83987e7a5ef275..54223f64610a05 100644
--- a/drivers/block/drbd/drbd_main.c
+++ b/drivers/block/drbd/drbd_main.c
@@ -37,7 +37,6 @@
 #include <linux/notifier.h>
 #include <linux/kthread.h>
 #include <linux/workqueue.h>
-#define __KERNEL_SYSCALLS__
 #include <linux/unistd.h>
 #include <linux/vmalloc.h>
 #include <linux/sched/signal.h>
diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 8c2bc47de4735e..0c9f54197768d6 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -27,7 +27,6 @@
 #include <uapi/linux/sched/types.h>
 #include <linux/sched/signal.h>
 #include <linux/pkt_sched.h>
-#define __KERNEL_SYSCALLS__
 #include <linux/unistd.h>
 #include <linux/vmalloc.h>
 #include <linux/random.h>
-- 
2.39.2

