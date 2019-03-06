Return-Path: <SRS0=tltz=RJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52993C43381
	for <linux-block@archiver.kernel.org>; Wed,  6 Mar 2019 08:48:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31BB020643
	for <linux-block@archiver.kernel.org>; Wed,  6 Mar 2019 08:48:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729626AbfCFIsx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Mar 2019 03:48:53 -0500
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:47900 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729631AbfCFIsx (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Mar 2019 03:48:53 -0500
Received: from Internal Mail-Server by MTLPINE1 (envelope-from talgi@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 6 Mar 2019 10:48:46 +0200
Received: from gen-l-vrt-691.mtl.labs.mlnx (gen-l-vrt-691.mtl.labs.mlnx [10.141.69.1])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x268mgk4017599;
        Wed, 6 Mar 2019 10:48:42 +0200
Received: from gen-l-vrt-691.mtl.labs.mlnx (localhost [127.0.0.1])
        by gen-l-vrt-691.mtl.labs.mlnx (8.15.2/8.15.2/Debian-11ubuntu1) with ESMTP id x268mgBG057829;
        Wed, 6 Mar 2019 10:48:42 +0200
Received: (from talgi@localhost)
        by gen-l-vrt-691.mtl.labs.mlnx (8.15.2/8.15.2/Submit) id x268mgSf057828;
        Wed, 6 Mar 2019 10:48:42 +0200
From:   Tal Gilboa <talgi@mellanox.com>
To:     linux-rdma@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
Cc:     Yishai Hadas <yishaih@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        Tal Gilboa <talgi@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Idan Burstein <idanb@mellanox.com>,
        Yamin Friedman <yaminf@mellanox.com>,
        Max Gurtovoy <maxg@mellanox.com>
Subject: [RFC/PATCH net-next 8/9] linux/dim: Implement blk_dim.h
Date:   Wed,  6 Mar 2019 10:48:31 +0200
Message-Id: <20190306084832.57753-9-talgi@mellanox.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190306084832.57753-1-talgi@mellanox.com>
References: <20190306084832.57753-1-talgi@mellanox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Yamin Friedman <yaminf@mellanox.com>

blk_dim implements a different algorithm than net_dim that is optimized for nvmf
storage applications.
The algorithm optimizes for number of completions and ratio between completions
and events.
It also has a feature for fast reduction of moderation level when the traffic
changes in such a way as to no longer require high moderation in order to avoid
long latencies.

blk_dim.h will be called from the ib_core module.

Signed-off-by: Yamin Friedman <yaminf@mellanox.com>
Signed-off-by: Tal Gilboa <talgi@mellanox.com>
---
 MAINTAINERS             |   1 +
 include/linux/blk_dim.h |  56 ++++++++++++++++++++
 lib/dim/Makefile        |   7 ++-
 lib/dim/blk_dim.c       | 114 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 177 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/blk_dim.h
 create mode 100644 lib/dim/blk_dim.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 6ae949be8b83..2860a3316be5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5337,6 +5337,7 @@ DYNAMIC INTERRUPT MODERATION
 M:	Tal Gilboa <talgi@mellanox.com>
 S:	Maintained
 F:	include/linux/net_dim.h
+F:	include/linux/blk_dim.h
 F:	include/linux/dim.h
 F:	lib/dim/
 
diff --git a/include/linux/blk_dim.h b/include/linux/blk_dim.h
new file mode 100644
index 000000000000..a044f62ec8fe
--- /dev/null
+++ b/include/linux/blk_dim.h
@@ -0,0 +1,56 @@
+/*
+ * Copyright (c) 2016, Mellanox Technologies. All rights reserved.
+ *
+ * This software is available to you under a choice of one of two
+ * licenses.  You may choose to be licensed under the terms of the GNU
+ * General Public License (GPL) Version 2, available from the file
+ * COPYING in the main directory of this source tree, or the
+ * OpenIB.org BSD license below:
+ *
+ *     Redistribution and use in source and binary forms, with or
+ *     without modification, are permitted provided that the following
+ *     conditions are met:
+ *
+ *      - Redistributions of source code must retain the above
+ *        copyright notice, this list of conditions and the following
+ *        disclaimer.
+ *
+ *      - Redistributions in binary form must reproduce the above
+ *        copyright notice, this list of conditions and the following
+ *        disclaimer in the documentation and/or other materials
+ *        provided with the distribution.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+ * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
+ * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
+ * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
+ * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+ * SOFTWARE.
+ */
+
+#ifndef BLK_DIM_H
+#define BLK_DIM_H
+
+#include <linux/module.h>
+#include <linux/dim.h>
+
+#define BLK_DIM_PARAMS_NUM_PROFILES 8
+#define BLK_DIM_START_PROFILE 0
+
+static const struct dim_cq_moder
+blk_dim_prof[BLK_DIM_PARAMS_NUM_PROFILES] = {
+	{1,   0, 1,  0},
+	{2,   0, 2,  0},
+	{4,   0, 4,  0},
+	{16,  0, 4,  0},
+	{32,  0, 4,  0},
+	{32,  0, 16, 0},
+	{256, 0, 16, 0},
+	{256, 0, 32, 0},
+};
+
+void blk_dim(struct dim *dim, struct dim_sample end_sample);
+
+#endif /* BLK_DIM_H */
diff --git a/lib/dim/Makefile b/lib/dim/Makefile
index 160afe288df0..2b3c57318dbb 100644
--- a/lib/dim/Makefile
+++ b/lib/dim/Makefile
@@ -2,8 +2,13 @@
 # DIM Dynamic Interrupt Moderation library
 #
 
-obj-$(CONFIG_DIMLIB) = net_dim.o
+obj-$(CONFIG_DIMLIB) += net_dim.o
+obj-$(CONFIG_DIMLIB) += blk_dim.o
 
 net_dim-y = \
 	dim.o		\
 	net_dim.o
+
+blk_dim-y = \
+	dim.o		\
+	blk_dim.o
diff --git a/lib/dim/blk_dim.c b/lib/dim/blk_dim.c
new file mode 100644
index 000000000000..49107c169b56
--- /dev/null
+++ b/lib/dim/blk_dim.c
@@ -0,0 +1,114 @@
+#include <linux/blk_dim.h>
+
+static inline int blk_dim_step(struct dim *dim)
+{
+	switch (dim->tune_state) {
+	case DIM_PARKING_ON_TOP:
+	case DIM_PARKING_TIRED:
+		break;
+	case DIM_GOING_RIGHT:
+		if (dim->profile_ix == (BLK_DIM_PARAMS_NUM_PROFILES - 1))
+			return DIM_ON_EDGE;
+		dim->profile_ix++;
+		dim->steps_right++;
+		break;
+	case DIM_GOING_LEFT:
+		if (dim->profile_ix == 0)
+			return DIM_ON_EDGE;
+		dim->profile_ix--;
+		dim->steps_left++;
+		break;
+	}
+
+	return DIM_STEPPED;
+}
+
+static inline int blk_dim_stats_compare(struct dim_stats *curr, struct dim_stats *prev)
+{
+	/* first stat */
+	if (!prev->cpms)
+		return DIM_STATS_SAME;
+
+	if (IS_SIGNIFICANT_DIFF(curr->cpms, prev->cpms))
+		return (curr->cpms > prev->cpms) ? DIM_STATS_BETTER :
+						DIM_STATS_WORSE;
+
+	if (IS_SIGNIFICANT_DIFF(curr->cpe_ratio, prev->cpe_ratio))
+		return (curr->cpe_ratio > prev->cpe_ratio) ? DIM_STATS_BETTER :
+						DIM_STATS_WORSE;
+
+	return DIM_STATS_SAME;
+}
+
+static inline bool blk_dim_decision(struct dim_stats *curr_stats, struct dim *dim)
+{
+	int prev_ix = dim->profile_ix;
+	int stats_res;
+	int step_res;
+
+	switch (dim->tune_state) {
+	case DIM_PARKING_ON_TOP:
+		break;
+	case DIM_PARKING_TIRED:
+		break;
+
+	case DIM_GOING_RIGHT:
+	case DIM_GOING_LEFT:
+		stats_res = blk_dim_stats_compare(curr_stats, &dim->prev_stats);
+
+		switch (stats_res) {
+		case DIM_STATS_SAME:
+			if (curr_stats->cpe_ratio <= 50*prev_ix)
+				dim->profile_ix = 0;
+			break;
+		case DIM_STATS_WORSE:
+			dim_turn(dim);
+		default:
+		case DIM_STATS_BETTER:
+			/* fall through */
+			step_res = blk_dim_step(dim);
+			if (step_res == DIM_ON_EDGE)
+				dim_turn(dim);
+			break;
+		}
+		break;
+	}
+
+	dim->prev_stats = *curr_stats;
+
+	return dim->profile_ix != prev_ix;
+}
+
+void blk_dim(struct dim *dim, struct dim_sample end_sample)
+{
+	struct dim_stats curr_stats;
+	u16 nevents;
+
+	switch (dim->state) {
+	case DIM_MEASURE_IN_PROGRESS:
+		nevents = end_sample.event_ctr - dim->start_sample.event_ctr;
+		if (nevents < DIM_NEVENTS) {
+			dim_create_sample(end_sample.event_ctr, end_sample.pkt_ctr,
+				end_sample.byte_ctr, end_sample.comp_ctr, &dim->measuring_sample);
+			break;
+		}
+		dim_calc_stats(&dim->start_sample, &end_sample,
+				   &curr_stats);
+		if (blk_dim_decision(&curr_stats, dim)) {
+			dim->state = DIM_APPLY_NEW_PROFILE;
+			schedule_work(&dim->work);
+			break;
+		}
+		/* fall through */
+	case DIM_START_MEASURE:
+		dim->state = DIM_MEASURE_IN_PROGRESS;
+		dim_create_sample(end_sample.event_ctr, end_sample.pkt_ctr, end_sample.byte_ctr,
+				end_sample.comp_ctr, &dim->start_sample);
+		dim_create_sample(end_sample.event_ctr, end_sample.pkt_ctr, end_sample.byte_ctr,
+				end_sample.comp_ctr, &dim->measuring_sample);
+		break;
+	case DIM_APPLY_NEW_PROFILE:
+		break;
+	}
+}
+EXPORT_SYMBOL(blk_dim);
-- 
2.19.1

