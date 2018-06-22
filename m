Return-Path: <linux-block-owner@vger.kernel.org>
Received: from albert.telenet-ops.be ([195.130.137.90]:52250 "EHLO
        albert.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751377AbeFVLFh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Jun 2018 07:05:37 -0400
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Matias Bjorling <mb@lightnvm.io>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH v4] lightnvm: Remove depends on HAS_DMA in case of platform dependency
Date: Fri, 22 Jun 2018 13:05:35 +0200
Message-Id: <20180622110535.31796-1-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Remove dependencies on HAS_DMA where a Kconfig symbol depends on another
symbol that implies HAS_DMA, and, optionally, on "|| COMPILE_TEST".
In most cases this other symbol is an architecture or platform specific
symbol, or PCI.

Generic symbols and drivers without platform dependencies keep their
dependencies on HAS_DMA, to prevent compiling subsystems or drivers that
cannot work anyway.

This simplifies the dependencies, and allows to improve compile-testing.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Reviewed-by: Mark Brown <broonie@kernel.org>
Acked-by: Robin Murphy <robin.murphy@arm.com>
Reviewed-by: Matias Bjørling <mb@lightnvm.io>
---
v4:
  - Rebase to v4.18-rc1 (applies to next-20180622, too),

v3:
  - Add Reviewed-by,
  - Rebase to v4.17-rc1,
  - Removed bogus notes,

v2:
  - Add Reviewed-by, Acked-by,
  - Drop RFC state,
  - Split per subsystem.
---
 drivers/lightnvm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/lightnvm/Kconfig b/drivers/lightnvm/Kconfig
index 10c08982185a572f..9c03f35d9df113c6 100644
--- a/drivers/lightnvm/Kconfig
+++ b/drivers/lightnvm/Kconfig
@@ -4,7 +4,7 @@
 
 menuconfig NVM
 	bool "Open-Channel SSD target support"
-	depends on BLOCK && HAS_DMA && PCI
+	depends on BLOCK && PCI
 	select BLK_DEV_NVME
 	help
 	  Say Y here to get to enable Open-channel SSDs.
-- 
2.17.1
