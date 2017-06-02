Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:38656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751478AbdFBVyp (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 2 Jun 2017 17:54:45 -0400
From: Shaohua Li <shli@kernel.org>
To: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Cc: tj@kernel.org, gregkh@linuxfoundation.org, hch@lst.de,
        axboe@fb.com, rostedt@goodmis.org, lizefan@huawei.com,
        Kernel-team@fb.com, Shaohua Li <shli@fb.com>
Subject: [PATCH 09/11] block: call __bio_free in bio_endio
Date: Fri,  2 Jun 2017 14:54:02 -0700
Message-Id: <3035a49cc29b237231fd77200e03c0dd93f2f780.1496432591.git.shli@fb.com>
In-Reply-To: <cover.1496432591.git.shli@fb.com>
References: <cover.1496432591.git.shli@fb.com>
In-Reply-To: <cover.1496432591.git.shli@fb.com>
References: <cover.1496432591.git.shli@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Shaohua Li <shli@fb.com>

bio_free isn't a good place to free cgroup/integrity info. There are a
lot of cases bio is allocated in special way (for example, in stack) and
never gets called by bio_put hence bio_free, we are leaking memory. This
patch moves the free to bio endio, which should be called anyway. The
__bio_free call in bio_free is kept, in case the bio never gets called
bio endio.

Signed-off-by: Shaohua Li <shli@fb.com>
---
 block/bio-integrity.c | 1 +
 block/bio.c           | 1 +
 2 files changed, 2 insertions(+)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index 5384713..c6c5aed 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -120,6 +120,7 @@ void bio_integrity_free(struct bio *bio)
 	}
 
 	bio->bi_integrity = NULL;
+	bio->bi_opf &= ~REQ_INTEGRITY;
 }
 EXPORT_SYMBOL(bio_integrity_free);
 
diff --git a/block/bio.c b/block/bio.c
index 888e780..02556b3 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1803,6 +1803,7 @@ void bio_endio(struct bio *bio)
 	if (!bio_remaining_done(bio))
 		return;
 
+	__bio_free(bio);
 	/*
 	 * Need to have a real endio function for chained bios, otherwise
 	 * various corner cases will break (like stacking block devices that
-- 
2.9.3
