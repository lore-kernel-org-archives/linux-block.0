Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D63DC433EF
	for <linux-block@archiver.kernel.org>; Mon, 20 Sep 2021 12:35:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59B8460F50
	for <linux-block@archiver.kernel.org>; Mon, 20 Sep 2021 12:35:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234949AbhITMhI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Sep 2021 08:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233716AbhITMhI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Sep 2021 08:37:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66414C061760
        for <linux-block@vger.kernel.org>; Mon, 20 Sep 2021 05:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Eb5KEJ3m5v7x/riVemBim8ZrH03YEazos7dGkC4ngSY=; b=KbnP8nPXDu1zbXx+PfwkH/PeNW
        tNEPfluFXA7kQN17WJaaYRAxgYNQFKebhuGxaSwPae3Q4aFf5NaVvj4bX2eGmHlPJAtyXKTZsnmVT
        eAMyHoT2VUCLyJclXpGD/TJMNAcDkR5aEYSO8j+Y2do8raO89rgwBHluEtiFExMQvsIQrLTiG5TC9
        /lTcNWkOWTw02bd5QQrxbcRaLPN61DjDadP6HwToHtheqTUXmDbNPwjp9G9trOkSvwheihgqZ3kyy
        pqRsn6igwwVndC+xGFZEEy8jqBLXIGFz2/3NucfSBtwkmvC0Nwd70ycvXQ11VTHZFyLrEdSx2JWWG
        9XMAw3Og==;
Received: from [2001:4bb8:184:72db:7ad9:14d9:8599:3025] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mSIVv-002eyK-SE; Mon, 20 Sep 2021 12:35:22 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-mm@kvack.org,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH 04/17] mm: remove spurious blkdev.h includes
Date:   Mon, 20 Sep 2021 14:33:15 +0200
Message-Id: <20210920123328.1399408-5-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210920123328.1399408-1-hch@lst.de>
References: <20210920123328.1399408-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Various files have acquired spurious includes of <linux/blkdev.h> over
time.  Remove them.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 mm/filemap.c   | 1 -
 mm/highmem.c   | 1 -
 mm/mempool.c   | 1 -
 mm/nommu.c     | 1 -
 mm/readahead.c | 1 -
 mm/shmem.c     | 1 -
 6 files changed, 6 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index dae481293b5d9..44b4b551e430f 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -30,7 +30,6 @@
 #include <linux/writeback.h>
 #include <linux/backing-dev.h>
 #include <linux/pagevec.h>
-#include <linux/blkdev.h>
 #include <linux/security.h>
 #include <linux/cpuset.h>
 #include <linux/hugetlb.h>
diff --git a/mm/highmem.c b/mm/highmem.c
index 4212ad0e4a195..471d9779a7f47 100644
--- a/mm/highmem.c
+++ b/mm/highmem.c
@@ -23,7 +23,6 @@
 #include <linux/bio.h>
 #include <linux/pagemap.h>
 #include <linux/mempool.h>
-#include <linux/blkdev.h>
 #include <linux/init.h>
 #include <linux/hash.h>
 #include <linux/highmem.h>
diff --git a/mm/mempool.c b/mm/mempool.c
index 0b8afbec3e358..b933d0fc21b8b 100644
--- a/mm/mempool.c
+++ b/mm/mempool.c
@@ -17,7 +17,6 @@
 #include <linux/kmemleak.h>
 #include <linux/export.h>
 #include <linux/mempool.h>
-#include <linux/blkdev.h>
 #include <linux/writeback.h>
 #include "slab.h"
 
diff --git a/mm/nommu.c b/mm/nommu.c
index 02d2427b8f9e8..41ef204e74820 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -27,7 +27,6 @@
 #include <linux/pagemap.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
-#include <linux/blkdev.h>
 #include <linux/backing-dev.h>
 #include <linux/compiler.h>
 #include <linux/mount.h>
diff --git a/mm/readahead.c b/mm/readahead.c
index 41b75d76d36e1..e71e719e36c90 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -12,7 +12,6 @@
 #include <linux/dax.h>
 #include <linux/gfp.h>
 #include <linux/export.h>
-#include <linux/blkdev.h>
 #include <linux/backing-dev.h>
 #include <linux/task_io_accounting_ops.h>
 #include <linux/pagevec.h>
diff --git a/mm/shmem.c b/mm/shmem.c
index 88742953532cc..b9d22ab32a770 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -59,7 +59,6 @@ static struct vfsmount *shm_mnt;
 #include <linux/backing-dev.h>
 #include <linux/shmem_fs.h>
 #include <linux/writeback.h>
-#include <linux/blkdev.h>
 #include <linux/pagevec.h>
 #include <linux/percpu_counter.h>
 #include <linux/falloc.h>
-- 
2.30.2

