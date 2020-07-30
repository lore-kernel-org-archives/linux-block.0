Return-Path: <SRS0=0pY0=BJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEDB4C433E0
	for <linux-block@archiver.kernel.org>; Thu, 30 Jul 2020 11:25:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C83742074B
	for <linux-block@archiver.kernel.org>; Thu, 30 Jul 2020 11:25:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="FvtEgWO7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgG3LZZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 Jul 2020 07:25:25 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:49475 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbgG3LZY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Jul 2020 07:25:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1596108324; x=1627644324;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=BL3aRlbU4IAQ9Owvu4nn3/JjcIa8eDIK4A8jQvI9ELI=;
  b=FvtEgWO7Yp79/8umzlRXok4DTp0nZg0xSWCv5v1jeumPW6qMLA5kNLQe
   BLDgPOiBgrpFYAHWndxQoWx3XK5HRyPeBCHL9nfUrXmDo7c62vIU4gn1r
   UDXW5rn595NUnlwVNzPNhB3U4rSK1VV8IoOfBaonR6as2dvB78nrLHRcO
   pgcqKXVLtfMOvYGtas8ZqbI/Nfe8sHlOBWLVSf9Wr6EqDTWQo6Feu0RsX
   JZHbIgUzxfol67a69D+OEHWOgW3hEJ5JAcVaYGDCj0eJaRM/zRYBLipPq
   uO9UheLqsuoWWxkDY1WCTsobVM1kUY2rUP4Isup+9TedCvD95WsnRvJlg
   g==;
IronPort-SDR: aqukEQ1XyKb1m5IjvqDxyOzaNEYRhPks5HMi55WT9j1mUG5HHlpqAqKj6CVqfC4yAk5R7NzSES
 rD3zr+oyGgitjuUF8GkTGjRJgHFvHWQ8ULVLDfcT/TlCG5832atcYiLBb9MJpEHHRQ4wUgbdcU
 2D6Pp5vwqH4IjfqEJmK0/ywG+uoIH8gbcaRoCxddpMZA4y+bfGAvUOxUXT4i6zVOe0m4dguWt6
 YjaA7a9s2cyqtRZB+Wq+g/W45GQdUazdyNyusDiPdw8CmZBhf2Zfrhv5mcSEM7357hxIDJ/EBA
 PqI=
X-IronPort-AV: E=Sophos;i="5.75,414,1589212800"; 
   d="scan'208";a="148054573"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 30 Jul 2020 19:25:24 +0800
IronPort-SDR: 79gEIQYYMU/+ZWqinC2NEAX9plz+g6vcOyBLCkvrLcG56ecXZN8/vkuMf3iLv71CSoqeAAuJRg
 WUucNfNZ0P0vWkQkz4+BXJB07XBZjsa1Y=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2020 04:12:53 -0700
IronPort-SDR: HhBEa3CaAKUeKe6KZaa4M96eOXCKn88ZysFezYuiGkQblqIRUnQvvCJwqcEB2Tv5rUdNslBP/d
 TAMAwWW+FbJw==
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip02.wdc.com with ESMTP; 30 Jul 2020 04:25:24 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH] block: don't do revalidate zones on invalid devices
Date:   Thu, 30 Jul 2020 20:25:17 +0900
Message-Id: <20200730112517.12816-1-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When we loose a device for whatever reason while (re)scanning zones, we
trip over a NULL pointer in blk_revalidate_zone_cb, like in the following
log:

sd 0:0:0:0: [sda] 3418095616 4096-byte logical blocks: (14.0 TB/12.7 TiB)
sd 0:0:0:0: [sda] 52156 zones of 65536 logical blocks
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 37 00 00 08
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
sd 0:0:0:0: [sda] REPORT ZONES start lba 1065287680 failed
sd 0:0:0:0: [sda] REPORT ZONES: Result: hostbyte=0x00 driverbyte=0x08
sd 0:0:0:0: [sda] Sense Key : 0xb [current]
sd 0:0:0:0: [sda] ASC=0x0 ASCQ=0x6
sda: failed to revalidate zones
sd 0:0:0:0: [sda] 0 4096-byte logical blocks: (0 B/0 B)
sda: detected capacity change from 14000519643136 to 0
==================================================================
BUG: KASAN: null-ptr-deref in blk_revalidate_zone_cb+0x1b7/0x550
Write of size 8 at addr 0000000000000010 by task kworker/u4:1/58

CPU: 1 PID: 58 Comm: kworker/u4:1 Not tainted 5.8.0-rc1 #692
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.13.0-0-gf21b5a4-rebuilt.opensuse.org 04/01/2014
Workqueue: events_unbound async_run_entry_fn
Call Trace:
 dump_stack+0x7d/0xb0
 ? blk_revalidate_zone_cb+0x1b7/0x550
 kasan_report.cold+0x5/0x37
 ? blk_revalidate_zone_cb+0x1b7/0x550
 check_memory_region+0x145/0x1a0
 blk_revalidate_zone_cb+0x1b7/0x550
 sd_zbc_parse_report+0x1f1/0x370
 ? blk_req_zone_write_trylock+0x200/0x200
 ? sectors_to_logical+0x60/0x60
 ? blk_req_zone_write_trylock+0x200/0x200
 ? blk_req_zone_write_trylock+0x200/0x200
 sd_zbc_report_zones+0x3c4/0x5e0
 ? sd_dif_config_host+0x500/0x500
 blk_revalidate_disk_zones+0x231/0x44d
 ? _raw_write_lock_irqsave+0xb0/0xb0
 ? blk_queue_free_zone_bitmaps+0xd0/0xd0
 sd_zbc_read_zones+0x8cf/0x11a0
 sd_revalidate_disk+0x305c/0x64e0
 ? __device_add_disk+0x776/0xf20
 ? read_capacity_16.part.0+0x1080/0x1080
 ? blk_alloc_devt+0x250/0x250
 ? create_object.isra.0+0x595/0xa20
 ? kasan_unpoison_shadow+0x33/0x40
 sd_probe+0x8dc/0xcd2
 really_probe+0x20e/0xaf0
 __driver_attach_async_helper+0x249/0x2d0
 async_run_entry_fn+0xbe/0x560
 process_one_work+0x764/0x1290
 ? _raw_read_unlock_irqrestore+0x30/0x30
 worker_thread+0x598/0x12f0
 ? __kthread_parkme+0xc6/0x1b0
 ? schedule+0xed/0x2c0
 ? process_one_work+0x1290/0x1290
 kthread+0x36b/0x440
 ? kthread_create_worker_on_cpu+0xa0/0xa0
 ret_from_fork+0x22/0x30
==================================================================

When the device is already gone we end up with the following scenario:
The device's capacity is 0 and thus the number of zones will be 0 as well. When
allocating the bitmap for the conventional zones, we then trip over a NULL
pointer.

So if we encounter a zoned block device with a 0 capacity, don't dare to
revalidate the zones sizes.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---

Note: This is a hot-fix for 5.8, we're working on something to make a
recoverable error recoverable.


 block/blk-zoned.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 23831fa8701d..480dfff69a00 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -497,6 +497,9 @@ int blk_revalidate_disk_zones(struct gendisk *disk,
 	if (WARN_ON_ONCE(!queue_is_mq(q)))
 		return -EIO;
 
+	if (!get_capacity(disk))
+		return -EIO;
+
 	/*
 	 * Ensure that all memory allocations in this context are done as if
 	 * GFP_NOIO was specified.
-- 
2.26.2

