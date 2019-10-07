Return-Path: <SRS0=HuTb=YA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D79A2ECE58C
	for <linux-block@archiver.kernel.org>; Mon,  7 Oct 2019 21:17:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3A3320867
	for <linux-block@archiver.kernel.org>; Mon,  7 Oct 2019 21:17:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pbacVSdy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728877AbfJGVRA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 7 Oct 2019 17:17:00 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55009 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728330AbfJGVQ7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 7 Oct 2019 17:16:59 -0400
Received: by mail-wm1-f65.google.com with SMTP id p7so919214wmp.4;
        Mon, 07 Oct 2019 14:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r1Ds32p5O4ZcmTgQVgBnVXrwuxhYvcTzmMcSF3UJbRo=;
        b=pbacVSdys0sLAittjH0pybL66qLXh6pGBO12S3ky7p4gVpkjbCMlX/rcLQGzII8A/1
         q6wwsUbyYzohVk6/46fAIvyrXagObWvJUEQCWzNbKaCX3ubHaQba8eMQsputPLQ4xe8p
         MzSkcNRdMaeOJKXiQu6gb8FaJRuKYZtmAQLMU/cV5I2Ac0lWGgtci7fxYNti8VrPba7I
         bd003rqx7Wo3dq8wV6MWhU09yQU88XubqLmX59Xj3i+tRMp4glmW3mBt/PN6NgTdJfmC
         /QRgRfgsDCPIkbSRTXOWPF0kdvudgL3J/cNQf/okrN9yVl2SeUFS1jLMpjIJlUHkdhvb
         FI3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=r1Ds32p5O4ZcmTgQVgBnVXrwuxhYvcTzmMcSF3UJbRo=;
        b=KOXYr+woaqUi95jj2XUMhNuJZe+DNWe/IZOpTF/78Dw40vBaa6lAHkuhVqHf4SnlM/
         0hDcGwczGvkEFXJmLNG5663SoFZ7DwCRE1iajPOiO6R2whDyjQGm1GPRYBX1YPVgxrTl
         OqJV1Cdhl4GVWyO7lJoo6o/oI/UxWmdQAupuQAhjuSzXYV32SJBWAtbL6wr5EeDQShqp
         5FLJKzuj1D8C2/gRwt44QAQoxFnYuzMQfKvMX93LEe2CGiZXEQ69xd8vhlgKFL76TmH3
         mQqQgQDZNMecRfRo9+11A+Ouj0RQDkU7m4mlU611vAFyWSOp//TFVHBM/f1gZuce2BbV
         o3kQ==
X-Gm-Message-State: APjAAAXF6YKfQevNyc6x1g0NC3WJQwkvErE3X548gbrR1GdJJX2WGUel
        +yUzRG2chLbtWTr+ONRMsZE=
X-Google-Smtp-Source: APXvYqxyivR8RyXxX3tcMgK5BYcWUcd9CTctKbWKKBO62erx5rad+Y21F+bpUo63vmbXA23tsKhW7g==
X-Received: by 2002:a05:600c:1009:: with SMTP id c9mr933903wmc.64.1570483018061;
        Mon, 07 Oct 2019 14:16:58 -0700 (PDT)
Received: from localhost.localdomain ([109.126.133.195])
        by smtp.gmail.com with ESMTPSA id v8sm22227375wra.79.2019.10.07.14.16.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2019 14:16:57 -0700 (PDT)
From:   "Pavel Begunkov (Silence)" <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH] blk-stat: Optimise blk_stat_add()
Date:   Tue,  8 Oct 2019 00:16:51 +0300
Message-Id: <39dd33cc6f0264b2ec2f79f1dfe21466c2180851.1570482929.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Pavel Begunkov <asml.silence@gmail.com>

blk_stat_add() calls {get,put}_cpu_ptr() in a loop, which entails
overhead of disabling/enabling preemption. The loop is under RCU
(i.e.short) anyway, so do get_cpu() in advance.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 block/blk-stat.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/block/blk-stat.c b/block/blk-stat.c
index d892ad2cb938..4239954b0bce 100644
--- a/block/blk-stat.c
+++ b/block/blk-stat.c
@@ -75,7 +75,7 @@ void blk_stat_add(struct request *rq, u64 now)
 	struct request_queue *q = rq->q;
 	struct blk_stat_callback *cb;
 	struct blk_rq_stat_staging *stat;
-	int bucket;
+	int bucket, cpu;
 	u64 value;
 
 	value = (now >= rq->io_start_time_ns) ? now - rq->io_start_time_ns : 0;
@@ -83,6 +83,7 @@ void blk_stat_add(struct request *rq, u64 now)
 	blk_throtl_stat_add(rq, value);
 
 	rcu_read_lock();
+	cpu = get_cpu();
 	list_for_each_entry_rcu(cb, &q->stats->callbacks, list) {
 		if (!blk_stat_is_active(cb))
 			continue;
@@ -91,10 +92,10 @@ void blk_stat_add(struct request *rq, u64 now)
 		if (bucket < 0)
 			continue;
 
-		stat = &get_cpu_ptr(cb->cpu_stat)[bucket];
+		stat = &per_cpu_ptr(cb->cpu_stat, cpu)[bucket];
 		blk_rq_stat_add(stat, value);
-		put_cpu_ptr(cb->cpu_stat);
 	}
+	put_cpu();
 	rcu_read_unlock();
 }
 
-- 
2.23.0

