Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:51807 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751157AbeEENE4 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 5 May 2018 09:04:56 -0400
From: Coly Li <colyli@suse.de>
To: linux-bcache@vger.kernel.org
Cc: linux-block@vger.kernel.org, Coly Li <colyli@suse.de>
Subject: [PATCH] bcache: display rate debug parameters to 0 when writeback is not running
Date: Sat,  5 May 2018 21:04:45 +0800
Message-Id: <20180505130445.73214-1-colyli@suse.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

When writeback is not running, writeback rate should be 0, other value is
misleading. And the following dyanmic writeback rate debug parameters
should be 0 too,
	rate, proportional, integral, change
otherwise they are misleading when writeback is not running.

Signed-off-by: Coly Li <colyli@suse.de>
---
 drivers/md/bcache/sysfs.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/md/bcache/sysfs.c b/drivers/md/bcache/sysfs.c
index dfeef583ee50..6ef6616fb76e 100644
--- a/drivers/md/bcache/sysfs.c
+++ b/drivers/md/bcache/sysfs.c
@@ -119,6 +119,7 @@ SHOW(__bch_cached_dev)
 	struct cached_dev *dc = container_of(kobj, struct cached_dev,
 					     disk.kobj);
 	const char *states[] = { "no cache", "clean", "dirty", "inconsistent" };
+	int wb = dc->writeback_running;
 
 #define var(stat)		(dc->stat)
 
@@ -140,7 +141,7 @@ SHOW(__bch_cached_dev)
 	var_printf(writeback_running,	"%i");
 	var_print(writeback_delay);
 	var_print(writeback_percent);
-	sysfs_hprint(writeback_rate,	dc->writeback_rate.rate << 9);
+	sysfs_hprint(writeback_rate,	wb ? dc->writeback_rate.rate << 9 : 0);
 	sysfs_hprint(io_errors,		atomic_read(&dc->io_errors));
 	sysfs_printf(io_error_limit,	"%i", dc->error_limit);
 	sysfs_printf(io_disable,	"%i", dc->io_disable);
@@ -158,15 +159,20 @@ SHOW(__bch_cached_dev)
 		char change[20];
 		s64 next_io;
 
-		bch_hprint(rate,	dc->writeback_rate.rate << 9);
-		bch_hprint(dirty,	bcache_dev_sectors_dirty(&dc->disk) << 9);
-		bch_hprint(target,	dc->writeback_rate_target << 9);
-		bch_hprint(proportional,dc->writeback_rate_proportional << 9);
-		bch_hprint(integral,	dc->writeback_rate_integral_scaled << 9);
-		bch_hprint(change,	dc->writeback_rate_change << 9);
-
-		next_io = div64_s64(dc->writeback_rate.next - local_clock(),
-				    NSEC_PER_MSEC);
+		/*
+		 * Except for dirty and target, other values should
+		 * be 0 if writeback is not running.
+		 */
+		bch_hprint(rate, wb ? dc->writeback_rate.rate << 9 : 0);
+		bch_hprint(dirty, bcache_dev_sectors_dirty(&dc->disk) << 9);
+		bch_hprint(target, dc->writeback_rate_target << 9);
+		bch_hprint(proportional,
+			   wb ? dc->writeback_rate_proportional << 9 : 0);
+		bch_hprint(integral,
+			   wb ? dc->writeback_rate_integral_scaled << 9 : 0);
+		bch_hprint(change, wb ? dc->writeback_rate_change << 9 : 0);
+		next_io = wb ? div64_s64(dc->writeback_rate.next-local_clock(),
+					 NSEC_PER_MSEC) : 0;
 
 		return sprintf(buf,
 			       "rate:\t\t%s/sec\n"
-- 
2.16.3
