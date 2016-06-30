Return-Path: <famz@redhat.com>
From: Fam Zheng <famz@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, Jens Axboe <axboe@kernel.dk>,
        "Ed L. Cashin" <ed.cashin@acm.org>, Jiri Kosina <jikos@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Minchan Kim <minchan@kernel.org>, Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Shaohua Li <shli@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Keith Busch <keith.busch@intel.com>, linuxppc-dev@lists.ozlabs.org,
        linux-block@vger.kernel.org, virtualization@lists.linux-foundation.org,
        linux-raid@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-nvme@lists.infradead.org,
        Christoph Hellwig <hch@infradead.org>, famz@redhat.com
Subject: [PATCH v2 07/12] pktcdvd: Generate uevent after attribute available
Date: Thu, 30 Jun 2016 09:59:48 +0800
Message-Id: <20160630015953.6888-8-famz@redhat.com>
In-Reply-To: <20160630015953.6888-1-famz@redhat.com>
References: <20160630015953.6888-1-famz@redhat.com>
List-ID: <linux-block@vger.kernel.org>

It is documented that KOBJ_ADD should be generated after the object's
attributes and children are ready.  We can achieve this with the new
disk_gen_uevents interface.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 drivers/block/pktcdvd.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/block/pktcdvd.c b/drivers/block/pktcdvd.c
index 00928406..a4e6bb7 100644
--- a/drivers/block/pktcdvd.c
+++ b/drivers/block/pktcdvd.c
@@ -2785,11 +2785,13 @@ static int pkt_setup_dev(dev_t dev, dev_t* pkt_dev)
 	disk->events = pd->bdev->bd_disk->events;
 	disk->async_events = pd->bdev->bd_disk->async_events;
 
-	add_disk(disk, true);
+	add_disk(disk, false);
 
 	pkt_sysfs_dev_new(pd);
 	pkt_debugfs_dev_new(pd);
 
+	disk_gen_uevents(disk);
+
 	pkt_devs[idx] = pd;
 	if (pkt_dev)
 		*pkt_dev = pd->pkt_dev;
-- 
2.9.0
