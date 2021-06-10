Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA3FFC47094
	for <linux-block@archiver.kernel.org>; Thu, 10 Jun 2021 07:24:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2F42613C9
	for <linux-block@archiver.kernel.org>; Thu, 10 Jun 2021 07:24:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbhFJH0K (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Jun 2021 03:26:10 -0400
Received: from mail-pg1-f182.google.com ([209.85.215.182]:33323 "EHLO
        mail-pg1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230462AbhFJHZ7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Jun 2021 03:25:59 -0400
Received: by mail-pg1-f182.google.com with SMTP id e20so9928040pgg.0;
        Thu, 10 Jun 2021 00:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=tfZJcsESVJJ7LF8DyaFqXDwDLdv4yW2KMDeBAC866jo=;
        b=TNz2V8mH0uC3nWekPXPbsuGvtWuYItq3VzMzWiy5Jbg6oFkbWV6Qk5RSYzB1gF2KpC
         eMuen0T3Tx521ZxrTcFxoe+qqXNwf5294TMuWsHBFif0JRNWvoodst6T7oMBI+1k6eoP
         bZGqLqW4QP9SOfkNuVDAoLvbHTlahsd9wlbg2WpTQUG6PtqiubzynJuqO7pCGXaqV7S1
         QzQtlmJ2u8fkIoP9E/UUfb2biqiGv10beuGXBgZRxtz5wc8qOKvSkVSGV0+2NP1ccVJJ
         NWhg0tDlOqg1HxgnQGenCvDK/cxKSxuT0WG6qsxKKKUYnIiuhZMBQpthY28cUnYg8R2C
         UAww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=tfZJcsESVJJ7LF8DyaFqXDwDLdv4yW2KMDeBAC866jo=;
        b=YuvfwtNUoKHZEqVJCiNZJKyAcpkB6g2mTqJBUx72Sev5eJhkyJNbUzqfXF8d3g6fgs
         WkJDfcmpqlQb+dRFPRxAuw8ME7tW2uscPBKRHTl2XqtVKnlHJ1IzkI/jrlx2U44H0sTl
         YrAquIF+5wS3srjvB21CMg45aws+lSNQary0PkzrmLAy4iJQokqgVPocPXGCsrJGEjqT
         QOA+yST/WMB/HxKEpd1vqQp0MW+CgCDHuJ+D5wn6OskmXOztBm3NpWrdTBYcm+Yi/lKx
         JBwaKCLl2iM3xJEb+j275RXWrwzQUq9YZ/GrlFDXX0qXPFrt3Q+v8l3sZeF8FcILol5O
         A7Mg==
X-Gm-Message-State: AOAM531Vk+9gYeHZuyDuS7HphqZd6FPvealyOEHpP4igcyKlbLH9dQ0g
        3ElFYWhD75yH+f9oXiNcZZQ=
X-Google-Smtp-Source: ABdhPJwBDHbaTG0Rc07pg03y/uCEas54z9JC5z6ftDdLZOXHiVL/s5Mn9JLRh+eqZTrXtf6qd7ll3A==
X-Received: by 2002:a63:e253:: with SMTP id y19mr3650528pgj.137.1623309768839;
        Thu, 10 Jun 2021 00:22:48 -0700 (PDT)
Received: from VM-0-3-centos.localdomain ([101.32.213.191])
        by smtp.gmail.com with ESMTPSA id u24sm1591310pfm.200.2021.06.10.00.22.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Jun 2021 00:22:48 -0700 (PDT)
From:   brookxu <brookxu.cn@gmail.com>
To:     paolo.valente@linaro.org, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH 7/8] bfq: reset entity->prio_changed in bfq_init_entity()
Date:   Thu, 10 Jun 2021 15:22:36 +0800
Message-ID: <34c02f3525ed632ea1878591b41174aee50e953d.1618916839.git.brookxu@tencent.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1ce935f1bb10e0c7ecea7b79b826ff4cfc89acf0.1618916839.git.brookxu@tencent.com>
References: <1ce935f1bb10e0c7ecea7b79b826ff4cfc89acf0.1618916839.git.brookxu@tencent.com>
In-Reply-To: <cover.1618916839.git.brookxu@tencent.com>
References: <cover.1618916839.git.brookxu@tencent.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org
Message-ID: <20210610072236.hT2zlrQ_4C3VSfMgP3u3CaWanCwBXkWzzjmWoxs8Vzs@z>

From: Chunguang Xu <brookxu@tencent.com>

Since weight, ioprio, ioprio_class will be updated in bfq_init_entity(),
st->wsum will be updated in __bfq_activate_entity(), so when it is first
active, it seems that __bfq_entity_update_weight_prio() has nothing to
do. By resetting entity->prio_change in bfq_init_entity(), we can avoid
unnecessary logic calls.

Signed-off-by: Chunguang Xu <brookxu@tencent.com>
---
 block/bfq-cgroup.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index c8c68dc..79a5aaa 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -426,6 +426,7 @@ void bfq_init_entity(struct bfq_entity *entity, struct bfq_group *bfqg)
 
 	entity->weight = entity->new_weight;
 	entity->orig_weight = entity->new_weight;
+	entity->prio_changed = 0;
 	if (bfqq) {
 		bfqq->ioprio = bfqq->new_ioprio;
 		bfqq->ioprio_class = bfqq->new_ioprio_class;
-- 
1.8.3.1

