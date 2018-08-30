Return-Path: <zlsh007@hotmail.com>
From: ? ? <zlsh007@hotmail.com>
To: "axboe@kernel.dk" <axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: [PATCH] block: Add a check for fdisk
Date: Thu, 30 Aug 2018 07:07:41 +0000
Message-ID: <KL1PR01MB127192D2FC817BCA02F8B365F5080@KL1PR01MB1271.apcprd01.prod.exchangelabs.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

When a block device is acquired in the form of FMODE_EXCL, I think it
should not be allowed to perform partition operations, similar to when
mount is executed.

Signed-off-by: Hua Su <zlsh007@hotmail.com>
---
 block/partition-generic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/partition-generic.c b/block/partition-generic.c
index 5a8975a..a8daa31 100644
--- a/block/partition-generic.c
+++ b/block/partition-generic.c
@@ -440,7 +440,7 @@ static int drop_partitions(struct gendisk *disk, struct=
 block_device *bdev)
 	struct hd_struct *part;
 	int res;
=20
-	if (bdev->bd_part_count || bdev->bd_super)
+	if (bdev->bd_part_count || bdev->bd_super || bdev->bd_holders)
 		return -EBUSY;
 	res =3D invalidate_partition(disk, 0);
 	if (res)
--=20
2.7.4
