Return-Path: <SRS0=jhC6=X5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1278C4360C
	for <linux-block@archiver.kernel.org>; Fri,  4 Oct 2019 10:08:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8469E21D71
	for <linux-block@archiver.kernel.org>; Fri,  4 Oct 2019 10:08:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mlxtni30"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731385AbfJDKIk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 4 Oct 2019 06:08:40 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45641 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729291AbfJDKIj (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 4 Oct 2019 06:08:39 -0400
Received: by mail-wr1-f65.google.com with SMTP id r5so6365930wrm.12;
        Fri, 04 Oct 2019 03:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c2u7XRxJe99iE4rQjyctRU/UHhRXxdvAhzx35J6IZ0U=;
        b=Mlxtni30BNAxSE9bntqUDeJg+UfDncBAIim0Dbfbgo75OZjNsnJqQKzXaLZfIYQiWA
         2ME+r7KW4JXKe0j4r9EgQbFqXDbD+QETX5ibeEUCcNDa5vsJV53G+cT08x8/o8PvhJb5
         NVRtFPi8id1UCv3NGRLL9TPVTgnoCYL85MmfoqJRK7nQArLBLAGAG9HGbghvuvs1WJ1W
         yfnXW2JTqXpjWmPeKeqFi9Fd5ltHOTqoq/xEYeGdaGtWcxxJ2njYkJ8zDG1Go5sMixW0
         OFjkTENcdV6qx+BQ5Ec2aeNtLbEioxiYHYOqDmHrpVssm5N6c6ar/xsmJdhm5vAwzkL8
         tMVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c2u7XRxJe99iE4rQjyctRU/UHhRXxdvAhzx35J6IZ0U=;
        b=hVLGQViC6WwfxDd3TQnhSdggXvWf62WR2jyjbp88r7ZpvmjsJSAk8Ai6aqLTTRMGFk
         X9QdQvJBXpIVfK2hj/toiaifgtO9HkiQ+RV5XThSEZy7jwsrTEXBF+LzJ1J+dDvsJNC2
         2Ali5kXqM11rtmiHQGHZ2S3rcFmNIYBb0qmS7caIAZ1lHEga3hpWzCk/lKDSXLjaNXEv
         /3XwGCgJ5M0nHpHWlGmKHaUHIsmeJRXTJSdYrRzaG7Z3tlJdWI8/AjDKeBcmh1EFPZG3
         7H90dFd40VWTw5NEr7iRysuRxExdLW1cy9BfmCLnTxZXLktYQZmBNxSLhNastY3mKWCd
         K+nQ==
X-Gm-Message-State: APjAAAVmd97gtfZay6t8Q5jzjbLP6p2Eyfp/S02j/GypcWmAQ87f2d4N
        QRgeZwf9XkFxFc5LOGRqaJk=
X-Google-Smtp-Source: APXvYqwQB5aYrGxymvxvUBeHorb5eGIrb7KI3ggBpFiONG+INK2vAX3a1fxzUxGh/D0dYsNKcDiIMA==
X-Received: by 2002:a5d:6951:: with SMTP id r17mr1272958wrw.208.1570183717716;
        Fri, 04 Oct 2019 03:08:37 -0700 (PDT)
Received: from localhost.localdomain ([109.126.136.84])
        by smtp.gmail.com with ESMTPSA id n7sm5509273wrt.59.2019.10.04.03.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2019 03:08:37 -0700 (PDT)
From:   "Pavel Begunkov (Silence)" <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Pavel Begunkov <asml.silence@gmail.com>,
        kbuild test robot <lkp@intel.com>
Subject: [PATCH v2] io_uring: Fix reversed nonblock flag
Date:   Fri,  4 Oct 2019 13:07:43 +0300
Message-Id: <eecaf117de4894b595f300b9fb567825330b2d24.1570183599.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <75be62996d115a3e2effa6753a6d803069131460.1570177340.git.asml.silence@gmail.com>
References: <75be62996d115a3e2effa6753a6d803069131460.1570177340.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Pavel Begunkov <asml.silence@gmail.com>

io_queue_link_head() accepts @force_nonblock flag, but io_ring_submit()
passes something opposite.

v2: fix build error by test robot: Rebase from custom tree
Reported-by: kbuild test robot <lkp@intel.com>

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 fs/io_uring.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index c934f91c51e9..c909ea2b84e9 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2703,6 +2703,7 @@ static int io_ring_submit(struct io_ring_ctx *ctx, unsigned int to_submit,
 	struct io_kiocb *shadow_req = NULL;
 	bool prev_was_link = false;
 	int i, submit = 0;
+	bool force_nonblock = true;
 
 	if (to_submit > IO_PLUG_THRESHOLD) {
 		io_submit_state_start(&state, ctx, to_submit);
@@ -2710,9 +2711,9 @@ static int io_ring_submit(struct io_ring_ctx *ctx, unsigned int to_submit,
 	}
 
 	for (i = 0; i < to_submit; i++) {
-		bool force_nonblock = true;
 		struct sqe_submit s;
 
+		force_nonblock = true;
 		if (!io_get_sqring(ctx, &s))
 			break;
 
@@ -2761,7 +2762,7 @@ static int io_ring_submit(struct io_ring_ctx *ctx, unsigned int to_submit,
 
 	if (link)
 		io_queue_link_head(ctx, link, &link->submit, shadow_req,
-					block_for_last);
+					force_nonblock);
 	if (statep)
 		io_submit_state_end(statep);
 
-- 
2.23.0

