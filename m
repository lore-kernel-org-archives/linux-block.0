Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:59868 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751622AbeDOPAg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 15 Apr 2018 11:00:36 -0400
From: Christoph Hellwig <hch@lst.de>
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        iommu@lists.linux-foundation.org
Cc: x86@kernel.org, linux-block@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-mm@kvack.org,
        linux-ide@vger.kernel.org, linux-mips@linux-mips.org,
        sparclinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 09/12] PCI: remove CONFIG_PCI_BUS_ADDR_T_64BIT
Date: Sun, 15 Apr 2018 16:59:44 +0200
Message-Id: <20180415145947.1248-10-hch@lst.de>
In-Reply-To: <20180415145947.1248-1-hch@lst.de>
References: <20180415145947.1248-1-hch@lst.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

This symbol is now always identical to CONFIG_ARCH_DMA_ADDR_T_64BIT, so
remove it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/pci/Kconfig | 4 ----
 drivers/pci/bus.c   | 4 ++--
 include/linux/pci.h | 2 +-
 3 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 34b56a8f8480..29a487f31dae 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -5,10 +5,6 @@
 
 source "drivers/pci/pcie/Kconfig"
 
-config PCI_BUS_ADDR_T_64BIT
-	def_bool y if (ARCH_DMA_ADDR_T_64BIT || 64BIT)
-	depends on PCI
-
 config PCI_MSI
 	bool "Message Signaled Interrupts (MSI and MSI-X)"
 	depends on PCI
diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index bc2ded4c451f..35b7fc87eac5 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -120,7 +120,7 @@ int devm_request_pci_bus_resources(struct device *dev,
 EXPORT_SYMBOL_GPL(devm_request_pci_bus_resources);
 
 static struct pci_bus_region pci_32_bit = {0, 0xffffffffULL};
-#ifdef CONFIG_PCI_BUS_ADDR_T_64BIT
+#ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
 static struct pci_bus_region pci_64_bit = {0,
 				(pci_bus_addr_t) 0xffffffffffffffffULL};
 static struct pci_bus_region pci_high = {(pci_bus_addr_t) 0x100000000ULL,
@@ -230,7 +230,7 @@ int pci_bus_alloc_resource(struct pci_bus *bus, struct resource *res,
 					  resource_size_t),
 		void *alignf_data)
 {
-#ifdef CONFIG_PCI_BUS_ADDR_T_64BIT
+#ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
 	int rc;
 
 	if (res->flags & IORESOURCE_MEM_64) {
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 73178a2fcee0..55371cb827ad 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -670,7 +670,7 @@ int raw_pci_read(unsigned int domain, unsigned int bus, unsigned int devfn,
 int raw_pci_write(unsigned int domain, unsigned int bus, unsigned int devfn,
 		  int reg, int len, u32 val);
 
-#ifdef CONFIG_PCI_BUS_ADDR_T_64BIT
+#ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
 typedef u64 pci_bus_addr_t;
 #else
 typedef u32 pci_bus_addr_t;
-- 
2.17.0
