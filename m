Return-Path: <SRS0=tltz=RJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 538FAC43381
	for <linux-block@archiver.kernel.org>; Wed,  6 Mar 2019 08:48:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15D89206DD
	for <linux-block@archiver.kernel.org>; Wed,  6 Mar 2019 08:48:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729624AbfCFIsr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Mar 2019 03:48:47 -0500
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:47788 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729130AbfCFIsr (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Mar 2019 03:48:47 -0500
Received: from Internal Mail-Server by MTLPINE1 (envelope-from talgi@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 6 Mar 2019 10:48:40 +0200
Received: from gen-l-vrt-691.mtl.labs.mlnx (gen-l-vrt-691.mtl.labs.mlnx [10.141.69.1])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x268mdHE017364;
        Wed, 6 Mar 2019 10:48:39 +0200
Received: from gen-l-vrt-691.mtl.labs.mlnx (localhost [127.0.0.1])
        by gen-l-vrt-691.mtl.labs.mlnx (8.15.2/8.15.2/Debian-11ubuntu1) with ESMTP id x268mdIJ057813;
        Wed, 6 Mar 2019 10:48:39 +0200
Received: (from talgi@localhost)
        by gen-l-vrt-691.mtl.labs.mlnx (8.15.2/8.15.2/Submit) id x268mdp6057812;
        Wed, 6 Mar 2019 10:48:39 +0200
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
Subject: [RFC/PATCH net-next 1/9] linux/dim: Move logic to dim.h
Date:   Wed,  6 Mar 2019 10:48:24 +0200
Message-Id: <20190306084832.57753-2-talgi@mellanox.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190306084832.57753-1-talgi@mellanox.com>
References: <20190306084832.57753-1-talgi@mellanox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In preparation for supporting more implementations of the DIM
algorithm, I'm moving what would become common logic to a common
library. Downstream DIM implementations will use the common lib
for their implementation.

Signed-off-by: Tal Gilboa <talgi@mellanox.com>
---
 include/linux/dim.h     | 183 ++++++++++++++++++++++++++++++++++++++++
 include/linux/net_dim.h | 148 +-------------------------------
 2 files changed, 185 insertions(+), 146 deletions(-)
 create mode 100644 include/linux/dim.h

diff --git a/include/linux/dim.h b/include/linux/dim.h
new file mode 100644
index 000000000000..c745c5d457ff
--- /dev/null
+++ b/include/linux/dim.h
@@ -0,0 +1,183 @@
+/*
+ * Copyright (c) 2016, Mellanox Technologies. All rights reserved.
+ * Copyright (c) 2017-2018, Broadcom Limited. All rights reserved.
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
+#ifndef DIM_H
+#define DIM_H
+
+#include <linux/module.h>
+
+#define NET_DIM_NEVENTS 64
+#define IS_SIGNIFICANT_DIFF(val, ref) \
+	(((100UL * abs((val) - (ref))) / (ref)) > 10) /* more than 10% difference */
+#define BIT_GAP(bits, end, start) ((((end) - (start)) + BIT_ULL(bits)) & (BIT_ULL(bits) - 1))
+
+
+struct net_dim_cq_moder {
+	u16 usec;
+	u16 pkts;
+	u8 cq_period_mode;
+};
+
+struct net_dim_sample {
+	ktime_t time;
+	u32     pkt_ctr;
+	u32     byte_ctr;
+	u16     event_ctr;
+};
+
+struct net_dim_stats {
+	int ppms; /* packets per msec */
+	int bpms; /* bytes per msec */
+	int epms; /* events per msec */
+};
+
+struct net_dim { /* Dynamic Interrupt Moderation */
+	u8                                      state;
+	struct net_dim_stats                    prev_stats;
+	struct net_dim_sample                   start_sample;
+	struct work_struct                      work;
+	u8                                      profile_ix;
+	u8                                      mode;
+	u8                                      tune_state;
+	u8                                      steps_right;
+	u8                                      steps_left;
+	u8                                      tired;
+};
+
+enum {
+	NET_DIM_CQ_PERIOD_MODE_START_FROM_EQE = 0x0,
+	NET_DIM_CQ_PERIOD_MODE_START_FROM_CQE = 0x1,
+	NET_DIM_CQ_PERIOD_NUM_MODES
+};
+
+enum {
+	NET_DIM_START_MEASURE,
+	NET_DIM_MEASURE_IN_PROGRESS,
+	NET_DIM_APPLY_NEW_PROFILE,
+};
+
+enum {
+	NET_DIM_PARKING_ON_TOP,
+	NET_DIM_PARKING_TIRED,
+	NET_DIM_GOING_RIGHT,
+	NET_DIM_GOING_LEFT,
+};
+
+enum {
+	NET_DIM_STATS_WORSE,
+	NET_DIM_STATS_SAME,
+	NET_DIM_STATS_BETTER,
+};
+
+enum {
+	NET_DIM_STEPPED,
+	NET_DIM_TOO_TIRED,
+	NET_DIM_ON_EDGE,
+};
+
+static inline bool net_dim_on_top(struct net_dim *net_dim)
+{
+	switch (net_dim->tune_state) {
+	case NET_DIM_PARKING_ON_TOP:
+	case NET_DIM_PARKING_TIRED:
+		return true;
+	case NET_DIM_GOING_RIGHT:
+		return (net_dim->steps_left > 1) && (net_dim->steps_right == 1);
+	default: /* NET_DIM_GOING_LEFT */
+		return (net_dim->steps_right > 1) && (net_dim->steps_left == 1);
+	}
+}
+
+static inline void net_dim_turn(struct net_dim *net_dim)
+{
+	switch (net_dim->tune_state) {
+	case NET_DIM_PARKING_ON_TOP:
+	case NET_DIM_PARKING_TIRED:
+		break;
+	case NET_DIM_GOING_RIGHT:
+		net_dim->tune_state = NET_DIM_GOING_LEFT;
+		net_dim->steps_left = 0;
+		break;
+	case NET_DIM_GOING_LEFT:
+		net_dim->tune_state = NET_DIM_GOING_RIGHT;
+		net_dim->steps_right = 0;
+		break;
+	}
+}
+
+static inline void net_dim_park_on_top(struct net_dim *net_dim)
+{
+	net_dim->steps_right  = 0;
+	net_dim->steps_left   = 0;
+	net_dim->tired        = 0;
+	net_dim->tune_state   = NET_DIM_PARKING_ON_TOP;
+}
+
+static inline void net_dim_park_tired(struct net_dim *net_dim)
+{
+	net_dim->steps_right  = 0;
+	net_dim->steps_left   = 0;
+	net_dim->tune_state   = NET_DIM_PARKING_TIRED;
+}
+
+static inline void net_dim_sample(u16 event_ctr,
+				  u64 packets,
+				  u64 bytes,
+				  struct net_dim_sample *s)
+{
+	s->time	     = ktime_get();
+	s->pkt_ctr   = packets;
+	s->byte_ctr  = bytes;
+	s->event_ctr = event_ctr;
+}
+
+static inline void net_dim_calc_stats(struct net_dim_sample *start,
+				  struct net_dim_sample *end,
+				  struct net_dim_stats *curr_stats)
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
+	curr_stats->epms = DIV_ROUND_UP(NET_DIM_NEVENTS * USEC_PER_MSEC,
+					delta_us);
+}
+
+#endif /* DIM_H */
diff --git a/include/linux/net_dim.h b/include/linux/net_dim.h
index fd458389f7d1..373cda74b167 100644
--- a/include/linux/net_dim.h
+++ b/include/linux/net_dim.h
@@ -35,73 +35,10 @@
 #define NET_DIM_H
 
 #include <linux/module.h>
-
-struct net_dim_cq_moder {
-	u16 usec;
-	u16 pkts;
-	u8 cq_period_mode;
-};
-
-struct net_dim_sample {
-	ktime_t time;
-	u32     pkt_ctr;
-	u32     byte_ctr;
-	u16     event_ctr;
-};
-
-struct net_dim_stats {
-	int ppms; /* packets per msec */
-	int bpms; /* bytes per msec */
-	int epms; /* events per msec */
-};
-
-struct net_dim { /* Adaptive Moderation */
-	u8                                      state;
-	struct net_dim_stats                    prev_stats;
-	struct net_dim_sample                   start_sample;
-	struct work_struct                      work;
-	u8                                      profile_ix;
-	u8                                      mode;
-	u8                                      tune_state;
-	u8                                      steps_right;
-	u8                                      steps_left;
-	u8                                      tired;
-};
-
-enum {
-	NET_DIM_CQ_PERIOD_MODE_START_FROM_EQE = 0x0,
-	NET_DIM_CQ_PERIOD_MODE_START_FROM_CQE = 0x1,
-	NET_DIM_CQ_PERIOD_NUM_MODES
-};
-
-/* Adaptive moderation logic */
-enum {
-	NET_DIM_START_MEASURE,
-	NET_DIM_MEASURE_IN_PROGRESS,
-	NET_DIM_APPLY_NEW_PROFILE,
-};
-
-enum {
-	NET_DIM_PARKING_ON_TOP,
-	NET_DIM_PARKING_TIRED,
-	NET_DIM_GOING_RIGHT,
-	NET_DIM_GOING_LEFT,
-};
-
-enum {
-	NET_DIM_STATS_WORSE,
-	NET_DIM_STATS_SAME,
-	NET_DIM_STATS_BETTER,
-};
-
-enum {
-	NET_DIM_STEPPED,
-	NET_DIM_TOO_TIRED,
-	NET_DIM_ON_EDGE,
-};
+#include <linux/dim.h>
 
 #define NET_DIM_PARAMS_NUM_PROFILES 5
-/* Adaptive moderation profiles */
+/* Netdev dynamic interrupt moderation profiles */
 #define NET_DIM_DEFAULT_RX_CQ_MODERATION_PKTS_FROM_EQE 256
 #define NET_DIM_DEFAULT_TX_CQ_MODERATION_PKTS_FROM_EQE 128
 #define NET_DIM_DEF_PROFILE_CQE 1
@@ -188,36 +125,6 @@ net_dim_get_def_tx_moderation(u8 cq_period_mode)
 	return net_dim_get_tx_moderation(cq_period_mode, profile_ix);
 }
 
