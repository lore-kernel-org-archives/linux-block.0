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
Subject: [PATCH v2 05/12] aoeblk: Generate uevent after attribute available
Date: Thu, 30 Jun 2016 09:59:46 +0800
Message-Id: <20160630015953.6888-6-famz@redhat.com>
In-Reply-To: <20160630015953.6888-1-famz@redhat.com>
References: <20160630015953.6888-1-famz@redhat.com>
List-ID: <linux-block@vger.kernel.org>

It is documented that KOBJ_ADD should be generated after the object's
attributes and children are ready.  We can achieve this with the new
disk_gen_uevents interface.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 drivers/block/aoe/aoeblk.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/block/aoe/aoeblk.c b/drivers/block/aoe/aoeblk.c
index e91c5f1..f0cf4d6 100644
--- a/drivers/block/aoe/aoeblk.c
+++ b/drivers/block/aoe/aoeblk.c
@@ -417,9 +417,10 @@ aoeblk_gdalloc(void *vp)
 
 	spin_unlock_irqrestore(&d->lock, flags);
 
-	add_disk(gd, true);
+	add_disk(gd, false);
 	aoedisk_add_sysfs(d);
 	aoedisk_add_debugfs(d);
+	disk_gen_uevents(gd);
 
 	spin_lock_irqsave(&d->lock, flags);
 	WARN_ON(!(d->flags & DEVFL_GD_NOW));
-- 
2.9.0
