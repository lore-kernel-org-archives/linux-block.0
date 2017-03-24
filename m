Return-Path: <jinpu.wang@profitbricks.com>
Return-Path: <jinpu.wang@profitbricks.com>
From: Jack Wang <jinpu.wang@profitbricks.com>
To: linux-block@vger.kernel.org,
	linux-rdma@vger.kernel.org
Cc: dledford@redhat.com,
	axboe@kernel.dk,
	hch@lst.de,
	mail@fholler.de,
	Milind.dumbare@gmail.com,
	yun.wang@profitbricks.com,
	Jack Wang <jinpu.wang@profitbricks.com>
Subject: [PATCH 13/28] ibtrs_srv: add Makefile and Kconfig
Date: Fri, 24 Mar 2017 11:45:28 +0100
Message-Id: <1490352343-20075-14-git-send-email-jinpu.wangl@profitbricks.com>
In-Reply-To: <1490352343-20075-1-git-send-email-jinpu.wangl@profitbricks.com>
References: <1490352343-20075-1-git-send-email-jinpu.wangl@profitbricks.com>
List-ID: <linux-block@vger.kernel.org>

From: Jack Wang <jinpu.wang@profitbricks.com>

Signed-off-by: Jack Wang <jinpu.wang@profitbricks.com>
---
 drivers/infiniband/Kconfig                   | 1 +
 drivers/infiniband/ulp/Makefile              | 1 +
 drivers/infiniband/ulp/ibtrs_server/Kconfig  | 8 ++++++++
 drivers/infiniband/ulp/ibtrs_server/Makefile | 6 ++++++
 4 files changed, 16 insertions(+)
 create mode 100644 drivers/infiniband/ulp/ibtrs_server/Kconfig
 create mode 100644 drivers/infiniband/ulp/ibtrs_server/Makefile

diff --git a/drivers/infiniband/Kconfig b/drivers/infiniband/Kconfig
index cb1b864..07aa050 100644
--- a/drivers/infiniband/Kconfig
+++ b/drivers/infiniband/Kconfig
@@ -86,6 +86,7 @@ source "drivers/infiniband/ulp/iser/Kconfig"
 source "drivers/infiniband/ulp/isert/Kconfig"
 
 source "drivers/infiniband/ulp/ibtrs_client/Kconfig"
+source "drivers/infiniband/ulp/ibtrs_server/Kconfig"
 
 source "drivers/infiniband/sw/rdmavt/Kconfig"
 source "drivers/infiniband/sw/rxe/Kconfig"
diff --git a/drivers/infiniband/ulp/Makefile b/drivers/infiniband/ulp/Makefile
index acd8ce6..eb4da3f 100644
--- a/drivers/infiniband/ulp/Makefile
+++ b/drivers/infiniband/ulp/Makefile
@@ -4,3 +4,4 @@ obj-$(CONFIG_INFINIBAND_SRPT)		+= srpt/
 obj-$(CONFIG_INFINIBAND_ISER)		+= iser/
 obj-$(CONFIG_INFINIBAND_ISERT)		+= isert/
 obj-$(CONFIG_INFINIBAND_IBTRS_CLT)      += ibtrs_client/
+obj-$(CONFIG_INFINIBAND_IBTRS_SRV)      += ibtrs_server/
diff --git a/drivers/infiniband/ulp/ibtrs_server/Kconfig b/drivers/infiniband/ulp/ibtrs_server/Kconfig
new file mode 100644
index 0000000..6fbdc54
--- /dev/null
+++ b/drivers/infiniband/ulp/ibtrs_server/Kconfig
@@ -0,0 +1,8 @@
+config INFINIBAND_IBTRS_SRV
+	tristate "InfiniBand IBTRS SERVER"
+	depends on INFINIBAND_ADDR_TRANS
+	---help---
+	  Support for the simplified data transfer over InfiniBand.
+	  This offer API to user module IBNBD_SERVER
+
+	  The IBTRS protocol is defined by the ProfitBricks GmbH.
diff --git a/drivers/infiniband/ulp/ibtrs_server/Makefile b/drivers/infiniband/ulp/ibtrs_server/Makefile
new file mode 100644
index 0000000..39d9e1d
--- /dev/null
+++ b/drivers/infiniband/ulp/ibtrs_server/Makefile
@@ -0,0 +1,6 @@
+
+obj-$(CONFIG_INFINIBAND_IBTRS_SRV)	+= ibtrs_server.o
+
+ibtrs_server-y		:= ibtrs_srv.o ibtrs_srv_sysfs.o \
+			   ../ibtrs_lib/ibtrs.o ../ibtrs_lib/ibtrs-proto.o ../ibtrs_lib/iu.o \
+			   ../ibtrs_lib/heartbeat.o ../ibtrs_lib/common.o
-- 
2.7.4
