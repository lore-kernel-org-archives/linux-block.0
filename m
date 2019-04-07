Return-Path: <SRS0=ol8w=SJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CC67C10F0E
	for <linux-block@archiver.kernel.org>; Sun,  7 Apr 2019 06:56:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0D9A213F2
	for <linux-block@archiver.kernel.org>; Sun,  7 Apr 2019 06:56:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gDZ6ssTM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725996AbfDGG4p (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 7 Apr 2019 02:56:45 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57570 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbfDGG4p (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 7 Apr 2019 02:56:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=HzwGwCCD0jA/jTUjwYSmKS+QmiqMIYvi48eYWYew+cw=; b=gDZ6ssTMrWPca3J1ev6ACwycH
        /9UwHgeLOqHp/sMAFKbFEjosN+SQPit1Pv9mXrJmwbT9bP4/T/3vDxMjUmPQfs2jeONYczSpvNat7
        kqN0/Pl9Cfb1Osv6oOS22RxWZFv8Rdam5PSf2QpgfNGSpe6ps9t5pmX/M00gpeXVtQQ+0zd9cX3cM
        zolDOem9+zbGKR52N4p5HhxwkWpM4NZnLI9nLbZsUvmvVDFv1Uz86bG/sXfKL71pDkLsL1siMJjY4
        17XMZPQ4lcZMUooeCY9K6wc31HHm/yWWkRwktNUUxn+CAAO1dhFZYSoBpEO9VKfrR3fJdTxti5aFL
        wxkGVMOTQ==;
Received: from 089144214194.atnat0023.highway.a1.net ([89.144.214.194] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hD1jL-0006qu-Te; Sun, 07 Apr 2019 06:56:40 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     torvalds@linuxfoundation.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] block: remove CONFIG_LBDAF
Date:   Sun,  7 Apr 2019 08:56:18 +0200
Message-Id: <20190407065618.24483-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Currently support for 64-bit sector_t and blkcnt_t is optional on 32-bit
architectures.  These types are required to support block device and/or
file sizes larger than 2 TiB, and have generally defaulted to on for
a long time.  Enabling the option only increases the i386 tinyconfig
size by 145 bytes, and many data structures already always use
64-bit values for their in-core and on-disk data structures anyway,
so there should not be a large change in dynamic memory usage either.

Dropping this option removes a somewhat weird non-default config that
has cause various bugs or compiler warnings when actually used.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---

Changes since v1:
 - dropped the defconfig changes

 Documentation/process/submit-checklist.rst    | 27 +++++++---------
 .../translations/ja_JP/SubmitChecklist        | 22 ++++++-------
 block/Kconfig                                 | 24 --------------
 drivers/block/drbd/drbd_int.h                 |  5 ---
 drivers/block/ps3disk.c                       |  4 +--
 drivers/md/dm-exception-store.h               | 28 ++--------------
 drivers/md/dm-integrity.c                     |  8 ++---
 drivers/md/md.c                               |  6 ++--
 drivers/nvdimm/pfn_devs.c                     |  4 +--
 drivers/scsi/sd.c                             | 32 -------------------
 fs/ext4/resize.c                              |  2 --
 fs/ext4/super.c                               | 32 ++++---------------
 fs/gfs2/Kconfig                               |  1 -
 fs/nfs/Kconfig                                |  1 -
 fs/ocfs2/super.c                              | 10 ------
 fs/stack.c                                    | 15 ++++-----
 fs/xfs/Kconfig                                |  1 -
 fs/xfs/xfs_super.c                            | 10 +-----
 include/linux/genhd.h                         |  8 ++---
 include/linux/kernel.h                        | 14 ++------
 include/linux/types.h                         |  5 ---
 lib/Kconfig.debug                             |  1 -
 .../formal/srcu-cbmc/include/linux/types.h    |  4 ---
 23 files changed, 52 insertions(+), 212 deletions(-)

diff --git a/Documentation/process/submit-checklist.rst b/Documentation/process/submit-checklist.rst
index 367353c54949..c88867b173d9 100644
--- a/Documentation/process/submit-checklist.rst
+++ b/Documentation/process/submit-checklist.rst
@@ -72,47 +72,44 @@ and elsewhere regarding submitting Linux kernel patches.
 13) Has been build- and runtime tested with and without ``CONFIG_SMP`` and
     ``CONFIG_PREEMPT.``
 
-14) If the patch affects IO/Disk, etc: has been tested with and without
-    ``CONFIG_LBDAF.``
+16) All codepaths have been exercised with all lockdep features enabled.
 
