Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700B91ACED2
	for <linux-block@vger.kernel.org>; Sat,  8 Feb 2025 09:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739005591; cv=none; b=ADPWByRoLsqU1Ds/29wTL98cfukANqpgauK5q/kOF3iNKuiWSCjbqZX6xVzxVAzpwaK0kP4ePk9njocNZSRcBIgA3jpl7uhomh+e/iVA8asliDSASEaq3iMQnUnQwedGKre3/v/wFq0BZLW8Bn58pj50OaVD0pm/021TQcnF5vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739005591; c=relaxed/simple;
	bh=VTlnH2WIW7kGDHdeUWMtjkh2mRxOkDEdh9+SKHufAp8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TDUtrUQl8EvHe/QGrUAjAo6t3dPCpOk/G8mifJzEZbROQwcW/zdgFWNTUHHLhQJOmNMEUXr7x8z39b2uOmCW2r0jpU5EuVDFy4WCPn5G5UpvUNqHbmdiUNs0gLV4CQJsgzxcNpJSWZG7vB5Q9SKXxGIoR+fBwcregT2n/B31CYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=bYDYxM33; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="bYDYxM33"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2fa1fb3c445so2960885a91.2
        for <linux-block@vger.kernel.org>; Sat, 08 Feb 2025 01:06:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1739005588; x=1739610388; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dwpeSFZdmhzfc8/qFA4MyT2tUOC8UA2OsGoSXanSYG4=;
        b=bYDYxM33BbEgnfzSSCPJcdM8m8EFh7Iivsb4Q+Iknn4grYfL/bIeADsbSYem5gmEYj
         z1BjXZw3bZoqiiYTHrI4r0kU/VtHqABWFCgHpxCbneXknjuSRBX2okk23OjlbjpA2rSC
         kmfCk4YZvk7E1cdu/4MA1OP8E1fGmsH0sLZZbhr7R2OP1D55zI8OMoaiuRJ5WQgzfK7a
         MPsh8TBj/yov9TeVCwm8DThhqGJPj9iZZmnrgbHWJ8K8H8TMZ8gz56LQ67p8ZSXQ9PYV
         xqmwDP28LovAEFeshyzksXZayPrXkfrm1lHEHJujUDRLhD6Uhxxo6KqU/CCYc4TK/oRV
         RJXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739005588; x=1739610388;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dwpeSFZdmhzfc8/qFA4MyT2tUOC8UA2OsGoSXanSYG4=;
        b=fzkYuyAZfZ2XxvTwu/5PDjfQu4Brej3T5bSffJKwwyw73hgAJJFe+tAfEHsp+Yos/E
         R75yuGcA6TvRW7dJOsvcjbGdeYoBWJ/MTGtdfJaMliE8O0F2IIRek+RLHO5f7oXOjuVE
         50oouZQTLt1ikzTP5g/L2SnBGKoXbZCI0dceskxv+NU9e3cixcpI8Ys3LaLmrKVRYkne
         0OXT9RLNaI0DjDyzzNko/p/xQCV3EZTjvqzhYt3i4cArz+5XgbojQviCXfiIE90rgkGv
         9KrsStmKPGgcs9Cydz2f19ElNMioga7034kJfI1FzeDIT6/DHNMuSv4VE4E5++wb3GFV
         siyg==
X-Forwarded-Encrypted: i=1; AJvYcCUXuCJ740SDc8RVr9uK3GflJ9FgeQCOT4bmTTfKpa9pZu5FzUTVxIAiAGelt/zfEXmEVkqzPhNnnqsU1g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxofyIiI5/6A6PQkN0icdjdSjsgm17h0Sfxnn4yGKS1XXxhhCbd
	qfH2lf9KL+TDoZu21O0x+g6xu1rcH4wwk0vFmp6zPaWEAGdQod9C8Xxj80Psyfg=
X-Gm-Gg: ASbGncuvH/3a3Gx2Qin0KIDQ1cLvQvPOnefIL6AL1TdQjB4niwziBBA42H13hKiERFz
	4bnFz5RRTKWjYPrmeYnnM8Kyp2h1tMyxVPdY9PaUMVYquJ5jaku/teqdyiDlhgr2lBEVYF6t2B+
	wJ+Sm7gjUL9pb7xYnorlGrczCqIoR3IL+JRY3pZH8rOYKTorRdMty2m4uU8+lXFeWca4YdrNeNX
	t2pEcorAvfER0YZY+ZY0YmXJKyAP778hpw9t+S1+8tsJwRiYVMrRminlWDkBjiU9ipQ2ih1f2k0
	tMqwJGMDNq/yNBX0s2GFlhjXSSCGXpIpGWFep7Ip2c6lZQw2
X-Google-Smtp-Source: AGHT+IEOzt7459PAL07RC0zWz9pUH4t/bPsMiuYAaixY1RbqkKf6mlyq4FCdk22TvE92fusFNuVvuA==
X-Received: by 2002:a05:6a00:2289:b0:727:3fd5:b530 with SMTP id d2e1a72fcca58-7305d4f01f2mr10463243b3a.15.1739005587659;
        Sat, 08 Feb 2025 01:06:27 -0800 (PST)
Received: from PXLDJ45XCM.bytedance.net ([61.213.176.11])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73048bf1413sm4366493b3a.98.2025.02.08.01.06.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 08 Feb 2025 01:06:27 -0800 (PST)
From: Muchun Song <songmuchun@bytedance.com>
To: axboe@kernel.dk,
	tj@kernel.org,
	yukuai1@huaweicloud.com
