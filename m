Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1B7BC4361B
	for <linux-block@archiver.kernel.org>; Thu, 10 Dec 2020 11:01:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4972423B70
	for <linux-block@archiver.kernel.org>; Thu, 10 Dec 2020 11:01:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389257AbgLJK5k (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Dec 2020 05:57:40 -0500
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:33911 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389253AbgLJK5h (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Dec 2020 05:57:37 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UI8pCsw_1607597813;
Received: from localhost(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0UI8pCsw_1607597813)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 10 Dec 2020 18:56:53 +0800
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
To:     axboe@kernel.dk, tj@kernel.org
Cc:     baolin.wang@linux.alibaba.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] blk-iocost: Add iocg idle state tracepoint
Date:   Thu, 10 Dec 2020 18:56:44 +0800
Message-Id: <1ba7a38d5a6186b1e71432ef424c23ba1904a365.1607591591.git.baolin.wang@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

It will be helpful to trace the iocg's whole state, including active and
idle state. And we can easily expand the original iocost_iocg_activate
trace event to support a state trace class, including active and idle
state tracing.

Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 block/blk-iocost.c            |  3 +++
 include/trace/events/iocost.h | 16 +++++++++++++++-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index ffa418c..ac6078a 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -2185,6 +2185,9 @@ static int ioc_check_iocgs(struct ioc *ioc, struct ioc_now *now)
 							    WEIGHT_ONE);
 			}
 
+			TRACE_IOCG_PATH(iocg_idle, iocg, now,
+					atomic64_read(&iocg->active_period),
+					atomic64_read(&ioc->cur_period), vtime);
 			__propagate_weights(iocg, 0, 0, false, now);
 			list_del_init(&iocg->active_list);
 		}
diff --git a/include/trace/events/iocost.h b/include/trace/events/iocost.h
index 0b68699..e282ce0 100644
--- a/include/trace/events/iocost.h
+++ b/include/trace/events/iocost.h
@@ -11,7 +11,7 @@
 
 #include <linux/tracepoint.h>
 
-TRACE_EVENT(iocost_iocg_activate,
+DECLARE_EVENT_CLASS(iocost_iocg_state,
 
 	TP_PROTO(struct ioc_gq *iocg, const char *path, struct ioc_now *now,
 		u64 last_period, u64 cur_period, u64 vtime),
@@ -59,6 +59,20 @@
 	)
 );
 
+DEFINE_EVENT(iocost_iocg_state, iocost_iocg_activate,
+	TP_PROTO(struct ioc_gq *iocg, const char *path, struct ioc_now *now,
+		 u64 last_period, u64 cur_period, u64 vtime),
+
+	TP_ARGS(iocg, path, now, last_period, cur_period, vtime)
+);
+
+DEFINE_EVENT(iocost_iocg_state, iocost_iocg_idle,
+	TP_PROTO(struct ioc_gq *iocg, const char *path, struct ioc_now *now,
+		 u64 last_period, u64 cur_period, u64 vtime),
+
+	TP_ARGS(iocg, path, now, last_period, cur_period, vtime)
+);
+
 DECLARE_EVENT_CLASS(iocg_inuse_update,
 
 	TP_PROTO(struct ioc_gq *iocg, const char *path, struct ioc_now *now,
-- 
1.8.3.1

