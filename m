Return-Path: <BATV+fca8fac9a0a6ce832f12+5462+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: rdunlap@infradead.org,
	keescook@chromium.org,
	linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org
Subject: [PATCH] target/loop: depend on SCSI
Date: Tue,  7 Aug 2018 09:42:22 +0200
Message-Id: <20180807074222.22972-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

The target loopback driver is a low-level driver for the SCSI subsystem,
and as such needs to depend on it.

Fixes: 8a39a047 ("target: don't depend on SCSI")
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reported-by: Randy Dunlap <rdunlap@infradead.org>
---
 drivers/target/loopback/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/target/loopback/Kconfig b/drivers/target/loopback/Kconfig
index abe8ecbcdf06..158ee9d522f7 100644
--- a/drivers/target/loopback/Kconfig
+++ b/drivers/target/loopback/Kconfig
@@ -1,5 +1,6 @@
 config LOOPBACK_TARGET
 	tristate "TCM Virtual SAS target and Linux/SCSI LDD fabric loopback module"
+	depends on SCSI
 	help
 	  Say Y here to enable the TCM Virtual SAS target and Linux/SCSI LLD
 	  fabric loopback module.
-- 
2.18.0
