Return-Path: <SRS0=VjOk=UV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4017BC48BE8
	for <linux-block@archiver.kernel.org>; Sat, 22 Jun 2019 20:44:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3091206B7
	for <linux-block@archiver.kernel.org>; Sat, 22 Jun 2019 20:44:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CI5JLR/U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726372AbfFVUog (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 22 Jun 2019 16:44:36 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35263 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726286AbfFVUog (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 22 Jun 2019 16:44:36 -0400
Received: by mail-wr1-f67.google.com with SMTP id m3so9836258wrv.2
        for <linux-block@vger.kernel.org>; Sat, 22 Jun 2019 13:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9BG/7LnezII5mNtWEJv2o6z3Cg8xQRRiq9PY3GLO+LY=;
        b=CI5JLR/U6y44Ygrj+VvZ6E7p8O/SjHLTnzrOpgZkUVOfGLu7iqMa3du7L665qIt44n
         AMIAqVtuS+WUa862wI6sxSjBKryRs+o2ftKwk6f1H2Of2pZN/Chq1Nfrhw02jrwo9tKe
         rPD909rf+14Y+b7VZnSsMYEoutEKsX+QBYMmaFoxGWThYPmkt26uDpwpCIjriC7tiygQ
         vgeiuAYu8tdbyuDjygMrvysA2/mKFW0ivpxpqtJwk6ZmbvBxJnttLtpjkuNiU2WXUjZ0
         41j+bkHwu5sZtUfWbRdTg+T0XF8H2NH83kLcdxIsgI3JKhJ0mxwtJ/AWf731hY1l6TMP
         e1CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9BG/7LnezII5mNtWEJv2o6z3Cg8xQRRiq9PY3GLO+LY=;
        b=BCIiMppRIebQkY9Wdgd05woqfgp0YEYRlm/rNtBJoT/0e5D5Yk8bfrGWNd8GRrcVcr
         HIhRLsf/Cv7hB9mCUHHLn0ZOPz40Ft7v/jSyIOJK+0AUbgkasq1YFPUn/9MCpRT2hKJ6
         c8/SQm4ELcOLxNqx+0FI+C38tTcJlUtyiX+Ur2Tk3s39NQFpr0W/ewiTNbVC2d5Se94g
         nl5+5vju03fvQ3D02prrcYSVE5TwRrSxis+504Brot9NZAK2MpJwMD/yQvcbzIy5Jfb1
         iRrvff2KkQkJfEU9rtyV/KRQzrLRmuvsTN+2eU8ePmfzvFFgwYAr0pWfsCeuXeCAlaZJ
         6s3A==
X-Gm-Message-State: APjAAAWZZ5lOOdZUQqyD8h8Xa1NWX8MN7twKwAZlxu8WPeTMIlJ1njqZ
        EmW8nozktdQW46xudL32IikyHg==
X-Google-Smtp-Source: APXvYqxxBNt1dFAN50Hh6QHN7KEyuBb1kiDKJHGTt2uNUc3YBenG3q9KGBC+iT33jw5XwjBL6ArvQQ==
X-Received: by 2002:a05:6000:114b:: with SMTP id d11mr34771323wrx.167.1561236274447;
        Sat, 22 Jun 2019 13:44:34 -0700 (PDT)
Received: from localhost.localdomain (88-147-39-13.dyn.eolo.it. [88.147.39.13])
        by smtp.gmail.com with ESMTPSA id o20sm6779064wro.65.2019.06.22.13.44.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Jun 2019 13:44:33 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        bfq-iosched@googlegroups.com, oleksandr@natalenko.name,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH BUGFIX V2] block, bfq: fix operator in BFQQ_TOTALLY_SEEKY
Date:   Sat, 22 Jun 2019 22:44:16 +0200
Message-Id: <20190622204416.33871-1-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

By mistake, there is a '&' instead of a '==' in the definition of the
macro BFQQ_TOTALLY_SEEKY. This commit replaces the wrong operator with
the correct one.

Fixes: commit 7074f076ff15 ("block, bfq: do not tag totally seeky queues as soft rt")
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-iosched.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index f8d430f88d25..f9269ae6da9c 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -240,7 +240,7 @@ static struct kmem_cache *bfq_pool;
  * containing only random (seeky) I/O are prevented from being tagged
  * as soft real-time.
  */
-#define BFQQ_TOTALLY_SEEKY(bfqq)	(bfqq->seek_history & -1)
+#define BFQQ_TOTALLY_SEEKY(bfqq)	(bfqq->seek_history == -1)
 
 /* Min number of samples required to perform peak-rate update */
 #define BFQ_RATE_MIN_SAMPLES	32
-- 
2.20.1

