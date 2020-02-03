Return-Path: <SRS0=KNqY=3X=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A85FC33CAC
	for <linux-block@archiver.kernel.org>; Mon,  3 Feb 2020 10:41:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8EE820661
	for <linux-block@archiver.kernel.org>; Mon,  3 Feb 2020 10:41:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ClEgubha"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbgBCKlf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 3 Feb 2020 05:41:35 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43645 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727387AbgBCKlX (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 3 Feb 2020 05:41:23 -0500
Received: by mail-wr1-f65.google.com with SMTP id z9so5097556wrs.10
        for <linux-block@vger.kernel.org>; Mon, 03 Feb 2020 02:41:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2JnpfsZk3kAtby8wy0jKx+72oyKbhVB+xt+XMt95DpU=;
        b=ClEgubhacM0r6j0bZGOk6QkgGy3B9LsAcvsQMJ5TWx1Nz/qWqosjWLWAJehkrjFICR
         4d7HZRz9o9X+eU5NM2vPrPpo3PkvZ4SoP59HrGGDTbmCdCx48Nbd1FhqscNfWECOx97I
         4armcQeDukX45wpG3QSFRINkyL81BNZAF0aMXKm8Nx0ihzhqBAHCTtkQWlRKk7kifhVq
         WaAtI0k1jMiu2GoRQZZx7bAO6CBkE0OfNv1h11ryfbAIJUnIjP2V2uNW+GuaWkKMLh02
         1nP+UAwZurx5gUXwGeHwzptvTAPkyNBDA366IWoZz6r41Uf3944oA4G5lA0o7zsZwXjB
         IjGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2JnpfsZk3kAtby8wy0jKx+72oyKbhVB+xt+XMt95DpU=;
        b=E0RtRRCFfJo8v6cGaPT+GX7K3kYbdUuecVb4WGmvpayMXdIjRSf4iM/WyYwFzne31i
         d1xnpm7tAjH30mDGuA9b9Kskq1cLradsLZE5x9MhAOjebgcAFiBKB08Jxz8wSvK1U2Dq
         YV7ladJLumX/twq5e/9ytBJvLOn3EHf8zJKVEkcEz81PfUU943BJFIyFhscDW10foc4p
         +v84GZ9RR1yoSqaBRmgk8dO9Euq4i4yW8TNnGMAaU8UCJNMMlhmIrxRmaANuCZr+ymSh
         4V2pqxziCUvHNGURYIMMbwU4N0eumF4oLJ6XEw2Co4s3xCAZtkeFrIVjDftxFSmE6+LE
         fqAg==
X-Gm-Message-State: APjAAAWBOuH7/8n2Sauc8/2mJ+NO/+XUSwGq0Nqfglezdct30TLa6fAK
        0i3HHrqV/dN586WLCJ4IqvNXbw==
X-Google-Smtp-Source: APXvYqxYk7PxiHBDmIcORqLb4E1fjHW9hONnOxE+VHyuD8lX6ZB9yXsAInNQVM/mW4qwn69fi+OkGw==
X-Received: by 2002:a5d:40d1:: with SMTP id b17mr13281359wrq.93.1580726481592;
        Mon, 03 Feb 2020 02:41:21 -0800 (PST)
Received: from localhost.localdomain (84-33-65-46.dyn.eolo.it. [84.33.65.46])
        by smtp.gmail.com with ESMTPSA id i204sm23798930wma.44.2020.02.03.02.41.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Feb 2020 02:41:20 -0800 (PST)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        bfq-iosched@googlegroups.com, oleksandr@natalenko.name,
        patdung100@gmail.com, cevich@redhat.com,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX V2 5/7] block, bfq: remove ifdefs from around gets/puts of bfq groups
Date:   Mon,  3 Feb 2020 11:40:58 +0100
Message-Id: <20200203104100.16965-6-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200203104100.16965-1-paolo.valente@linaro.org>
References: <20200203104100.16965-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

ifdefs around gets and puts of bfq groups reduce readability, remove them.

Reported-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-cgroup.c  | 4 ++++
 block/bfq-iosched.c | 6 +-----
 block/bfq-iosched.h | 1 +
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index c818c64766e5..cae488b58049 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -1406,6 +1406,10 @@ struct bfq_group *bfqq_group(struct bfq_queue *bfqq)
 	return bfqq->bfqd->root_group;
 }
 
+void bfqg_and_blkg_get(struct bfq_group *bfqg) {}
+
+void bfqg_and_blkg_put(struct bfq_group *bfqg) {}
+
 struct bfq_group *bfq_create_group_hierarchy(struct bfq_data *bfqd, int node)
 {
 	struct bfq_group *bfqg;
diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 28770ec7c06f..fff76c920968 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -4825,9 +4825,7 @@ void bfq_put_queue(struct bfq_queue *bfqq)
 {
 	struct bfq_queue *item;
 	struct hlist_node *n;
-#ifdef CONFIG_BFQ_GROUP_IOSCHED
 	struct bfq_group *bfqg = bfqq_group(bfqq);
-#endif
 
 	if (bfqq->bfqd)
 		bfq_log_bfqq(bfqq->bfqd, bfqq, "put_queue: %p %d",
@@ -4900,9 +4898,7 @@ void bfq_put_queue(struct bfq_queue *bfqq)
 		bfqq->bfqd->last_completed_rq_bfqq = NULL;
 
 	kmem_cache_free(bfq_pool, bfqq);
-#ifdef CONFIG_BFQ_GROUP_IOSCHED
 	bfqg_and_blkg_put(bfqg);
-#endif
 }
 
 static void bfq_put_cooperator(struct bfq_queue *bfqq)
@@ -6390,10 +6386,10 @@ static void bfq_exit_queue(struct elevator_queue *e)
 
 	hrtimer_cancel(&bfqd->idle_slice_timer);
 
-#ifdef CONFIG_BFQ_GROUP_IOSCHED
 	/* release oom-queue reference to root group */
 	bfqg_and_blkg_put(bfqd->root_group);
 
+#ifdef CONFIG_BFQ_GROUP_IOSCHED
 	blkcg_deactivate_policy(bfqd->queue, &blkcg_policy_bfq);
 #else
 	spin_lock_irq(&bfqd->lock);
diff --git a/block/bfq-iosched.h b/block/bfq-iosched.h
index f1cb89def7f8..2c7cec737b2a 100644
--- a/block/bfq-iosched.h
+++ b/block/bfq-iosched.h
@@ -921,6 +921,7 @@ struct bfq_group {
 
 #else
 struct bfq_group {
+	struct bfq_entity entity;
 	struct bfq_sched_data sched_data;
 
 	struct bfq_queue *async_bfqq[2][IOPRIO_BE_NR];
-- 
2.20.1

