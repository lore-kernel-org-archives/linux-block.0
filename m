Return-Path: <prvs=7075ca7b7=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>
Subject: [PATCH] drbd: Do not redefine __must_hold()
Date: Mon, 25 Jun 2018 15:51:00 -0700
Message-Id: <20180625225100.4352-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Since __must_hold() is defined in <linux/compiler_types.h>, do not
redefine it in DRBD. Compile-tested only.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Philipp Reisner <philipp.reisner@linbit.com>
Cc: Lars Ellenberg <lars.ellenberg@linbit.com>
---
 drivers/block/drbd/drbd_int.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index b93cbac2cb5a..b9f60030850d 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -55,12 +55,10 @@
 # define __protected_by(x)       __attribute__((require_context(x,1,999,"rdwr")))
 # define __protected_read_by(x)  __attribute__((require_context(x,1,999,"read")))
 # define __protected_write_by(x) __attribute__((require_context(x,1,999,"write")))
-# define __must_hold(x)       __attribute__((context(x,1,1), require_context(x,1,999,"call")))
 #else
 # define __protected_by(x)
 # define __protected_read_by(x)
 # define __protected_write_by(x)
-# define __must_hold(x)
 #endif
 
 /* shared module parameters, defined in drbd_main.c */
-- 
2.17.1
