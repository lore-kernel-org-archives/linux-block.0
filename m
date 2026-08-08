Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5FA61E2834;
	Sat,  8 Aug 2026 15:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786204052; cv=none; b=X0y6FN4laiJGwBtEsMqxhd7zQXwwQVOWD5XCgqVMcoNGLd7PmAcpX1DY8mdDRbQbCat4Aw6DKhuQFhNzlSHYTL4/q3F4Uv3cMa4seiS847eC5mUAa4eDJnXvaXE1whchP5W8EODpmFXjBa+AiVSQ8MNU72NqljsaJBjHt450GU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786204052; c=relaxed/simple;
	bh=gqhS+4NR6/2XwDHhtfsM7JXQb2+7tazQhyuzMMJpsds=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=PXBhHlZNuZjHZIaZb9mLMLK1O39IAwrvHI0CTcC/0vqGbbdrmNNmb+S8pfPGwGmI/WGsfmebdaNeYgMQMHMpoRSy5t5SvohYi7+iIX2X4nBusvB44UuCQJZQO3PSBMrAZKDysOfcKqtoSGDEZQ1bHvaNjvQ4s9i4sLj4bHO8KRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=surriel.com; dkim=pass (2048-bit key) header.d=surriel.com header.i=@surriel.com header.b=captjuQ1; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=surriel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=surriel.com header.i=@surriel.com header.b="captjuQ1"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=surriel.com
	; s=mail; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=a+0+NWlRbix/8DRg9ZOeDIMzQf5a5/4ufgL8RJRyBc0=; b=captjuQ1o6krs4F2idChKEMb+S
	iroALuklfoJ5qOCXqGwc48Sr/NwUaHlQEbpk/oHFiO91cpneQbiUhyQkxnu47oP8FcwDrbCYisqWo
	kuHu62m+6lLHD8Z+YAeLnjBXCKU4xB7r991gowlDXhGjeKXZX4ItTvis5HTyiKAfvInQ+LgWTZXty
	CMYymmj7uqWT/sIZU5HbnuidLGh0g0Tq9Fvg004fUUt6F5u/gB/xCwmqREGDsm2VJTUQ2B9bqZoOa
	IPkhdJh6Xqf92Yv1JyZ4uK4o0dnMNCEgpaBB0LfT6nNkxJU9jdaK2VM/CE5Hnb3Uu0SqaN3T3k+i5
	L8m3sXaw==;
Received: from [2601:18c:8100:a0e0:5a47:caff:fe78:8708] (helo=fangorn)
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@surriel.com>)
	id 1wsjC3-000000001hY-1qzJ;
	Sat, 08 Aug 2026 11:42:39 -0400
Date: Sat, 8 Aug 2026 11:42:39 -0400
From: Rik van Riel <riel@surriel.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>, Damien Le Moal <dlemoal@kernel.org>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: RFC PATCH] null_blk: fix UBSAN shift-out-of-bounds when zone_size
 is 0 or overflows
Message-ID: <20260808114239.69167f68@fangorn>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

null_zone_no() does sect >> ilog2(dev->zone_size_sects). When
zone_size_sects is 0, ilog2(0) returns -1, producing shift exponent -1
which UBSAN reports as shift-out-of-bounds.

  UBSAN: shift-out-of-bounds in drivers/block/null_blk/zoned.c:21:14
  shift exponent -1 is negative
  Call Trace:
   null_zone_no drivers/block/null_blk/zoned.c:21 [inline]
   null_process_zoned_cmd+0xf76/0xf80 drivers/block/null_blk/zoned.c:728
   null_handle_cmd drivers/block/null_blk/main.c:1455 [inline]
   null_queue_rq+0x8bc/0xe70 drivers/block/null_blk/main.c:1703
   __blk_mq_issue_directly block/blk-mq.c:2694 [inline]
   blk_mq_try_issue_directly+0x3f4/0x880 block/blk-mq.c:2754
   blk_mq_submit_bio+0x20c0/0x2a40 block/blk-mq.c:3208
   submit_bio_noacct_nocheck+0x2f4/0xa40 block/blk-core.c:790
   block_read_full_folio+0x7a6/0x810 fs/buffer.c:2463
   filemap_read_folio+0x12c/0x3a0 mm/filemap.c:2510
   read_part_sector+0xb6/0x2b0 block/partitions/core.c:724
   adfspart_check_ICS+0xb1/0x960 block/partitions/acorn.c:357
   check_partition block/partitions/core.c:143 [inline]
   blk_add_partitions block/partitions/core.c:591 [inline]
   bdev_disk_changed+0x851/0x17a0 block/partitions/core.c:695
   blkdev_get_whole+0x372/0x510 block/bdev.c:751
   add_disk_final block/genhd.c:412 [inline]
   add_disk_fwnode+0x24b/0x3a0 block/genhd.c:606
   null_add_dev+0x130b/0x1d70 drivers/block/null_blk/main.c:2052
   nullb_device_power_store+0x240/0x380 drivers/block/null_blk/main.c:501
   configfs_write_iter+0x337/0x430 fs/configfs/file.c:229

