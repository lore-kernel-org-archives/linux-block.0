Return-Path: <famz@redhat.com>
From: Fam Zheng <famz@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-nvme@lists.infradead.org, Keith Busch <keith.busch@intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev@lists.ozlabs.org, "Michael S. Tsirkin" <mst@redhat.com>,
        linux-block@vger.kernel.org,
        Brian Norris <computersforpeace@gmail.com>,
        Paul Mackerras <paulus@samba.org>, linux-mtd@lists.infradead.org,
        "Ed L. Cashin" <ed.cashin@acm.org>, Jens Axboe <axboe@kernel.dk>,
        Minchan Kim <minchan@kernel.org>,
        virtualization@lists.linux-foundation.org,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Nitin Gupta <ngupta@vflare.org>, David Woodhouse <dwmw2@infradead.org>
Subject: [PATCH 11/15] zram: Pass attribute group to device_add_disk
Date: Wed, 17 Aug 2016 15:15:11 +0800
Message-Id: <1471418115-3654-12-git-send-email-famz@redhat.com>
In-Reply-To: <1471418115-3654-1-git-send-email-famz@redhat.com>
References: <1471418115-3654-1-git-send-email-famz@redhat.com>
List-ID: <linux-block@vger.kernel.org>

Previously after device_add_disk returns, the KOBJ_ADD uevent is already
emitted. Adding attributes after that is a poor usage of kobject, and
in practice may result in race conditions with userspace, for
example udev checks availability of certain attributes and initializes
/dev entries conditionally.

device_add_disk can handle adding attribute group better, so use it.
Meanwhile, update the error check code and message.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 drivers/block/zram/zram_drv.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 20920a2..2331788 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1298,13 +1298,10 @@ static int zram_add(void)
 		zram->disk->queue->limits.discard_zeroes_data = 0;
 	queue_flag_set_unlocked(QUEUE_FLAG_DISCARD, zram->disk->queue);
 
-	device_add_disk(NULL, zram->disk, NULL);
+	ret = device_add_disk(NULL, zram->disk, &zram_disk_attr_group);
 
-	ret = sysfs_create_group(&disk_to_dev(zram->disk)->kobj,
-				&zram_disk_attr_group);
 	if (ret < 0) {
-		pr_err("Error creating sysfs group for device %d\n",
-				device_id);
+		pr_err("Error creating disk %d\n", device_id);
 		goto out_free_disk;
 	}
 	strlcpy(zram->compressor, default_compressor, sizeof(zram->compressor));
-- 
2.7.4
