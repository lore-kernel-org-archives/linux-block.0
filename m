Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:39220 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727237AbeHIJIq (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 9 Aug 2018 05:08:46 -0400
From: Coly Li <colyli@suse.de>
To: linux-bcache@vger.kernel.org
Cc: linux-block@vger.kernel.org, Coly Li <colyli@suse.de>
Subject: [PATCH 13/17] bcache: add static const prefix to char * array declarations
Date: Thu,  9 Aug 2018 14:43:16 +0800
Message-Id: <20180809064320.10229-14-colyli@suse.de>
In-Reply-To: <20180809064320.10229-1-colyli@suse.de>
References: <20180809064320.10229-1-colyli@suse.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

This patch declares char * array with const prefix in sysfs.c,
which is suggested by checkpatch.pl.

Signed-off-by: Coly Li <colyli@suse.de>
---
 drivers/md/bcache/sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/bcache/sysfs.c b/drivers/md/bcache/sysfs.c
index 2ed503ab9e5c..543b06408321 100644
--- a/drivers/md/bcache/sysfs.c
+++ b/drivers/md/bcache/sysfs.c
@@ -150,7 +150,7 @@ SHOW(__bch_cached_dev)
 {
 	struct cached_dev *dc = container_of(kobj, struct cached_dev,
 					     disk.kobj);
-	const char *states[] = { "no cache", "clean", "dirty", "inconsistent" };
+	char const *states[] = { "no cache", "clean", "dirty", "inconsistent" };
 	int wb = dc->writeback_running;
 
 #define var(stat)		(dc->stat)
-- 
2.18.0
