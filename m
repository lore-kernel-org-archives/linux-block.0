Return-Path: <jinb.park7@gmail.com>
Return-Path: <jinb.park7@gmail.com>
Date: Sat, 28 Jul 2018 10:31:51 +0900
From: Jinbum Park <jinb.park7@gmail.com>
To: axboe@kernel.dk, bart.vanassche@wdc.com, jiufei.xue@linux.alibaba.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] pktcdvd: Fix possible Spectre-v1 for pkt_devs
Message-ID: <20180728013151.GA15457@pjb1027-Latitude-E5410>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-block@vger.kernel.org>

User controls @dev_minor which to be used as index of pkt_devs.
So, It can be exploited via Spectre-like attack. (speculative execution)

This kind of attack leaks address of pkt_devs, [1]
It leads an attacker to bypass security mechanism such as KASLR.

So sanitize @dev_minor before using it to prevent attack.

[1] https://github.com/jinb-park/linux-exploit/
tree/master/exploit-remaining-spectre-gadget/leak_pkt_devs.c

Signed-off-by: Jinbum Park <jinb.park7@gmail.com>
---
 drivers/block/pktcdvd.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index c61d20c..665760d 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -67,8 +67,8 @@
 #include <scsi/scsi.h>
 #include <linux/debugfs.h>
 #include <linux/device.h>
-
 #include <linux/uaccess.h>
+#include <linux/nospec.h>
 
 #define DRIVER_NAME	"pktcdvd"
 
@@ -2229,9 +2229,13 @@ static void pkt_release_dev(struct pktcdvd_device *pd, int flush)
 
 static struct pktcdvd_device *pkt_find_dev_from_minor(unsigned int dev_minor)
 {
+	unsigned int idx = 0;
+
 	if (dev_minor >= MAX_WRITERS)
 		return NULL;
-	return pkt_devs[dev_minor];
+
+	idx = array_index_nospec(dev_minor, MAX_WRITERS);
+	return pkt_devs[idx];
 }
 
 static int pkt_open(struct block_device *bdev, fmode_t mode)
-- 
1.9.1
