Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:46281 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753125AbdBARxT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 1 Feb 2017 12:53:19 -0500
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id v11HrE32025737
        for <linux-block@vger.kernel.org>; Wed, 1 Feb 2017 09:53:18 -0800
Received: from mail.thefacebook.com ([199.201.64.23])
        by mx0a-00082601.pphosted.com with ESMTP id 28b40tb3ur-3
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT)
        for <linux-block@vger.kernel.org>; Wed, 01 Feb 2017 09:53:18 -0800
Received: from facebook.com (2401:db00:21:603d:face:0:19:0)     by
 mx-out.facebook.com (10.212.232.59) with ESMTP id
 4fb0258ae8a711e69b2c0002c991e86a-c21f0a50 for <linux-block@vger.kernel.org>;
        Wed, 01 Feb 2017 09:53:17 -0800
From: Shaohua Li <shli@fb.com>
To: <linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>
CC: <bhelgaas@google.com>, <hch@lst.de>, <axboe@fb.com>
Subject: [PATCH V2 2/3] PCI: add an API to get node from vector
Date: Wed, 1 Feb 2017 09:53:15 -0800
Message-ID: <d0f9b1bda8c27f058c95f88015e013b9d8131dc0.1485971427.git.shli@fb.com>
In-Reply-To: <a52afb3e09691267f2240331ef0b9962f793703d.1485971427.git.shli@fb.com>
References: <a52afb3e09691267f2240331ef0b9962f793703d.1485971427.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Next patch will use the API to get the node from vector for nvme device

Signed-off-by: Shaohua Li <shli@fb.com>
---
 drivers/pci/msi.c   | 16 ++++++++++++++++
 include/linux/pci.h |  6 ++++++
 2 files changed, 22 insertions(+)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 50c5003..ab7aee7 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -1313,6 +1313,22 @@ const struct cpumask *pci_irq_get_affinity(struct pci_dev *dev, int nr)
 }
 EXPORT_SYMBOL(pci_irq_get_affinity);
 
+/**
+ * pci_irq_get_node - return the numa node of a particular msi vector
+ * @pdev:	PCI device to operate on
+ * @vec:	device-relative interrupt vector index (0-based).
+ */
+int pci_irq_get_node(struct pci_dev *pdev, int vec)
+{
+	const struct cpumask *mask;
+
+	mask = pci_irq_get_affinity(pdev, vec);
+	if (mask)
+		return local_memory_node(cpu_to_node(cpumask_first(mask)));
+	return dev_to_node(&pdev->dev);
+}
+EXPORT_SYMBOL(pci_irq_get_node);
+
 struct pci_dev *msi_desc_to_pci_dev(struct msi_desc *desc)
 {
 	return to_pci_dev(desc->dev);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index e2d1a12..df2c649 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1334,6 +1334,7 @@ int pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
 void pci_free_irq_vectors(struct pci_dev *dev);
 int pci_irq_vector(struct pci_dev *dev, unsigned int nr);
 const struct cpumask *pci_irq_get_affinity(struct pci_dev *pdev, int vec);
+int pci_irq_get_node(struct pci_dev *pdev, int vec);
 
 #else
 static inline int pci_msi_vec_count(struct pci_dev *dev) { return -ENOSYS; }
@@ -1384,6 +1385,11 @@ static inline const struct cpumask *pci_irq_get_affinity(struct pci_dev *pdev,
 {
 	return cpu_possible_mask;
 }
+
+static inline int pci_irq_get_node(struct pci_dev *pdev, int vec)
+{
+	return first_online_node;
+}
 #endif
 
 static inline int
-- 
2.9.3

