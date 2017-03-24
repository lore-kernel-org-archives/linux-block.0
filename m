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
Subject: [PATCH 28/28] MAINTRAINERS: Add maintainer for IBNBD/IBTRS
Date: Fri, 24 Mar 2017 11:45:43 +0100
Message-Id: <1490352343-20075-29-git-send-email-jinpu.wangl@profitbricks.com>
In-Reply-To: <1490352343-20075-1-git-send-email-jinpu.wangl@profitbricks.com>
References: <1490352343-20075-1-git-send-email-jinpu.wangl@profitbricks.com>
List-ID: <linux-block@vger.kernel.org>

From: Jack Wang <jinpu.wang@profitbricks.com>

Signed-off-by: Jack Wang <jinpu.wang@profitbricks.com>
---
 MAINTAINERS | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c776906..12a528a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6263,6 +6263,20 @@ IBM ServeRAID RAID DRIVER
 S:	Orphan
 F:	drivers/scsi/ips.*
 
+IBTRS TRANSPORT DRIVERS
+M:      Jack Wang <jinpu.wang@profitbricks.com>
+L:      linux-rdma@vger.kernel.org
+S:      Maintained
+F:      include/linux/ibtrs*.h
+F:      drivers/infiniband/ulp/ibtrs*
+
+IBNBD BLOCK DRIVERS
+M:      Jack Wang <jinpu.wang@profitbricks.com>
+L:      linux-rdma@vger.kernel.org
+S:      Maintained
+F:	Documentation/IBNBD.txt
+F:      drivers/block/ibnbd*
+
 ICH LPC AND GPIO DRIVER
 M:	Peter Tyser <ptyser@xes-inc.com>
 S:	Maintained
-- 
2.7.4
