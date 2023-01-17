Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0107FC3DA78
	for <linux-block@archiver.kernel.org>; Tue, 17 Jan 2023 11:43:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236671AbjAQLny (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 Jan 2023 06:43:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236761AbjAQLnx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Jan 2023 06:43:53 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35F6023642
        for <linux-block@vger.kernel.org>; Tue, 17 Jan 2023 03:43:52 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id ss4so67407508ejb.11
        for <linux-block@vger.kernel.org>; Tue, 17 Jan 2023 03:43:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JdeNmuJ6kbnP8MYh4lEr1wWN+ucS92J8koP7Z2P9BMQ=;
        b=JuYiMy3QgY/q9SY2nRHeDeUz/DLER18yeBap1B3hgQLPKn2tdBcSGq8B2gI8Di/SZK
         4e3nAFjJcGHNrAyK7Samdty8ppBZZWw9gKp8rDOWS4ofMkPrzt/xmugTrT3PC6CG42w5
         f2+D6si2nGxigqF5q84VAA7sxFUpIG+CVPYmQ8Ir07f6JVfi0Z4SWZ0xRG491BPwZTT3
         ANvzN6moA6oOmmCX5J/w3JcLxYwNomL4RS+MgsYkJA62QscM4LxjA+OIBGCx416YqbQO
         5jV8bVcNQ/LPVGFdRbu55/xrE6xlmkAfX6QQh2VUpG/GdjDDStwI7O0gEThllXs1HRZ/
         az0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JdeNmuJ6kbnP8MYh4lEr1wWN+ucS92J8koP7Z2P9BMQ=;
        b=2wTTVLqpOmMaoZPxg6A/kH6+gUWM4vPkzTNC94uxDiZSCSL4FJClX+UyE5VmjbtgI2
         8zgYuKU9U38Y99HFYExbJmfQmsIaLe471ryUaSht1Sp1JVCDMXNdZrrUpzV7TbOBCwHD
         U/xvnPahwltIB8dndNETa0QsWSlKck83Iw9/tr1hhEutGCeevn+3upZLbUVSAm/kRnB2
         QKXiXp8uF0RgqoiRjqRCxe6RXNS9Q37BGYEnPIb6Elyyg3AMvhIrrFNHXFTPi4503JFW
         EqtHC1zVG9iqhbinoC1vNmQ3nOLWwXiihpDTbN9yGwo7mxwd9bWoHMk6fENR/zHG7Vbs
         F+1g==
X-Gm-Message-State: AFqh2kpFr5Uior8MFbsuVI4+vQeQ8S/6CvhTKaVBRTB7+0NJxJZC982q
        YFnSMwekPAdGSOTkeGrDJOqR884HYzA=
X-Google-Smtp-Source: AMrXdXuEtYNx2rb5HS6acg4bFZWbvnz4VWHz9bThkTyab1woIbL4VfRpSwaWXBh4ymIyJSDcmoKMeg==
X-Received: by 2002:a17:907:6746:b0:84d:1c67:97d7 with SMTP id qm6-20020a170907674600b0084d1c6797d7mr2670434ejc.30.1673955830660;
        Tue, 17 Jan 2023 03:43:50 -0800 (PST)
Received: from 127.com ([2620:10d:c092:600::2:4ae2])
        by smtp.gmail.com with ESMTPSA id u1-20020a1709061da100b0086b7ffb3b92sm4788632ejh.205.2023.01.17.03.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 03:43:50 -0800 (PST)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc:     Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH for-next] block: fix hctx checks for batch allocation
Date:   Tue, 17 Jan 2023 11:42:15 +0000
Message-Id: <80d4511011d7d4751b4cf6375c4e38f237d935e3.1673955390.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When there are no read queues read requests will be assigned a
default queue on allocation. However, blk_mq_get_cached_request() is not
prepared for that and will fail all attempts to grab read requests from
the cache. Worst case it doubles the number of requests allocated,
roughly half of which will be returned by blk_mq_free_plug_rqs().

It only affects batched allocations and so is io_uring specific.
For reference, QD8 t/io_uring benchmark improves by 20-35%.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---

It might be a good idea to always use HCTX_TYPE_DEFAULT, so the cache
always can accomodate combined write with read reqs.

 block/blk-mq.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 2c49b4151da1..9d463f7563bc 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2890,6 +2890,7 @@ static inline struct request *blk_mq_get_cached_request(struct request_queue *q,
 		struct blk_plug *plug, struct bio **bio, unsigned int nsegs)
 {
 	struct request *rq;
+	enum hctx_type type, hctx_type;
 
 	if (!plug)
 		return NULL;
@@ -2902,7 +2903,10 @@ static inline struct request *blk_mq_get_cached_request(struct request_queue *q,
 		return NULL;
 	}
 
-	if (blk_mq_get_hctx_type((*bio)->bi_opf) != rq->mq_hctx->type)
+	type = blk_mq_get_hctx_type((*bio)->bi_opf);
+	hctx_type = rq->mq_hctx->type;
+	if (type != hctx_type &&
+	    !(type == HCTX_TYPE_READ && hctx_type == HCTX_TYPE_DEFAULT))
 		return NULL;
 	if (op_is_flush(rq->cmd_flags) != op_is_flush((*bio)->bi_opf))
 		return NULL;
-- 
2.38.1

