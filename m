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
	Jens Axboe <axboe@kernel.dk>,
	Logan Gunthorpe <logang@deltatee.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Vinod Koul <vinod.koul@intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Thierry Reding <treding@nvidia.com>,
	Sanyog Kale <sanyog.r.kale@intel.com>,
	Sagar Dharia <sdharia@codeaurora.org>
Date: Thu,  4 Oct 2018 15:27:39 -0600
Message-Id: <20181004212747.6301-6-logang@deltatee.com>
In-Reply-To: <20181004212747.6301-1-logang@deltatee.com>
References: <20181004212747.6301-1-logang@deltatee.com>
MIME-Version: 1.0
Subject: [PATCH v9 05/13] docs-rst: Add a new directory for PCI documentation
List-ID: <linux-block@vger.kernel.org>

Add a new directory in the driver API guide for PCI specific
documentation.

This is in preparation for adding a new PCI P2P DMA driver writers
guide which will go in this directory.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Vinod Koul <vinod.koul@intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Logan Gunthorpe <logang@deltatee.com>
Cc: Thierry Reding <treding@nvidia.com>
Cc: Sanyog Kale <sanyog.r.kale@intel.com>
Cc: Sagar Dharia <sdharia@codeaurora.org>
---
 Documentation/driver-api/index.rst         |  2 +-
 Documentation/driver-api/pci/index.rst     | 20 ++++++++++++++++++++
 Documentation/driver-api/{ => pci}/pci.rst |  0
 3 files changed, 21 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/driver-api/pci/index.rst
 rename Documentation/driver-api/{ => pci}/pci.rst (100%)

diff --git a/Documentation/driver-api/index.rst b/Documentation/driver-api/index.rst
index 6d9f2f9fe20e..e9e7d24169cf 100644
--- a/Documentation/driver-api/index.rst
+++ b/Documentation/driver-api/index.rst
@@ -29,7 +29,7 @@ available subsections can be seen below.
    iio/index
    input
    usb/index
-   pci
+   pci/index
    spi
    i2c
    hsi
diff --git a/Documentation/driver-api/pci/index.rst b/Documentation/driver-api/pci/index.rst
new file mode 100644
index 000000000000..eaf20b24bf7d
--- /dev/null
+++ b/Documentation/driver-api/pci/index.rst
@@ -0,0 +1,20 @@
+.. SPDX-License-Identifier: GPL-2.0
+============================================
+The Linux PCI driver implementer's API guide
+============================================
+
+.. class:: toc-title
+
+	   Table of contents
+
+.. toctree::
+   :maxdepth: 2
+
+   pci
+
+.. only::  subproject and html
+
+   Indices
+   =======
+
+   * :ref:`genindex`
diff --git a/Documentation/driver-api/pci.rst b/Documentation/driver-api/pci/pci.rst
similarity index 100%
rename from Documentation/driver-api/pci.rst
rename to Documentation/driver-api/pci/pci.rst
-- 
2.19.0
