Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:30594 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S947383AbcJaWDu (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 31 Oct 2016 18:03:50 -0400
From: Scott Bauer <scott.bauer@intel.com>
To: linux-nvme@lists.infradead.org
Cc: Rafael.Antognolli@intel.com, axboe@fb.com, keith.busch@intel.com,
        jonathan.derrick@intel.com, j.naumann@fu-berlin.de,
        hch@infradead.org, linux-block@vger.kernel.org,
        Scott Bauer <scott.bauer@intel.com>
Subject: [RFC PATCH 4/6] include: Add sec_ops to block device operations
Date: Mon, 31 Oct 2016 15:58:17 -0600
Message-Id: <1477951099-3127-5-git-send-email-scott.bauer@intel.com>
In-Reply-To: <1477951099-3127-1-git-send-email-scott.bauer@intel.com>
References: <1477951099-3127-1-git-send-email-scott.bauer@intel.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Signed-off-by: Scott Bauer <scott.bauer@intel.com>
Signed-off-by: Rafael Antognolli <Rafael.Antognolli@intel.com>
---
 include/linux/blkdev.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index c47c358..6fceff1 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1690,6 +1690,7 @@ struct block_device_operations {
 	void (*swap_slot_free_notify) (struct block_device *, unsigned long);
 	struct module *owner;
 	const struct pr_ops *pr_ops;
+	struct sec_ops *sec_ops;
 };
 
 extern int __blkdev_driver_ioctl(struct block_device *, fmode_t, unsigned int,
-- 
2.7.4

