Return-Path: <linux-block-owner@vger.kernel.org>
Received: from ale.deltatee.com ([207.54.116.67]:40076 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726122AbeH3W5l (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Aug 2018 18:57:41 -0400
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-block@vger.kernel.org
Cc: Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
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
Date: Thu, 30 Aug 2018 12:53:41 -0600
Message-Id: <20180830185352.3369-3-logang@deltatee.com>
In-Reply-To: <20180830185352.3369-1-logang@deltatee.com>
References: <20180830185352.3369-1-logang@deltatee.com>
Subject: [PATCH v5 02/13] PCI/P2PDMA: Add sysfs group to display p2pmem stats
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Add a sysfs group to display statistics about P2P memory that is
registered in each PCI device.

Attributes in the group display the total amount of P2P memory, the
amount available and whether it is published or not.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 Documentation/ABI/testing/sysfs-bus-pci | 25 +++++++++++++++
 drivers/pci/p2pdma.c                    | 54 +++++++++++++++++++++++++++++++++
 2 files changed, 79 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
index 44d4b2be92fd..044812c816d0 100644
--- a/Documentation/ABI/testing/sysfs-bus-pci
+++ b/Documentation/ABI/testing/sysfs-bus-pci
@@ -323,3 +323,28 @@ Description:
 
 		This is similar to /sys/bus/pci/drivers_autoprobe, but
 		affects only the VFs associated with a specific PF.
+
+What:		/sys/bus/pci/devices/.../p2pmem/available
+Date:		November 2017
+Contact:	Logan Gunthorpe <logang@deltatee.com>
+Description:
+		If the device has any Peer-to-Peer memory registered, this
+	        file contains the amount of memory that has not been
+		allocated (in decimal).
+
+What:		/sys/bus/pci/devices/.../p2pmem/size
+Date:		November 2017
+Contact:	Logan Gunthorpe <logang@deltatee.com>
+Description:
+		If the device has any Peer-to-Peer memory registered, this
+	        file contains the total amount of memory that the device
+		provides (in decimal).
+
+What:		/sys/bus/pci/devices/.../p2pmem/published
+Date:		November 2017
+Contact:	Logan Gunthorpe <logang@deltatee.com>
+Description:
+		If the device has any Peer-to-Peer memory registered, this
+	        file contains a '1' if the memory has been published for
+		use inside the kernel or a '0' if it is only intended
+		for use within the driver that published it.
diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 88aaec5351cd..67c1daf1189e 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -25,6 +25,54 @@ struct pci_p2pdma {
 	bool p2pmem_published;
 };
 
+static ssize_t size_show(struct device *dev, struct device_attribute *attr,
+			 char *buf)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	size_t size = 0;
+
+	if (pdev->p2pdma->pool)
+		size = gen_pool_size(pdev->p2pdma->pool);
+
+	return snprintf(buf, PAGE_SIZE, "%zd\n", size);
+}
+static DEVICE_ATTR_RO(size);
+
+static ssize_t available_show(struct device *dev, struct device_attribute *attr,
+			      char *buf)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	size_t avail = 0;
+
+	if (pdev->p2pdma->pool)
+		avail = gen_pool_avail(pdev->p2pdma->pool);
+
+	return snprintf(buf, PAGE_SIZE, "%zd\n", avail);
+}
+static DEVICE_ATTR_RO(available);
+
+static ssize_t published_show(struct device *dev, struct device_attribute *attr,
+			      char *buf)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+
+	return snprintf(buf, PAGE_SIZE, "%d\n",
+			pdev->p2pdma->p2pmem_published);
+}
+static DEVICE_ATTR_RO(published);
+
+static struct attribute *p2pmem_attrs[] = {
+	&dev_attr_size.attr,
+	&dev_attr_available.attr,
+	&dev_attr_published.attr,
+	NULL,
+};
+
+static const struct attribute_group p2pmem_group = {
+	.attrs = p2pmem_attrs,
+	.name = "p2pmem",
+};
+
 static void pci_p2pdma_percpu_release(struct percpu_ref *ref)
 {
 	struct pci_p2pdma *p2p =
@@ -54,6 +102,7 @@ static void pci_p2pdma_release(void *data)
 	percpu_ref_exit(&pdev->p2pdma->devmap_ref);
 
 	gen_pool_destroy(pdev->p2pdma->pool);
+	sysfs_remove_group(&pdev->dev.kobj, &p2pmem_group);
 	pdev->p2pdma = NULL;
 }
 
@@ -84,9 +133,14 @@ static int pci_p2pdma_setup(struct pci_dev *pdev)
 
 	pdev->p2pdma = p2p;
 
+	error = sysfs_create_group(&pdev->dev.kobj, &p2pmem_group);
+	if (error)
+		goto out_pool_destroy;
+
 	return 0;
 
 out_pool_destroy:
+	pdev->p2pdma = NULL;
 	gen_pool_destroy(p2p->pool);
 out:
 	devm_kfree(&pdev->dev, p2p);
-- 
2.11.0