-static inline bool net_dim_on_top(struct net_dim *dim)
-{
-	switch (dim->tune_state) {
-	case NET_DIM_PARKING_ON_TOP:
-	case NET_DIM_PARKING_TIRED:
-		return true;
-	case NET_DIM_GOING_RIGHT:
-		return (dim->steps_left > 1) && (dim->steps_right == 1);
-	default: /* NET_DIM_GOING_LEFT */
-		return (dim->steps_right > 1) && (dim->steps_left == 1);
-	}
-}
-
-static inline void net_dim_turn(struct net_dim *dim)
-{
-	switch (dim->tune_state) {
-	case NET_DIM_PARKING_ON_TOP:
-	case NET_DIM_PARKING_TIRED:
-		break;
-	case NET_DIM_GOING_RIGHT:
-		dim->tune_state = NET_DIM_GOING_LEFT;
-		dim->steps_left = 0;
-		break;
-	case NET_DIM_GOING_LEFT:
-		dim->tune_state = NET_DIM_GOING_RIGHT;
-		dim->steps_right = 0;
-		break;
-	}
-}
-
 static inline int net_dim_step(struct net_dim *dim)
 {
 	if (dim->tired == (NET_DIM_PARAMS_NUM_PROFILES * 2))
@@ -245,21 +152,6 @@ static inline int net_dim_step(struct net_dim *dim)
 	return NET_DIM_STEPPED;
 }
 
