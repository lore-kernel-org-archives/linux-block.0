Return-Path: <SRS0=89dG=QE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED8CEC282C8
	for <linux-block@archiver.kernel.org>; Mon, 28 Jan 2019 17:10:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B513F2175B
	for <linux-block@archiver.kernel.org>; Mon, 28 Jan 2019 17:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548695403;
	bh=XF3HxZuNo+c2QSGvRZKfvOmkpMZSWseres8uiEQsTh8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=or8hKxqUwbNso0I61wHLDA5a6zGslRnlbLRRvq9QhRAE+my0KanYCrdtDLsHjqIib
	 6Fx2Oui2chUdAhHqRLK1qSj+bJ3W02W7kSUmc5FeWJ+h9OguItMdRDrPmQx4xMr1jH
	 OHyTSxjPzA4jGTCWiZ4+lzfCaAWRuNm49f3/EXXE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731112AbfA1QLD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:11:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:37656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732895AbfA1QLC (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Jan 2019 11:11:02 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BBACA21848;
        Mon, 28 Jan 2019 16:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548691860;
        bh=XF3HxZuNo+c2QSGvRZKfvOmkpMZSWseres8uiEQsTh8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VKRw1mXfKH5Y0XmXj4mwqkiHq26gEewDKuIhpuBfQmEDpbGAMcNnQWzLwhlqIrMKa
         127e1CqkPATFNCTaFS023H5TEHAZekcD6xCYM361UEegZuAVwVM2yLAkTKsGq55YTx
         yRQd95lpTpRJ3cfP06UZ07DkZ2imnzVH9Wsq+Abo=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>, linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 239/258] zram: fix lockdep warning of free block handling
Date:   Mon, 28 Jan 2019 10:59:05 -0500
Message-Id: <20190128155924.51521-239-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128155924.51521-1-sashal@kernel.org>
References: <20190128155924.51521-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Minchan Kim <minchan@kernel.org>

[ Upstream commit 3c9959e025472122a61faebb208525cf26b305d1 ]

Patch series "zram idle page writeback", v3.

Inherently, swap device has many idle pages which are rare touched since
it was allocated.  It is never problem if we use storage device as swap.
However, it's just waste for zram-swap.

This patchset supports zram idle page writeback feature.

* Admin can define what is idle page "no access since X time ago"
* Admin can define when zram should writeback them
* Admin can define when zram should stop writeback to prevent wearout

Details are in each patch's description.

This patch (of 7):

  ================================
  WARNING: inconsistent lock state
  4.19.0+ #390 Not tainted
  --------------------------------
  inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W} usage.
  zram_verify/2095 [HC0[0]:SC1[1]:HE1:SE0] takes:
  00000000b1828693 (&(&zram->bitmap_lock)->rlock){+.?.}, at: put_entry_bdev+0x1e/0x50
  {SOFTIRQ-ON-W} state was registered at:
    _raw_spin_lock+0x2c/0x40
    zram_make_request+0x755/0xdc9
    generic_make_request+0x373/0x6a0
    submit_bio+0x6c/0x140
    __swap_writepage+0x3a8/0x480
    shrink_page_list+0x1102/0x1a60
    shrink_inactive_list+0x21b/0x3f0
    shrink_node_memcg.constprop.99+0x4f8/0x7e0
    shrink_node+0x7d/0x2f0
    do_try_to_free_pages+0xe0/0x300
    try_to_free_pages+0x116/0x2b0
    __alloc_pages_slowpath+0x3f4/0xf80
    __alloc_pages_nodemask+0x2a2/0x2f0
    __handle_mm_fault+0x42e/0xb50
    handle_mm_fault+0x55/0xb0
    __do_page_fault+0x235/0x4b0
    page_fault+0x1e/0x30
  irq event stamp: 228412
  hardirqs last  enabled at (228412): [<ffffffff98245846>] __slab_free+0x3e6/0x600
  hardirqs last disabled at (228411): [<ffffffff98245625>] __slab_free+0x1c5/0x600
  softirqs last  enabled at (228396): [<ffffffff98e0031e>] __do_softirq+0x31e/0x427
  softirqs last disabled at (228403): [<ffffffff98072051>] irq_exit+0xd1/0xe0

  other info that might help us debug this:
   Possible unsafe locking scenario:

         CPU0
         ----
    lock(&(&zram->bitmap_lock)->rlock);
    <Interrupt>
      lock(&(&zram->bitmap_lock)->rlock);

   *** DEADLOCK ***

  no locks held by zram_verify/2095.

  stack backtrace:
  CPU: 5 PID: 2095 Comm: zram_verify Not tainted 4.19.0+ #390
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
  Call Trace:
   <IRQ>
   dump_stack+0x67/0x9b
   print_usage_bug+0x1bd/0x1d3
   mark_lock+0x4aa/0x540
   __lock_acquire+0x51d/0x1300
   lock_acquire+0x90/0x180
   _raw_spin_lock+0x2c/0x40
   put_entry_bdev+0x1e/0x50
   zram_free_page+0xf6/0x110
   zram_slot_free_notify+0x42/0xa0
   end_swap_bio_read+0x5b/0x170
   blk_update_request+0x8f/0x340
   scsi_end_request+0x2c/0x1e0
   scsi_io_completion+0x98/0x650
   blk_done_softirq+0x9e/0xd0
   __do_softirq+0xcc/0x427
   irq_exit+0xd1/0xe0
   do_IRQ+0x93/0x120
   common_interrupt+0xf/0xf
   </IRQ>

