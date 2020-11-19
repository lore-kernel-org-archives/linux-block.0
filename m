Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7C88C6379D
	for <linux-block@archiver.kernel.org>; Thu, 19 Nov 2020 15:33:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67FCB2225B
	for <linux-block@archiver.kernel.org>; Thu, 19 Nov 2020 15:33:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AI+Zu2tR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727946AbgKSPdH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 19 Nov 2020 10:33:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727944AbgKSPdH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 Nov 2020 10:33:07 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68D4AC0613CF;
        Thu, 19 Nov 2020 07:33:05 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id k27so8464660ejs.10;
        Thu, 19 Nov 2020 07:33:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=QHs9GIlt4UaOPU6hF2x6d6LK3yQJupb3Ug5YzgmTPR0=;
        b=AI+Zu2tRSFla05NeOjV7j1LuI2o+bXvtNEYsWnLGgehDDzlYH8RtG4ujs12CzTreeq
         CMcldJ0P17+H1FPIW9flBG0LK/89ctUlFkd0pb3TvRMkNU33WYhEdyMynG8z+318K3aV
         ZMoTf6XQWFk9UIhHVQcLJATlr+qoXDBee7BHFWyAYXo+VzHZiAEZxokFoOkvawZWr4tg
         euyhCt1MolVPLVZKHQYh1YLj9OQssVMrw1mLD8h6ahAF2eryyXd4y9yNe+kHKREkkaC3
         sL/HN2Vd4hWZafDkfmEeLVY0f90JVvQxGjsE4eKKaw+vfRaSeocBUxrB8kQ0gRMfsUjO
         +bdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QHs9GIlt4UaOPU6hF2x6d6LK3yQJupb3Ug5YzgmTPR0=;
        b=Z4lQ3uoKw286OSjDMGh6TYqDkl1EWbmudX46hEnYAro9UcUAWTjVp0HF5gXO4lT1rH
         UaoET0RLPvjHsUvbUCWBUTF39nyznsAg70gzBh4unH+49a9U9gB0vQgE6MvJrKII4ntN
         uD1soc3Z5Ya4Yugwe33ED6gkuW3lCFdPgb7/C7lIACsFSWzQju3yLFTzQN6tCu1/IGWp
         Aje3hmnRYvogz43VGv3lyqWhGVPVw4Rl6D+FGYl/ee6043GxLY9gOmsWGg11iEMtWuyC
         /dhnPD/OFV8gYqbi4nRdv9FKvecNlFpB5De2GqBhx9Uyv4IYDgyCYF5uvTbSh56hOeEz
         LLMg==
X-Gm-Message-State: AOAM533pvj9ewmR4/3DbmEBbEWLSGt/lO5cNKaBm5H4/YfnhTUHrKRMb
        o7yTyHNkguYJI3EBeu/LwcmlOIfurgqZ5g==
X-Google-Smtp-Source: ABdhPJx6W/2Vpd3ZNwy0PWPOd9RURIuLaLFpAeAZkM3ojboamNSQ7XSusToFwza8wimIR3a2Y8arHw==
X-Received: by 2002:a17:906:ca93:: with SMTP id js19mr30379533ejb.537.1605799980166;
        Thu, 19 Nov 2020 07:33:00 -0800 (PST)
Received: from localhost.localdomain (host109-152-100-135.range109-152.btcentralplus.com. [109.152.100.135])
        by smtp.gmail.com with ESMTPSA id u7sm3595612ejf.83.2020.11.19.07.32.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2020 07:32:59 -0800 (PST)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] iov_iter: optimise iov_iter_npages for bvec
Date:   Thu, 19 Nov 2020 15:29:42 +0000
Message-Id: <b52c2ad9e2aaf6129d60aac595df86231c8373ef.1605799583.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1605799583.git.asml.silence@gmail.com>
References: <cover.1605799583.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Block layer spend quite a while in iov_iter_npages(), but for bvecs
number of pages is already known and stored in iter->nr_segs, so it can
be returned directly as an optimisation

Running an io_uring benchmark with registered buffers (i.e. bvec) perf
showed ~1.5-2.0% total cycle was spent there, and that dropped to ~0.2%
after applying this patch.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 lib/iov_iter.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 1635111c5bd2..0fa7ac330acf 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1594,6 +1594,8 @@ int iov_iter_npages(const struct iov_iter *i, int maxpages)
 		return 0;
 	if (unlikely(iov_iter_is_discard(i)))
 		return 0;
+	if (unlikely(iov_iter_is_bvec(i)))
+		return min_t(int, i->nr_segs, maxpages);
 
 	if (unlikely(iov_iter_is_pipe(i))) {
 		struct pipe_inode_info *pipe = i->pipe;
@@ -1614,11 +1616,9 @@ int iov_iter_npages(const struct iov_iter *i, int maxpages)
 			- p / PAGE_SIZE;
 		if (npages >= maxpages)
 			return maxpages;
-	0;}),({
-		npages++;
-		if (npages >= maxpages)
-			return maxpages;
-	}),({
+	0;}),
+		0 /* bvecs are handled above */
+	,({
 		unsigned long p = (unsigned long)v.iov_base;
 		npages += DIV_ROUND_UP(p + v.iov_len, PAGE_SIZE)
 			- p / PAGE_SIZE;
-- 
2.24.0

