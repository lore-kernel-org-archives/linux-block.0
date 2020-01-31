Return-Path: <SRS0=MKaG=3U=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D422C33CB7
	for <linux-block@archiver.kernel.org>; Fri, 31 Jan 2020 09:25:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 525B620705
	for <linux-block@archiver.kernel.org>; Fri, 31 Jan 2020 09:25:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="evcl4rc0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728281AbgAaJZB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 31 Jan 2020 04:25:01 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33842 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728258AbgAaJY7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 31 Jan 2020 04:24:59 -0500
Received: by mail-wr1-f66.google.com with SMTP id t2so7778444wrr.1
        for <linux-block@vger.kernel.org>; Fri, 31 Jan 2020 01:24:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+Kno0Ufwl1kAKmD9m5umt2SU5mWhcoh+53Gn8TLVtdo=;
        b=evcl4rc0NAC7KoG7W+hHO+yYLgoIWhsULe3VHo8ZfCPzYl32U5h2vCJyYiJErq0zZi
         QwpxFwr37Q4gwnpYI5GlKMw5gDoK5/OpuBsaSWew36bydz4zJ46ur/THHH6yFtl8ukK0
         eelQXn/EOVQPRzSGpkUh3LtUhmue8RWsfMkYrJGivUmsVaRQR/6Axd3OvjTZg503Ff4a
         +m7rFqdSk6EWppY1EUmL+dsI9TBttxIRgOd2aKpp92TGwK/LYC0EKLjZQu4LWqmytuJm
         y7EsLlLfcMqUC4oFai2Ds+HZ53A+MOA7b34gEgg2Mhh7woMRKPhUSAao3wfBtSdCfUxp
         Qd3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+Kno0Ufwl1kAKmD9m5umt2SU5mWhcoh+53Gn8TLVtdo=;
        b=OGY1JuilKGcm2vdWobDhNRn72Wzse2k43SHhgvtkAc7FqrRla5RFAEx7Ht0TA4guxk
         nA6IH5ySHCj+tkuQiQ1WonXYaR07/QTtvD2jkqmI42hQ6cL45X0kypQWEjpeJ/xCEITJ
         F4PAI7myMJPrhmpPcsTzabfDU5RVyVDUAksx0wyGpHkEoM1UWsWZ3wT5QuDVKMcNVlPG
         FmPXnMQvvBntI3y/XjPzgVceakXpHwQg7L9z0ja5gTIuALpOiVmTJDEAKT6J0GaDFqm7
         R56lx+bHVP2QO9s83fsbe5hiPiTtyXO/7MmKOnGmGHuX/LklOyA5o8xurWveUJhUtOJG
         cbGg==
X-Gm-Message-State: APjAAAU2pS5eUwcYBS1jdkPWNDDjhJe0uMjNAa9sVvijadJR9fKxz1hK
        humvBibUJPOW+8F8A0AeGThn6Q==
X-Google-Smtp-Source: APXvYqxF+WeknTEzrs+NFH97PzIldGWLGI86YDyqDlVHFCExejPHiKfuK1zhZ6neZ8xBPN1vG/Hy8Q==
X-Received: by 2002:adf:cd04:: with SMTP id w4mr11638814wrm.219.1580462698078;
        Fri, 31 Jan 2020 01:24:58 -0800 (PST)
Received: from localhost.localdomain (88-147-73-186.dyn.eolo.it. [88.147.73.186])
        by smtp.gmail.com with ESMTPSA id 16sm10144364wmi.0.2020.01.31.01.24.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Jan 2020 01:24:57 -0800 (PST)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        bfq-iosched@googlegroups.com, oleksandr@natalenko.name,
        patdung100@gmail.com, cevich@redhat.com,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX 2/6] block, bfq: do not insert oom queue into position tree
Date:   Fri, 31 Jan 2020 10:24:05 +0100
Message-Id: <20200131092409.10867-3-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200131092409.10867-1-paolo.valente@linaro.org>
References: <20200131092409.10867-1-paolo.valente@linaro.org>
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

