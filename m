Return-Path: <colyli@suse.de>
From: Coly Li <colyli@suse.de>
To: axboe@kernel.dk,
	linux-bcache@vger.kernel.org
Cc: linux-block@vger.kernel.org,
	Coly Li <colyli@suse.de>
Subject: [PATCH v3 13/17] bcache: add static const prefix to char * array declarations
Date: Sat, 11 Aug 2018 13:19:56 +0800
Message-Id: <20180811052000.103680-14-colyli@suse.de>
In-Reply-To: <20180811052000.103680-1-colyli@suse.de>
References: <20180811052000.103680-1-colyli@suse.de>
List-ID: <linux-block@vger.kernel.org>

This patch declares char * array with const prefix in sysfs.c,
which is suggested by checkpatch.pl.

Signed-off-by: Coly Li <colyli@suse.de>
Reviewed-by: Shenghui Wang <shhuiw@foxmail.com>
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
