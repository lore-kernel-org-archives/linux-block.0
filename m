Return-Path: <gunthorp@deltatee.com>
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-rdma@vger.kernel.org,
	linux-nvdimm@lists.01.org,
	linux-block@vger.kernel.org
Cc: Stephen Bates <sbates@raithlin.com>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Keith Busch <keith.busch@intel.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jason Gunthorpe <jgg@mellanox.com>,
	Max Gurtovoy <maxg@mellanox.com>,
	Dan Williams <dan.j.williams@intel.com>,
	=?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Logan Gunthorpe <logang@deltatee.com>
Date: Mon, 23 Apr 2018 17:30:36 -0600
Message-Id: <20180423233046.21476-5-logang@deltatee.com>
In-Reply-To: <20180423233046.21476-1-logang@deltatee.com>
References: <20180423233046.21476-1-logang@deltatee.com>
Subject: [PATCH v4 04/14] PCI/P2PDMA: Clear ACS P2P flags for all devices behind switches
List-ID: <linux-block@vger.kernel.org>

For peer-to-peer transactions to work the downstream ports in each
switch must not have the ACS flags set. At this time there is no way
to dynamically change the flags and update the corresponding IOMMU
groups so this is done at enumeration time before the groups are
assigned.

This effectively means that if CONFIG_PCI_P2PDMA is selected then
all devices behind any PCIe switch heirarchy will be in the same IOMMU
group. Which implies that individual devices behind any switch
heirarchy will not be able to be assigned to separate VMs because
there is no isolation between them. Additionally, any malicious PCIe
devices will be able to DMA to memory exposed by other EPs in the same
domain as TLPs will not be checked by the IOMMU.

Given that the intended use case of P2P Memory is for users with
custom hardware designed for purpose, we do not expect distributors
to ever need to enable this option. Users that want to use P2P
must have compiled a custom kernel with this configuration option
and understand the implications regarding ACS. They will either
not require ACS or will have design the system in such a way that
devices that require isolation will be separate from those using P2P
transactions.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/pci/Kconfig        |  9 +++++++++
 drivers/pci/p2pdma.c       | 45 ++++++++++++++++++++++++++++++---------------
 drivers/pci/pci.c          |  6 ++++++
 include/linux/pci-p2pdma.h |  5 +++++
 4 files changed, 50 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index b2396c22b53e..b6db41d4b708 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -139,6 +139,15 @@ config PCI_P2PDMA
 	  transations must be between devices behind the same root port.
 	  (Typically behind a network of PCIe switches).
 
+	  Enabling this option will also disable ACS on all ports behind
+	  any PCIe switch. This effectively puts all devices behind any
+	  switch heirarchy into the same IOMMU group. Which implies that
+	  individual devices behind any switch will not be able to be
+	  assigned to separate VMs because there is no isolation between
+	  them. Additionally, any malicious PCIe devices will be able to
+	  DMA to memory exposed by other EPs in the same domain as TLPs
+	  will not be checked by the IOMMU.
+
 	  If unsure, say N.
 
 config PCI_LABEL
diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index ed9dce8552a2..e9f43b43acac 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -240,27 +240,42 @@ static struct pci_dev *find_parent_pci_dev(struct device *dev)
 }
 
 /*
- * If a device is behind a switch, we try to find the upstream bridge
- * port of the switch. This requires two calls to pci_upstream_bridge():
- * one for the upstream port on the switch, one on the upstream port
- * for the next level in the hierarchy. Because of this, devices connected
- * to the root port will be rejected.
+ * pci_p2pdma_disable_acs - disable ACS flags for all PCI bridges
+ * @pdev: device to disable ACS flags for
+ *
+ * The ACS flags for P2P Request Redirect and P2P Completion Redirect need
+ * to be disabled on any PCI bridge in order for the TLPS to not be forwarded
+ * up to the RC which is not what we want for P2P.
+ *
+ * This function is called when the devices are first enumerated and
+ * will result in all devices behind any bridge to be in the same IOMMU
+ * group. At this time, there is no way to "hotplug" IOMMU groups so we rely
+ * on this largish hammer. If you need the devices to be in separate groups
+ * don't enable CONFIG_PCI_P2PDMA.
+ *
+ * Returns 1 if the ACS bits for this device was cleared, otherwise 0.
  */
-static struct pci_dev *get_upstream_bridge_port(struct pci_dev *pdev)
+int pci_p2pdma_disable_acs(struct pci_dev *pdev)
 {
-	struct pci_dev *up1, *up2;
+	int pos;
+	u16 ctrl;
 
-	if (!pdev)
-		return NULL;
+	if (!pci_is_bridge(pdev))
+		return 0;
 
-	up1 = pci_dev_get(pci_upstream_bridge(pdev));
-	if (!up1)
-		return NULL;
+	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_ACS);
+	if (!pos)
+		return 0;
+
+	pci_info(pdev, "disabling ACS flags for peer-to-peer DMA\n");
+
+	pci_read_config_word(pdev, pos + PCI_ACS_CTRL, &ctrl);
+
+	ctrl &= ~(PCI_ACS_RR | PCI_ACS_CR);
 
-	up2 = pci_dev_get(pci_upstream_bridge(up1));
-	pci_dev_put(up1);
+	pci_write_config_word(pdev, pos + PCI_ACS_CTRL, ctrl);
 
-	return up2;
+	return 1;
 }
 
 /*
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index e597655a5643..7e2f5724ba22 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -16,6 +16,7 @@
 #include <linux/of.h>
 #include <linux/of_pci.h>
 #include <linux/pci.h>
+#include <linux/pci-p2pdma.h>
 #include <linux/pm.h>
 #include <linux/slab.h>
 #include <linux/module.h>
@@ -2835,6 +2836,11 @@ static void pci_std_enable_acs(struct pci_dev *dev)
  */
 void pci_enable_acs(struct pci_dev *dev)
 {
+#ifdef CONFIG_PCI_P2PDMA
+	if (pci_p2pdma_disable_acs(dev))
+		return;
+#endif
+
 	if (!pci_acs_enable)
 		return;
 
diff --git a/include/linux/pci-p2pdma.h b/include/linux/pci-p2pdma.h
index 0cde88341eeb..fcb3437a2f3c 100644
--- a/include/linux/pci-p2pdma.h
+++ b/include/linux/pci-p2pdma.h
@@ -18,6 +18,7 @@ struct block_device;
 struct scatterlist;
 
 #ifdef CONFIG_PCI_P2PDMA
+int pci_p2pdma_disable_acs(struct pci_dev *pdev);
 int pci_p2pdma_add_resource(struct pci_dev *pdev, int bar, size_t size,
 		u64 offset);
 int pci_p2pdma_add_client(struct list_head *head, struct device *dev);
@@ -40,6 +41,10 @@ int pci_p2pdma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
 void pci_p2pdma_unmap_sg(struct device *dev, struct scatterlist *sg, int nents,
 			 enum dma_data_direction dir);
 #else /* CONFIG_PCI_P2PDMA */
+static inline int pci_p2pdma_disable_acs(struct pci_dev *pdev)
+{
+	return 0;
+}
 static inline int pci_p2pdma_add_resource(struct pci_dev *pdev, int bar,
 		size_t size, u64 offset)
 {
-- 
2.11.0