Cc: chengming.zhou@linux.dev,
	muchun.song@linux.dev,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Muchun Song <songmuchun@bytedance.com>,
	Yu Kuai <yukuai3@huawei.com>
Subject: [PATCH RESEND v2 2/2] block: refactor rq_qos_wait()
Date: Sat,  8 Feb 2025 17:04:16 +0800
Message-Id: <20250208090416.38642-2-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250208090416.38642-1-songmuchun@bytedance.com>
References: <20250208090416.38642-1-songmuchun@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When rq_qos_wait() is first introduced, it is easy to understand. But
with some bug fixes applied, it is not easy for newcomers to understand
the whole logic under those fixes. In this patch, rq_qos_wait() is
refactored and more comments are added for better understanding. There
are 3 points for the improvement:

1) Use waitqueue_active() instead of wq_has_sleeper() to eliminate
   unnecessary memory barrier in wq_has_sleeper() which is supposed
   to be used in waker side. In this case, we do need the barrier.
   So use the cheaper one to locklessly test for waiters on the queue.

2) Remove acquire_inflight_cb() logic for the first waiter out of the
   while loop to make the code clear.

3) Add more comments to explain how to sync with different waiters and
   the waker.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Reviewed-by: Yu Kuai <yukuai3@huawei.com>
---
 block/blk-rq-qos.c | 68 ++++++++++++++++++++++++++++++++--------------
 1 file changed, 47 insertions(+), 21 deletions(-)

diff --git a/block/blk-rq-qos.c b/block/blk-rq-qos.c
index 0b1245d368cd1..5d995d389eaf5 100644
--- a/block/blk-rq-qos.c
+++ b/block/blk-rq-qos.c
@@ -223,6 +223,14 @@ static int rq_qos_wake_function(struct wait_queue_entry *curr,
 	 * Remove explicitly and use default_wake_function().
 	 */
 	default_wake_function(curr, mode, wake_flags, key);
+	/*
+	 * Note that the order of operations is important as finish_wait()
+	 * tests whether @curr is removed without grabbing the lock. This
+	 * should be the last thing to do to make sure we will not have a
+	 * UAF access to @data. And the semantics of memory barrier in it
+	 * also make sure the waiter will see the latest @data->got_token
+	 * once list_empty_careful() in finish_wait() returns true.
+	 */
 	list_del_init_careful(&curr->entry);
 	return 1;
 }
@@ -248,37 +256,55 @@ void rq_qos_wait(struct rq_wait *rqw, void *private_data,
 		 cleanup_cb_t *cleanup_cb)
 {
 	struct rq_qos_wait_data data = {
-		.rqw = rqw,
-		.cb = acquire_inflight_cb,
-		.private_data = private_data,
+		.rqw		= rqw,
+		.cb		= acquire_inflight_cb,
+		.private_data	= private_data,
+		.got_token	= false,
 	};
-	bool has_sleeper;
+	bool first_waiter;
 
-	has_sleeper = wq_has_sleeper(&rqw->wait);
-	if (!has_sleeper && acquire_inflight_cb(rqw, private_data))
+	/*
+	 * If there are no waiters in the waiting queue, try to increase the
+	 * inflight counter if we can. Otherwise, prepare for adding ourselves
+	 * to the waiting queue.
+	 */
+	if (!waitqueue_active(&rqw->wait) && acquire_inflight_cb(rqw, private_data))
 		return;
 
 	init_wait_func(&data.wq, rq_qos_wake_function);
-	has_sleeper = !prepare_to_wait_exclusive(&rqw->wait, &data.wq,
+	first_waiter = prepare_to_wait_exclusive(&rqw->wait, &data.wq,
 						 TASK_UNINTERRUPTIBLE);
+	/*
+	 * Make sure there is at least one inflight process; otherwise, waiters
+	 * will never be woken up. Since there may be no inflight process before
+	 * adding ourselves to the waiting queue above, we need to try to
+	 * increase the inflight counter for ourselves. And it is sufficient to
+	 * guarantee that at least the first waiter to enter the waiting queue
+	 * will re-check the waiting condition before going to sleep, thus
+	 * ensuring forward progress.
+	 */
+	if (!data.got_token && first_waiter && acquire_inflight_cb(rqw, private_data)) {
+		finish_wait(&rqw->wait, &data.wq);
+		/*
+		 * We raced with rq_qos_wake_function() getting a token,
+		 * which means we now have two. Put our local token
+		 * and wake anyone else potentially waiting for one.
+		 *
+		 * Enough memory barrier in list_empty_careful() in
+		 * finish_wait() is paired with list_del_init_careful()
+		 * in rq_qos_wake_function() to make sure we will see
+		 * the latest @data->got_token.
+		 */
+		if (data.got_token)
+			cleanup_cb(rqw, private_data);
+		return;
+	}
+
+	/* we are now relying on the waker to increase our inflight counter. */
 	do {
-		/* The memory barrier in set_current_state saves us here. */
 		if (data.got_token)
 			break;
-		if (!has_sleeper && acquire_inflight_cb(rqw, private_data)) {
-			finish_wait(&rqw->wait, &data.wq);
-
-			/*
-			 * We raced with rq_qos_wake_function() getting a token,
-			 * which means we now have two. Put our local token
-			 * and wake anyone else potentially waiting for one.
-			 */
-			if (data.got_token)
-				cleanup_cb(rqw, private_data);
-			return;
-		}
 		io_schedule();
-		has_sleeper = true;
 		set_current_state(TASK_UNINTERRUPTIBLE);
 	} while (1);
 	finish_wait(&rqw->wait, &data.wq);
-- 
2.20.1