-15) All codepaths have been exercised with all lockdep features enabled.
+17) All new ``/proc`` entries are documented under ``Documentation/``
 
-16) All new ``/proc`` entries are documented under ``Documentation/``
-
-17) All new kernel boot parameters are documented in
+18) All new kernel boot parameters are documented in
     ``Documentation/admin-guide/kernel-parameters.rst``.
 
-18) All new module parameters are documented with ``MODULE_PARM_DESC()``
+19) All new module parameters are documented with ``MODULE_PARM_DESC()``
 
-19) All new userspace interfaces are documented in ``Documentation/ABI/``.
+20) All new userspace interfaces are documented in ``Documentation/ABI/``.
     See ``Documentation/ABI/README`` for more information.
     Patches that change userspace interfaces should be CCed to
     linux-api@vger.kernel.org.
 
-20) Check that it all passes ``make headers_check``.
+21) Check that it all passes ``make headers_check``.
 
-21) Has been checked with injection of at least slab and page-allocation
+22) Has been checked with injection of at least slab and page-allocation
     failures.  See ``Documentation/fault-injection/``.
 
     If the new code is substantial, addition of subsystem-specific fault
     injection might be appropriate.
 
-22) Newly-added code has been compiled with ``gcc -W`` (use
+23) Newly-added code has been compiled with ``gcc -W`` (use
     ``make EXTRA_CFLAGS=-W``).  This will generate lots of noise, but is good
     for finding bugs like "warning: comparison between signed and unsigned".
 
-23) Tested after it has been merged into the -mm patchset to make sure
+24) Tested after it has been merged into the -mm patchset to make sure
     that it still works with all of the other queued patches and various
     changes in the VM, VFS, and other subsystems.
 
-24) All memory barriers {e.g., ``barrier()``, ``rmb()``, ``wmb()``} need a
+25) All memory barriers {e.g., ``barrier()``, ``rmb()``, ``wmb()``} need a
     comment in the source code that explains the logic of what they are doing
     and why.
 
-25) If any ioctl's are added by the patch, then also update
+26) If any ioctl's are added by the patch, then also update
     ``Documentation/ioctl/ioctl-number.txt``.
 
