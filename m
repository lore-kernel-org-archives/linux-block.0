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
	Danil Kipnis <danil.kipnis@profitbricks.com>,
	Jack Wang <jinpu.wang@profitbricks.com>,
	Roman Pen <roman.penyaev@profitbricks.com>
Subject: [PATCH v3 11/25] ibtrs: server: statistics functions
Date: Wed,  6 Jun 2018 17:25:01 +0200
Message-Id: <20180606152515.25807-12-roman.penyaev@profitbricks.com>
In-Reply-To: <20180606152515.25807-1-roman.penyaev@profitbricks.com>
References: <20180606152515.25807-1-roman.penyaev@profitbricks.com>
List-ID: <linux-block@vger.kernel.org>

This introduces set of functions used on server side to account
statistics of RDMA data sent/received.

Signed-off-by: Roman Pen <roman.penyaev@profitbricks.com>
Signed-off-by: Danil Kipnis <danil.kipnis@profitbricks.com>
Cc: Jack Wang <jinpu.wang@profitbricks.com>
---
 drivers/infiniband/ulp/ibtrs/ibtrs-srv-stats.c | 110 +++++++++++++++++++++++++
 1 file changed, 110 insertions(+)
 create mode 100644 drivers/infiniband/ulp/ibtrs/ibtrs-srv-stats.c

diff --git a/drivers/infiniband/ulp/ibtrs/ibtrs-srv-stats.c b/drivers/infiniband/ulp/ibtrs/ibtrs-srv-stats.c
new file mode 100644
index 000000000000..5933cfc03f95
--- /dev/null
+++ b/drivers/infiniband/ulp/ibtrs/ibtrs-srv-stats.c
@@ -0,0 +1,110 @@
+/*
+ * InfiniBand Transport Layer
+ *
+ * Copyright (c) 2014 - 2017 ProfitBricks GmbH. All rights reserved.
+ * Authors: Fabian Holler <mail@fholler.de>
+ *          Jack Wang <jinpu.wang@profitbricks.com>
+ *          Kleber Souza <kleber.souza@profitbricks.com>
+ *          Danil Kipnis <danil.kipnis@profitbricks.com>
+ *          Roman Penyaev <roman.penyaev@profitbricks.com>
+ *          Milind Dumbare <Milind.dumbare@gmail.com>
+ *
+ * Copyright (c) 2017 - 2018 ProfitBricks GmbH. All rights reserved.
+ * Authors: Danil Kipnis <danil.kipnis@profitbricks.com>
+ *          Roman Penyaev <roman.penyaev@profitbricks.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#undef pr_fmt
+#define pr_fmt(fmt) KBUILD_MODNAME " L" __stringify(__LINE__) ": " fmt
+
+#include "ibtrs-srv.h"
+
+void ibtrs_srv_update_rdma_stats(struct ibtrs_srv_stats *s,
+				 size_t size, int d)
+{
+	atomic64_inc(&s->rdma_stats.dir[d].cnt);
+	atomic64_add(size, &s->rdma_stats.dir[d].size_total);
+}
+
+void ibtrs_srv_update_wc_stats(struct ibtrs_srv_stats *s)
+{
+	atomic64_inc(&s->wc_comp.calls);
+	atomic64_inc(&s->wc_comp.total_wc_cnt);
+}
+
+int ibtrs_srv_reset_rdma_stats(struct ibtrs_srv_stats *stats, bool enable)
+{
+	if (enable) {
+		struct ibtrs_srv_stats_rdma_stats *r = &stats->rdma_stats;
+
+		memset(r, 0, sizeof(*r));
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+ssize_t ibtrs_srv_stats_rdma_to_str(struct ibtrs_srv_stats *stats,
+				    char *page, size_t len)
+{
+	struct ibtrs_srv_stats_rdma_stats *r = &stats->rdma_stats;
+	struct ibtrs_srv_sess *sess;
+
+	sess = container_of(stats, typeof(*sess), stats);
+
+	return scnprintf(page, len, "%lld %lld %lld %lld %u\n",
+			 (s64)atomic64_read(&r->dir[READ].cnt),
+			 (s64)atomic64_read(&r->dir[READ].size_total),
+			 (s64)atomic64_read(&r->dir[WRITE].cnt),
+			 (s64)atomic64_read(&r->dir[WRITE].size_total),
+			 atomic_read(&sess->ids_inflight));
+}
+
+int ibtrs_srv_reset_wc_completion_stats(struct ibtrs_srv_stats *stats,
+					bool enable)
+{
+	if (enable) {
+		memset(&stats->wc_comp, 0, sizeof(stats->wc_comp));
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+int ibtrs_srv_stats_wc_completion_to_str(struct ibtrs_srv_stats *stats,
+					 char *buf, size_t len)
+{
+	return snprintf(buf, len, "%lld %lld\n",
+			(s64)atomic64_read(&stats->wc_comp.total_wc_cnt),
+			(s64)atomic64_read(&stats->wc_comp.calls));
+}
+
+ssize_t ibtrs_srv_reset_all_help(struct ibtrs_srv_stats *stats,
+				 char *page, size_t len)
+{
+	return scnprintf(page, PAGE_SIZE, "echo 1 to reset all statistics\n");
+}
+
+int ibtrs_srv_reset_all_stats(struct ibtrs_srv_stats *stats, bool enable)
+{
+	if (enable) {
+		ibtrs_srv_reset_wc_completion_stats(stats, enable);
+		ibtrs_srv_reset_rdma_stats(stats, enable);
+		return 0;
+	}
+
+	return -EINVAL;
+}
-- 
2.13.1
