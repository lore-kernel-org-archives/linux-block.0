Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDA7136E;
	Fri,  4 Jul 2025 09:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751621463; cv=none; b=EUnEcKsbssFDeUbpi+/h6SSvGBr4rFVm5xjAqH1iD1LQW1yirs6KK8oa9wA43ZWOsNrfcps1V6IDxJyAHNjrXaEWhlEgGKw/bubHDC2Tzc+pqng8F/gxJhtbjuydZSUWIqfI66znhWWuaeE5J8NKjv7AI19eZM0/L8FNoLqbr9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751621463; c=relaxed/simple;
	bh=DgJEirE2drDPGSXFXC0f/QIbKHo7uI3B5qoI9iYxmoc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gCiT0XbJb/YI3JA79BGM89JJrAcjrGuJBXT1WaeUKYj+E4MAnKTmIxICgL0dfT7cv6y7n6WG1o2k2prifEKL71A9KmaWxxZgjjAYzsyPVVknRcfNhcbI/W29uXJceVDpuK0n8IPu9wh1K3m78D9fdnI+CVKzs69cQXouXz2UED0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=pankajraghav.com; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4bYSnK2YHbz9t29;
	Fri,  4 Jul 2025 11:21:41 +0200 (CEST)
From: Pankaj Raghav <p.raghav@samsung.com>
To: Matthew Wilcox <willy@infradead.org>,
	Hannes Reinecke <hare@suse.de>,
	mcgrof@kernel.org,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	gost.dev@samsung.com,
	kernel@pankajraghav.com,
	hch@lst.de,
	Christian Brauner <brauner@kernel.org>,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH] block: reject bs > ps block devices when THP is disabled
Date: Fri,  4 Jul 2025 11:21:34 +0200
Message-ID: <20250704092134.289491-1-p.raghav@samsung.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If THP is disabled and when a block device with logical block size >
page size is present, the following null ptr deref panic happens during
boot:

[   [13.2 mK  AOSAN: null-ptr-deref in range [0x0000000000000000-0x0000000000K0 0 0[07]
[   13.017749] RIP: 0010:create_empty_buffers+0x3b/0x380
<snip>
[   13.025448] Call Trace:
[   13.025692]  <TASK>
[   13.025895]  block_read_full_folio+0x610/0x780
[   13.026379]  ? __pfx_blkdev_get_block+0x10/0x10
[   13.027008]  ? __folio_batch_add_and_move+0x1fa/0x2b0
[   13.027548]  ? __pfx_blkdev_read_folio+0x10/0x10
[   13.028080]  filemap_read_folio+0x9b/0x200
[   13.028526]  ? __pfx_filemap_read_folio+0x10/0x10
[   13.029030]  ? __filemap_get_folio+0x43/0x620
[   13.029497]  do_read_cache_folio+0x155/0x3b0
[   13.029962]  ? __pfx_blkdev_read_folio+0x10/0x10
[   13.030381]  read_part_sector+0xb7/0x2a0
[   13.030805]  read_lba+0x174/0x2c0
<snip>
[   13.045348]  nvme_scan_ns+0x684/0x850 [nvme_core]
[   13.045858]  ? __pfx_nvme_scan_ns+0x10/0x10 [nvme_core]
[   13.046414]  ? _raw_spin_unlock+0x15/0x40
[   13.046843]  ? __switch_to+0x523/0x10a0
[   13.047253]  ? kvm_clock_get_cycles+0x14/0x30
[   13.047742]  ? __pfx_nvme_scan_ns_async+0x10/0x10 [nvme_core]
[   13.048353]  async_run_entry_fn+0x96/0x4f0
[   13.048787]  process_one_work+0x667/0x10a0
[   13.049219]  worker_thread+0x63c/0xf60

As large folio support depends on THP, only allow bs > ps block devices
if THP is enabled.

Fixes: 47dd67532303 ("block/bdev: lift block size restrictions to 64k")
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 include/linux/blkdev.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 82348fcc2455..724ddc40f35c 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -270,11 +270,16 @@ static inline dev_t disk_devt(struct gendisk *disk)
 	return MKDEV(disk->major, disk->first_minor);
 }
 
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
 /*
  * We should strive for 1 << (PAGE_SHIFT + MAX_PAGECACHE_ORDER)
  * however we constrain this to what we can validate and test.
  */
 #define BLK_MAX_BLOCK_SIZE      SZ_64K
+#else
+#define BLK_MAX_BLOCK_SIZE      PAGE_SIZE
+#endif
+
 
 /* blk_validate_limits() validates bsize, so drivers don't usually need to */
 static inline int blk_validate_block_size(unsigned long bsize)

base-commit: 8d6c58332c7a8ba025fcfa76888b6c37dbce9633
-- 
2.49.0

