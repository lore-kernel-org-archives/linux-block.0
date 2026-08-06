Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC0E25A2DD
	for <linux-block@vger.kernel.org>; Thu,  6 Aug 2026 06:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785996310; cv=none; b=U6KxDBOGOHNf176ByJ7j2pdBgKpNbQQkwemrsfL/biu7lsmw81oq01vv+SGeJcRO1sIcMOsxMDLFD19Y7Ssrusb800XTTWUMMq3bDNwJ/BHuWgd8w7ddLiYG2OIFvhM19ZXF/Dj20jaRctWVNXxbxVwocQTuIqDZ9SUN59M4NGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785996310; c=relaxed/simple;
	bh=D0jxbcB7of1MNyozyUI9VTXVdLrAuN1V+QQdQZmtCRg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JqMKpQU8kA6SXJPFWHVWDZ+qvbZUDEsJ1ksjydhxe8YJrpamG+hvLcL2x7/T66m4mCj+6rUu8ZF3IN7XLzUlnH8VvWOGXBlCP7qrnZXoKvzd7aGOVCBaeDpDUXaEznCtgHg5CeJ4/xttuR1A5UkQIwXG4zRkIXgoFpSt2c/Y6/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=l8+PXWaA; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="l8+PXWaA"
Received: from LAPTOP-99KJFSET (unknown [36.153.54.46])
	by smtp.qiye.163.com (Hmail) with ESMTP id 48fb94a0f;
	Thu, 6 Aug 2026 14:04:54 +0800 (GMT+08:00)
From: Hongyan Xu <getshell@seu.edu.cn>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	jianhao.xu@seu.edu.cn,
	Hongyan Xu <getshell@seu.edu.cn>
Subject: [PATCH] block: mtip32xx: synchronize ioctls with device removal
Date: Thu,  6 Aug 2026 14:04:41 +0800
Message-ID: <20260806060441.676-1-getshell@seu.edu.cn>
X-Mailer: git-send-email 2.50.1.windows.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9fd5acabf603a1kunmc012de0c289298
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDSR1IVk5CSx5NHxkZTUtDTlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlITVVKTkhVTk9VT01ZV1kWGg8SFR0UWUFZT0tIVUpLSEpPSE
	xVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=l8+PXWaAUiRHoA5ZdtKAR3hZdkBb/JLXeCqfjZ1N6wQvSXqeCHqQksMDv6hkWclJ5ohGbW3W6TunsEPJUD6pqJngB+0uXvtvMHXkP146vAM57S4s5KfysYpmCeoV6t0siXRcRVe1e8otQCh5Y1eHTroNoNpWUc2RI1pM9ThvB/A=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=cK1qcdFqMaA9K2xKPBm4tZmn60ftPKT5i1PScX/IiSE=;
	h=date:mime-version:subject:message-id:from;

The ioctl handlers only test REMOVE_PENDING before entering
mtip_hw_ioctl(). Removal can set that bit immediately afterwards and free
dd->port in mtip_hw_exit() while an ioctl still dereferences it. An already
open block device can reach the handlers while del_gendisk() is in
progress.

Serialize both native and compat ioctls with removal. Set REMOVE_PENDING
before taking the mutex so new callers fail after an in-flight ioctl has
drained, and hold the mutex until the port has been torn down.

Fixes: 88523a61558a ("block: Add driver for Micron RealSSD pcie flash cards")
Signed-off-by: Hongyan Xu <getshell@seu.edu.cn>
---
 drivers/block/mtip32xx/mtip32xx.c | 7 +++++++
 drivers/block/mtip32xx/mtip32xx.h | 2 ++
 2 files changed, 9 insertions(+)

diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/mtip32xx.c
index f214a616386c..113bdb868c46 100644
--- a/drivers/block/mtip32xx/mtip32xx.c
+++ b/drivers/block/mtip32xx/mtip32xx.c
@@ -3048,6 +3048,8 @@ static int mtip_block_ioctl(struct block_device *dev,
 	if (!dd)
 		return -ENOTTY;
 
+	guard(mutex)(&dd->ioctl_mutex);
+
 	if (unlikely(test_bit(MTIP_DDF_REMOVE_PENDING_BIT, &dd->dd_flag)))
 		return -ENOTTY;
 
@@ -3086,6 +3088,8 @@ static int mtip_block_compat_ioctl(struct block_device *dev,
 	if (!dd)
 		return -ENOTTY;
 
+	guard(mutex)(&dd->ioctl_mutex);
+
 	if (unlikely(test_bit(MTIP_DDF_REMOVE_PENDING_BIT, &dd->dd_flag)))
 		return -ENOTTY;
 
@@ -3721,6 +3725,7 @@ static int mtip_pci_probe(struct pci_dev *pdev,
 	dd = kzalloc_node(sizeof(struct driver_data), GFP_KERNEL, my_node);
 	if (!dd)
 		return -ENOMEM;
+	mutex_init(&dd->ioctl_mutex);
 
 	/* Attach the private data to this PCI device.  */
 	pci_set_drvdata(pdev, dd);
@@ -3887,6 +3892,7 @@ static void mtip_pci_remove(struct pci_dev *pdev)
 	}
 
 	set_bit(MTIP_DDF_REMOVE_PENDING_BIT, &dd->dd_flag);
+	mutex_lock(&dd->ioctl_mutex);
 
 	if (test_bit(MTIP_DDF_INIT_DONE_BIT, &dd->dd_flag))
 		del_gendisk(dd->disk);
@@ -3915,6 +3921,7 @@ static void mtip_pci_remove(struct pci_dev *pdev)
 
 	/* De-initialize the protocol layer. */
 	mtip_hw_exit(dd);
+	mutex_unlock(&dd->ioctl_mutex);
 
 	if (dd->isr_workq) {
 		destroy_workqueue(dd->isr_workq);
diff --git a/drivers/block/mtip32xx/mtip32xx.h b/drivers/block/mtip32xx/mtip32xx.h
index f7328f19ac5c..0963c07b5845 100644
--- a/drivers/block/mtip32xx/mtip32xx.h
+++ b/drivers/block/mtip32xx/mtip32xx.h
@@ -12,6 +12,7 @@
 #define __MTIP32XX_H__
 
 #include <linux/spinlock.h>
+#include <linux/mutex.h>
 #include <linux/rwsem.h>
 #include <linux/ata.h>
 #include <linux/interrupt.h>
@@ -432,6 +433,7 @@ struct driver_data {
 	struct request_queue *queue; /* Our request queue. */
 
 	struct blk_mq_tag_set tags; /* blk_mq tags */
+	struct mutex ioctl_mutex;
 
 	struct mtip_port *port; /* Pointer to the port data structure. */
 
-- 
2.50.1.windows.1

