Return-Path: <roman.penyaev@profitbricks.com>
Return-Path: <roman.penyaev@profitbricks.com>
From: Roman Pen <roman.penyaev@profitbricks.com>
To: linux-block@vger.kernel.org,
	linux-rdma@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@infradead.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Bart Van Assche <bart.vanassche@sandisk.com>,
	Or Gerlitz <ogerlitz@mellanox.com>,
	Doug Ledford <dledford@redhat.com>,
	Swapnil Ingle <swapnil.ingle@profitbricks.com>,
	Danil Kipnis <danil.kipnis@profitbricks.com>,
	Jack Wang <jinpu.wang@profitbricks.com>,
	Roman Pen <roman.penyaev@profitbricks.com>
Subject: [PATCH v2 14/26] ibtrs: include client and server modules into kernel compilation
Date: Fri, 18 May 2018 15:04:01 +0200
Message-Id: <20180518130413.16997-15-roman.penyaev@profitbricks.com>
In-Reply-To: <20180518130413.16997-1-roman.penyaev@profitbricks.com>
References: <20180518130413.16997-1-roman.penyaev@profitbricks.com>
List-ID: <linux-block@vger.kernel.org>

Add IBTRS Makefile, Kconfig and also corresponding lines into upper
layer infiniband/ulp files.

Signed-off-by: Roman Pen <roman.penyaev@profitbricks.com>
Signed-off-by: Danil Kipnis <danil.kipnis@profitbricks.com>
Cc: Jack Wang <jinpu.wang@profitbricks.com>
---
 drivers/infiniband/Kconfig            |  1 +
 drivers/infiniband/ulp/Makefile       |  1 +
 drivers/infiniband/ulp/ibtrs/Kconfig  | 20 ++++++++++++++++++++
 drivers/infiniband/ulp/ibtrs/Makefile | 15 +++++++++++++++
 4 files changed, 37 insertions(+)
 create mode 100644 drivers/infiniband/ulp/ibtrs/Kconfig
 create mode 100644 drivers/infiniband/ulp/ibtrs/Makefile

diff --git a/drivers/infiniband/Kconfig b/drivers/infiniband/Kconfig
index ee270e065ba9..787bd286fb08 100644
--- a/drivers/infiniband/Kconfig
+++ b/drivers/infiniband/Kconfig
@@ -94,6 +94,7 @@ source "drivers/infiniband/ulp/srpt/Kconfig"
 
 source "drivers/infiniband/ulp/iser/Kconfig"
 source "drivers/infiniband/ulp/isert/Kconfig"
+source "drivers/infiniband/ulp/ibtrs/Kconfig"
 
 source "drivers/infiniband/ulp/opa_vnic/Kconfig"
 source "drivers/infiniband/sw/rdmavt/Kconfig"
diff --git a/drivers/infiniband/ulp/Makefile b/drivers/infiniband/ulp/Makefile
index 437813c7b481..1c4f10dc8d49 100644
--- a/drivers/infiniband/ulp/Makefile
+++ b/drivers/infiniband/ulp/Makefile
@@ -5,3 +5,4 @@ obj-$(CONFIG_INFINIBAND_SRPT)		+= srpt/
 obj-$(CONFIG_INFINIBAND_ISER)		+= iser/
 obj-$(CONFIG_INFINIBAND_ISERT)		+= isert/
 obj-$(CONFIG_INFINIBAND_OPA_VNIC)	+= opa_vnic/
+obj-$(CONFIG_INFINIBAND_IBTRS)		+= ibtrs/
diff --git a/drivers/infiniband/ulp/ibtrs/Kconfig b/drivers/infiniband/ulp/ibtrs/Kconfig
new file mode 100644
index 000000000000..eaeb8f3f6b4e
--- /dev/null
+++ b/drivers/infiniband/ulp/ibtrs/Kconfig
@@ -0,0 +1,20 @@
+config INFINIBAND_IBTRS
+	tristate
+	depends on INFINIBAND_ADDR_TRANS
+
+config INFINIBAND_IBTRS_CLIENT
+	tristate "IBTRS client module"
+	depends on INFINIBAND_ADDR_TRANS
+	select INFINIBAND_IBTRS
+	help
+	  IBTRS client allows for simplified data transfer and connection
+	  establishment over RDMA (InfiniBand, RoCE, iWarp). Uses BIO-like
+	  READ/WRITE semantics and provides multipath capabilities.
+
+config INFINIBAND_IBTRS_SERVER
+	tristate "IBTRS server module"
+	depends on INFINIBAND_ADDR_TRANS
+	select INFINIBAND_IBTRS
+	help
+	  IBTRS server module processing connection and IO requests received
+	  from the IBTRS client module.
diff --git a/drivers/infiniband/ulp/ibtrs/Makefile b/drivers/infiniband/ulp/ibtrs/Makefile
new file mode 100644
index 000000000000..e6ea858745ad
--- /dev/null
+++ b/drivers/infiniband/ulp/ibtrs/Makefile
@@ -0,0 +1,15 @@
+ibtrs-client-y := ibtrs-clt.o \
+		  ibtrs-clt-stats.o \
+		  ibtrs-clt-sysfs.o
+
+ibtrs-server-y := ibtrs-srv.o \
+		  ibtrs-srv-stats.o \
+		  ibtrs-srv-sysfs.o
+
+ibtrs-core-y := ibtrs.o
+
+obj-$(CONFIG_INFINIBAND_IBTRS)        += ibtrs-core.o
+obj-$(CONFIG_INFINIBAND_IBTRS_CLIENT) += ibtrs-client.o
+obj-$(CONFIG_INFINIBAND_IBTRS_SERVER) += ibtrs-server.o
+
+-include $(src)/compat/compat.mk
-- 
2.13.1
