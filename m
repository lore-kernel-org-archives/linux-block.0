Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 127DDC433F5
	for <linux-block@archiver.kernel.org>; Sun, 17 Oct 2021 01:37:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB31D60F70
	for <linux-block@archiver.kernel.org>; Sun, 17 Oct 2021 01:37:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244782AbhJQBkD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 16 Oct 2021 21:40:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244778AbhJQBkD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 16 Oct 2021 21:40:03 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B1B1C061765
        for <linux-block@vger.kernel.org>; Sat, 16 Oct 2021 18:37:54 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id o184so208985iof.6
        for <linux-block@vger.kernel.org>; Sat, 16 Oct 2021 18:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7lhCfdRSOPd+mAiRJf4K+vWNm8poJDhSHgYsxOkE4s0=;
        b=FMKK8+PNzDg5nZfyrwUBguLcNEm4fQqMpkTB86Dor/7UIWp+20PqISHhXKtVsv3nWS
         ARKpDM+GC2vpO0I3dBN1/laFk2seNntdS2IeD1iOHflrdKcTk71Zm2Cb+NShx/QzO9gX
         LOy1TlJBXmF/d986H6gQr3+4qdFxJzJsWxu8iRR3LoROZlnkt80hvo0rmksXs/TX6d1i
         TAd+JpXObVWYIKyh/v1dLbgIRmYqniWpbnCeaWLIWwETVAo6/ccTWYgWULOV5fbiCF3f
         k/fZvsyTQYT2lxwz4/VlouGBft2Y/X9w+lrHRQixY2OFd5V49IA4OPLRBTJ/IcQRXhiZ
         VYyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7lhCfdRSOPd+mAiRJf4K+vWNm8poJDhSHgYsxOkE4s0=;
        b=007TwOHFAlEYJzDxFN9OT2g/kRCldrG57t0CQ8kL/0YHHQxoHzLd1l6g6+l4L4vFEN
         Md8l/3gJmqoTBZ2SB9niqVdwJEin8X0YEoQF5ftxMNp7jnNWHpeEdzT+PwHknJIelgJF
         Aq5j+4bAI52O5osK/WJg+SN5XbqeM40mvgdvoSe6m5qYgLbcKEOZ1YlBjIW2XVqgfvwz
         tIwmY/q0BLQ9bXUYEMIBIPGIghi2zD9GmZu3rf2KkT0qXR3gHAptetYH3MX4f6X/Wr1s
         zkBSvxoeaCYuX0iFVSn4+OVZBj6iu5SVaS3N2q2QZLsPDQ/j38OHAqCpQyuggZN/x6Nr
         zLVg==
X-Gm-Message-State: AOAM5339NS6HsA+VPSK2X4yNjckH1uWfJVKAXpoJZRK71XD0lo5kEsJC
        94y2tPZ8uu2rh2YCa1mSbMNpBkKDbZe82A==
X-Google-Smtp-Source: ABdhPJzpy3WnjcqoP7WMe+XbPRt+TRwRlZIZ5Lb3ZcbdPnCSGTwaMmnoGfurp3cQH2ReLAe1JnItow==
X-Received: by 2002:a02:c6ca:: with SMTP id r10mr13491212jan.111.1634434673716;
        Sat, 16 Oct 2021 18:37:53 -0700 (PDT)
Received: from localhost.localdomain ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id j17sm4934383ilq.1.2021.10.16.18.37.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Oct 2021 18:37:53 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 03/14] block: remove useless caller argument to print_req_error()
Date:   Sat, 16 Oct 2021 19:37:37 -0600
Message-Id: <20211017013748.76461-4-axboe@kernel.dk>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211017013748.76461-1-axboe@kernel.dk>
References: <20211017013748.76461-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We have exactly one caller of this, just get rid of adding the useless
function name to the output.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/blk-core.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index d5b0258dd218..2596327f07d6 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -217,8 +217,7 @@ int blk_status_to_errno(blk_status_t status)
 }
 EXPORT_SYMBOL_GPL(blk_status_to_errno);
 
-static void print_req_error(struct request *req, blk_status_t status,
-		const char *caller)
+static void print_req_error(struct request *req, blk_status_t status)
 {
 	int idx = (__force int)status;
 
@@ -226,9 +225,9 @@ static void print_req_error(struct request *req, blk_status_t status,
 		return;
 
 	printk_ratelimited(KERN_ERR
-		"%s: %s error, dev %s, sector %llu op 0x%x:(%s) flags 0x%x "
+		"%s error, dev %s, sector %llu op 0x%x:(%s) flags 0x%x "
 		"phys_seg %u prio class %u\n",
-		caller, blk_errors[idx].name,
+		blk_errors[idx].name,
 		req->rq_disk ? req->rq_disk->disk_name : "?",
 		blk_rq_pos(req), req_op(req), blk_op_str(req_op(req)),
 		req->cmd_flags & ~REQ_OP_MASK,
@@ -1464,7 +1463,7 @@ bool blk_update_request(struct request *req, blk_status_t error,
 
 	if (unlikely(error && !blk_rq_is_passthrough(req) &&
 		     !(req->rq_flags & RQF_QUIET)))
-		print_req_error(req, error, __func__);
+		print_req_error(req, error);
 
 	blk_account_io_completion(req, nr_bytes);
 
-- 
2.33.1

