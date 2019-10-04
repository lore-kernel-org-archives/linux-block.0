Return-Path: <SRS0=jhC6=X5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF33EC47404
	for <linux-block@archiver.kernel.org>; Fri,  4 Oct 2019 14:01:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F55720700
	for <linux-block@archiver.kernel.org>; Fri,  4 Oct 2019 14:01:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lu+khzDp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388752AbfJDOBR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 4 Oct 2019 10:01:17 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52059 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388780AbfJDOBQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 4 Oct 2019 10:01:16 -0400
Received: by mail-wm1-f68.google.com with SMTP id 7so5974562wme.1;
        Fri, 04 Oct 2019 07:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aeGpWqAjf5UKAuu/hp38roJW58G/zrbSBwMk3/m3txc=;
        b=Lu+khzDpI76peiE2e5D3GSx+i1V+slX7mty3gTEQaJKAhZ7TdOD8S0tQ+bX5j6/t4Y
         Kw7wNebIHxeI7cSg0JRc0znn6jixe4Z41bK7VlnSj8C423kByrev7P7x/f9f08g4/PaB
         U0tY05+nfeSr8GYpZiiFywzEiv9zR6qzyIIapUtxFqsJhtZztX+IQLT/LNe3PqfIxLtL
         tkMP4YMo4f6NsD29dt25H14ceLvJE2Mx683NWsy3zxUHNkKPpoLj1QSqZs3x/8gZvahQ
         6rtJ2+btWvqR7wPuBa11I4IfiNUrVMWPwW3JUT3PhSZpPt4LngdVcirbTF2IypZaI6ZS
         /CZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aeGpWqAjf5UKAuu/hp38roJW58G/zrbSBwMk3/m3txc=;
        b=RUWijjiJs2i/lVB/6ZRoixX7mavvy7KI5ln0FaWl6kiUBCQBJvUCV1ugDF3PaaUPtU
         5Gunae7HENGUe3JUDXz3kY0D7CbABA/hAQ6dqUDgFgMJce+atuoCDJyHF2Q3t2Z73c4F
         hsburT1vaL0tE9jIU1V8Dr9W9WNKcSHt9eEIwFg3oQuV8eeQNwTtMKnx2h866iN0aEIC
         1TNNlYIkAmrd2H0kSZEWsxL87Z+tqVx7Im3DHAjbHLvAgRjnwDMdymz5MTc9vyE7zUL5
         PhXe8KkmhZchb9DydHfz4uCKUtleVyflVAHGfhqlkI/Lkn16+gVL8D4dDiniQ+01HHae
         MUnQ==
X-Gm-Message-State: APjAAAW5A1hIbwn2oUNiLJd6dJlowZJ0lAzL7U5yAJ7ghfLML0tsBR7T
        hBaAEHE73URfNhLZ2D4Dt6MxbrmJZIs=
X-Google-Smtp-Source: APXvYqzQ49raynP76AYbRMm5tcCrZmOSCiQvbP8nEX4aIul2thLqh/MCnqVUcPJyfE6UgLjmdDbbJg==
X-Received: by 2002:a1c:1bcf:: with SMTP id b198mr11756584wmb.0.1570197674859;
        Fri, 04 Oct 2019 07:01:14 -0700 (PDT)
Received: from localhost.localdomain ([109.126.135.5])
        by smtp.gmail.com with ESMTPSA id t8sm5530753wrx.76.2019.10.04.07.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2019 07:01:14 -0700 (PDT)
From:   "Pavel Begunkov (Silence)" <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Pavel Begunkov <asml.silence@gmail.com>,
        kbuild test robot <lkp@intel.com>
Subject: [PATCH v3] io_uring: Fix reversed nonblock flag
Date:   Fri,  4 Oct 2019 17:01:08 +0300
Message-Id: <9752f33f509287c77801d5e807213cff9195197a.1570197234.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <eecaf117de4894b595f300b9fb567825330b2d24.1570183599.git.asml.silence@gmail.com>
References: <eecaf117de4894b595f300b9fb567825330b2d24.1570183599.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Pavel Begunkov <asml.silence@gmail.com>

io_queue_link_head() accepts @force_nonblock flag, but io_ring_submit()
passes something opposite.

v2: build error from test robot: Rebase to block-tree
v3: simplify with Jens suggestion

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 fs/io_uring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index c934f91c51e9..b58c3d8594d8 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2761,7 +2761,7 @@ static int io_ring_submit(struct io_ring_ctx *ctx, unsigned int to_submit,
 
 	if (link)
 		io_queue_link_head(ctx, link, &link->submit, shadow_req,
-					block_for_last);
+					!block_for_last);
 	if (statep)
 		io_submit_state_end(statep);
 
-- 
2.23.0

