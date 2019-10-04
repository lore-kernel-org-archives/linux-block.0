Return-Path: <SRS0=jhC6=X5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5763C4360C
	for <linux-block@archiver.kernel.org>; Fri,  4 Oct 2019 19:18:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FC96222C0
	for <linux-block@archiver.kernel.org>; Fri,  4 Oct 2019 19:18:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="UUjFMXlU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728356AbfJDTSQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 4 Oct 2019 15:18:16 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39919 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbfJDTSP (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 4 Oct 2019 15:18:15 -0400
Received: by mail-pf1-f194.google.com with SMTP id v4so4473358pff.6
        for <linux-block@vger.kernel.org>; Fri, 04 Oct 2019 12:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=mQm52KNq8N1PBtNAdz7FJMAcNHHXJOD2Ou1TSm/vQoY=;
        b=UUjFMXlUGQlvKqrMkDehgQCQXee5UKdyVgPDGSteaTsnKqn7gxZ6dgPzFSwXJbbBKJ
         WK+vvwLylg0nt2NFLOoYbKp4hPISU1zW1lYi4U25QDFBb61RoED5MvKkyQN2TnJZHgZI
         hG5/+rApO6xpWwOyRUPPjvvTvvTDZLMtN99oQkiv3mNyMSqGpdyeeD1NLLyJjrt9WwdL
         LLoMEHkxE5J44ug5v64sQt0pR8cXpTJao+IoVh10GiPQkrJ++H6eYxGkiOyhTclhft5m
         e8mDYAV29E1qwrpC2oYUWqSdc+Aj3o90we2caq+VqExNZO6b5NqadypjEEspopWobv86
         w8eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=mQm52KNq8N1PBtNAdz7FJMAcNHHXJOD2Ou1TSm/vQoY=;
        b=g3ul6BhdfKG56yX0HO2hVqO1v4qlwItXgyty5qIXA0gNimwS5WjGYs3AyizXV+IbKT
         Px/mpRUXJNcbgLsaJJ4gV/A6Zh/qXYNi3XqxDDm2zAkz0UFIP5JKLTyWbVdr8RT+0cl+
         2nozjhWfyX5QdATSQDhAuDnT87h4tG+gxuvswO6NyMMB90IfGyNO8PN/Hqtw0TxWhopR
         IoDq22pOYwD7IvFqYYSCKWctjvp/P8Phyjk6kq1JkedrBrdbmPRG/HOrBmI42ca0IgXA
         SzzC+GYUClCWZ9gAfNzvxzg2s5gO3ZFeup6cj8YIbbeyHS8PXrJqasldnqhYmIRD7X9h
         ckCg==
X-Gm-Message-State: APjAAAUwdkxfKfAITIixQIM74JS5pGWiGXjRu+S4bUeMjcQt5Ijefa93
        faiQFcDjgdXvp7ZkqnKv1SLUo2sGQcpODA==
X-Google-Smtp-Source: APXvYqwVTvKUmG+vYORR71rkzzwyxr5bqKo+TCdVgljXCH2+nLtx6wQT1+wwvecalsYQ4lCrb85pwA==
X-Received: by 2002:a17:90a:2464:: with SMTP id h91mr19595566pje.9.1570216692905;
        Fri, 04 Oct 2019 12:18:12 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id h186sm10822156pfb.63.2019.10.04.12.18.11
        for <linux-block@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Oct 2019 12:18:12 -0700 (PDT)
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] io_uring: allow application controlled CQ ring size
Message-ID: <0188a3ff-6a41-1a95-f444-2ef308a83f7a@kernel.dk>
Date:   Fri, 4 Oct 2019 13:18:09 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We currently size the CQ ring as twice the SQ ring, to allow some
flexibility in not overflowing the CQ ring. This is done because the
SQE life time is different than that of the IO request itself, the SQE
is consumed as soon as the kernel has seen the entry.

Certain application don't need a huge SQ ring size, since they just
submit IO in batches. But they may have a lot of requests pending, and
hence need a big CQ ring to hold them all. By allowing the application
to control the CQ ring size multiplier, we can cater to those
applications more efficiently.

If an application wants to define its own CQ ring size, it must set
IORING_SETUP_CQSIZE in the setup flags, and fill out
io_uring_params->cq_entries. The value must be a power of two.

Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 8afb0b689523..bfbb7ab3c4e4 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -76,6 +76,7 @@
 #include "internal.h"
 
 #define IORING_MAX_ENTRIES	32768
+#define IORING_MAX_CQ_ENTRIES	(2 * IORING_MAX_ENTRIES)
 #define IORING_MAX_FIXED_FILES	1024
 
 struct io_uring {
@@ -3984,10 +3985,23 @@ static int io_uring_create(unsigned entries, struct io_uring_params *p)
 	 * Use twice as many entries for the CQ ring. It's possible for the
 	 * application to drive a higher depth than the size of the SQ ring,
 	 * since the sqes are only used at submission time. This allows for
-	 * some flexibility in overcommitting a bit.
+	 * some flexibility in overcommitting a bit. If the application has
+	 * set IORING_SETUP_CQSIZE, it will have passed in the desired number
+	 * of CQ ring entries manually.
 	 */
 	p->sq_entries = roundup_pow_of_two(entries);
-	p->cq_entries = 2 * p->sq_entries;
+	if (p->flags & IORING_SETUP_CQSIZE) {
+		/*
+		 * If IORING_SETUP_CQSIZE is set, we do the same roundup
+		 * to a power-of-two, if it isn't already. We do NOT impose
+		 * any cq vs sq ring sizing.
+		 */
+		if (!p->cq_entries || p->cq_entries > IORING_MAX_CQ_ENTRIES)
+			return -EINVAL;
+		p->cq_entries = roundup_pow_of_two(p->cq_entries);
+	} else {
+		p->cq_entries = 2 * p->sq_entries;
+	}
 
 	user = get_uid(current_user());
 	account_mem = !capable(CAP_IPC_LOCK);
@@ -4068,7 +4082,7 @@ static long io_uring_setup(u32 entries, struct io_uring_params __user *params)
 	}
 
 	if (p.flags & ~(IORING_SETUP_IOPOLL | IORING_SETUP_SQPOLL |
-			IORING_SETUP_SQ_AFF))
+			IORING_SETUP_SQ_AFF | IORING_SETUP_CQSIZE))
 		return -EINVAL;
 
 	ret = io_uring_create(entries, &p);
diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
index 4f532d9c0554..e0137ea6ad79 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -50,6 +50,7 @@ struct io_uring_sqe {
 #define IORING_SETUP_IOPOLL	(1U << 0)	/* io_context is polled */
 #define IORING_SETUP_SQPOLL	(1U << 1)	/* SQ poll thread */
 #define IORING_SETUP_SQ_AFF	(1U << 2)	/* sq_thread_cpu is valid */
+#define IORING_SETUP_CQSIZE	(1U << 3)	/* app defines CQ size */
 
 #define IORING_OP_NOP		0
 #define IORING_OP_READV		1

-- 
Jens Axboe

