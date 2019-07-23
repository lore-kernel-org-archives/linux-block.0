Return-Path: <SRS0=ppXp=VU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B26CAC7618F
	for <linux-block@archiver.kernel.org>; Tue, 23 Jul 2019 02:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 819732238B
	for <linux-block@archiver.kernel.org>; Tue, 23 Jul 2019 02:14:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NTWxuGoE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728720AbfGWCN5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Jul 2019 22:13:57 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:43013 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727753AbfGWCN4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Jul 2019 22:13:56 -0400
Received: by mail-pl1-f194.google.com with SMTP id 4so12962432pld.10;
        Mon, 22 Jul 2019 19:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MlQn19xkFS3Ba2rtt43rWTYoRgMfcqbz+hy4lbmkZYU=;
        b=NTWxuGoEsdh/1JWj2rcSPa8nOmSGqeLDSCcDqVgl5cRWQZ9SQxIDxiUs5pLU/Jad1M
         2fyfXjf19Jeox+cJtRHqOg3gKYoDgEmXQems3scyLLLwu8VEE9N7/dAN7U3GVQIs4fjV
         YnpZVlClBnjmI5sfOhxIvSgZFYTm2lxZ4bEqaFNkGVyZmHIs8rQfpZfXTMELzgETQaPd
         uZ8v7ozuGtEdYa+AfTtBw3hw70ZpXPW3D+HrmqkDWS6Tgx7ejaoeGYH50ilBxy2y7e/I
         z+SmhmwTOTN/GsbhCs0QVDD3yr1Nmv27dYZaTxC0SCL+aDbZPYM546pYEiMy+r1J1/7u
         yUBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MlQn19xkFS3Ba2rtt43rWTYoRgMfcqbz+hy4lbmkZYU=;
        b=Y1crl599KLtAnGP7j8nRNjSp+lmVPP/e48CD395hma2Z1mXaYngETiy6vlQf2qt7gc
         fjQJ+VZ/RNoKJEIwfd74q3ClLfo51HuF1BNe/DZQIIb/S1JQmSsaAa9XD2fHKqJnFUPF
         N3yuJhWetlviAj7OJd/fZE128cpfn64v+sv1tRTFBJAPBT5hv9WMuUoegs5UZDpeQc57
         bRboDusrR4Z8kNnlH0omy0U4sH0KkVuevLceN1rWPHrFGg0HAnhatDwVt3H98FFPLG5v
         OcoVk1FuyETVK3H/00u/D/EvV6wVkqPlKrAPdwF7z6qvmqUgCMdxgSqiOamG4ajBNEov
         mLsw==
X-Gm-Message-State: APjAAAVUjmHPB9pli5ddq5wmuGn9+7Uu3+l9CRoj1a6rFiY3QWgXMClE
        dndujNZ6jhLflow2bZqa0tzwGTjyP64=
X-Google-Smtp-Source: APXvYqw+zt1XfvS1B7M/6NM2A83h2lOsy2cyfYPYfPT7qa1cnP4ch9yz5YEX3N8NlnYeoXWlwRPsNQ==
X-Received: by 2002:a17:902:e582:: with SMTP id cl2mr78748450plb.60.1563848034665;
        Mon, 22 Jul 2019 19:13:54 -0700 (PDT)
Received: from continental.prv.suse.net ([191.248.110.143])
        by smtp.gmail.com with ESMTPSA id v126sm7999257pgb.23.2019.07.22.19.13.52
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 22 Jul 2019 19:13:53 -0700 (PDT)
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        axboe@kernel.dk, hare@suse.com
Cc:     Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Subject: [PATCH 1/2] block: blk-mq: Remove blk_mq_sched_started_request function
Date:   Mon, 22 Jul 2019 23:14:38 -0300
Message-Id: <20190723021439.8419-2-marcos.souza.org@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190723021439.8419-1-marcos.souza.org@gmail.com>
References: <20190723021439.8419-1-marcos.souza.org@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This function checks if the elevator related to the request has
started_request implemented, but currently, none of the available IO
schedulers implement started_request.

Signed-off-by: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
---
 block/blk-mq-sched.h | 9 ---------
 block/blk-mq.c       | 2 --
 2 files changed, 11 deletions(-)

diff --git a/block/blk-mq-sched.h b/block/blk-mq-sched.h
index cf22ab00fefb..126021fc3a11 100644
--- a/block/blk-mq-sched.h
+++ b/block/blk-mq-sched.h
@@ -61,15 +61,6 @@ static inline void blk_mq_sched_completed_request(struct request *rq, u64 now)
 		e->type->ops.completed_request(rq, now);
 }
 
-static inline void blk_mq_sched_started_request(struct request *rq)
-{
-	struct request_queue *q = rq->q;
-	struct elevator_queue *e = q->elevator;
-
-	if (e && e->type->ops.started_request)
-		e->type->ops.started_request(rq);
-}
-
 static inline void blk_mq_sched_requeue_request(struct request *rq)
 {
 	struct request_queue *q = rq->q;
diff --git a/block/blk-mq.c b/block/blk-mq.c
index b038ec680e84..3e8902714253 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -669,8 +669,6 @@ void blk_mq_start_request(struct request *rq)
 {
 	struct request_queue *q = rq->q;
 
-	blk_mq_sched_started_request(rq);
-
 	trace_block_rq_issue(q, rq);
 
 	if (test_bit(QUEUE_FLAG_STATS, &q->queue_flags)) {
-- 
2.22.0