-static inline void net_dim_park_on_top(struct net_dim *dim)
-{
-	dim->steps_right  = 0;
-	dim->steps_left   = 0;
-	dim->tired        = 0;
-	dim->tune_state   = NET_DIM_PARKING_ON_TOP;
-}
-
-static inline void net_dim_park_tired(struct net_dim *dim)
-{
-	dim->steps_right  = 0;
-	dim->steps_left   = 0;
-	dim->tune_state   = NET_DIM_PARKING_TIRED;
-}
-
 static inline void net_dim_exit_parking(struct net_dim *dim)
 {
 	dim->tune_state = dim->profile_ix ? NET_DIM_GOING_LEFT :
@@ -267,9 +159,6 @@ static inline void net_dim_exit_parking(struct net_dim *dim)
 	net_dim_step(dim);
 }
 
-#define IS_SIGNIFICANT_DIFF(val, ref) \
-	(((100UL * abs((val) - (ref))) / (ref)) > 10) /* more than 10% difference */
-
 static inline int net_dim_stats_compare(struct net_dim_stats *curr,
 					struct net_dim_stats *prev)
 {
@@ -351,39 +240,6 @@ static inline bool net_dim_decision(struct net_dim_stats *curr_stats,
 	return dim->profile_ix != prev_ix;
 }
 
-static inline void net_dim_sample(u16 event_ctr,
-				  u64 packets,
-				  u64 bytes,
-				  struct net_dim_sample *s)
-{
-	s->time	     = ktime_get();
-	s->pkt_ctr   = packets;
-	s->byte_ctr  = bytes;
-	s->event_ctr = event_ctr;
-}
-
-#define NET_DIM_NEVENTS 64
-#define BIT_GAP(bits, end, start) ((((end) - (start)) + BIT_ULL(bits)) & (BIT_ULL(bits) - 1))
-
-static inline void net_dim_calc_stats(struct net_dim_sample *start,
-				      struct net_dim_sample *end,
-				      struct net_dim_stats *curr_stats)
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
-	curr_stats->epms = DIV_ROUND_UP(NET_DIM_NEVENTS * USEC_PER_MSEC,
-					delta_us);
-}
-
 static inline void net_dim(struct net_dim *dim,
 			   struct net_dim_sample end_sample)
 {
-- 
2.19.1

