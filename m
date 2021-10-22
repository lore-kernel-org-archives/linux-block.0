Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89A38C433F5
	for <linux-block@archiver.kernel.org>; Fri, 22 Oct 2021 15:02:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 631C760F25
	for <linux-block@archiver.kernel.org>; Fri, 22 Oct 2021 15:02:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233186AbhJVPEV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Oct 2021 11:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233143AbhJVPEV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Oct 2021 11:04:21 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B12D8C061764
        for <linux-block@vger.kernel.org>; Fri, 22 Oct 2021 08:02:03 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 5so3378862edw.7
        for <linux-block@vger.kernel.org>; Fri, 22 Oct 2021 08:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ymxL+lowqiJELgCioMN9dXfvQrTfgKn+05pgZ+8882k=;
        b=E7quO4geJuqUOPVNSjDs0zMbP4s4fCSsLnrF5i1ADFbkAQEBUxA6bhph5JVxDdXgqx
         yd+LkEcwCNPPmAJAvBMazaEecQ6sUvLKsvnA4p+rZfU7Qze4r9oxU4Wj9ng20yuuzMrM
         nG6ZtBe0Pkkn3LX4/kTau6vuMVwjJpupEITEk/8achUu7C20o6vyzot872PGX4QZZQ5f
         NiRtXBYKqzu+lxW39EJ1POg5qkQguPGhh+6BrgkwJVotkLTO0NVq0NrHMfiKF2zV8xQS
         JM7fGylqCMMsUasdRTZLeMAuDbI2vg4DZRF3u+S1TFFpVj45ApHJWav/03Y7kXpZWDGs
         G1cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ymxL+lowqiJELgCioMN9dXfvQrTfgKn+05pgZ+8882k=;
        b=LvqgI5y33kqMfwMNtaJCN5sLESd0E0qaOLwzs5KdBrrDG9wViUks3CDtVVi6M9v/mN
         K0a0azUb7PuK8B4DdAxs4dNTHejK7/rSvc/H3Qog7zcNHKKxkXRAfHfp1SkDkuiKitE1
         liiOuvr2QTZ/hc3I+unxg49hwpUCJi1iLBjr26EYZBz9URfyDQTbkZ4/oI0hV9HNYUbH
         aJjHDWiT+5oHGZ+pjr+oS0oXYQq31BnJhV7nfbfqzBcMCyGigMy09dwXWNllTBwvLZ6i
         MSWEyi0gBQWuFnmSZgF2aCEMFQ+9O7hAhUktDkHDMe+w2bOuStsgqYa7nGXnSodDDKcB
         tmLA==
X-Gm-Message-State: AOAM5304KQ/F41QtUCDaq8P76StuvJp42me4HWw/9/fI9VYhRDwWbUn+
        Law3iXU/r6+uXByQ3/IIxRrKAcXOCl8=
X-Google-Smtp-Source: ABdhPJx/QnSQoh9EX+poCEj/dySpeVoC5bnxAEPxWpjOK0DOxOyMMPvSuh7jl3abeIE1RDXCFCsgwA==
X-Received: by 2002:a50:be8f:: with SMTP id b15mr696954edk.200.1634914912568;
        Fri, 22 Oct 2021 08:01:52 -0700 (PDT)
Received: from 127.0.0.1localhost ([148.252.133.195])
        by smtp.gmail.com with ESMTPSA id b20sm1690694edd.50.2021.10.22.08.01.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 08:01:52 -0700 (PDT)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH for-next] block: fix req_bio_endio append error handling
Date:   Fri, 22 Oct 2021 16:01:44 +0100
Message-Id: <344ea4e334aace9148b41af5f2426da38c8aa65a.1634914228.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Shinichiro Kawasaki reports that there is a bug in a recent
req_bio_endio() patch causing problems with zonefs. As Shinichiro
suggested, inverse the condition in zone append path to resemble how it
was before: fail when it's not fully completed.

Fixes: 478eb72b815f3 ("block: optimise req_bio_endio()")
Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 block/blk-mq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index d04ee72ba125..c19dfa8ea65e 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -640,7 +640,7 @@ static void req_bio_endio(struct request *rq, struct bio *bio,
 		 * Partial zone append completions cannot be supported as the
 		 * BIO fragments may end up not being written sequentially.
 		 */
-		if (bio->bi_iter.bi_size == nbytes)
+		if (bio->bi_iter.bi_size != nbytes)
 			bio->bi_status = BLK_STS_IOERR;
 		else
 			bio->bi_iter.bi_sector = rq->__sector;
-- 
2.33.1