-26) If your modified source code depends on or uses any of the kernel
+27) If your modified source code depends on or uses any of the kernel
     APIs or features that are related to the following ``Kconfig`` symbols,
     then test multiple builds with the related ``Kconfig`` symbols disabled
     and/or ``=m`` (if that option is available) [not all of these at the
diff --git a/Documentation/translations/ja_JP/SubmitChecklist b/Documentation/translations/ja_JP/SubmitChecklist
index 60c7c35ac517..b42220d3d46c 100644
--- a/Documentation/translations/ja_JP/SubmitChecklist
+++ b/Documentation/translations/ja_JP/SubmitChecklist
@@ -74,38 +74,34 @@ Linux カーネルパッチ投稿者向けチェックリスト
 13: CONFIG_SMP, CONFIG_PREEMPT を有効にした場合と無効にした場合の両方で
     ビルドした上、動作確認を行ってください。
 
-14: もしパッチがディスクのI/O性能などに影響を与えるようであれば、
-    'CONFIG_LBDAF'オプションを有効にした場合と無効にした場合の両方で
-    テストを実施してみてください。
+14: lockdepの機能を全て有効にした上で、全てのコードパスを評価してください。
 
-15: lockdepの機能を全て有効にした上で、全てのコードパスを評価してください。
-
-16: /proc に新しいエントリを追加した場合には、Documentation/ 配下に
+15: /proc に新しいエントリを追加した場合には、Documentation/ 配下に
     必ずドキュメントを追加してください。
 
-17: 新しいブートパラメータを追加した場合には、
+16: 新しいブートパラメータを追加した場合には、
     必ずDocumentation/admin-guide/kernel-parameters.rst に説明を追加してください。
 
-18: 新しくmoduleにパラメータを追加した場合には、MODULE_PARM_DESC()を
+17: 新しくmoduleにパラメータを追加した場合には、MODULE_PARM_DESC()を
     利用して必ずその説明を記述してください。
 
-19: 新しいuserspaceインタフェースを作成した場合には、Documentation/ABI/ に
+18: 新しいuserspaceインタフェースを作成した場合には、Documentation/ABI/ に
     Documentation/ABI/README を参考にして必ずドキュメントを追加してください。
 
-20: 'make headers_check'を実行して全く問題がないことを確認してください。
+19: 'make headers_check'を実行して全く問題がないことを確認してください。
 
-21: 少なくともslabアロケーションとpageアロケーションに失敗した場合の
+20: 少なくともslabアロケーションとpageアロケーションに失敗した場合の
     挙動について、fault-injectionを利用して確認してください。
     Documentation/fault-injection/ を参照してください。
 
     追加したコードがかなりの量であったならば、サブシステム特有の
     fault-injectionを追加したほうが良いかもしれません。
 
-22: 新たに追加したコードは、`gcc -W'でコンパイルしてください。
+21: 新たに追加したコードは、`gcc -W'でコンパイルしてください。
     このオプションは大量の不要なメッセージを出力しますが、
     "warning: comparison between signed and unsigned" のようなメッセージは、
     バグを見つけるのに役に立ちます。
 
-23: 投稿したパッチが -mm パッチセットにマージされた後、全ての既存のパッチや
+22: 投稿したパッチが -mm パッチセットにマージされた後、全ての既存のパッチや
     VM, VFS およびその他のサブシステムに関する様々な変更と、現時点でも共存
     できることを確認するテストを行ってください。
diff --git a/block/Kconfig b/block/Kconfig
index 028bc085dac8..1b220101a9cb 100644
--- a/block/Kconfig
+++ b/block/Kconfig
@@ -26,30 +26,6 @@ menuconfig BLOCK
 
 if BLOCK
 
-config LBDAF
-	bool "Support for large (2TB+) block devices and files"
-	depends on !64BIT
-	default y
-	help
-	  Enable block devices or files of size 2TB and larger.
-
-	  This option is required to support the full capacity of large
-	  (2TB+) block devices, including RAID, disk, Network Block Device,
-	  Logical Volume Manager (LVM) and loopback.
-	
-	  This option also enables support for single files larger than
-	  2TB.
-
-	  The ext4 filesystem requires that this feature be enabled in
-	  order to support filesystems that have the huge_file feature
-	  enabled.  Otherwise, it will refuse to mount in the read-write
-	  mode any filesystems that use the huge_file feature, which is
-	  enabled by default by mke2fs.ext4.
-
-	  The GFS2 filesystem also requires this feature.
-
-	  If unsure, say Y.
-
 config BLK_SCSI_REQUEST
 	bool
 
diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index 000a2f4c0e92..acd7af3630e9 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -1317,10 +1317,6 @@ struct bm_extent {
 
 #define DRBD_MAX_SECTORS_FIXED_BM \
 	  ((MD_128MB_SECT - MD_32kB_SECT - MD_4kB_SECT) * (1LL<<(BM_EXT_SHIFT-9)))
-#if !defined(CONFIG_LBDAF) && BITS_PER_LONG == 32
-#define DRBD_MAX_SECTORS      DRBD_MAX_SECTORS_32
-#define DRBD_MAX_SECTORS_FLEX DRBD_MAX_SECTORS_32
-#else
 #define DRBD_MAX_SECTORS      DRBD_MAX_SECTORS_FIXED_BM
 /* 16 TB in units of sectors */
 #if BITS_PER_LONG == 32
@@ -1333,7 +1329,6 @@ struct bm_extent {
 #define DRBD_MAX_SECTORS_FLEX (1UL << 51)
 /* corresponds to (1UL << 38) bits right now. */
 #endif
-#endif
 
 /* Estimate max bio size as 256 * PAGE_SIZE,
  * so for typical PAGE_SIZE of 4k, that is (1<<20) Byte.
diff --git a/drivers/block/ps3disk.c b/drivers/block/ps3disk.c
index 4e1d9b31f60c..cc61c5ce3ad5 100644
--- a/drivers/block/ps3disk.c
+++ b/drivers/block/ps3disk.c
@@ -102,7 +102,7 @@ static void ps3disk_scatter_gather(struct ps3_storage_device *dev,
 
 	rq_for_each_segment(bvec, req, iter) {
 		unsigned long flags;
-		dev_dbg(&dev->sbd.core, "%s:%u: bio %u: %u sectors from %lu\n",
+		dev_dbg(&dev->sbd.core, "%s:%u: bio %u: %u sectors from %llu\n",
 			__func__, __LINE__, i, bio_sectors(iter.bio),
 			iter.bio->bi_iter.bi_sector);
 
@@ -496,7 +496,7 @@ static int ps3disk_probe(struct ps3_system_bus_device *_dev)
 		     dev->regions[dev->region_idx].size*priv->blocking_factor);
 
 	dev_info(&dev->sbd.core,
-		 "%s is a %s (%llu MiB total, %lu MiB for OtherOS)\n",
+		 "%s is a %s (%llu MiB total, %llu MiB for OtherOS)\n",
 		 gendisk->disk_name, priv->model, priv->raw_capacity >> 11,
 		 get_capacity(gendisk) >> 11);
 
diff --git a/drivers/md/dm-exception-store.h b/drivers/md/dm-exception-store.h
index 12b5216c2cfe..721efc493942 100644
--- a/drivers/md/dm-exception-store.h
+++ b/drivers/md/dm-exception-store.h
@@ -135,9 +135,8 @@ struct dm_dev *dm_snap_cow(struct dm_snapshot *snap);
 /*
  * Funtions to manipulate consecutive chunks
  */
-#  if defined(CONFIG_LBDAF) || (BITS_PER_LONG == 64)
-#    define DM_CHUNK_CONSECUTIVE_BITS 8
-#    define DM_CHUNK_NUMBER_BITS 56
+#define DM_CHUNK_CONSECUTIVE_BITS 8
+#define DM_CHUNK_NUMBER_BITS 56
 
 static inline chunk_t dm_chunk_number(chunk_t chunk)
 {
@@ -163,29 +162,6 @@ static inline void dm_consecutive_chunk_count_dec(struct dm_exception *e)
 	e->new_chunk -= (1ULL << DM_CHUNK_NUMBER_BITS);
 }
 
-#  else
-#    define DM_CHUNK_CONSECUTIVE_BITS 0
-
-static inline chunk_t dm_chunk_number(chunk_t chunk)
-{
-	return chunk;
-}
-
-static inline unsigned dm_consecutive_chunk_count(struct dm_exception *e)
-{
-	return 0;
-}
-
-static inline void dm_consecutive_chunk_count_inc(struct dm_exception *e)
-{
-}
-
-static inline void dm_consecutive_chunk_count_dec(struct dm_exception *e)
-{
-}
-
-#  endif
-
 /*
  * Return the number of sectors in the device.
  */
diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
index d57d997a52c8..0eb56ba89a7f 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -88,14 +88,10 @@ struct journal_entry {
 
 #if BITS_PER_LONG == 64
 #define journal_entry_set_sector(je, x)		do { smp_wmb(); WRITE_ONCE((je)->u.sector, cpu_to_le64(x)); } while (0)
-#define journal_entry_get_sector(je)		le64_to_cpu((je)->u.sector)
-#elif defined(CONFIG_LBDAF)
-#define journal_entry_set_sector(je, x)		do { (je)->u.s.sector_lo = cpu_to_le32(x); smp_wmb(); WRITE_ONCE((je)->u.s.sector_hi, cpu_to_le32((x) >> 32)); } while (0)
-#define journal_entry_get_sector(je)		le64_to_cpu((je)->u.sector)
 #else
-#define journal_entry_set_sector(je, x)		do { (je)->u.s.sector_lo = cpu_to_le32(x); smp_wmb(); WRITE_ONCE((je)->u.s.sector_hi, cpu_to_le32(0)); } while (0)
-#define journal_entry_get_sector(je)		le32_to_cpu((je)->u.s.sector_lo)
+#define journal_entry_set_sector(je, x)		do { (je)->u.s.sector_lo = cpu_to_le32(x); smp_wmb(); WRITE_ONCE((je)->u.s.sector_hi, cpu_to_le32((x) >> 32)); } while (0)
 #endif
+#define journal_entry_get_sector(je)		le64_to_cpu((je)->u.sector)
 #define journal_entry_is_unused(je)		((je)->u.s.sector_hi == cpu_to_le32(-1))
 #define journal_entry_set_unused(je)		do { ((je)->u.s.sector_hi = cpu_to_le32(-1)); } while (0)
 #define journal_entry_is_inprogress(je)		((je)->u.s.sector_hi == cpu_to_le32(-2))
diff --git a/drivers/md/md.c b/drivers/md/md.c
index 3cd662c2863c..1f344b9b95f8 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -1105,8 +1105,7 @@ static int super_90_load(struct md_rdev *rdev, struct md_rdev *refdev, int minor
 	 * (not needed for Linear and RAID0 as metadata doesn't
 	 * record this size)
 	 */
-	if (IS_ENABLED(CONFIG_LBDAF) && (u64)rdev->sectors >= (2ULL << 32) &&
-	    sb->level >= 1)
+	if ((u64)rdev->sectors >= (2ULL << 32) && sb->level >= 1)
 		rdev->sectors = (sector_t)(2ULL << 32) - 2;
 
 	if (rdev->sectors < ((sector_t)sb->size) * 2 && sb->level >= 1)
@@ -1404,8 +1403,7 @@ super_90_rdev_size_change(struct md_rdev *rdev, sector_t num_sectors)
 	/* Limit to 4TB as metadata cannot record more than that.
 	 * 4TB == 2^32 KB, or 2*2^32 sectors.
 	 */
-	if (IS_ENABLED(CONFIG_LBDAF) && (u64)num_sectors >= (2ULL << 32) &&
-	    rdev->mddev->level >= 1)
+	if ((u64)num_sectors >= (2ULL << 32) && rdev->mddev->level >= 1)
 		num_sectors = (sector_t)(2ULL << 32) - 2;
 	do {
 		md_super_write(rdev->mddev, rdev, rdev->sb_start, rdev->sb_size,
diff --git a/drivers/nvdimm/pfn_devs.c b/drivers/nvdimm/pfn_devs.c
index d271bd731af7..01f40672507f 100644
--- a/drivers/nvdimm/pfn_devs.c
+++ b/drivers/nvdimm/pfn_devs.c
@@ -391,7 +391,7 @@ static int nd_pfn_clear_memmap_errors(struct nd_pfn *nd_pfn)
 		bb_present = badblocks_check(&nd_region->bb, meta_start,
 				meta_num, &first_bad, &num_bad);
 		if (bb_present) {
-			dev_dbg(&nd_pfn->dev, "meta: %x badblocks at %lx\n",
+			dev_dbg(&nd_pfn->dev, "meta: %x badblocks at %llx\n",
 					num_bad, first_bad);
 			nsoff = ALIGN_DOWN((nd_region->ndr_start
 					+ (first_bad << 9)) - nsio->res.start,
@@ -410,7 +410,7 @@ static int nd_pfn_clear_memmap_errors(struct nd_pfn *nd_pfn)
 			}
 			if (rc) {
 				dev_err(&nd_pfn->dev,
-					"error clearing %x badblocks at %lx\n",
+					"error clearing %x badblocks at %llx\n",
 					num_bad, first_bad);
 				return rc;
 			}
diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 2b2bc4b49d78..92c34d93e051 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -2256,22 +2256,6 @@ static void read_capacity_error(struct scsi_disk *sdkp, struct scsi_device *sdp,
 
 #define READ_CAPACITY_RETRIES_ON_RESET	10
 
-/*
- * Ensure that we don't overflow sector_t when CONFIG_LBDAF is not set
- * and the reported logical block size is bigger than 512 bytes. Note
- * that last_sector is a u64 and therefore logical_to_sectors() is not
- * applicable.
- */
-static bool sd_addressable_capacity(u64 lba, unsigned int sector_size)
-{
-	u64 last_sector = (lba + 1ULL) << (ilog2(sector_size) - 9);
-
-	if (sizeof(sector_t) == 4 && last_sector > U32_MAX)
-		return false;
-
-	return true;
-}
-
 static int read_capacity_16(struct scsi_disk *sdkp, struct scsi_device *sdp,
 						unsigned char *buffer)
 {
@@ -2337,14 +2321,6 @@ static int read_capacity_16(struct scsi_disk *sdkp, struct scsi_device *sdp,
 		return -ENODEV;
 	}
 
-	if (!sd_addressable_capacity(lba, sector_size)) {
-		sd_printk(KERN_ERR, sdkp, "Too big for this kernel. Use a "
-			"kernel compiled with support for large block "
-			"devices.\n");
-		sdkp->capacity = 0;
-		return -EOVERFLOW;
-	}
-
 	/* Logical blocks per physical block exponent */
 	sdkp->physical_block_size = (1 << (buffer[13] & 0xf)) * sector_size;
 
@@ -2426,14 +2402,6 @@ static int read_capacity_10(struct scsi_disk *sdkp, struct scsi_device *sdp,
 		return sector_size;
 	}
 
-	if (!sd_addressable_capacity(lba, sector_size)) {
-		sd_printk(KERN_ERR, sdkp, "Too big for this kernel. Use a "
-			"kernel compiled with support for large block "
-			"devices.\n");
-		sdkp->capacity = 0;
-		return -EOVERFLOW;
-	}
-
 	sdkp->capacity = lba + 1;
 	sdkp->physical_block_size = sector_size;
 	return sector_size;
diff --git a/fs/ext4/resize.c b/fs/ext4/resize.c
index e7ae26e36c9c..38faf661e237 100644
--- a/fs/ext4/resize.c
+++ b/fs/ext4/resize.c
@@ -1760,8 +1760,6 @@ int ext4_group_extend(struct super_block *sb, struct ext4_super_block *es,
 		ext4_msg(sb, KERN_ERR,
 			 "filesystem too large to resize to %llu blocks safely",
 			 n_blocks_count);
-		if (sizeof(sector_t) < 8)
-			ext4_warning(sb, "CONFIG_LBDAF not enabled");
 		return -EINVAL;
 	}
 
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 6ed4eb81e674..d10e9e724bdd 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -2706,13 +2706,9 @@ static loff_t ext4_max_size(int blkbits, int has_huge_files)
 	loff_t res;
 	loff_t upper_limit = MAX_LFS_FILESIZE;
 
-	/* small i_blocks in vfs inode? */
-	if (!has_huge_files || sizeof(blkcnt_t) < sizeof(u64)) {
-		/*
-		 * CONFIG_LBDAF is not enabled implies the inode
-		 * i_block represent total blocks in 512 bytes
-		 * 32 == size of vfs inode i_blocks * 8
-		 */
+	BUILD_BUG_ON(sizeof(blkcnt_t) < sizeof(u64));
+
+	if (!has_huge_files) {
 		upper_limit = (1LL << 32) - 1;
 
 		/* total blocks in file system block size */
@@ -2753,11 +2749,11 @@ static loff_t ext4_max_bitmap_size(int bits, int has_huge_files)
 	 * number of 512-byte sectors of the file.
 	 */
 
-	if (!has_huge_files || sizeof(blkcnt_t) < sizeof(u64)) {
+	if (!has_huge_files) {
 		/*
-		 * !has_huge_files or CONFIG_LBDAF not enabled implies that
-		 * the inode i_block field represents total file blocks in
-		 * 2^32 512-byte sectors == size of vfs inode i_blocks * 8
+		 * !has_huge_files or implies that the inode i_block field
+		 * represents total file blocks in 2^32 512-byte sectors ==
+		 * size of vfs inode i_blocks * 8
 		 */
 		upper_limit = (1LL << 32) - 1;
 
@@ -2897,18 +2893,6 @@ static int ext4_feature_set_ok(struct super_block *sb, int readonly)
 				~EXT4_FEATURE_RO_COMPAT_SUPP));
 		return 0;
 	}
-	/*
-	 * Large file size enabled file system can only be mounted
-	 * read-write on 32-bit systems if kernel is built with CONFIG_LBDAF
-	 */
-	if (ext4_has_feature_huge_file(sb)) {
-		if (sizeof(blkcnt_t) < sizeof(u64)) {
-			ext4_msg(sb, KERN_ERR, "Filesystem with huge files "
-				 "cannot be mounted RDWR without "
-				 "CONFIG_LBDAF");
-			return 0;
-		}
-	}
 	if (ext4_has_feature_bigalloc(sb) && !ext4_has_feature_extents(sb)) {
 		ext4_msg(sb, KERN_ERR,
 			 "Can't support bigalloc feature without "
@@ -4057,8 +4041,6 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 	if (err) {
 		ext4_msg(sb, KERN_ERR, "filesystem"
 			 " too large to mount safely on this system");
-		if (sizeof(sector_t) < 8)
-			ext4_msg(sb, KERN_WARNING, "CONFIG_LBDAF not enabled");
 		goto failed_mount;
 	}
 
diff --git a/fs/gfs2/Kconfig b/fs/gfs2/Kconfig
index 3ed2b088dcfd..6a1e499543f5 100644
--- a/fs/gfs2/Kconfig
+++ b/fs/gfs2/Kconfig
@@ -1,6 +1,5 @@
 config GFS2_FS
 	tristate "GFS2 file system support"
-	depends on (64BIT || LBDAF)
 	select FS_POSIX_ACL
 	select CRC32
 	select LIBCRC32C
diff --git a/fs/nfs/Kconfig b/fs/nfs/Kconfig
index 5f93cfacb3d1..69d02cf8cf37 100644
--- a/fs/nfs/Kconfig
+++ b/fs/nfs/Kconfig
@@ -121,7 +121,6 @@ config PNFS_FILE_LAYOUT
 config PNFS_BLOCK
 	tristate
 	depends on NFS_V4_1 && BLK_DEV_DM
-	depends on 64BIT || LBDAF
 	default NFS_V4
 
 config PNFS_FLEXFILE_LAYOUT
diff --git a/fs/ocfs2/super.c b/fs/ocfs2/super.c
index 96ae7cedd487..fc3d29eceb2f 100644
--- a/fs/ocfs2/super.c
+++ b/fs/ocfs2/super.c
@@ -600,7 +600,6 @@ static unsigned long long ocfs2_max_file_offset(unsigned int bbits,
 	 */
 
 #if BITS_PER_LONG == 32
-# if defined(CONFIG_LBDAF)
 	BUILD_BUG_ON(sizeof(sector_t) != 8);
 	/*
 	 * We might be limited by page cache size.
@@ -614,15 +613,6 @@ static unsigned long long ocfs2_max_file_offset(unsigned int bbits,
 		 */
 		bitshift = 31;
 	}
-# else
-	/*
-	 * We are limited by the size of sector_t. Use block size, as
-	 * that's what we expose to the VFS.
-	 */
-	bytes = 1 << bbits;
-	trim = 1;
-	bitshift = 31;
-# endif
 #endif
 
 	/*
diff --git a/fs/stack.c b/fs/stack.c
index a54e33ed10f1..664ed35558bd 100644
--- a/fs/stack.c
+++ b/fs/stack.c
@@ -21,11 +21,10 @@ void fsstack_copy_inode_size(struct inode *dst, struct inode *src)
 	i_size = i_size_read(src);
 
 	/*
-	 * But if CONFIG_LBDAF (on 32-bit), we ought to make an effort to
-	 * keep the two halves of i_blocks in sync despite SMP or PREEMPT -
-	 * though stat's generic_fillattr() doesn't bother, and we won't be
-	 * applying quotas (where i_blocks does become important) at the
-	 * upper level.
+	 * But on 32-bit, we ought to make an effort to keep the two halves of
+	 * i_blocks in sync despite SMP or PREEMPT - though stat's
+	 * generic_fillattr() doesn't bother, and we won't be applying quotas
+	 * (where i_blocks does become important) at the upper level.
 	 *
 	 * We don't actually know what locking is used at the lower level;
 	 * but if it's a filesystem that supports quotas, it will be using
@@ -44,9 +43,9 @@ void fsstack_copy_inode_size(struct inode *dst, struct inode *src)
 	 * include/linux/fs.h).  We don't necessarily hold i_mutex when this
 	 * is called, so take i_lock for that case.
 	 *
-	 * And if CONFIG_LBDAF (on 32-bit), continue our effort to keep the
-	 * two halves of i_blocks in sync despite SMP or PREEMPT: use i_lock
-	 * for that case too, and do both at once by combining the tests.
+	 * And if on 32-bit, continue our effort to keep the two halves of
+	 * i_blocks in sync despite SMP or PREEMPT: use i_lock  for that case
+	 * too, and do both at once by combining the tests.
 	 *
 	 * There is none of this locking overhead in the 64-bit case.
 	 */
diff --git a/fs/xfs/Kconfig b/fs/xfs/Kconfig
index 457ac9f97377..99af5e5bda9f 100644
--- a/fs/xfs/Kconfig
+++ b/fs/xfs/Kconfig
@@ -1,7 +1,6 @@
 config XFS_FS
 	tristate "XFS filesystem support"
 	depends on BLOCK
-	depends on (64BIT || LBDAF)
 	select EXPORTFS
 	select LIBCRC32C
 	select FS_IOMAP
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index f093ea244849..703b6be063ef 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -539,26 +539,18 @@ xfs_max_file_offset(
 
 	/* Figure out maximum filesize, on Linux this can depend on
 	 * the filesystem blocksize (on 32 bit platforms).
-	 * __block_write_begin does this in an [unsigned] long...
+	 * __block_write_begin does this in an [unsigned] long long...
 	 *      page->index << (PAGE_SHIFT - bbits)
 	 * So, for page sized blocks (4K on 32 bit platforms),
 	 * this wraps at around 8Tb (hence MAX_LFS_FILESIZE which is
 	 *      (((u64)PAGE_SIZE << (BITS_PER_LONG-1))-1)
 	 * but for smaller blocksizes it is less (bbits = log2 bsize).
-	 * Note1: get_block_t takes a long (implicit cast from above)
-	 * Note2: The Large Block Device (LBD and HAVE_SECTOR_T) patch
-	 * can optionally convert the [unsigned] long from above into
-	 * an [unsigned] long long.
 	 */
 
 #if BITS_PER_LONG == 32
-# if defined(CONFIG_LBDAF)
 	ASSERT(sizeof(sector_t) == 8);
 	pagefactor = PAGE_SIZE;
 	bitshift = BITS_PER_LONG;
-# else
-	pagefactor = PAGE_SIZE >> (PAGE_SHIFT - blockshift);
-# endif
 #endif
 
 	return (((uint64_t)pagefactor) << bitshift) - 1;
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 06c0fd594097..98076b1b5e48 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -714,7 +714,7 @@ static inline void hd_free_part(struct hd_struct *part)
  */
 static inline sector_t part_nr_sects_read(struct hd_struct *part)
 {
-#if BITS_PER_LONG==32 && defined(CONFIG_LBDAF) && defined(CONFIG_SMP)
+#if BITS_PER_LONG==32 && defined(CONFIG_SMP)
 	sector_t nr_sects;
 	unsigned seq;
 	do {
@@ -722,7 +722,7 @@ static inline sector_t part_nr_sects_read(struct hd_struct *part)
 		nr_sects = part->nr_sects;
 	} while (read_seqcount_retry(&part->nr_sects_seq, seq));
 	return nr_sects;
-#elif BITS_PER_LONG==32 && defined(CONFIG_LBDAF) && defined(CONFIG_PREEMPT)
+#elif BITS_PER_LONG==32 && defined(CONFIG_PREEMPT)
 	sector_t nr_sects;
 
 	preempt_disable();
@@ -741,11 +741,11 @@ static inline sector_t part_nr_sects_read(struct hd_struct *part)
  */
 static inline void part_nr_sects_write(struct hd_struct *part, sector_t size)
 {
-#if BITS_PER_LONG==32 && defined(CONFIG_LBDAF) && defined(CONFIG_SMP)
+#if BITS_PER_LONG==32 && defined(CONFIG_SMP)
 	write_seqcount_begin(&part->nr_sects_seq);
 	part->nr_sects = size;
 	write_seqcount_end(&part->nr_sects_seq);
-#elif BITS_PER_LONG==32 && defined(CONFIG_LBDAF) && defined(CONFIG_PREEMPT)
+#elif BITS_PER_LONG==32 && defined(CONFIG_PREEMPT)
 	preempt_disable();
 	part->nr_sects = size;
 	preempt_enable();
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 34a5036debd3..24ef5a018a5e 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -17,6 +17,7 @@
 #include <asm/byteorder.h>
 #include <asm/div64.h>
 #include <uapi/linux/kernel.h>
+#include <asm/div64.h>
 
 #define STACK_MAGIC	0xdeadbeef
 
@@ -175,18 +176,7 @@
 #define _RET_IP_		(unsigned long)__builtin_return_address(0)
 #define _THIS_IP_  ({ __label__ __here; __here: (unsigned long)&&__here; })
 
-#ifdef CONFIG_LBDAF
-# define sector_div(a, b) do_div(a, b)
-#else
-# define sector_div(n, b)( \
-{ \
-	int _res; \
-	_res = (n) % (b); \
-	(n) /= (b); \
-	_res; \
-} \
-)
-#endif
+#define sector_div(a, b) do_div(a, b)
 
 /**
  * upper_32_bits - return bits 32-63 of a number
diff --git a/include/linux/types.h b/include/linux/types.h
index cc0dbbe551d5..231114ae38f4 100644
--- a/include/linux/types.h
+++ b/include/linux/types.h
@@ -127,13 +127,8 @@ typedef s64			int64_t;
  *
  * blkcnt_t is the type of the inode's block count.
  */
-#ifdef CONFIG_LBDAF
 typedef u64 sector_t;
 typedef u64 blkcnt_t;
-#else
-typedef unsigned long sector_t;
-typedef unsigned long blkcnt_t;
-#endif
 
 /*
  * The type of an index into the pagecache.
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 0d9e81779e37..d8781786cf63 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1927,7 +1927,6 @@ config TEST_STATIC_KEYS
 config TEST_KMOD
 	tristate "kmod stress tester"
 	depends on m
-	depends on BLOCK && (64BIT || LBDAF)	  # for XFS, BTRFS
 	depends on NETDEVICES && NET_CORE && INET # for TUN
 	select TEST_LKM
 	select XFS_FS
diff --git a/tools/testing/selftests/rcutorture/formal/srcu-cbmc/include/linux/types.h b/tools/testing/selftests/rcutorture/formal/srcu-cbmc/include/linux/types.h
index d27285f8ee82..8bc960e5e713 100644
--- a/tools/testing/selftests/rcutorture/formal/srcu-cbmc/include/linux/types.h
+++ b/tools/testing/selftests/rcutorture/formal/srcu-cbmc/include/linux/types.h
@@ -59,11 +59,7 @@ typedef		__u32		uint32_t;
  *
  * blkcnt_t is the type of the inode's block count.
  */
-#ifdef CONFIG_LBDAF
 typedef u64 sector_t;
-#else
-typedef unsigned long sector_t;
-#endif
 
 /*
  * The type of an index into the pagecache.
-- 
2.20.1

