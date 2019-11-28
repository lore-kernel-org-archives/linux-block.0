Return-Path: <SRS0=c8VV=ZU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 003ADC432C0
	for <linux-block@archiver.kernel.org>; Thu, 28 Nov 2019 21:07:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8BF9216F4
	for <linux-block@archiver.kernel.org>; Thu, 28 Nov 2019 21:07:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p/0m4767"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbfK1VFS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 Nov 2019 16:05:18 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53921 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbfK1VFS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Nov 2019 16:05:18 -0500
Received: by mail-wm1-f65.google.com with SMTP id u18so12187742wmc.3;
        Thu, 28 Nov 2019 13:05:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=JIqdPvDq60NeSA4MmFOLLaYMW+f7MTJk0ci/m/ClifE=;
        b=p/0m47672Xp4nRbIVgDxszY6a3FoKsWwrHx71iDUbTUs34ac66g4CfS9III0nnP3TO
         s4s7qDpIZXDuBrgZ9x0DtHhVQG/HxrucWmipR5Ukeifsny0AgjkeLRQcRnpah0eQYWdR
         SMmShFLsnO2AeWhsC6l1yKd/ttYF18eUkBlYcHQ1Um78zHpN00bosDbgHqRQzsW9I/rn
         UfXrWWcMEYCRu7ughS/TBKoJkSMBmoCHZa1mF/3XvpaePosKKLTmQjZZh4QD1Gr0VfOt
         PR9cPqcnyjF9mPHK4LAZPsonQ8RDsakUgFUnNnCqEuWBa7Hxqi1WuZmINtsaJrZfgs9w
         vGEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JIqdPvDq60NeSA4MmFOLLaYMW+f7MTJk0ci/m/ClifE=;
        b=LlxmP45nRCx5TXeYazF76TmTMECQD2mamufsyTIuzrPsoZU4K7Dlsk/HgSJOFUrbiH
         HPLRxZCiutpsbWFRXv5ly5Q7v3x6TtumjNHIfSbQ+u6jaRxxrL+NOv7q+0KMMyA/x8H9
         rxzfxIfJqQnd4LpZuCUZ31SM/CFboS+7sGYYnnlvbh0Cp7qYGBWndFcvJvR0AOVyu+zV
         0Z70U0ZU6VYlbOwMp1Tc0zQY8nEYyJZ2VoyVhZgAv+Ucjzag5qLSuq7LDJvdVWXCmJ5s
         hQK2jWgKqsZ46g//8ERAS66LJLAmYzIqSAg+FBX7QNHqQgN87HotTnsC45CAkxPthZTb
         7iSg==
X-Gm-Message-State: APjAAAVYrZkJMqYEU5utAiqVOIEP0wFvpXZ7CKd8dokSzd53mwbL1A2d
        r+tUUZITZOc02avVTrXdIR0=
X-Google-Smtp-Source: APXvYqxomuZMUods9JvbkAcTXWlI94OoREhDjbEJT12TZ5Pu/KbyO8NxBBn+WNNmtcHRpcvG87lDDQ==
X-Received: by 2002:a7b:c84b:: with SMTP id c11mr10633418wml.158.1574975116327;
        Thu, 28 Nov 2019 13:05:16 -0800 (PST)
Received: from localhost.localdomain ([109.126.143.74])
        by smtp.gmail.com with ESMTPSA id y8sm11047038wmi.9.2019.11.28.13.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2019 13:05:15 -0800 (PST)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@canonical.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] block: optimise bvec_iter_advance()
Date:   Fri, 29 Nov 2019 00:04:37 +0300
Message-Id: <06b1b796b8d9bcaa6d5b325668525b7a5663035b.1574974574.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1574974574.git.asml.silence@gmail.com>
References: <cover.1574974574.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

bvec_iter_advance() is quite popular, but compilers fail to do proper
alias analysis and optimise it good enough. The assembly is checked
for gcc 9.2, x86-64.

- remove @iter->bi_size from min(...), as it's always less than @bytes.
Modify at the beginning and forget about it.

- the compiler isn't able to collapse memory dependencies and remove
writes in the loop. Help it by explicitely using local vars.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 include/linux/bvec.h | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/include/linux/bvec.h b/include/linux/bvec.h
index a032f01e928c..7b2f05faae14 100644
--- a/include/linux/bvec.h
+++ b/include/linux/bvec.h
@@ -87,26 +87,31 @@ struct bvec_iter_all {
 static inline bool bvec_iter_advance(const struct bio_vec *bv,
 		struct bvec_iter *iter, unsigned bytes)
 {
+	unsigned int done = iter->bi_bvec_done;
+	unsigned int idx = iter->bi_idx;
+
 	if (WARN_ONCE(bytes > iter->bi_size,
 		     "Attempted to advance past end of bvec iter\n")) {
 		iter->bi_size = 0;
 		return false;
 	}
 
+	iter->bi_size -= bytes;
+
 	while (bytes) {
-		const struct bio_vec *cur = bv + iter->bi_idx;
-		unsigned len = min3(bytes, iter->bi_size,
-				    cur->bv_len - iter->bi_bvec_done);
+		const struct bio_vec *cur = bv + idx;
+		unsigned int len = min(bytes, cur->bv_len - done);
 
 		bytes -= len;
-		iter->bi_size -= len;
-		iter->bi_bvec_done += len;
-
-		if (iter->bi_bvec_done == cur->bv_len) {
-			iter->bi_bvec_done = 0;
-			iter->bi_idx++;
+		done += len;
+		if (done == cur->bv_len) {
+			idx++;
+			done = 0;
 		}
 	}
+
+	iter->bi_idx = idx;
+	iter->bi_bvec_done = done;
 	return true;
 }
 
-- 
2.24.0