With writeback feature, zram_slot_free_notify could be called in softirq
context by end_swap_bio_read.  However, bitmap_lock is not aware of that
so lockdep yell out:

  get_entry_bdev
  spin_lock(bitmap->lock);
  irq
  softirq
  end_swap_bio_read
  zram_slot_free_notify
  zram_slot_lock <-- deadlock prone
  zram_free_page
  put_entry_bdev
  spin_lock(bitmap->lock); <-- deadlock prone

With akpm's suggestion (i.e.  bitmap operation is already atomic), we
could remove bitmap lock.  It might fail to find a empty slot if serious
contention happens.  However, it's not severe problem because huge page
writeback has already possiblity to fail if there is severe memory
pressure.  Worst case is just keeping the incompressible in memory, not
storage.

The other problem is zram_slot_lock in zram_slot_slot_free_notify.  To
make it safe is this patch introduces zram_slot_trylock where
zram_slot_free_notify uses it.  Although it's rare to be contented, this
patch adds new debug stat "miss_free" to keep monitoring how often it
happens.

Link: http://lkml.kernel.org/r/20181127055429.251614-2-minchan@kernel.org
Signed-off-by: Minchan Kim <minchan@kernel.org>
Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Reviewed-by: Joey Pabalinas <joeypabalinas@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/zram/zram_drv.c | 38 +++++++++++++++++++----------------
 drivers/block/zram/zram_drv.h |  2 +-
 2 files changed, 22 insertions(+), 18 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index e19bf0a750cf..a65505db09e5 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -53,6 +53,11 @@ static size_t huge_class_size;
 
 static void zram_free_page(struct zram *zram, size_t index);
 
+static int zram_slot_trylock(struct zram *zram, u32 index)
+{
+	return bit_spin_trylock(ZRAM_LOCK, &zram->table[index].value);
+}
+
 static void zram_slot_lock(struct zram *zram, u32 index)
 {
 	bit_spin_lock(ZRAM_LOCK, &zram->table[index].value);
@@ -401,7 +406,6 @@ static ssize_t backing_dev_store(struct device *dev,
 		goto out;
 
 	reset_bdev(zram);
-	spin_lock_init(&zram->bitmap_lock);
 
 	zram->old_block_size = old_block_size;
 	zram->bdev = bdev;
@@ -445,29 +449,24 @@ static ssize_t backing_dev_store(struct device *dev,
 
 static unsigned long get_entry_bdev(struct zram *zram)
 {
-	unsigned long entry;
-
-	spin_lock(&zram->bitmap_lock);
+	unsigned long blk_idx = 1;
+retry:
 	/* skip 0 bit to confuse zram.handle = 0 */
-	entry = find_next_zero_bit(zram->bitmap, zram->nr_pages, 1);
-	if (entry == zram->nr_pages) {
-		spin_unlock(&zram->bitmap_lock);
+	blk_idx = find_next_zero_bit(zram->bitmap, zram->nr_pages, blk_idx);
+	if (blk_idx == zram->nr_pages)
 		return 0;
-	}
 
-	set_bit(entry, zram->bitmap);
-	spin_unlock(&zram->bitmap_lock);
+	if (test_and_set_bit(blk_idx, zram->bitmap))
+		goto retry;
 
-	return entry;
+	return blk_idx;
 }
 
 static void put_entry_bdev(struct zram *zram, unsigned long entry)
 {
 	int was_set;
 
-	spin_lock(&zram->bitmap_lock);
 	was_set = test_and_clear_bit(entry, zram->bitmap);
-	spin_unlock(&zram->bitmap_lock);
 	WARN_ON_ONCE(!was_set);
 }
 
@@ -888,9 +887,10 @@ static ssize_t debug_stat_show(struct device *dev,
 
 	down_read(&zram->init_lock);
 	ret = scnprintf(buf, PAGE_SIZE,
-			"version: %d\n%8llu\n",
+			"version: %d\n%8llu %8llu\n",
 			version,
-			(u64)atomic64_read(&zram->stats.writestall));
+			(u64)atomic64_read(&zram->stats.writestall),
+			(u64)atomic64_read(&zram->stats.miss_free));
 	up_read(&zram->init_lock);
 
 	return ret;
@@ -1402,10 +1402,14 @@ static void zram_slot_free_notify(struct block_device *bdev,
 
 	zram = bdev->bd_disk->private_data;
 
-	zram_slot_lock(zram, index);
+	atomic64_inc(&zram->stats.notify_free);
+	if (!zram_slot_trylock(zram, index)) {
+		atomic64_inc(&zram->stats.miss_free);
+		return;
+	}
+
 	zram_free_page(zram, index);
 	zram_slot_unlock(zram, index);
-	atomic64_inc(&zram->stats.notify_free);
 }
 
 static int zram_rw_page(struct block_device *bdev, sector_t sector,
diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
index 72c8584b6dff..d1095dfdffa8 100644
--- a/drivers/block/zram/zram_drv.h
+++ b/drivers/block/zram/zram_drv.h
@@ -79,6 +79,7 @@ struct zram_stats {
 	atomic64_t pages_stored;	/* no. of pages currently stored */
 	atomic_long_t max_used_pages;	/* no. of maximum pages stored */
 	atomic64_t writestall;		/* no. of write slow paths */
+	atomic64_t miss_free;		/* no. of missed free */
 };
 
 struct zram {
@@ -110,7 +111,6 @@ struct zram {
 	unsigned int old_block_size;
 	unsigned long *bitmap;
 	unsigned long nr_pages;
-	spinlock_t bitmap_lock;
 #endif
 #ifdef CONFIG_ZRAM_MEMORY_TRACKING
 	struct dentry *debugfs_dir;
-- 
2.19.1

