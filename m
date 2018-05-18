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
Subject: [PATCH v2 26/26] MAINTAINERS: Add maintainer for IBNBD/IBTRS modules
Date: Fri, 18 May 2018 15:04:13 +0200
Message-Id: <20180518130413.16997-27-roman.penyaev@profitbricks.com>
In-Reply-To: <20180518130413.16997-1-roman.penyaev@profitbricks.com>
References: <20180518130413.16997-1-roman.penyaev@profitbricks.com>
List-ID: <linux-block@vger.kernel.org>

Signed-off-by: Roman Pen <roman.penyaev@profitbricks.com>
Cc: Danil Kipnis <danil.kipnis@profitbricks.com>
Cc: Jack Wang <jinpu.wang@profitbricks.com>
---
 MAINTAINERS | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 92be777d060a..e5a001bd0f05 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6786,6 +6786,20 @@ IBM ServeRAID RAID DRIVER
 S:	Orphan
 F:	drivers/scsi/ips.*
 
+IBNBD BLOCK DRIVERS
+M:	IBNBD/IBTRS Storage Team <ibnbd@profitbricks.com>
+L:	linux-block@vger.kernel.org
+S:	Maintained
+T:	git git://github.com/profitbricks/ibnbd.git
+F:	drivers/block/ibnbd/
+
+IBTRS TRANSPORT DRIVERS
+M:	IBNBD/IBTRS Storage Team <ibnbd@profitbricks.com>
+L:	linux-rdma@vger.kernel.org
+S:	Maintained
+T:	git git://github.com/profitbricks/ibnbd.git
+F:	drivers/infiniband/ulp/ibtrs/
+
 ICH LPC AND GPIO DRIVER
 M:	Peter Tyser <ptyser@xes-inc.com>
 S:	Maintained
-- 
2.13.1
