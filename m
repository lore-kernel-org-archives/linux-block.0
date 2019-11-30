Return-Path: <SRS0=ZuuS=ZW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5437C432C0
	for <linux-block@archiver.kernel.org>; Sat, 30 Nov 2019 20:24:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 845BB2084D
	for <linux-block@archiver.kernel.org>; Sat, 30 Nov 2019 20:24:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lIH+oOWd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727340AbfK3UY3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 30 Nov 2019 15:24:29 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42469 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727320AbfK3UY3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 30 Nov 2019 15:24:29 -0500
Received: by mail-wr1-f66.google.com with SMTP id a15so39119910wrf.9;
        Sat, 30 Nov 2019 12:24:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=gm798JVdHtTJhBTTcijtCtbLjelhqSHRBfY12Cw0a4c=;
        b=lIH+oOWdTRBDIjYMuQgQyhAWsykfAJ53WLQ8ig7qoZRh4GygPVxyIL0d6ueYT18u1B
         ilnOQIc+DEdGFuYiiuvCA29eyCdkvWuzaSNSyMItuKzDbjC3XvTxIamhnFjPSVLPGHzt
         atu7McfWIHwGtIrmTyo6kCjbNNETUWkfJoEQF76HrAZo4/NXbtJVt3zOv/g8i0vdOBwo
         RlCS7xesHmx7RG2x5PSMvpXX3HlRJes5r77UgtsSM9fOpw/ed75Il+DgsX2KJ7QxiQXG
         3N+0UX43I7pdOklF2DpTx7wYIkYJ4CKVGLo8lo5huEKnWq5J4Y8mpQjLuaKhjCQJ8E1Z
         WK+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gm798JVdHtTJhBTTcijtCtbLjelhqSHRBfY12Cw0a4c=;
        b=rLKit8arOJxt78PVMgBO/qKKR/4iQnZDNf8rl12PQNNf1IBVtym71eqEMLkqJn7NbR
         JEZeHS/gnn+BmqMm2mpXyEknGZB7Ps6xen+ZW4hb1mh9r8Y9OIE6uC74OPotIMKvNvWX
         WNL/MBSeiYLrPJHlTEZGn1C+W9kHskA736/3caSZ8mLG7NRo1pnFG9mYYEq0YPu5VxNG
         Kuf64bMtC/KhDFuVONZQgMq5Nchus89q5YPXM5TFDTDgySgiUUjqVppOuvLrbxEHVNrh
         atk+gld7CMnEHvryTpYapKqIgqkJM9eKEyI2amDXLqaP6MW7HgNZ9nk55eIJuWjJrDj4
         mX2g==
X-Gm-Message-State: APjAAAVlfznwMVGxjTHrml4bNIX7WsKMqciRwljzDPabhO5FLSTHBWff
        ivHedKoorzKlbJdFuw/GW1NExRIK
X-Google-Smtp-Source: APXvYqxHW7q4Y6fvM4cwHdhWe84sXeiNNMifBlPSc3N86gBwY+Z0sysfG9kCj6yxkkLrWip7krp8wA==
X-Received: by 2002:adf:ea8a:: with SMTP id s10mr51324721wrm.278.1575145467511;
        Sat, 30 Nov 2019 12:24:27 -0800 (PST)
Received: from localhost.localdomain ([109.126.143.74])
        by smtp.gmail.com with ESMTPSA id y15sm30929308wrh.94.2019.11.30.12.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Nov 2019 12:24:27 -0800 (PST)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, nivedita@alum.mit.edu,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] block: optimise bvec_iter_advance()
Date:   Sat, 30 Nov 2019 23:23:52 +0300
Message-Id: <b1408bd6cc3f04fe22ce64f97174b6fbf9ffea40.1575144884.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1575144884.git.asml.silence@gmail.com>
References: <cover.1575144884.git.asml.silence@gmail.com>
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

v2: simplify code (Arvind Sankar)

 include/linux/bvec.h | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/include/linux/bvec.h b/include/linux/bvec.h
index a032f01e928c..679a42253170 100644
--- a/include/linux/bvec.h
+++ b/include/linux/bvec.h
@@ -87,26 +87,24 @@ struct bvec_iter_all {
 static inline bool bvec_iter_advance(const struct bio_vec *bv,
 		struct bvec_iter *iter, unsigned bytes)
 {
+	unsigned int idx = iter->bi_idx;
+
 	if (WARN_ONCE(bytes > iter->bi_size,
 		     "Attempted to advance past end of bvec iter\n")) {
 		iter->bi_size = 0;
 		return false;
 	}
 
-	while (bytes) {
-		const struct bio_vec *cur = bv + iter->bi_idx;
-		unsigned len = min3(bytes, iter->bi_size,
-				    cur->bv_len - iter->bi_bvec_done);
-
-		bytes -= len;
-		iter->bi_size -= len;
-		iter->bi_bvec_done += len;
+	iter->bi_size -= bytes;
+	bytes += iter->bi_bvec_done;
 
-		if (iter->bi_bvec_done == cur->bv_len) {
-			iter->bi_bvec_done = 0;
-			iter->bi_idx++;
-		}
+	while (bytes && bytes >= bv[idx].bv_len) {
+		bytes -= bv[idx].bv_len;
+		idx++;
 	}
+
+	iter->bi_idx = idx;
+	iter->bi_bvec_done = bytes;
 	return true;
 }
 
-- 
2.24.0

