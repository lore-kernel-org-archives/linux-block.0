Return-Path: <prvs=401b34db8=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 2/2] compat_hdio_ioctl: Fix a declaration
Date: Wed, 23 Aug 2017 15:29:11 -0700
Message-Id: <20170823222911.29453-3-bart.vanassche@wdc.com>
In-Reply-To: <20170823222911.29453-1-bart.vanassche@wdc.com>
References: <20170823222911.29453-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

This patch avoids that sparse reports the following warning messages:

block/compat_ioctl.c:85:11: warning: incorrect type in assignment (different address spaces)
block/compat_ioctl.c:85:11:    expected unsigned long *[noderef] <asn:1>p
block/compat_ioctl.c:85:11:    got void [noderef] <asn:1>*
block/compat_ioctl.c:91:21: warning: incorrect type in argument 1 (different address spaces)
block/compat_ioctl.c:91:21:    expected void const volatile [noderef] <asn:1>*<noident>
block/compat_ioctl.c:91:21:    got unsigned long *[noderef] <asn:1>p
block/compat_ioctl.c:87:53: warning: dereference of noderef expression
block/compat_ioctl.c:91:21: warning: dereference of noderef expression

Fixes: commit d597580d3737 ("generic ...copy_..._user primitives")
Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Jens Axboe <axboe@kernel.dk>
---
 block/compat_ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/compat_ioctl.c b/block/compat_ioctl.c
index 38554c2ea38a..abaf9d78a206 100644
--- a/block/compat_ioctl.c
+++ b/block/compat_ioctl.c
@@ -79,7 +79,7 @@ static int compat_hdio_getgeo(struct gendisk *disk, struct block_device *bdev,
 static int compat_hdio_ioctl(struct block_device *bdev, fmode_t mode,
 		unsigned int cmd, unsigned long arg)
 {
-	unsigned long *__user p;
+	unsigned long __user *p;
 	int error;
 
 	p = compat_alloc_user_space(sizeof(unsigned long));
-- 
2.14.0