Syzkaller triggers this by creating a zoned null_blk device via
configfs. The Call Trace shows configfs_write_iter in configfs/file.c
handling a write to power file, which calls nullb_device_power_store in
main.c, which calls null_add_dev in main.c, which calls add_disk in
genhd.c, which triggers partition scan via bdev_disk_changed in
partitions/core.c.

A zoned null_blk device with zone_size 0 should not be legal. Existing
code tries to reject it via is_power_of_2() check in zoned.c and
!zone_size check in main.c, but syzkaller can still reach
null_zone_no() with zone_size_sects 0 via two paths:

1. Direct 0 via configfs: zone_size attribute store in main.c has
NULLB_DEVICE_ATTR(zone_size, ulong, NULL) with no validation callback,
so echo 0 > zone_size succeeds before power store. If zoned is false
at power store time, the !zone_size check in main.c is skipped, and
later zoned set true leaves zone_size 0.

2. Large value overflow: mb_to_sects() in zoned.c does
(sector_t)mb * SZ_1M >> SECTOR_SHIFT which is mb * 2048. If mb is
1UL << 53 (9PB), mb * 2048 overflows 64-bit to 0. The value is
power-of-two so is_power_of_2() passes, but mb_to_sects() returns 0.

Check for zero zone_size explicitly in null_init_zoned_dev() in
zoned.c, returning -EINVAL with "must be non-zero power-of-two".
Check for zero zone_size_sects after mb_to_sects() conversion,
returning -EINVAL for overflow case. Keep defensive check in
null_zone_no() returning 0 for zero sectors to avoid shift out-of-bounds
even if  zero slips through.

This change should be safe because zone_size is set once in
null_init_zoned_dev() under device lock and never changes after, and 0
is never valid for a zoned device. Returning -EINVAL at init time fails
device creation early with clear error, while defensive return 0 in
null_zone_no() makes zoned command fail via offline zone check.
No new locking is introduced.

Reported-by: syzbot+abd6a8dca0f2b7726060@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=abd6a8dca0f2b7726060
Link: https://lore.kernel.org/all/6a75205c.01d0871a.3a0d52.0033.GAE@google.com/
Fixes: 8a3cf049af68 ("null_blk: add zoned block device emulation")
Cc: stable@vger.kernel.org
Assisted-by: Hermes:muse-spark-1.2 syzkaller
Signed-off-by: Rik van Riel <riel@surriel.com>
---
 drivers/block/null_blk/zoned.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/block/null_blk/zoned.c b/drivers/block/null_blk/zoned.c
index 384bdce6a9b7..7e9b5ffb9e84 100644
--- a/drivers/block/null_blk/zoned.c
+++ b/drivers/block/null_blk/zoned.c
@@ -18,6 +18,8 @@ static inline sector_t mb_to_sects(unsigned long mb)
 
 static inline unsigned int null_zone_no(struct nullb_device *dev, sector_t sect)
 {
+	if (WARN_ON_ONCE(!dev->zone_size_sects))
+		return 0;
 	return sect >> ilog2(dev->zone_size_sects);
 }
 
@@ -56,8 +58,8 @@ int null_init_zoned_dev(struct nullb_device *dev,
 	sector_t sector = 0;
 	unsigned int i;
 
-	if (!is_power_of_2(dev->zone_size)) {
-		pr_err("zone_size must be power-of-two\n");
+	if (!dev->zone_size || !is_power_of_2(dev->zone_size)) {
+		pr_err("zone_size must be non-zero power-of-two\n");
 		return -EINVAL;
 	}
 	if (dev->zone_size > dev->size) {
@@ -88,6 +90,10 @@ int null_init_zoned_dev(struct nullb_device *dev,
 	zone_capacity_sects = mb_to_sects(dev->zone_capacity);
 	dev_capacity_sects = mb_to_sects(dev->size);
 	dev->zone_size_sects = mb_to_sects(dev->zone_size);
+	if (!dev->zone_size_sects) {
+		pr_err("zone_size too large or too small, leads to zero sectors\n");
+		return -EINVAL;
+	}
 	dev->nr_zones = round_up(dev_capacity_sects, dev->zone_size_sects)
 		>> ilog2(dev->zone_size_sects);
 
-- 
2.55.0

