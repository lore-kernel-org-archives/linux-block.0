Return-Path: <colyli@suse.de>
From: Coly Li <colyli@suse.de>
To: axboe@kernel.dk
Cc: linux-bcache@vger.kernel.org,
	linux-block@vger.kernel.org,
	Ben Peddell <klightspeed@killerwolves.net>,
	Coly Li <colyli@suse.de>
Subject: [PATCH 07/15] bcache: Populate writeback_rate_minimum attribute
Date: Mon,  8 Oct 2018 20:41:13 +0800
Message-Id: <20181008124121.20192-8-colyli@suse.de>
In-Reply-To: <20181008124121.20192-1-colyli@suse.de>
References: <20181008124121.20192-1-colyli@suse.de>
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

From: Ben Peddell <klightspeed@killerwolves.net>

Forgot to include the maintainers with my first email.

Somewhere between Michael Lyle's original
"bcache: PI controller for writeback rate V2" patch dated 07 Sep 2017
and 1d316e6 bcache: implement PI controller for writeback rate,
the mapping of the writeback_rate_minimum attribute was dropped.

Re-add the missing sysfs writeback_rate_minimum attribute mapping to
"allow the user to specify a minimum rate at which dirty blocks are
retired."

Fixes: 1d316e6 bcache: implement PI controller for writeback rate
Signed-off-by: Ben Peddell <klightspeed@killerwolves.net>
Signed-off-by: Coly Li <colyli@suse.de>
---
 drivers/md/bcache/sysfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/md/bcache/sysfs.c b/drivers/md/bcache/sysfs.c
index 150cf4f4cf74..26f035a0c5b9 100644
--- a/drivers/md/bcache/sysfs.c
+++ b/drivers/md/bcache/sysfs.c
@@ -285,6 +285,7 @@ STORE(__cached_dev)
 			    1, WRITEBACK_RATE_UPDATE_SECS_MAX);
 	d_strtoul(writeback_rate_i_term_inverse);
 	d_strtoul_nonzero(writeback_rate_p_term_inverse);
+	d_strtoul_nonzero(writeback_rate_minimum);
 
 	sysfs_strtoul_clamp(io_error_limit, dc->error_limit, 0, INT_MAX);
 
@@ -412,6 +413,7 @@ static struct attribute *bch_cached_dev_files[] = {
 	&sysfs_writeback_rate_update_seconds,
 	&sysfs_writeback_rate_i_term_inverse,
 	&sysfs_writeback_rate_p_term_inverse,
+	&sysfs_writeback_rate_minimum,
 	&sysfs_writeback_rate_debug,
 	&sysfs_errors,
 	&sysfs_io_error_limit,
-- 
2.19.0
