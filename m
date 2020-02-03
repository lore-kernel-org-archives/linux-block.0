Return-Path: <SRS0=KNqY=3X=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C14B1C3524D
	for <linux-block@archiver.kernel.org>; Mon,  3 Feb 2020 10:41:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 983722080D
	for <linux-block@archiver.kernel.org>; Mon,  3 Feb 2020 10:41:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Aj3T4ug+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727501AbgBCKlV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 3 Feb 2020 05:41:21 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33819 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727389AbgBCKlV (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 3 Feb 2020 05:41:21 -0500
Received: by mail-wr1-f65.google.com with SMTP id t2so17349543wrr.1
        for <linux-block@vger.kernel.org>; Mon, 03 Feb 2020 02:41:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+Kno0Ufwl1kAKmD9m5umt2SU5mWhcoh+53Gn8TLVtdo=;
        b=Aj3T4ug+aflZfA/nndr2kZEys0nIS/FJXZ8B6qlk35IFcTzljTYx6rmI5QEEhLD+Gd
         z+2z2Yb2mvCpr6Dn0wLKBte7hgXAKtBEv82KTJAtWF1yJ04mOmDAxNx4lxS+pnRQXNgV
         9gmWmIqGPY2SGzr/8QdcBBZ2QzDFBDZIvEI1S3S3oV0rPj3cXeI+aJUf/knug3VO2LEl
         NeqO0tTCRjLcPuZTNl2ddKgY9z8jP7Lact1HeVd5XqAmlgS4qW8GmRq6iY89BJZDEp46
         QmjlXmGSvXMAudYWe2CC7+rtIfO/eMvwij1zB042iFmRS9mruEPACM93nWtlJnyCxy7/
         f2Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+Kno0Ufwl1kAKmD9m5umt2SU5mWhcoh+53Gn8TLVtdo=;
        b=CViLOacwEw2/Eh4NKPn0IN1C1BhoquwkdSBW1unPeGLgF654Ot8B9e4apIIt713FT+
         bzjILVVqWNvAnyEPZwXCFP800KwxtdmOG9cWdtpv4lhf+QOp6YrCYyV0uTUqabuijB7X
         k4/6X8j6YSo4QkxwbaZ6f5ZVC1SMdqkrUsAOHch11/jR1kWmWfZCFclQNtdLIgIyH/Og
         +3mh24sxmVpNlPj30Q9qLbZsUn/SNDFXU37PDZWM3XYa610bN8C8Zsh3VQaFfIpUBbBu
         TSjTcTJgTWDDujescJ3Pv+20BjP0MnbKj05zrExeE3fyQVAmy8vE6eGmkIH03vqfdYzJ
         389Q==
X-Gm-Message-State: APjAAAWuITsp+JkSzJz1DF+5PkgQXIQH0joxJ8m9oO/VjWHvBtZ2SUxd
        s3trE6eSMOTitRC4moZI74FecA==
X-Google-Smtp-Source: APXvYqwIl74eQZRgLB7TI/l05Ru0I7oZFprd4/KtPiEfF8w3nM7Yw7E+rPva3hmYBIIB+ZBpL9YVuQ==
X-Received: by 2002:adf:82ce:: with SMTP id 72mr14690299wrc.14.1580726477470;
        Mon, 03 Feb 2020 02:41:17 -0800 (PST)
Received: from localhost.localdomain (84-33-65-46.dyn.eolo.it. [84.33.65.46])
        by smtp.gmail.com with ESMTPSA id i204sm23798930wma.44.2020.02.03.02.41.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Feb 2020 02:41:17 -0800 (PST)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        bfq-iosched@googlegroups.com, oleksandr@natalenko.name,
        patdung100@gmail.com, cevich@redhat.com,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX V2 2/7] block, bfq: do not insert oom queue into position tree
Date:   Mon,  3 Feb 2020 11:40:55 +0100
Message-Id: <20200203104100.16965-3-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200203104100.16965-1-paolo.valente@linaro.org>
References: <20200203104100.16965-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

BFQ maintains an ordered list, implemented with an RB tree, of
head-request positions of non-empty bfq_queues. This position tree,
inherited from CFQ, is used to find bfq_queues that contain I/O close
to each other. BFQ merges these bfq_queues into a single shared queue,
if this boosts throughput on the device at hand.

There is however a special-purpose bfq_queue that does not participate
in queue merging, the oom bfq_queue. Yet, also this bfq_queue could be
wrongly added to the position tree. So bfqq_find_close() could return
the oom bfq_queue, which is a source of further troubles in an
out-of-memory situation. This commit prevents the oom bfq_queue from
being inserted into the position tree.

Tested-by: Patrick Dung <patdung100@gmail.com>
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-iosched.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 55d4328e7c12..15dfb0844644 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -613,6 +613,10 @@ bfq_pos_tree_add_move(struct bfq_data *bfqd, struct bfq_queue *bfqq)
 		bfqq->pos_root = NULL;
 	}
 
+	/* oom_bfqq does not participate in queue merging */
+	if (bfqq == &bfqd->oom_bfqq)
+		return;
+
 	/*
 	 * bfqq cannot be merged any longer (see comments in
 	 * bfq_setup_cooperator): no point in adding bfqq into the
-- 
2.20.1

