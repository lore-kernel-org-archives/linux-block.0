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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38581C56201
	for <linux-block@archiver.kernel.org>; Tue, 24 Nov 2020 10:25:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF522206E0
	for <linux-block@archiver.kernel.org>; Tue, 24 Nov 2020 10:25:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FbZLGesz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731638AbgKXKZk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 24 Nov 2020 05:25:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731772AbgKXKZj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Nov 2020 05:25:39 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62DCEC0613D6;
        Tue, 24 Nov 2020 02:25:39 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id a65so2307538wme.1;
        Tue, 24 Nov 2020 02:25:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=19GmmXOyRtGmWddN5cf4I3pc9POtzdyHfXPU1+kLG50=;
        b=FbZLGeszgRtp7HVKEOP8IKYhp17GrR2e6Y7e+enEVuc+Rx22E2REB0kLbHMs1Q882v
         itKeAGSmMfjD8T6JDQQg4Urovr4P6JPH6KVqCZ5TGX1bEpYJsHU/9VWb45KhKHyq52uE
         F07+mQGiCmKjqZvWvy/JtlFKqLN8N6dX0kXDl2RKDvd025i/hasKdsXNXioe/2Ly2K1h
         dqkKGrLFQN41exQSPYlAqwCWZZr1zguaMlL5n+FghwiWCU3+sTDu2sZMtNjdoyHi1lQO
         GnxfVKWYTpkEBso92s0o5VLZ1kIaSJiFoNCAbK13qkYAAEPlPbcpNwfb3Rg00aHgIAPM
         QeQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=19GmmXOyRtGmWddN5cf4I3pc9POtzdyHfXPU1+kLG50=;
        b=pyvF80kkND1BkHaA/5mARKsjlu/89N1STiWYaOcn1o8L9OB4PaDH7oPUnT/ZrAnFNM
         o+evpvweKpfyXiVdblKbSR0WPde9PVG2iZutN3ODeiz4DEncTAIU5/Qiim5PD6xygGlm
         4w8efaX5QMejIPVxgfZIvGZbUaaxuNtIrz0cLpVo02PHlBfQKC4zdxSnFwgSC2ZcURpW
         /PS7e3Xn56tY3WfncpI4bPyXJgj8qH3hKKhFLl63fIRGiZneJVmGMYaKxlVgQ3cxEJAK
         2Lst8UukGz3BHuDgM8QsgSrq1HRAXPVDqIEuTuJSd5clpFbiQScX4CIyQLkoiIh6Zl8a
         j25g==
X-Gm-Message-State: AOAM530CG72x+bXPeCw1jMZlNlOWWCZ/4WPqgmDTuikyhmTWKhiLWyUa
        22FmUU6D9q7EhuVVemO32zg=
X-Google-Smtp-Source: ABdhPJw3QTgJ2sp325P4/RCYm22m3Ivkh06vs9WyCgKGziEH/EHw2d8Kladi0gF/dPk3eecMlSxNcA==
X-Received: by 2002:a1c:6856:: with SMTP id d83mr3673403wmc.13.1606213538064;
        Tue, 24 Nov 2020 02:25:38 -0800 (PST)
Received: from localhost.localdomain (host109-152-100-135.range109-152.btcentralplus.com. [109.152.100.135])
        by smtp.gmail.com with ESMTPSA id f23sm4295812wmb.43.2020.11.24.02.25.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 02:25:37 -0800 (PST)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        ming.lei@redhat.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 5.11] block: optimise for_each_bvec() advance
Date:   Tue, 24 Nov 2020 10:21:23 +0000
Message-Id: <60aaa6caab3d061cf7194716c27a10920b5bd7ad.1606212786.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.24.0
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

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 include/linux/bvec.h | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/include/linux/bvec.h b/include/linux/bvec.h
index 2efec10bf792..4a304dfafa18 100644
--- a/include/linux/bvec.h
+++ b/include/linux/bvec.h
@@ -121,18 +121,24 @@ static inline bool bvec_iter_advance(const struct bio_vec *bv,
 	return true;
 }
 
-static inline void bvec_iter_skip_zero_bvec(struct bvec_iter *iter)
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

