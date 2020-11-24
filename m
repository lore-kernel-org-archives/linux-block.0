Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62B48C56202
	for <linux-block@archiver.kernel.org>; Tue, 24 Nov 2020 18:01:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC56D206D5
	for <linux-block@archiver.kernel.org>; Tue, 24 Nov 2020 18:01:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oa8w8BnV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390840AbgKXSB5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 24 Nov 2020 13:01:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390831AbgKXSB5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Nov 2020 13:01:57 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71729C0613D6
        for <linux-block@vger.kernel.org>; Tue, 24 Nov 2020 10:01:55 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id m6so23245436wrg.7
        for <linux-block@vger.kernel.org>; Tue, 24 Nov 2020 10:01:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RnDyqCPp/6fDB95MN1DP8Xo/I0mJ9d7WkCe+ujIWeMI=;
        b=oa8w8BnVruBihFbUs4fvu2zkpR3U0xMwjGk/WD+rSe82p+L+O6i6op0uybzJSAEAs5
         rhwmxucD4OHOVad3fob07bQgtFPaohYhtzO1geM5N4QXFOVmo5J8oNfN0az7H+UkvUv3
         ERVLXxsiVDOh92IZZ2fJnl3kil5kTsnAyQQLCuNdQRZSQvCJi9/5gvua8OKRJMVDc+0P
         N7+wmEGakqQz8Dr2sBBNXF4b9xADX9uDRLzoCUSQG/K2Rx5185K3xzRacRXThAJ3E4dO
         ZemeIDeZIfZAbJb9nEH+Y5AWY0rtj9h5xpbl1Oi7okF4dpwsOoJDHb1ZIc/p9WKDlKay
         arSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RnDyqCPp/6fDB95MN1DP8Xo/I0mJ9d7WkCe+ujIWeMI=;
        b=he3y/YOK2RFzTDJy2NSv+LTgc6IXcDiW6FfBOuBhCZ7FKF54s3ScXdGscGCulzFTsh
         wL5674+cPukoxwwDHiXkFTymck6RtTWXy8iXf355gk9QzbRq7z3xxD4ZrG6r08dxexGO
         1eiMf7hHs+WFh1PkvT3atpLzxXXC66mgq4s51R9+7d6r7KzMCy2Be049zDi3m4qL4TOB
         SlxvT+TVJJUyTtUz4T46FNH9URRrrplSDmaByEJELSXEwxkP80ker2JdeagrmvOg8kUc
         93ROg1ivDEAi2ASzTfCSXk9vP728lLz8JiHZ/foc9BfOOl9lL0owRvy4wl0BosVFqsGB
         MZEg==
X-Gm-Message-State: AOAM532YAPdgAJ7nolpZATN1n0E+Pz6nUNXrQWK+Dex+BVB9pSsR47dk
        5ahta+inP6jBDKLgYZWsGrgRoAkJVGaUug==
X-Google-Smtp-Source: ABdhPJzabclDeqmDn8WfZC/+S3AFH9m+R67gb+dUw2yuCetnKW3eXhUYfdz8lj/hxTBaJEETp3hb/Q==
X-Received: by 2002:adf:f6c7:: with SMTP id y7mr6357533wrp.147.1606240914137;
        Tue, 24 Nov 2020 10:01:54 -0800 (PST)
Received: from localhost.localdomain (host109-152-100-135.range109-152.btcentralplus.com. [109.152.100.135])
        by smtp.gmail.com with ESMTPSA id x4sm12246403wrv.81.2020.11.24.10.01.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 10:01:53 -0800 (PST)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc:     Ming Lei <ming.lei@redhat.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH 1/2] block: optimise for_each_bvec() advance
Date:   Tue, 24 Nov 2020 17:58:12 +0000
Message-Id: <8a399fe52e05c5aece4424b4ce114ec4e5b40b99.1606240077.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1606240077.git.asml.silence@gmail.com>
References: <cover.1606240077.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Because of how for_each_bvec() works it never advances across multiple
entries at a time, so bvec_iter_advance() is an overkill. Add
specialised bvec_iter_advance_single() that is faster. It also handles
zero-len bvecs, so can kill bvec_iter_skip_zero_bvec().

   text    data     bss     dec     hex filename
before:
  23977     805       0   24782    60ce lib/iov_iter.o
before, bvec_iter_advance() w/o WARN_ONCE()
  22886     600       0   23486    5bbe ./lib/iov_iter.o
after:
  21862     600       0   22462    57be lib/iov_iter.o

Reviewed-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 include/linux/bvec.h | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/include/linux/bvec.h b/include/linux/bvec.h
index 2efec10bf792..ff832e698efb 100644
--- a/include/linux/bvec.h
+++ b/include/linux/bvec.h
@@ -121,18 +121,28 @@ static inline bool bvec_iter_advance(const struct bio_vec *bv,
 	return true;
 }
 
-static inline void bvec_iter_skip_zero_bvec(struct bvec_iter *iter)
+/*
+ * A simpler version of bvec_iter_advance(), @bytes should not span
+ * across multiple bvec entries, i.e. bytes <= bv[i->bi_idx].bv_len
+ */
+static inline void bvec_iter_advance_single(const struct bio_vec *bv,
+				struct bvec_iter *iter, unsigned int bytes)
 {
-	iter->bi_bvec_done = 0;
-	iter->bi_idx++;
+	unsigned int done = iter->bi_bvec_done + bytes;
+
+	if (done == bv[iter->bi_idx].bv_len) {
+		done = 0;
+		iter->bi_idx++;
+	}
+	iter->bi_bvec_done = done;
+	iter->bi_size -= bytes;
 }
 
 #define for_each_bvec(bvl, bio_vec, iter, start)			\
 	for (iter = (start);						\
 	     (iter).bi_size &&						\
 		((bvl = bvec_iter_bvec((bio_vec), (iter))), 1);	\
-	     (bvl).bv_len ? (void)bvec_iter_advance((bio_vec), &(iter),	\
-		     (bvl).bv_len) : bvec_iter_skip_zero_bvec(&(iter)))
+	     bvec_iter_advance_single((bio_vec), &(iter), (bvl).bv_len))
 
 /* for iterating one bio from start to end */
 #define BVEC_ITER_ALL_INIT (struct bvec_iter)				\
-- 
2.24.0

