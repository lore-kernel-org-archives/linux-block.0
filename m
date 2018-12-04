Return-Path: <SRS0=ovnK=ON=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA166C04EBF
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 17:59:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AF842082B
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 17:59:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="S5rd6I7j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AF842082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbeLDR7O (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Dec 2018 12:59:14 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:39389 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbeLDR7O (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Dec 2018 12:59:14 -0500
Received: by mail-yw1-f67.google.com with SMTP id j6so7330711ywj.6
        for <linux-block@vger.kernel.org>; Tue, 04 Dec 2018 09:59:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=aoM0TGuZdp2Tjvb7I0kBQhIGZxUwsDSKQW86qy2szPk=;
        b=S5rd6I7jHTaarpyfr8mcIvoFPC2cOWEf+cQsr4bnICCzzpjhPL/AO4iKuP+Be0D5ZA
         k3j1YP6HHgij49JuhO8ayDixwI/hRl8ZKqGUQ+VPcqtqgRxA6lFIa5JdeOPYLC1QteAp
         DiDMKbwVFMcpst/S7JFGE2wJj2plN78CvBVLnvOEYllGwoOevD8gGd/uI5GDXKM8PWBM
         Dt+9R84g7+Q2KYY8O0X25Jx8YMJ2uf+sUebbXSOKCTHm6cj5GCuCgHD+zzFSHVwt84wm
         CgIThjpzw1H1W2hpfAsWf8fCk+/uKYPy+ud+WC2mOAs1ZKjKP99/gKWwg6j5MLkSFGq/
         mZnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=aoM0TGuZdp2Tjvb7I0kBQhIGZxUwsDSKQW86qy2szPk=;
        b=hbZm4ucLyI+jrAgnI2LDknPl5aP3OjXEkpPxZnfBemSa+IiogjqIA06HccceDiB7jl
         JHBoUjJhCgwxFDkZYI1yhSn6h5eLSFUp26t+6kVT3GgagrHGrquHaDkkmrKA59y5xcVY
         u7C4zxT5mPk4r8nAgMejLFMXSlLxqs6ypUqEfE8q71ZQHMdqI+t3tfU435G/psmIIuuQ
         9J35+IyKBtoS+Akn65+PHuvcV6+pOPQIkha+aBr973CPaVoCUWbmhw8JssH7LrcAloZv
         J7rhCBkwRQuFCKeXAX0dPakdbZzONoLYWBa7Hhj4mT32UOreJQCfsyo69vokQtRVFMHL
         smHg==
X-Gm-Message-State: AA+aEWZ/qN/2quOS05eNtn+7VIC+SZjFpBVogenT4ETtaAd66jcU+DSH
        CcgiuYo3iy6vlECmPW0zkoZ5sg==
X-Google-Smtp-Source: AFSGD/Xua5rv9FOdDQPLwlFvO1o+ohmDveZaOQ2CpoKMEV6kyRbphIrmmmYkNdkuYDKJ4fopiMjZlQ==
X-Received: by 2002:a0d:cf04:: with SMTP id r4mr6211889ywd.283.1543946352786;
        Tue, 04 Dec 2018 09:59:12 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id x135-v6sm6322998ywg.68.2018.12.04.09.59.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Dec 2018 09:59:12 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     kernel-team@fb.com, linux-block@vger.kernel.org, axboe@kernel.dk
Subject: [PATCH 2/3] block: convert wbt_wait() to use rq_qos_wait()
Date:   Tue,  4 Dec 2018 12:59:03 -0500
Message-Id: <20181204175904.8486-3-josef@toxicpanda.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20181204175904.8486-1-josef@toxicpanda.com>
References: <20181204175904.8486-1-josef@toxicpanda.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Now that we have rq_qos_wait() in place, convert wbt_wait() over to
using it with it's specific callbacks.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 block/blk-wbt.c | 65 ++++++++++-----------------------------------------------
 1 file changed, 11 insertions(+), 54 deletions(-)

diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index d051ebfb4852..40207edd1d89 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -489,31 +489,21 @@ static inline unsigned int get_limit(struct rq_wb *rwb, unsigned long rw)
 }
 
 struct wbt_wait_data {
-	struct wait_queue_entry wq;
-	struct task_struct *task;
 	struct rq_wb *rwb;
-	struct rq_wait *rqw;
+	enum wbt_flags wb_acct;
 	unsigned long rw;
-	bool got_token;
 };
 
-static int wbt_wake_function(struct wait_queue_entry *curr, unsigned int mode,
-			     int wake_flags, void *key)
+static bool wbt_inflight_cb(struct rq_wait *rqw, void *private_data)
 {
-	struct wbt_wait_data *data = container_of(curr, struct wbt_wait_data,
-							wq);
-
-	/*
-	 * If we fail to get a budget, return -1 to interrupt the wake up
-	 * loop in __wake_up_common.
-	 */
-	if (!rq_wait_inc_below(data->rqw, get_limit(data->rwb, data->rw)))
-		return -1;
+	struct wbt_wait_data *data = private_data;
+	return rq_wait_inc_below(rqw, get_limit(data->rwb, data->rw));
+}
 
-	data->got_token = true;
-	list_del_init(&curr->entry);
-	wake_up_process(data->task);
-	return 1;
+static void wbt_cleanup_cb(struct rq_wait *rqw, void *private_data)
+{
+	struct wbt_wait_data *data = private_data;
+	wbt_rqw_done(data->rwb, rqw, data->wb_acct);
 }
 
 /*
@@ -525,45 +515,12 @@ static void __wbt_wait(struct rq_wb *rwb, enum wbt_flags wb_acct,
 {
 	struct rq_wait *rqw = get_rq_wait(rwb, wb_acct);
 	struct wbt_wait_data data = {
-		.wq = {
-			.func	= wbt_wake_function,
-			.entry	= LIST_HEAD_INIT(data.wq.entry),
-		},
-		.task = current,
 		.rwb = rwb,
-		.rqw = rqw,
+		.wb_acct = wb_acct,
 		.rw = rw,
 	};
-	bool has_sleeper;
-
-	has_sleeper = wq_has_sleeper(&rqw->wait);
-	if (!has_sleeper && rq_wait_inc_below(rqw, get_limit(rwb, rw)))
-		return;
-
-	prepare_to_wait_exclusive(&rqw->wait, &data.wq, TASK_UNINTERRUPTIBLE);
-	do {
-		if (data.got_token)
-			break;
-
-		if (!has_sleeper &&
-		    rq_wait_inc_below(rqw, get_limit(rwb, rw))) {
-			finish_wait(&rqw->wait, &data.wq);
-
-			/*
-			 * We raced with wbt_wake_function() getting a token,
-			 * which means we now have two. Put our local token
-			 * and wake anyone else potentially waiting for one.
-			 */
-			if (data.got_token)
-				wbt_rqw_done(rwb, rqw, wb_acct);
-			break;
-		}
-
-		io_schedule();
-		has_sleeper = false;
-	} while (1);
 
-	finish_wait(&rqw->wait, &data.wq);
+	rq_qos_wait(rqw, &data, wbt_inflight_cb, wbt_cleanup_cb);
 }
 
 static inline bool wbt_should_throttle(struct rq_wb *rwb, struct bio *bio)
-- 
2.14.3

