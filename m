Return-Path: <linux-scsi-owner@vger.kernel.org>
From: Damien Le Moal <damien.lemoal@wdc.com>
To: linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        dm-devel@redhat.com, Mike Snitzer <snitzer@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>,
        Matias Bjorling <matias.bjorling@wdc.com>
Subject: [PATCH v4 07/11] block: Introduce BLKGETNRZONES ioctl
Date: Fri, 12 Oct 2018 19:08:46 +0900
Message-Id: <20181012100850.23316-8-damien.lemoal@wdc.com>
In-Reply-To: <20181012100850.23316-1-damien.lemoal@wdc.com>
References: <20181012100850.23316-1-damien.lemoal@wdc.com>
Sender: linux-scsi-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

Get a zoned block device total number of zones. The device can be a
partition of the whole device. The number of zones is always 0 for
regular block devices.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 block/ioctl.c                 | 2 ++
 include/uapi/linux/blkzoned.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/block/ioctl.c b/block/ioctl.c
index f6d2c6f1f050..4825c78a6baa 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -534,6 +534,8 @@ int blkdev_ioctl(struct block_device *bdev, fmode_t mode, unsigned cmd,
 		return blkdev_reset_zones_ioctl(bdev, mode, cmd, arg);
 	case BLKGETZONESZ:
 		return put_uint(arg, bdev_zone_sectors(bdev));
+	case BLKGETNRZONES:
+		return put_uint(arg, blkdev_nr_zones(bdev));
 	case HDIO_GETGEO:
 		return blkdev_getgeo(bdev, argp);
 	case BLKRAGET:
diff --git a/include/uapi/linux/blkzoned.h b/include/uapi/linux/blkzoned.h
index 281ac605f752..8f08ff9bdea0 100644
--- a/include/uapi/linux/blkzoned.h
+++ b/include/uapi/linux/blkzoned.h
@@ -142,5 +142,6 @@ struct blk_zone_range {
 #define BLKREPORTZONE	_IOWR(0x12, 130, struct blk_zone_report)
 #define BLKRESETZONE	_IOW(0x12, 131, struct blk_zone_range)
 #define BLKGETZONESZ	_IOW(0x12, 132, __u32)
+#define BLKGETNRZONES	_IOW(0x12, 133, __u32)
 
 #endif /* _UAPI_BLKZONED_H */
-- 
2.17.1
