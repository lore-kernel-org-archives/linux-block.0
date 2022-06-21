Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DCC5C43334
	for <linux-block@archiver.kernel.org>; Tue, 21 Jun 2022 16:07:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353697AbiFUQHi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 Jun 2022 12:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353692AbiFUQHb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Jun 2022 12:07:31 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2651FFB
        for <linux-block@vger.kernel.org>; Tue, 21 Jun 2022 09:07:29 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id k6so5184096ilq.2
        for <linux-block@vger.kernel.org>; Tue, 21 Jun 2022 09:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:from
         :subject:cc:content-transfer-encoding;
        bh=DXukMPLTgFb13yCCIjDEeL7bA19QAntRr4FRC1wZJBc=;
        b=a68SrSSsLMAFEnb3WkMZvS5w1mhQS9AwT1RQK+QSjlJLUKgUostdeY6geebKJGGVy4
         ad34D6f6tPoaWIgNkJi+L1T27MMCDBUtRgiJjyK7YzqSi4mSqbbHuW8ht40C5nWZEB6q
         N1Y4GdD74/brRwE/OyyI+aGAWPVLLUZ0aLZQ0qQtxNDa0OGgrfHVckpSkulwWQijJ8eX
         5bt9wQi2BvcVGdx5XvcvlpEWTmn6xWS54slQbdgPwQ1EgtPxj/5vEV0H2iS7Kctrw48N
         6K/MplI5M0b8PcaTLV/vcw8yxBp7yZTm50u9EUNfGWLKI9ZcAYqGIso6Dohlw9dQozB9
         A+pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:from:subject:cc:content-transfer-encoding;
        bh=DXukMPLTgFb13yCCIjDEeL7bA19QAntRr4FRC1wZJBc=;
        b=C2LQZ4K7Rym/62BXcloA/egI9wThj2oMm7cGEzV0HZnZiHdrsCD3x5PqdExoFs6YC9
         /fVMg0yULb+NONSMXNFuH8htNvJkjZbpx3+I5t+FCnYOHFIYabYTMR+TtPo7vxJTaG6b
         AyaSY2MveF9Ggk/epareVExYqbAwa4LNokRDCMkUNSa93ia/scYpCVSwun2zAy/GJYL+
         TOzPaanhkZOt1AUIXVL7yh8gUPCbMcKQljBwNQR1GDDKNL/ACNRxYwGIEUsFNtAL/8Ox
         5KZVi+2U5A7Tiq9NXPUhiLxJP/X6/C0UpyjRB4B6xUR4sdIuO05dNOLcwbYpRrn/e0Y9
         IgGA==
X-Gm-Message-State: AJIora8s+Ipd2USEkJm8HCBXSuDYaQPMLD3TUwFBBKG+4wZB51/pJ0k2
        tqzHEtI5/XTHjcZtKjkzmDZGPKl/DZoYlQ==
X-Google-Smtp-Source: AGRyM1uJnf/jL6bP1lrwjxZx2T7tjMyHenvymY9+aZo7Qsmrec3MdixAkBsAWDdD8ndEStxeD06y3w==
X-Received: by 2002:a05:6e02:1885:b0:2d9:18c2:c5b6 with SMTP id o5-20020a056e02188500b002d918c2c5b6mr5035537ilu.201.1655827648972;
        Tue, 21 Jun 2022 09:07:28 -0700 (PDT)
Received: from [192.168.1.172] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id e40-20020a022128000000b0032e49fcc241sm7276777jaa.176.2022.06.21.09.07.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jun 2022 09:07:28 -0700 (PDT)
Message-ID: <65187802-413a-7425-234e-68cf0b281a91@kernel.dk>
Date:   Tue, 21 Jun 2022 10:07:26 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Content-Language: en-US
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] block: pop cached rq before potentially blocking
 rq_qos_throttle()
Cc:     Dylan Yudaken <dylany@fb.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If rq_qos_throttle() ends up blocking, then we will have invalidated and
flushed our current plug. Since blk_mq_get_cached_request() hasn't
popped the cached request off the plug list just yet, we end holding a
pointer to a request that is no longer valid. This insta-crashes with
rq->mq_hctx being NULL in the validity checks just after.

Pop the request off the cached list before doing rq_qos_throttle() to
avoid using a potentially stale request.

Fixes: 0a5aa8d161d1 ("block: fix blk_mq_attempt_bio_merge and rq_qos_throttle protection")
Reported-by: Dylan Yudaken <dylany@fb.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 33145ba52c96..93d9d60980fb 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2765,15 +2765,20 @@ static inline struct request *blk_mq_get_cached_request(struct request_queue *q,
 		return NULL;
 	}
 
-	rq_qos_throttle(q, *bio);
-
 	if (blk_mq_get_hctx_type((*bio)->bi_opf) != rq->mq_hctx->type)
 		return NULL;
 	if (op_is_flush(rq->cmd_flags) != op_is_flush((*bio)->bi_opf))
 		return NULL;
 
-	rq->cmd_flags = (*bio)->bi_opf;
+	/*
+	 * If any qos ->throttle() end up blocking, we will have flushed the
+	 * plug and hence killed the cached_rq list as well. Pop this entry
+	 * before we throttle.
+	 */
 	plug->cached_rq = rq_list_next(rq);
+	rq_qos_throttle(q, *bio);
+
+	rq->cmd_flags = (*bio)->bi_opf;
 	INIT_LIST_HEAD(&rq->queuelist);
 	return rq;
 }
-- 
Jens Axboe

