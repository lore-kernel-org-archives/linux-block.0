Return-Path: <colyli@suse.de>
To: Jens Axboe <axboe@kernel.dk>, Michael Lyle <mlyle@lyle.org>
Cc: linux-bcache <linux-bcache@vger.kernel.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "tang.junhui" <tang.junhui@zte.com.cn>
From: Coly Li <colyli@suse.de>
Subject: extra part in bcache patch commit 539d39eb2708
Message-ID: <35deaddb-fcd8-c4b0-4c5f-6cb8d8495a33@suse.de>
Date: Thu, 19 Apr 2018 13:17:46 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Michael and Jens

When I do back port of bcache patches, I find commit 539d39eb2708
("bcache: fix wrong return value in bch_debug_init()") has extra part
from the original patch which Junhui Tanng posted.

The patch posted by Junhui Tang was,
From: Tang Junhui <tang.junhui@zte.com.cn>

in bch_debug_init(), ret is always 0, and the return value is useless,
change it to return 0 if be success after calling debugfs_create_dir(),
else return a non-zero value.

Signed-off-by: Tang Junhui <tang.junhui@zte.com.cn>
---
 drivers/md/bcache/debug.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/md/bcache/debug.c b/drivers/md/bcache/debug.c
index c7a02c4..2bb0b28
--- a/drivers/md/bcache/debug.c
+++ b/drivers/md/bcache/debug.c
@@ -251,8 +251,7 @@ void bch_debug_exit(void)

 int __init bch_debug_init(struct kobject *kobj)
 {
-	int ret = 0;
-
 	debug = debugfs_create_dir("bcache", NULL);
-	return ret;
+
+	return IS_ERR_OR_NULL(debug);
 }

But the patch merged in 4.16 has extra part of writeback stuffs. I guess
maybe some two patches combined together unwittingly.

Michael, could you please give me some hint ? Should we remove the extra
part of this patch, or we should split them into two patches ?

Thanks.

Coly Li
