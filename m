Return-Path: <prvs=401b34db8=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <Damien.LeMoal@wdc.com>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Hannes Reinecke <hare@suse.de>,
	Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH 5/5] skd: Change default interrupt mode to MSI-X
Date: Wed, 23 Aug 2017 10:56:33 -0700
Message-Id: <20170823175633.12680-6-bart.vanassche@wdc.com>
In-Reply-To: <20170823175633.12680-1-bart.vanassche@wdc.com>
References: <20170823175633.12680-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Since MSI support on some motherboards is unreliable, change the
default interrupt mode from MSI to MSI-X. This patch avoids that
the following message appears sporadially in the kernel logs of
my test setup:

do_IRQ: 3.193 No irq handler for vector

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
---
 drivers/block/skd_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/skd_main.c b/drivers/block/skd_main.c
index ff288f1a5dec..577618c57975 100644
--- a/drivers/block/skd_main.c
+++ b/drivers/block/skd_main.c
@@ -310,7 +310,7 @@ static inline void skd_reg_write64(struct skd_device *skdev, u64 val,
 }
 
 
-#define SKD_IRQ_DEFAULT SKD_IRQ_MSI
+#define SKD_IRQ_DEFAULT SKD_IRQ_MSIX
 static int skd_isr_type = SKD_IRQ_DEFAULT;
 
 module_param(skd_isr_type, int, 0444);
-- 
2.14.0
