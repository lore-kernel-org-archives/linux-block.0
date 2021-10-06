Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93786C4167B
	for <linux-block@archiver.kernel.org>; Wed,  6 Oct 2021 23:13:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75B7761077
	for <linux-block@archiver.kernel.org>; Wed,  6 Oct 2021 23:13:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbhJFXPb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Oct 2021 19:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231231AbhJFXPa (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Oct 2021 19:15:30 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D5EBC061746
        for <linux-block@vger.kernel.org>; Wed,  6 Oct 2021 16:13:37 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id x1so724956iof.7
        for <linux-block@vger.kernel.org>; Wed, 06 Oct 2021 16:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fB0J1oLaWn8aQX1qmT2pF+15JxKPoNeiCpTQYqkrAY4=;
        b=nLas33MUIpZaohjazlCL17urrtmqiKZ3QzMe/8Om2Fpq5nCQQwiuLkYYuUviOpjacy
         VSqAu7nWldscev6+JBRyILC0rX1rrfCu6TUlWdG5CZwDgClU8DzgW22kUQ3WZi9UfZSm
         u/AcvsJotbJPNr5Bkugzbdak0iZLfJcMbYFTB7RWD2nOtJTYbzjCjdb4ZLp1yXEVNccx
         HnALQWp2Fa1RyGTI4dTH50GP+lgJlIJu/abSLCJAMGWQw+cIV2QxflOOTfYgQaWQMv48
         Vi4p35pX0oCT1fMS9jWIXM7T7YgyRPT7JiQyWwhWV4FYo4vgMs+JoY2dM3v9YRTyUlRK
         PECA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fB0J1oLaWn8aQX1qmT2pF+15JxKPoNeiCpTQYqkrAY4=;
        b=xTzIKrIpXYvo/WCZ/1qhBKNyceS3T5+DMpSjqiSI7gjP7vEiMly91vSXQ4rARS0a8G
         NR7OKcPy/ljRYtIxkz5vshYC4F0T+lnzZ9VmXw6Hv9nE0J5r/drxSVhfj8C+fuaIArpA
         XAo96SLz5cgpvZXzYViu41IxnnVAhYkdFuO2zCyo4t97v6nrVYe0ZpfhnyezBSpTGUqe
         0Spx5ZdB/c1XH+56iDYn9lwio9c3GHG19tVDpFVp8gygOjnLtRKu2NTDoHbaQ2tI8Xw/
         Xpc5RPnCR1BygmM8d3+pgrdtKC/CHbJX/zW1u3qmLEHm4brTyMO+P7eX9L/fpHxaHrgr
         Q49Q==
X-Gm-Message-State: AOAM533AT/pXVpPle8mN7/2IJEpxXmiU274OtfLQzRNTb/JmTfQ6u15p
        QmbKRGf1ny1QjqWshmi0kvKJ2dy+qrMOmQ==
X-Google-Smtp-Source: ABdhPJw0I/o3+XDl8OxTztxBYD/piLLj1nuhTQ8r5NvmhLggRDnuU+3L1lqRAAeRa8IGwiWX/YKUew==
X-Received: by 2002:a02:c7d2:: with SMTP id s18mr385807jao.68.1633562016617;
        Wed, 06 Oct 2021 16:13:36 -0700 (PDT)
Received: from p1.localdomain ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id o1sm12955203ilj.41.2021.10.06.16.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 16:13:36 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     io-uring@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 3/3] io_uring: inform block layer of how many requests we are submitting
Date:   Wed,  6 Oct 2021 17:13:30 -0600
Message-Id: <20211006231330.20268-4-axboe@kernel.dk>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211006231330.20268-1-axboe@kernel.dk>
References: <20211006231330.20268-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The block layer can use this knowledge to make smarter decisions on
how to handle the request, if it knows that N more may be coming. Switch
to using blk_start_plug_nr_ios() to pass in that information.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io_uring.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 73135c5c6168..90af264fdac6 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -316,6 +316,7 @@ struct io_submit_state {
 
 	bool			plug_started;
 	bool			need_plug;
+	unsigned short		submit_nr;
 	struct blk_plug		plug;
 };
 
@@ -7027,7 +7028,7 @@ static int io_init_req(struct io_ring_ctx *ctx, struct io_kiocb *req,
 		if (state->need_plug && io_op_defs[opcode].plug) {
 			state->plug_started = true;
 			state->need_plug = false;
-			blk_start_plug(&state->plug);
+			blk_start_plug_nr_ios(&state->plug, state->submit_nr);
 		}
 
 		req->file = io_file_get(ctx, req, READ_ONCE(sqe->fd),
@@ -7148,6 +7149,7 @@ static void io_submit_state_start(struct io_submit_state *state,
 {
 	state->plug_started = false;
 	state->need_plug = max_ios > 2;
+	state->submit_nr = max_ios;
 	/* set only head, no need to init link_last in advance */
 	state->link.head = NULL;
 }
-- 
2.33.0

