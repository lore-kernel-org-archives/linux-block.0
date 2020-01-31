Return-Path: <SRS0=MKaG=3U=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DFBDC33CB2
	for <linux-block@archiver.kernel.org>; Fri, 31 Jan 2020 09:25:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23A00215A4
	for <linux-block@archiver.kernel.org>; Fri, 31 Jan 2020 09:25:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iRXRSb4D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728284AbgAaJZB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 31 Jan 2020 04:25:01 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35633 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728274AbgAaJZB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 31 Jan 2020 04:25:01 -0500
Received: by mail-wm1-f68.google.com with SMTP id b17so7864685wmb.0
        for <linux-block@vger.kernel.org>; Fri, 31 Jan 2020 01:25:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9S9BwHx5UyCKJX2JPPBf1rlNAUg9PfPZ0MUkcYcdubg=;
        b=iRXRSb4DE5RRgBR+1dzaU40ae0vmJbAJrH7ssWKCDoti6cVtCXOhHrRgtxLuu74K7I
         Tw3sJ1uQbf05gkl/PqtpOVRtDGHMsSlfL9YBa91dbcrDEUTDRl7PR0uucmawserg4suP
         dVsMWzYSzrUpjPPNlKlnyl9QLhCqdHohs4I5rQ4ngR46zzjF+o6Iro7l0p9RQ+jqhj3t
         GCHSdSsbC9Ez9HMVWP5wRpZO2Mm7sYiWuL0BTzrWlE8QkhY6/PtCQ7lUy4k+/ZmhuXjI
         msLBIUrrrUE62KX/PYyadwpxp/5qeUMb/NCwLHBukakYpsIZHrjnt5ZcWgkKTa+3iIxE
         HuUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9S9BwHx5UyCKJX2JPPBf1rlNAUg9PfPZ0MUkcYcdubg=;
        b=Wlf8c2cyWkSK28fPqT9e0P2bFT6vPsnDWlYejvQI8KLnFA6kh0riB74w1UV0Hv6A/6
         1JFae26+C+ak1Bzh8yzgjWnzAbkb7F6LijQYxAKYpg56xDAwDkFb4GzwTQJu1OSSa8wo
         vr7hdxgyrQONwyXr7R+HNN1IrKUwCMYKbJGzzOQOGs6hVHTDZYxldzoCyMULh0Lfmk9p
         sxS0crw/cEM5LlRISxiKXj2wCF84i2E/rmGYrRnSgz4J0VZcB5Zl0yxBOlg0Fo5M/nKy
         6QyePw1n3VmBysQ+bFQvSA+7qHFrvYsudHPtnOHqrMq6IhOQw1jXMXrAmxg8mCqZScE+
         EZZg==
X-Gm-Message-State: APjAAAXaDj8M9FIh3RqJH2SMoi43wb2RQ/X3F9j3kbfYrKN/s9rB7kzl
        fNeKRjzHt1WDXwp05xJnYWsaIQ==
X-Google-Smtp-Source: APXvYqxB4qSPUHX306OsPESk96PbfKWReeeWyRX+ZbnNBODPZNtLG1E8CogAmQhcBFk6/5MNcZOwqQ==
X-Received: by 2002:a1c:545d:: with SMTP id p29mr11760504wmi.91.1580462699266;
        Fri, 31 Jan 2020 01:24:59 -0800 (PST)
Received: from localhost.localdomain (88-147-73-186.dyn.eolo.it. [88.147.73.186])
        by smtp.gmail.com with ESMTPSA id 16sm10144364wmi.0.2020.01.31.01.24.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Jan 2020 01:24:58 -0800 (PST)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        bfq-iosched@googlegroups.com, oleksandr@natalenko.name,
        patdung100@gmail.com, cevich@redhat.com,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX 3/6] block, bfq: get extra ref to prevent a queue from being freed during a group move
Date:   Fri, 31 Jan 2020 10:24:06 +0100
Message-Id: <20200131092409.10867-4-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200131092409.10867-1-paolo.valente@linaro.org>
References: <20200131092409.10867-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In bfq_bfqq_move(), the bfq_queue, say Q, to be moved to a new group
may happen to be deactivated in the scheduling data structures of the
source group (and then activated in the destination group). If Q is
referred only by the data structures in the source group when the
deactivation happens, then Q is freed upon the deactivation.

This commit addresses this issue by getting an extra reference before
the possible deactivation, and releasing this extra reference after Q
has been moved.

Tested-by: Chris Evich <cevich@redhat.com>
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-cgroup.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
index e1419edde2ec..8ab7f18ff8cb 100644
--- a/block/bfq-cgroup.c
+++ b/block/bfq-cgroup.c
@@ -651,6 +651,12 @@ void bfq_bfqq_move(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 		bfq_bfqq_expire(bfqd, bfqd->in_service_queue,
 				false, BFQQE_PREEMPTED);
 
+	/*
+	 * get extra reference to prevent bfqq from being freed in
+	 * next possible deactivate
+	 */
+	bfqq->ref++;
+
 	if (bfq_bfqq_busy(bfqq))
 		bfq_deactivate_bfqq(bfqd, bfqq, false, false);
 	else if (entity->on_st)
@@ -670,6 +676,8 @@ void bfq_bfqq_move(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 
 	if (!bfqd->in_service_queue && !bfqd->rq_in_driver)
 		bfq_schedule_dispatch(bfqd);
+	/* release extra ref taken above */
+	bfq_put_queue(bfqq);
 }
 
 /**
-- 
2.20.1

