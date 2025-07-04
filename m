Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C76267B01;
	Fri,  4 Jul 2025 09:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751622656; cv=none; b=dfAg0W+61ygEvUcWj6WcYcpukyFTaW2ED/GsxLc+Ki+MecRydLeFQBZCUYKGm33Xc3zF9srzVmVIU5n/HkpUBTbAsNj7XZOrQ9iFvay09P2JXzfeKnVfRn61nbllpTxWKhbFVCUENTEpcZHt7DqsYf//xWYxqyA51cSpE8B+8s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751622656; c=relaxed/simple;
	bh=+R7T4cgd5ESZu7NKPcsY3aOZwYC1VTcKIPPnSChpUFI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qlQAU0CM15/YdqwaH9iKjOHTnnMWxysIMEnNGj56cVsetEmf9tOY3ECqqledIocEbfCIYXfn6l6iV2EyamBlW2GPhQs4BUGQ807T8bt5InoBDs7QkZ1t7uDuiBoxtE/EkrWF/A0ZP4jIdw/VF/vHKoYAnZcw9NVIWZG+YJRgwSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=MAvWNssD; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="MAvWNssD"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4bYTQs1r9kz9sv3;
	Fri,  4 Jul 2025 11:50:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1751622645;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=PxPJXmh6qUL371s8DUk4uxbv4gGBXgx13cBP4VPLwWY=;
	b=MAvWNssDHsI7RGGmLiHdwp7Ib3oeefB7b7dgxWE9XMC/Ut1lKY2CVOY026d6OSR0x49Qio
	Xr7RnCG9cesPYXJ2Of5Ijsvr1jYGSSN+zjc/KJNItkDs4F/Lu7EGIWYOE27Ax5Er1wvvyl
	KmpEGvSxQdMtWfraTifhdgN6S5kX6gUDt8Si+rW0sw77z79wZzoE5GCCd5JYHyzA0cUSbC
	GDhU3taM2Z2Vi1NggbY2Yhc9gjbEmXKsMBoTGY7PtH3LaTpHGAK2Y5WpD78RN0xhJG8MKx
	T8ajv2ZfDs4p8cVTV/hBHCeXo/4Z0hzTetYd1NEPwK+73+ybIJadtE4bkVnw+w==
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Matthew Wilcox <willy@infradead.org>,
	Hannes Reinecke <hare@suse.de>,
	mcgrof@kernel.org,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-kernel@vger.kernel.org,
	kernel@pankajraghav.com,
	hch@lst.de,
	linux-block@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	gost.dev@samsung.com,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: [PATCH v2] block: reject bs > ps block devices when THP is disabled
Date: Fri,  4 Jul 2025 11:50:36 +0200
Message-ID: <20250704095036.293568-1-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pankaj Raghav <p.raghav@samsung.com>

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
Changes since v1:
- Use mapping_max_folio_size_supported() instead of doing a ifdef with
  CONFIG_THP

 include/linux/blkdev.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 82348fcc2455..0c22ad8120da 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -26,6 +26,7 @@
 #include <linux/xarray.h>
 #include <linux/file.h>
 #include <linux/lockdep.h>
+#include <linux/pagemap.h>
 
 struct module;
 struct request_queue;
@@ -274,7 +275,7 @@ static inline dev_t disk_devt(struct gendisk *disk)
  * We should strive for 1 << (PAGE_SHIFT + MAX_PAGECACHE_ORDER)
  * however we constrain this to what we can validate and test.
  */
-#define BLK_MAX_BLOCK_SIZE      SZ_64K
+#define BLK_MAX_BLOCK_SIZE (min(mapping_max_folio_size_supported(), SZ_64K))
 
 /* blk_validate_limits() validates bsize, so drivers don't usually need to */
 static inline int blk_validate_block_size(unsigned long bsize)

base-commit: 8d6c58332c7a8ba025fcfa76888b6c37dbce9633
-- 
2.49.0

