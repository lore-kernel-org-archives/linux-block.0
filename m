Return-Path: <jinb.park7@gmail.com>
Return-Path: <jinb.park7@gmail.com>
Date: Sat, 28 Jul 2018 13:20:44 +0900
From: Jinbum Park <jinb.park7@gmail.com>
To: axboe@kernel.dk, bart.vanassche@wdc.com, jiufei.xue@linux.alibaba.com,
	gustavo@embeddedor.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] pktcdvd: Fix possible Spectre-v1 for pkt_devs
Message-ID: <20180728042044.GA3571@pjb1027-Latitude-E5410>
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
v3: work from latest linux-next tree

 drivers/block/pktcdvd.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index a4b4d52..9bb7721 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -67,7 +67,7 @@
 #include <scsi/scsi.h>
 #include <linux/debugfs.h>
 #include <linux/device.h>
-
+#include <linux/nospec.h>
 #include <linux/uaccess.h>
 
 #define DRIVER_NAME	"pktcdvd"
@@ -2254,6 +2254,8 @@ static struct pktcdvd_device *pkt_find_dev_from_minor(unsigned int dev_minor)
 {
 	if (dev_minor >= MAX_WRITERS)
 		return NULL;
+
+	dev_minor = array_index_nospec(dev_minor, MAX_WRITERS);
 	return pkt_devs[dev_minor];
 }
 
-- 
1.9.1
