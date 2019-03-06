Return-Path: <SRS0=tltz=RJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4622AC43381
	for <linux-block@archiver.kernel.org>; Wed,  6 Mar 2019 08:48:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1444E20675
	for <linux-block@archiver.kernel.org>; Wed,  6 Mar 2019 08:48:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729517AbfCFIss (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Mar 2019 03:48:48 -0500
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:47815 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729621AbfCFIss (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Mar 2019 03:48:48 -0500
Received: from Internal Mail-Server by MTLPINE1 (envelope-from talgi@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 6 Mar 2019 10:48:41 +0200
Received: from gen-l-vrt-691.mtl.labs.mlnx (gen-l-vrt-691.mtl.labs.mlnx [10.141.69.1])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x268meb5017397;
        Wed, 6 Mar 2019 10:48:40 +0200
Received: from gen-l-vrt-691.mtl.labs.mlnx (localhost [127.0.0.1])
        by gen-l-vrt-691.mtl.labs.mlnx (8.15.2/8.15.2/Debian-11ubuntu1) with ESMTP id x268mdOa057816;
        Wed, 6 Mar 2019 10:48:39 +0200
Received: (from talgi@localhost)
        by gen-l-vrt-691.mtl.labs.mlnx (8.15.2/8.15.2/Submit) id x268mdMO057815;
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
Subject: [RFC/PATCH net-next 2/9] linux/dim: Remove "net" prefix from internal DIM members
Date:   Wed,  6 Mar 2019 10:48:25 +0200
Message-Id: <20190306084832.57753-3-talgi@mellanox.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190306084832.57753-1-talgi@mellanox.com>
References: <20190306084832.57753-1-talgi@mellanox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Only renaming functions and structs which aren't used by an external code.

Signed-off-by: Tal Gilboa <talgi@mellanox.com>
---
 include/linux/dim.h     | 86 ++++++++++++++++++++---------------------
 include/linux/net_dim.h | 86 ++++++++++++++++++++---------------------
 2 files changed, 86 insertions(+), 86 deletions(-)

diff --git a/include/linux/dim.h b/include/linux/dim.h
index c745c5d457ff..16ef59524b69 100644
--- a/include/linux/dim.h
+++ b/include/linux/dim.h
@@ -36,7 +36,7 @@
 
 #include <linux/module.h>
 
-#define NET_DIM_NEVENTS 64
+#define DIM_NEVENTS 64
 #define IS_SIGNIFICANT_DIFF(val, ref) \
 	(((100UL * abs((val) - (ref))) / (ref)) > 10) /* more than 10% difference */
 #define BIT_GAP(bits, end, start) ((((end) - (start)) + BIT_ULL(bits)) & (BIT_ULL(bits) - 1))
@@ -55,7 +55,7 @@ struct net_dim_sample {
 	u16     event_ctr;
 };
 
-struct net_dim_stats {
+struct dim_stats {
 	int ppms; /* packets per msec */
 	int bpms; /* bytes per msec */
 	int epms; /* events per msec */
@@ -63,7 +63,7 @@ struct net_dim_stats {
 
 struct net_dim { /* Dynamic Interrupt Moderation */
 	u8                                      state;
-	struct net_dim_stats                    prev_stats;
+	struct dim_stats                        prev_stats;
 	struct net_dim_sample                   start_sample;
 	struct work_struct                      work;
 	u8                                      profile_ix;
@@ -87,67 +87,67 @@ enum {
 };
 
 enum {
-	NET_DIM_PARKING_ON_TOP,
-	NET_DIM_PARKING_TIRED,
-	NET_DIM_GOING_RIGHT,
-	NET_DIM_GOING_LEFT,
+	DIM_PARKING_ON_TOP,
+	DIM_PARKING_TIRED,
+	DIM_GOING_RIGHT,
+	DIM_GOING_LEFT,
 };
 
 enum {
-	NET_DIM_STATS_WORSE,
-	NET_DIM_STATS_SAME,
-	NET_DIM_STATS_BETTER,
+	DIM_STATS_WORSE,
+	DIM_STATS_SAME,
+	DIM_STATS_BETTER,
 };
 
 enum {
-	NET_DIM_STEPPED,
-	NET_DIM_TOO_TIRED,
-	NET_DIM_ON_EDGE,
+	DIM_STEPPED,
+	DIM_TOO_TIRED,
+	DIM_ON_EDGE,
 };
 
-static inline bool net_dim_on_top(struct net_dim *net_dim)
+static inline bool dim_on_top(struct net_dim *dim)
 {
-	switch (net_dim->tune_state) {
-	case NET_DIM_PARKING_ON_TOP:
-	case NET_DIM_PARKING_TIRED:
+	switch (dim->tune_state) {
+	case DIM_PARKING_ON_TOP:
+	case DIM_PARKING_TIRED:
 		return true;
-	case NET_DIM_GOING_RIGHT:
-		return (net_dim->steps_left > 1) && (net_dim->steps_right == 1);
-	default: /* NET_DIM_GOING_LEFT */
-		return (net_dim->steps_right > 1) && (net_dim->steps_left == 1);
+	case DIM_GOING_RIGHT:
+		return (dim->steps_left > 1) && (dim->steps_right == 1);
+	default: /* DIM_GOING_LEFT */
+		return (dim->steps_right > 1) && (dim->steps_left == 1);
 	}
 }
 
-static inline void net_dim_turn(struct net_dim *net_dim)
+static inline void dim_turn(struct net_dim *dim)
 {
-	switch (net_dim->tune_state) {
-	case NET_DIM_PARKING_ON_TOP:
-	case NET_DIM_PARKING_TIRED:
+	switch (dim->tune_state) {
+	case DIM_PARKING_ON_TOP:
+	case DIM_PARKING_TIRED:
 		break;
-	case NET_DIM_GOING_RIGHT:
-		net_dim->tune_state = NET_DIM_GOING_LEFT;
-		net_dim->steps_left = 0;
+	case DIM_GOING_RIGHT:
+		dim->tune_state = DIM_GOING_LEFT;
+		dim->steps_left = 0;
 		break;
-	case NET_DIM_GOING_LEFT:
-		net_dim->tune_state = NET_DIM_GOING_RIGHT;
-		net_dim->steps_right = 0;
+	case DIM_GOING_LEFT:
+		dim->tune_state = DIM_GOING_RIGHT;
+		dim->steps_right = 0;
 		break;
 	}
 }
 
-static inline void net_dim_park_on_top(struct net_dim *net_dim)
+static inline void dim_park_on_top(struct net_dim *dim)
 {
-	net_dim->steps_right  = 0;
-	net_dim->steps_left   = 0;
-	net_dim->tired        = 0;
-	net_dim->tune_state   = NET_DIM_PARKING_ON_TOP;
+	dim->steps_right  = 0;
+	dim->steps_left   = 0;
+	dim->tired        = 0;
+	dim->tune_state   = DIM_PARKING_ON_TOP;
 }
 
-static inline void net_dim_park_tired(struct net_dim *net_dim)
+static inline void dim_park_tired(struct net_dim *dim)
 {
-	net_dim->steps_right  = 0;
-	net_dim->steps_left   = 0;
-	net_dim->tune_state   = NET_DIM_PARKING_TIRED;
+	dim->steps_right  = 0;
+	dim->steps_left   = 0;
+	dim->tune_state   = DIM_PARKING_TIRED;
 }
 
 static inline void net_dim_sample(u16 event_ctr,
@@ -161,9 +161,9 @@ static inline void net_dim_sample(u16 event_ctr,
 	s->event_ctr = event_ctr;
 }
 
-static inline void net_dim_calc_stats(struct net_dim_sample *start,
+static inline void dim_calc_stats(struct net_dim_sample *start,
 				  struct net_dim_sample *end,
-				  struct net_dim_stats *curr_stats)
+				  struct dim_stats *curr_stats)
 {
 	/* u32 holds up to 71 minutes, should be enough */
 	u32 delta_us = ktime_us_delta(end->time, start->time);
@@ -176,7 +176,7 @@ static inline void net_dim_calc_stats(struct net_dim_sample *start,
 
 	curr_stats->ppms = DIV_ROUND_UP(npkts * USEC_PER_MSEC, delta_us);
 	curr_stats->bpms = DIV_ROUND_UP(nbytes * USEC_PER_MSEC, delta_us);
-	curr_stats->epms = DIV_ROUND_UP(NET_DIM_NEVENTS * USEC_PER_MSEC,
+	curr_stats->epms = DIV_ROUND_UP(DIM_NEVENTS * USEC_PER_MSEC,
 					delta_us);
 }
 
diff --git a/include/linux/net_dim.h b/include/linux/net_dim.h
index 373cda74b167..1ce0899b5f30 100644
--- a/include/linux/net_dim.h
+++ b/include/linux/net_dim.h
@@ -128,67 +128,67 @@ net_dim_get_def_tx_moderation(u8 cq_period_mode)
 static inline int net_dim_step(struct net_dim *dim)
 {
 	if (dim->tired == (NET_DIM_PARAMS_NUM_PROFILES * 2))
-		return NET_DIM_TOO_TIRED;
+		return DIM_TOO_TIRED;
 
 	switch (dim->tune_state) {
-	case NET_DIM_PARKING_ON_TOP:
-	case NET_DIM_PARKING_TIRED:
+	case DIM_PARKING_ON_TOP:
+	case DIM_PARKING_TIRED:
 		break;
-	case NET_DIM_GOING_RIGHT:
+	case DIM_GOING_RIGHT:
 		if (dim->profile_ix == (NET_DIM_PARAMS_NUM_PROFILES - 1))
-			return NET_DIM_ON_EDGE;
+			return DIM_ON_EDGE;
 		dim->profile_ix++;
 		dim->steps_right++;
 		break;
-	case NET_DIM_GOING_LEFT:
+	case DIM_GOING_LEFT:
 		if (dim->profile_ix == 0)
-			return NET_DIM_ON_EDGE;
+			return DIM_ON_EDGE;
 		dim->profile_ix--;
 		dim->steps_left++;
 		break;
 	}
 
 	dim->tired++;
-	return NET_DIM_STEPPED;
+	return DIM_STEPPED;
 }
 
 static inline void net_dim_exit_parking(struct net_dim *dim)
 {
-	dim->tune_state = dim->profile_ix ? NET_DIM_GOING_LEFT :
-					  NET_DIM_GOING_RIGHT;
+	dim->tune_state = dim->profile_ix ? DIM_GOING_LEFT :
+					  DIM_GOING_RIGHT;
 	net_dim_step(dim);
 }
 
-static inline int net_dim_stats_compare(struct net_dim_stats *curr,
-					struct net_dim_stats *prev)
+static inline int net_dim_stats_compare(struct dim_stats *curr,
+					struct dim_stats *prev)
 {
 	if (!prev->bpms)
-		return curr->bpms ? NET_DIM_STATS_BETTER :
-				    NET_DIM_STATS_SAME;
+		return curr->bpms ? DIM_STATS_BETTER :
+				    DIM_STATS_SAME;
 
 	if (IS_SIGNIFICANT_DIFF(curr->bpms, prev->bpms))
-		return (curr->bpms > prev->bpms) ? NET_DIM_STATS_BETTER :
-						   NET_DIM_STATS_WORSE;
+		return (curr->bpms > prev->bpms) ? DIM_STATS_BETTER :
+						   DIM_STATS_WORSE;
 
 	if (!prev->ppms)
-		return curr->ppms ? NET_DIM_STATS_BETTER :
-				    NET_DIM_STATS_SAME;
+		return curr->ppms ? DIM_STATS_BETTER :
+				    DIM_STATS_SAME;
 
 	if (IS_SIGNIFICANT_DIFF(curr->ppms, prev->ppms))
-		return (curr->ppms > prev->ppms) ? NET_DIM_STATS_BETTER :
-						   NET_DIM_STATS_WORSE;
+		return (curr->ppms > prev->ppms) ? DIM_STATS_BETTER :
+						   DIM_STATS_WORSE;
 
 	if (!prev->epms)
-		return NET_DIM_STATS_SAME;
+		return DIM_STATS_SAME;
 
 	if (IS_SIGNIFICANT_DIFF(curr->epms, prev->epms))
-		return (curr->epms < prev->epms) ? NET_DIM_STATS_BETTER :
-						   NET_DIM_STATS_WORSE;
+		return (curr->epms < prev->epms) ? DIM_STATS_BETTER :
+						   DIM_STATS_WORSE;
 
-	return NET_DIM_STATS_SAME;
+	return DIM_STATS_SAME;
 }
 
-static inline bool net_dim_decision(struct net_dim_stats *curr_stats,
+static inline bool net_dim_decision(struct dim_stats *curr_stats,
 				    struct net_dim *dim)
 {
 	int prev_state = dim->tune_state;
@@ -197,44 +197,44 @@ static inline bool net_dim_decision(struct net_dim_stats *curr_stats,
 	int step_res;
 
 	switch (dim->tune_state) {
-	case NET_DIM_PARKING_ON_TOP:
+	case DIM_PARKING_ON_TOP:
 		stats_res = net_dim_stats_compare(curr_stats, &dim->prev_stats);
-		if (stats_res != NET_DIM_STATS_SAME)
+		if (stats_res != DIM_STATS_SAME)
 			net_dim_exit_parking(dim);
 		break;
 
-	case NET_DIM_PARKING_TIRED:
+	case DIM_PARKING_TIRED:
 		dim->tired--;
 		if (!dim->tired)
 			net_dim_exit_parking(dim);
 		break;
 
-	case NET_DIM_GOING_RIGHT:
-	case NET_DIM_GOING_LEFT:
+	case DIM_GOING_RIGHT:
+	case DIM_GOING_LEFT:
 		stats_res = net_dim_stats_compare(curr_stats, &dim->prev_stats);
-		if (stats_res != NET_DIM_STATS_BETTER)
-			net_dim_turn(dim);
+		if (stats_res != DIM_STATS_BETTER)
+			dim_turn(dim);
 
-		if (net_dim_on_top(dim)) {
-			net_dim_park_on_top(dim);
+		if (dim_on_top(dim)) {
+			dim_park_on_top(dim);
 			break;
 		}
 
 		step_res = net_dim_step(dim);
 		switch (step_res) {
-		case NET_DIM_ON_EDGE:
-			net_dim_park_on_top(dim);
+		case DIM_ON_EDGE:
+			dim_park_on_top(dim);
 			break;
-		case NET_DIM_TOO_TIRED:
-			net_dim_park_tired(dim);
+		case DIM_TOO_TIRED:
+			dim_park_tired(dim);
 			break;
 		}
 
 		break;
 	}
 
-	if ((prev_state      != NET_DIM_PARKING_ON_TOP) ||
-	    (dim->tune_state != NET_DIM_PARKING_ON_TOP))
+	if ((prev_state      != DIM_PARKING_ON_TOP) ||
+	    (dim->tune_state != DIM_PARKING_ON_TOP))
 		dim->prev_stats = *curr_stats;
 
 	return dim->profile_ix != prev_ix;
@@ -243,7 +243,7 @@ static inline bool net_dim_decision(struct net_dim_stats *curr_stats,
 static inline void net_dim(struct net_dim *dim,
 			   struct net_dim_sample end_sample)
 {
-	struct net_dim_stats curr_stats;
+	struct dim_stats curr_stats;
 	u16 nevents;
 
 	switch (dim->state) {
@@ -251,9 +251,9 @@ static inline void net_dim(struct net_dim *dim,
 		nevents = BIT_GAP(BITS_PER_TYPE(u16),
 				  end_sample.event_ctr,
 				  dim->start_sample.event_ctr);
-		if (nevents < NET_DIM_NEVENTS)
+		if (nevents < DIM_NEVENTS)
 			break;
-		net_dim_calc_stats(&dim->start_sample, &end_sample,
+		dim_calc_stats(&dim->start_sample, &end_sample,
 				   &curr_stats);
 		if (net_dim_decision(&curr_stats, dim)) {
 			dim->state = NET_DIM_APPLY_NEW_PROFILE;
-- 
2.19.1

