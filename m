Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:55780 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932886AbcKPXZR (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Nov 2016 18:25:17 -0500
From: Scott Bauer <scott.bauer@intel.com>
To: linux-nvme@lists.infradead.org
Cc: Rafael.Antognolli@intel.com, axboe@fb.com, keith.busch@intel.com,
        jonathan.derrick@intel.com, j.naumann@fu-berlin.de,
        hch@infradead.org, linux-block@vger.kernel.org, sagi@grimberg.me,
        Scott Bauer <scott.bauer@intel.com>
Subject: [PATCH v1 4/7] include: Add sec_ops to block device operations
Date: Wed, 16 Nov 2016 16:17:29 -0700
Message-Id: <1479338252-8777-5-git-send-email-scott.bauer@intel.com>
In-Reply-To: <1479338252-8777-1-git-send-email-scott.bauer@intel.com>
References: <1479338252-8777-1-git-send-email-scott.bauer@intel.com>
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

