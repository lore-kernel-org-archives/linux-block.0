Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62FC3C4332F
	for <linux-block@archiver.kernel.org>; Wed,  1 Jun 2022 12:21:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352994AbiFAMVn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 Jun 2022 08:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344635AbiFAMVV (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 Jun 2022 08:21:21 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 538C95D641
        for <linux-block@vger.kernel.org>; Wed,  1 Jun 2022 05:21:19 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id v11-20020a17090a4ecb00b001e2c5b837ccso6042845pjl.3
        for <linux-block@vger.kernel.org>; Wed, 01 Jun 2022 05:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cvyMZ32vWUq0PQ25pSdJ7F9z18j1tkrk0X4DK0wb+pM=;
        b=kxnZ7vRN+WQqWOB5MR7wfAgarJxLA8uLDRHyri1tlk0f3K2IslXSjPSWuFg5pMnFdh
         HDprEkLHaoZeQty7cXur4ieJIQFBwHlhllSwX0QHPN5RZ18H+aLarpAS4eTynppFq7tr
         8u6ndn8SaZbl57XrVoqT3djuazguIoR19fS3i/SyMs63WJtK++FLs/FpvVbyFjEW6dY5
         r3+JiisF0irEv6sMXMqmLlQvAsAwuK6WoHky9FPY8nBi/NWIgEfT9T+kg2uW+emFntPh
         Uq361otGJ8ZZOo4bGCiX/3ngHRQ/ra8xFDjVDh2xuWumlHmfa+nBgNtDMNJ2pZEVshRR
         lOnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cvyMZ32vWUq0PQ25pSdJ7F9z18j1tkrk0X4DK0wb+pM=;
        b=nqSAZwQrpO4h2AiRZUxQ4oxkoHi8enkaOAYrjjZyzbfmSsZ5sg5Fq88Wmg0t3aS1+q
         mpz74gVtCvXYmPTIoPrjmws4P3knsk6bKfTM02BpDKtjsV2tdFiUDjPJvXX6/XB+VA6Y
         Ffku5U8ys1KznAUoTTiaq+BqoXn5V6E0wmI6fQD3VvV8AgwWJjCNnslEZG+zBqeQvunQ
         svxR07sbrFzc6ts4glxxvpmth3WUy+tc+9Vt8+OjnlJIIQIHFEPocBqcDEmOXOCXmrs4
         wRcGVcrMQZnF12nFsSvrv31UinmLY4Ry7ohgqRUOUU9cmXLEJ35OQ6JdiML2hIXwxQl4
         leMQ==
X-Gm-Message-State: AOAM53016q3vqMjqh1aBBIjbVYiWt6qQSkxzQBVQfaOKO+fl838LmX/4
        Ay4dGJx/5loqjA4QR+mF41yFVA==
X-Google-Smtp-Source: ABdhPJxGNOmMnzBvygoNU/XIaL9fFEvwZd9o7+MdRm17YWKvByOJnl3tUA+d8dJYE9JdwafzFEa25A==
X-Received: by 2002:a17:90b:4c47:b0:1df:ad5b:e32e with SMTP id np7-20020a17090b4c4700b001dfad5be32emr33826198pjb.59.1654086078831;
        Wed, 01 Jun 2022 05:21:18 -0700 (PDT)
Received: from C02CV1DAMD6P.bytedance.net ([139.177.225.231])
        by smtp.gmail.com with ESMTPSA id ij24-20020a170902ab5800b0015e8d4eb1f7sm1427535plb.65.2022.06.01.05.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 05:21:18 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     tj@kernel.org, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH 1/2] blk-iocost: factor out iocg_deactivate()
Date:   Wed,  1 Jun 2022 20:20:06 +0800
Message-Id: <20220601122007.1057-1-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch factor out iocg deactivation into a separate function:
iocg_deactivate(). No functional changes.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 block/blk-iocost.c | 59 ++++++++++++++++++++++++++--------------------
 1 file changed, 33 insertions(+), 26 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 33a11ba971ea..b1f2305e8032 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -1322,6 +1322,37 @@ static bool iocg_activate(struct ioc_gq *iocg, struct ioc_now *now)
 	return false;
 }
 
+static void iocg_deactivate(struct ioc_gq *iocg, struct ioc_now *now)
+{
+	struct ioc *ioc = iocg->ioc;
+	u64 vtime = atomic64_read(&iocg->vtime);
+	s64 excess;
+
+	lockdep_assert_held(&ioc->lock);
+	lockdep_assert_held(&iocg->waitq.lock);
+
+	/*
+	 * @iocg has been inactive for a full duration and will
+	 * have a high budget. Account anything above target as
+	 * error and throw away. On reactivation, it'll start
+	 * with the target budget.
+	 */
+	excess = now->vnow - vtime - ioc->margins.target;
+	if (excess > 0) {
+		u32 old_hwi;
+
+		current_hweight(iocg, NULL, &old_hwi);
+		ioc->vtime_err -= div64_u64(excess * old_hwi,
+					    WEIGHT_ONE);
+	}
+
+	TRACE_IOCG_PATH(iocg_idle, iocg, now,
+			atomic64_read(&iocg->active_period),
+			atomic64_read(&ioc->cur_period), vtime);
+	__propagate_weights(iocg, 0, 0, false, now);
+	list_del_init(&iocg->active_list);
+}
+
 static bool iocg_kick_delay(struct ioc_gq *iocg, struct ioc_now *now)
 {
 	struct ioc *ioc = iocg->ioc;
@@ -2165,32 +2196,8 @@ static int ioc_check_iocgs(struct ioc *ioc, struct ioc_now *now)
 			iocg_kick_waitq(iocg, true, now);
 			if (iocg->abs_vdebt || iocg->delay)
 				nr_debtors++;
-		} else if (iocg_is_idle(iocg)) {
-			/* no waiter and idle, deactivate */
-			u64 vtime = atomic64_read(&iocg->vtime);
-			s64 excess;
-
-			/*
-			 * @iocg has been inactive for a full duration and will
-			 * have a high budget. Account anything above target as
-			 * error and throw away. On reactivation, it'll start
-			 * with the target budget.
-			 */
-			excess = now->vnow - vtime - ioc->margins.target;
-			if (excess > 0) {
-				u32 old_hwi;
-
-				current_hweight(iocg, NULL, &old_hwi);
-				ioc->vtime_err -= div64_u64(excess * old_hwi,
-							    WEIGHT_ONE);
-			}
-
-			TRACE_IOCG_PATH(iocg_idle, iocg, now,
-					atomic64_read(&iocg->active_period),
-					atomic64_read(&ioc->cur_period), vtime);
-			__propagate_weights(iocg, 0, 0, false, now);
-			list_del_init(&iocg->active_list);
-		}
+		} else if (iocg_is_idle(iocg))
+			iocg_deactivate(iocg, now);
 
 		spin_unlock(&iocg->waitq.lock);
 	}
-- 
2.36.1

