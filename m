Return-Path: <SRS0=tltz=RJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D461FC4360F
	for <linux-block@archiver.kernel.org>; Wed,  6 Mar 2019 08:48:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9754E20675
	for <linux-block@archiver.kernel.org>; Wed,  6 Mar 2019 08:48:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729628AbfCFIss (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Mar 2019 03:48:48 -0500
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:47842 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729626AbfCFIss (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Mar 2019 03:48:48 -0500
Received: from Internal Mail-Server by MTLPINE1 (envelope-from talgi@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 6 Mar 2019 10:48:42 +0200
Received: from gen-l-vrt-691.mtl.labs.mlnx (gen-l-vrt-691.mtl.labs.mlnx [10.141.69.1])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x268mfsv017534;
        Wed, 6 Mar 2019 10:48:41 +0200
Received: from gen-l-vrt-691.mtl.labs.mlnx (localhost [127.0.0.1])
        by gen-l-vrt-691.mtl.labs.mlnx (8.15.2/8.15.2/Debian-11ubuntu1) with ESMTP id x268mf4Z057825;
        Wed, 6 Mar 2019 10:48:41 +0200
Received: (from talgi@localhost)
        by gen-l-vrt-691.mtl.labs.mlnx (8.15.2/8.15.2/Submit) id x268mfBB057823;
        Wed, 6 Mar 2019 10:48:41 +0200
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
Subject: [RFC/PATCH net-next 6/9] linux/dim: Move implementation to .c files
Date:   Wed,  6 Mar 2019 10:48:29 +0200
Message-Id: <20190306084832.57753-7-talgi@mellanox.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190306084832.57753-1-talgi@mellanox.com>
References: <20190306084832.57753-1-talgi@mellanox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Moved all logic from dim.h and net_dim.h to dim.c and net_dim.c.

Signed-off-by: Tal Gilboa <talgi@mellanox.com>
---
 MAINTAINERS             |   2 +
 include/linux/dim.h     |  86 +++---------------
 include/linux/net_dim.h | 182 ++-----------------------------------
 lib/Kconfig             |   7 ++
 lib/Makefile            |   1 +
 lib/dim/Makefile        |   9 ++
 lib/dim/dim.c           |  83 +++++++++++++++++
 lib/dim/net_dim.c       | 193 ++++++++++++++++++++++++++++++++++++++++
 8 files changed, 312 insertions(+), 251 deletions(-)
 create mode 100644 lib/dim/Makefile
 create mode 100644 lib/dim/dim.c
 create mode 100644 lib/dim/net_dim.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 019a2bcfbd09..6ae949be8b83 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5337,6 +5337,8 @@ DYNAMIC INTERRUPT MODERATION
 M:	Tal Gilboa <talgi@mellanox.com>
 S:	Maintained
 F:	include/linux/net_dim.h
+F:	include/linux/dim.h
+F:	lib/dim/
 
 DZ DECSTATION DZ11 SERIAL DRIVER
 M:	"Maciej W. Rozycki" <macro@linux-mips.org>
diff --git a/include/linux/dim.h b/include/linux/dim.h
index 8d9f8279ebee..88a74cd83d95 100644
--- a/include/linux/dim.h
+++ b/include/linux/dim.h
@@ -105,79 +105,17 @@ enum {
 	DIM_ON_EDGE,
 };
 
-static inline bool dim_on_top(struct dim *dim)
-{
-	switch (dim->tune_state) {
-	case DIM_PARKING_ON_TOP:
-	case DIM_PARKING_TIRED:
-		return true;
-	case DIM_GOING_RIGHT:
-		return (dim->steps_left > 1) && (dim->steps_right == 1);
-	default: /* DIM_GOING_LEFT */
-		return (dim->steps_right > 1) && (dim->steps_left == 1);
-	}
-}
-
-static inline void dim_turn(struct dim *dim)
-{
-	switch (dim->tune_state) {
-	case DIM_PARKING_ON_TOP:
-	case DIM_PARKING_TIRED:
-		break;
-	case DIM_GOING_RIGHT:
-		dim->tune_state = DIM_GOING_LEFT;
-		dim->steps_left = 0;
-		break;
-	case DIM_GOING_LEFT:
-		dim->tune_state = DIM_GOING_RIGHT;
-		dim->steps_right = 0;
-		break;
-	}
-}
-
-static inline void dim_park_on_top(struct dim *dim)
-{
-	dim->steps_right  = 0;
-	dim->steps_left   = 0;
-	dim->tired        = 0;
-	dim->tune_state   = DIM_PARKING_ON_TOP;
-}
-
-static inline void dim_park_tired(struct dim *dim)
-{
-	dim->steps_right  = 0;
-	dim->steps_left   = 0;
-	dim->tune_state   = DIM_PARKING_TIRED;
-}
-
-static inline void dim_create_sample(u16 event_ctr,
-				     u64 packets,
-				     u64 bytes,
-				     struct dim_sample *s)
-{
-	s->time	     = ktime_get();
-	s->pkt_ctr   = packets;
-	s->byte_ctr  = bytes;
-	s->event_ctr = event_ctr;
-}
-
-static inline void dim_calc_stats(struct dim_sample *start,
-				  struct dim_sample *end,
-				  struct dim_stats *curr_stats)
-{
-	/* u32 holds up to 71 minutes, should be enough */
-	u32 delta_us = ktime_us_delta(end->time, start->time);
-	u32 npkts = BIT_GAP(BITS_PER_TYPE(u32), end->pkt_ctr, start->pkt_ctr);
-	u32 nbytes = BIT_GAP(BITS_PER_TYPE(u32), end->byte_ctr,
-			     start->byte_ctr);
-
-	if (!delta_us)
-		return;
-
-	curr_stats->ppms = DIV_ROUND_UP(npkts * USEC_PER_MSEC, delta_us);
-	curr_stats->bpms = DIV_ROUND_UP(nbytes * USEC_PER_MSEC, delta_us);
-	curr_stats->epms = DIV_ROUND_UP(DIM_NEVENTS * USEC_PER_MSEC,
-					delta_us);
-}
+bool dim_on_top(struct dim *dim);
+
+void dim_turn(struct dim *dim);
+
+void dim_park_on_top(struct dim *dim);
+
+void dim_park_tired(struct dim *dim);
+
+void dim_create_sample(u16 event_ctr, u64 packets, u64 bytes, struct dim_sample *s);
+
+void dim_calc_stats(struct dim_sample *start, struct dim_sample *end,
+		    struct dim_stats *curr_stats);
 
 #endif /* DIM_H */
diff --git a/include/linux/net_dim.h b/include/linux/net_dim.h
index e9363c372b68..debf548cfb33 100644
--- a/include/linux/net_dim.h
+++ b/include/linux/net_dim.h
@@ -89,186 +89,14 @@ tx_profile[DIM_CQ_PERIOD_NUM_MODES][NET_DIM_PARAMS_NUM_PROFILES] = {
 	NET_DIM_TX_CQE_PROFILES,
 };
 
-static inline struct dim_cq_moder
-net_dim_get_rx_moderation(u8 cq_period_mode, int ix)
-{
-	struct dim_cq_moder cq_moder = rx_profile[cq_period_mode][ix];
+struct dim_cq_moder net_dim_get_rx_moderation(u8 cq_period_mode, int ix);
 
-	cq_moder.cq_period_mode = cq_period_mode;
-	return cq_moder;
-}
-
-static inline struct dim_cq_moder
-net_dim_get_def_rx_moderation(u8 cq_period_mode)
-{
-	u8 profile_ix = cq_period_mode == DIM_CQ_PERIOD_MODE_START_FROM_CQE ?
-			NET_DIM_DEF_PROFILE_CQE : NET_DIM_DEF_PROFILE_EQE;
-
-	return net_dim_get_rx_moderation(cq_period_mode, profile_ix);
-}
-
-static inline struct dim_cq_moder
-net_dim_get_tx_moderation(u8 cq_period_mode, int ix)
-{
-	struct dim_cq_moder cq_moder = tx_profile[cq_period_mode][ix];
-
-	cq_moder.cq_period_mode = cq_period_mode;
-	return cq_moder;
-}
-
-static inline struct dim_cq_moder
-net_dim_get_def_tx_moderation(u8 cq_period_mode)
-{
-	u8 profile_ix = cq_period_mode == DIM_CQ_PERIOD_MODE_START_FROM_CQE ?
-			NET_DIM_DEF_PROFILE_CQE : NET_DIM_DEF_PROFILE_EQE;
-
-	return net_dim_get_tx_moderation(cq_period_mode, profile_ix);
-}
-
-static inline int net_dim_step(struct dim *dim)
-{
-	if (dim->tired == (NET_DIM_PARAMS_NUM_PROFILES * 2))
-		return DIM_TOO_TIRED;
-
-	switch (dim->tune_state) {
-	case DIM_PARKING_ON_TOP:
-	case DIM_PARKING_TIRED:
-		break;
-	case DIM_GOING_RIGHT:
-		if (dim->profile_ix == (NET_DIM_PARAMS_NUM_PROFILES - 1))
-			return DIM_ON_EDGE;
-		dim->profile_ix++;
-		dim->steps_right++;
-		break;
-	case DIM_GOING_LEFT:
-		if (dim->profile_ix == 0)
-			return DIM_ON_EDGE;
-		dim->profile_ix--;
-		dim->steps_left++;
-		break;
-	}
-
-	dim->tired++;
-	return DIM_STEPPED;
-}
-
-static inline void net_dim_exit_parking(struct dim *dim)
-{
-	dim->tune_state = dim->profile_ix ? DIM_GOING_LEFT :
-					  DIM_GOING_RIGHT;
-	net_dim_step(dim);
-}
-
-static inline int net_dim_stats_compare(struct dim_stats *curr,
-					struct dim_stats *prev)
-{
-	if (!prev->bpms)
-		return curr->bpms ? DIM_STATS_BETTER :
-				    DIM_STATS_SAME;
+struct dim_cq_moder net_dim_get_def_rx_moderation(u8 cq_period_mode);
 
-	if (IS_SIGNIFICANT_DIFF(curr->bpms, prev->bpms))
-		return (curr->bpms > prev->bpms) ? DIM_STATS_BETTER :
-						   DIM_STATS_WORSE;
+struct dim_cq_moder net_dim_get_tx_moderation(u8 cq_period_mode, int ix);
 
-	if (!prev->ppms)
-		return curr->ppms ? DIM_STATS_BETTER :
-				    DIM_STATS_SAME;
+struct dim_cq_moder net_dim_get_def_tx_moderation(u8 cq_period_mode);
 
-	if (IS_SIGNIFICANT_DIFF(curr->ppms, prev->ppms))
-		return (curr->ppms > prev->ppms) ? DIM_STATS_BETTER :
-						   DIM_STATS_WORSE;
-
-	if (!prev->epms)
-		return DIM_STATS_SAME;
-
-	if (IS_SIGNIFICANT_DIFF(curr->epms, prev->epms))
-		return (curr->epms < prev->epms) ? DIM_STATS_BETTER :
-						   DIM_STATS_WORSE;
-
-	return DIM_STATS_SAME;
-}
-
-static inline bool net_dim_decision(struct dim_stats *curr_stats,
-				    struct dim *dim)
-{
-	int prev_state = dim->tune_state;
-	int prev_ix = dim->profile_ix;
-	int stats_res;
-	int step_res;
-
-	switch (dim->tune_state) {
-	case DIM_PARKING_ON_TOP:
-		stats_res = net_dim_stats_compare(curr_stats, &dim->prev_stats);
-		if (stats_res != DIM_STATS_SAME)
-			net_dim_exit_parking(dim);
-		break;
-
-	case DIM_PARKING_TIRED:
-		dim->tired--;
-		if (!dim->tired)
-			net_dim_exit_parking(dim);
-		break;
-
-	case DIM_GOING_RIGHT:
-	case DIM_GOING_LEFT:
-		stats_res = net_dim_stats_compare(curr_stats, &dim->prev_stats);
-		if (stats_res != DIM_STATS_BETTER)
-			dim_turn(dim);
-
-		if (dim_on_top(dim)) {
-			dim_park_on_top(dim);
-			break;
-		}
-
-		step_res = net_dim_step(dim);
-		switch (step_res) {
-		case DIM_ON_EDGE:
-			dim_park_on_top(dim);
-			break;
-		case DIM_TOO_TIRED:
-			dim_park_tired(dim);
-			break;
-		}
-
-		break;
-	}
-
-	if ((prev_state      != DIM_PARKING_ON_TOP) ||
-	    (dim->tune_state != DIM_PARKING_ON_TOP))
-		dim->prev_stats = *curr_stats;
-
-	return dim->profile_ix != prev_ix;
-}
-
-static inline void net_dim(struct dim *dim,
-			   struct dim_sample end_sample)
-{
-	struct dim_stats curr_stats;
-	u16 nevents;
-
-	switch (dim->state) {
-	case DIM_MEASURE_IN_PROGRESS:
-		nevents = BIT_GAP(BITS_PER_TYPE(u16),
-				  end_sample.event_ctr,
-				  dim->start_sample.event_ctr);
-		if (nevents < DIM_NEVENTS)
-			break;
-		dim_calc_stats(&dim->start_sample, &end_sample,
-				   &curr_stats);
-		if (net_dim_decision(&curr_stats, dim)) {
-			dim->state = DIM_APPLY_NEW_PROFILE;
-			schedule_work(&dim->work);
-			break;
-		}
-		/* fall through */
-	case DIM_START_MEASURE:
-		dim_create_sample(end_sample.event_ctr, end_sample.pkt_ctr,
-				  end_sample.byte_ctr, &dim->start_sample);
-		dim->state = DIM_MEASURE_IN_PROGRESS;
-		break;
-	case DIM_APPLY_NEW_PROFILE:
-		break;
-	}
-}
+void net_dim(struct dim *dim, struct dim_sample end_sample);
 
 #endif /* NET_DIM_H */
diff --git a/lib/Kconfig b/lib/Kconfig
index a9e56539bd11..153465c65624 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -551,6 +551,13 @@ config SIGNATURE
 	  Digital signature verification. Currently only RSA is supported.
 	  Implementation is done using GnuPG MPI library
 
+config DIMLIB
+	bool "DIM library"
+	default y
+	help
+	  Dynamic Interrupt Moderation library.
+	  It is used to implement DIM logic.
+
 #
 # libfdt files, only selected if needed.
 #
diff --git a/lib/Makefile b/lib/Makefile
index e1b59da71418..0f2155eb9a85 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -185,6 +185,7 @@ obj-$(CONFIG_GLOB) += glob.o
 obj-$(CONFIG_GLOB_SELFTEST) += globtest.o
 
 obj-$(CONFIG_MPILIB) += mpi/
+obj-$(CONFIG_DIMLIB) += dim/
 obj-$(CONFIG_SIGNATURE) += digsig.o
 
 lib-$(CONFIG_CLZ_TAB) += clz_tab.o
diff --git a/lib/dim/Makefile b/lib/dim/Makefile
new file mode 100644
index 000000000000..160afe288df0
--- /dev/null
+++ b/lib/dim/Makefile
@@ -0,0 +1,9 @@
+#
+# DIM Dynamic Interrupt Moderation library
+#
+
+obj-$(CONFIG_DIMLIB) = net_dim.o
+
+net_dim-y = \
+	dim.o		\
+	net_dim.o
diff --git a/lib/dim/dim.c b/lib/dim/dim.c
new file mode 100644
index 000000000000..93e1ddd701b0
--- /dev/null
+++ b/lib/dim/dim.c
@@ -0,0 +1,83 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
+/*
+ * Copyright (c) 2018, Mellanox Technologies inc.  All rights reserved.
+ */
+
+#include <linux/dim.h>
+
+bool dim_on_top(struct dim *dim)
+{
+	switch (dim->tune_state) {
+	case DIM_PARKING_ON_TOP:
+	case DIM_PARKING_TIRED:
+		return true;
+	case DIM_GOING_RIGHT:
+		return (dim->steps_left > 1) && (dim->steps_right == 1);
+	default: /* DIM_GOING_LEFT */
+		return (dim->steps_right > 1) && (dim->steps_left == 1);
+	}
+}
+EXPORT_SYMBOL(dim_on_top);
+
+void dim_turn(struct dim *dim)
+{
+	switch (dim->tune_state) {
+	case DIM_PARKING_ON_TOP:
+	case DIM_PARKING_TIRED:
+		break;
+	case DIM_GOING_RIGHT:
+		dim->tune_state = DIM_GOING_LEFT;
+		dim->steps_left = 0;
+		break;
+	case DIM_GOING_LEFT:
+		dim->tune_state = DIM_GOING_RIGHT;
+		dim->steps_right = 0;
+		break;
+	}
+}
+EXPORT_SYMBOL(dim_turn);
+
+void dim_park_on_top(struct dim *dim)
+{
+	dim->steps_right  = 0;
+	dim->steps_left   = 0;
+	dim->tired        = 0;
+	dim->tune_state   = DIM_PARKING_ON_TOP;
+}
+EXPORT_SYMBOL(dim_park_on_top);
+
+void dim_park_tired(struct dim *dim)
+{
+	dim->steps_right  = 0;
+	dim->steps_left   = 0;
+	dim->tune_state   = DIM_PARKING_TIRED;
+}
+EXPORT_SYMBOL(dim_park_tired);
+
+void dim_create_sample(u16 event_ctr, u64 packets, u64 bytes, struct dim_sample *s)
+{
+	s->time	     = ktime_get();
+	s->pkt_ctr   = packets;
+	s->byte_ctr  = bytes;
+	s->event_ctr = event_ctr;
+}
+EXPORT_SYMBOL(dim_create_sample);
+
+void dim_calc_stats(struct dim_sample *start, struct dim_sample *end,
+		    struct dim_stats *curr_stats)
+{
+	/* u32 holds up to 71 minutes, should be enough */
+	u32 delta_us = ktime_us_delta(end->time, start->time);
+	u32 npkts = BIT_GAP(BITS_PER_TYPE(u32), end->pkt_ctr, start->pkt_ctr);
+	u32 nbytes = BIT_GAP(BITS_PER_TYPE(u32), end->byte_ctr,
+			     start->byte_ctr);
+
+	if (!delta_us)
+		return;
+
+	curr_stats->ppms = DIV_ROUND_UP(npkts * USEC_PER_MSEC, delta_us);
+	curr_stats->bpms = DIV_ROUND_UP(nbytes * USEC_PER_MSEC, delta_us);
+	curr_stats->epms = DIV_ROUND_UP(DIM_NEVENTS * USEC_PER_MSEC,
+					delta_us);
+}
+EXPORT_SYMBOL(dim_calc_stats);
diff --git a/lib/dim/net_dim.c b/lib/dim/net_dim.c
new file mode 100644
index 000000000000..cf95cd20cf02
--- /dev/null
+++ b/lib/dim/net_dim.c
@@ -0,0 +1,193 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
+/*
+ * Copyright (c) 2018, Mellanox Technologies inc.  All rights reserved.
+ */
+
+#include <linux/net_dim.h>
+#include <linux/dim.h>
+
+struct dim_cq_moder
+net_dim_get_rx_moderation(u8 cq_period_mode, int ix)
+{
+	struct dim_cq_moder cq_moder = rx_profile[cq_period_mode][ix];
+
+	cq_moder.cq_period_mode = cq_period_mode;
+	return cq_moder;
+}
+EXPORT_SYMBOL(net_dim_get_rx_moderation);
+
+struct dim_cq_moder
+net_dim_get_def_rx_moderation(u8 cq_period_mode)
+{
+	u8 profile_ix = cq_period_mode == DIM_CQ_PERIOD_MODE_START_FROM_CQE ?
+			NET_DIM_DEF_PROFILE_CQE : NET_DIM_DEF_PROFILE_EQE;
+
+	return net_dim_get_rx_moderation(cq_period_mode, profile_ix);
+}
+EXPORT_SYMBOL(net_dim_get_def_rx_moderation);
+
+struct dim_cq_moder
+net_dim_get_tx_moderation(u8 cq_period_mode, int ix)
+{
+	struct dim_cq_moder cq_moder = tx_profile[cq_period_mode][ix];
+
+	cq_moder.cq_period_mode = cq_period_mode;
+	return cq_moder;
+}
+EXPORT_SYMBOL(net_dim_get_tx_moderation);
+
+struct dim_cq_moder
+net_dim_get_def_tx_moderation(u8 cq_period_mode)
+{
+	u8 profile_ix = cq_period_mode == DIM_CQ_PERIOD_MODE_START_FROM_CQE ?
+			NET_DIM_DEF_PROFILE_CQE : NET_DIM_DEF_PROFILE_EQE;
+
+	return net_dim_get_tx_moderation(cq_period_mode, profile_ix);
+}
+EXPORT_SYMBOL(net_dim_get_def_tx_moderation);
+
+static inline int net_dim_step(struct dim *dim)
+{
+	if (dim->tired == (NET_DIM_PARAMS_NUM_PROFILES * 2))
+		return DIM_TOO_TIRED;
+
+	switch (dim->tune_state) {
+	case DIM_PARKING_ON_TOP:
+	case DIM_PARKING_TIRED:
+		break;
+	case DIM_GOING_RIGHT:
+		if (dim->profile_ix == (NET_DIM_PARAMS_NUM_PROFILES - 1))
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
+	dim->tired++;
+	return DIM_STEPPED;
+}
+
+static inline void net_dim_exit_parking(struct dim *dim)
+{
+	dim->tune_state = dim->profile_ix ? DIM_GOING_LEFT :
+					  DIM_GOING_RIGHT;
+	net_dim_step(dim);
+}
+
+static inline int net_dim_stats_compare(struct dim_stats *curr,
+					struct dim_stats *prev)
+{
+	if (!prev->bpms)
+		return curr->bpms ? DIM_STATS_BETTER :
+				    DIM_STATS_SAME;
+
+	if (IS_SIGNIFICANT_DIFF(curr->bpms, prev->bpms))
+		return (curr->bpms > prev->bpms) ? DIM_STATS_BETTER :
+						   DIM_STATS_WORSE;
+
+	if (!prev->ppms)
+		return curr->ppms ? DIM_STATS_BETTER :
+				    DIM_STATS_SAME;
+
+	if (IS_SIGNIFICANT_DIFF(curr->ppms, prev->ppms))
+		return (curr->ppms > prev->ppms) ? DIM_STATS_BETTER :
+						   DIM_STATS_WORSE;
+
+	if (!prev->epms)
+		return DIM_STATS_SAME;
+
+	if (IS_SIGNIFICANT_DIFF(curr->epms, prev->epms))
+		return (curr->epms < prev->epms) ? DIM_STATS_BETTER :
+						   DIM_STATS_WORSE;
+
+	return DIM_STATS_SAME;
+}
+
+static inline bool net_dim_decision(struct dim_stats *curr_stats,
+				    struct dim *dim)
+{
+	int prev_state = dim->tune_state;
+	int prev_ix = dim->profile_ix;
+	int stats_res;
+	int step_res;
+
+	switch (dim->tune_state) {
+	case DIM_PARKING_ON_TOP:
+		stats_res = net_dim_stats_compare(curr_stats, &dim->prev_stats);
+		if (stats_res != DIM_STATS_SAME)
+			net_dim_exit_parking(dim);
+		break;
+
+	case DIM_PARKING_TIRED:
+		dim->tired--;
+		if (!dim->tired)
+			net_dim_exit_parking(dim);
+		break;
+
+	case DIM_GOING_RIGHT:
+	case DIM_GOING_LEFT:
+		stats_res = net_dim_stats_compare(curr_stats, &dim->prev_stats);
+		if (stats_res != DIM_STATS_BETTER)
+			dim_turn(dim);
+
+		if (dim_on_top(dim)) {
+			dim_park_on_top(dim);
+			break;
+		}
+
+		step_res = net_dim_step(dim);
+		switch (step_res) {
+		case DIM_ON_EDGE:
+			dim_park_on_top(dim);
+			break;
+		case DIM_TOO_TIRED:
+			dim_park_tired(dim);
+			break;
+		}
+
+		break;
+	}
+
+	if ((prev_state      != DIM_PARKING_ON_TOP) ||
+	    (dim->tune_state != DIM_PARKING_ON_TOP))
+		dim->prev_stats = *curr_stats;
+
+	return dim->profile_ix != prev_ix;
+}
+
+void net_dim(struct dim *dim, struct dim_sample end_sample)
+{
+	struct dim_stats curr_stats;
+	u16 nevents;
+
+	switch (dim->state) {
+	case DIM_MEASURE_IN_PROGRESS:
+		nevents = BIT_GAP(BITS_PER_TYPE(u16),
+				  end_sample.event_ctr,
+				  dim->start_sample.event_ctr);
+		if (nevents < DIM_NEVENTS)
+			break;
+		dim_calc_stats(&dim->start_sample, &end_sample,
+				   &curr_stats);
+		if (net_dim_decision(&curr_stats, dim)) {
+			dim->state = DIM_APPLY_NEW_PROFILE;
+			schedule_work(&dim->work);
+			break;
+		}
+		/* fall through */
+	case DIM_START_MEASURE:
+		dim_create_sample(end_sample.event_ctr, end_sample.pkt_ctr,
+				  end_sample.byte_ctr, &dim->start_sample);
+		dim->state = DIM_MEASURE_IN_PROGRESS;
+		break;
+	case DIM_APPLY_NEW_PROFILE:
+		break;
+	}
+}
+EXPORT_SYMBOL(net_dim);
-- 
2.19.1

