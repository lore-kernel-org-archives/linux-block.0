Return-Path: <SRS0=gXx0=YU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92D64CA9EAF
	for <linux-block@archiver.kernel.org>; Sun, 27 Oct 2019 15:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 594442067B
	for <linux-block@archiver.kernel.org>; Sun, 27 Oct 2019 15:52:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YN5TTZI/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727600AbfJ0Pwk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 27 Oct 2019 11:52:40 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42266 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727599AbfJ0Pwk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 27 Oct 2019 11:52:40 -0400
Received: by mail-wr1-f66.google.com with SMTP id r1so7317946wrs.9;
        Sun, 27 Oct 2019 08:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fIBBUxxM5+UM8gvbkkRZTbDiJuRtrtW1NDs5sWQoYL8=;
        b=YN5TTZI/8w/p/XXhGbq0LWPtDR0/0vjJvMLFpqJ3GvEcsxrV0IdROE66ghB4eiQRXS
         VQZYX5XC4ZJm0ZVxo4zQ9ABSfkhcBg4cINEAvumoeZrAFZzc9QwXSLW+xktg1UE69n2z
         vQ2mXyxJfv9AQ6pNTRy5ndwZt5Me+/Ou/TBY/j+Vfq7YuYjXCon82LPXkbSB+B26hQKH
         lUqltfrFmr24gr3X74RluS77/qZyARCYz5NhJX7l9F1vrcB1ghvKQ07L29oRnF0ZYE3X
         AHj8P8EiQdaXnGYFeCrW7eSQ+8BON1zTAJNNE/nthV27E2wmIAlpcVPJsiLAwdGDy6Cm
         kQaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fIBBUxxM5+UM8gvbkkRZTbDiJuRtrtW1NDs5sWQoYL8=;
        b=esaJeTmhtgtx+sf3N0C+AxgdJOWJASjRkm99QVjRIBq4+UW9y2iNsw7/UkhzAY9QdU
         bLJ2uVi4QhfoIdx49qanf8rZ52+s0whK5QW8wYXLNiEsU1GDVbARL3Au7wnf1hArIlb/
         lIp5jeNwRHQcxK1sDBvCDu9ixtDGKo1YTInRh2OBOVN+/jElaGglfa/UUdevAm14SD7B
         wk159DdkLLW1UIzRjGJMK9QlODO4ORjyrgmQx4rhXtxmUnL93xUPtpSBO3T252KirdPV
         IweLVdj1wV+pRm8YzCHj4047sl8fGpf4KI8xuyxcvgnK+AGB0tLoxtZTFk9SKUOENucZ
         As+A==
X-Gm-Message-State: APjAAAWrOF1Ns9nONonY5ZiMo3+u77Dmlbqxsb63dvCw5UHaga8wz7rH
        g8NzGlAJ2Yxgevx1do6Pamc=
X-Google-Smtp-Source: APXvYqyoYQCWKoKWdLu5r6YJBhnjbMFluhE7WwC0zkxr5S/XJZx7rF/1doB+5h6mvKc491O+iPWtaw==
X-Received: by 2002:a5d:4382:: with SMTP id i2mr11785387wrq.387.1572191557046;
        Sun, 27 Oct 2019 08:52:37 -0700 (PDT)
Received: from localhost.localdomain ([109.126.132.16])
        by smtp.gmail.com with ESMTPSA id x205sm10424855wmb.5.2019.10.27.08.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2019 08:52:36 -0700 (PDT)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] io_uring: remove index from sqe_submit
Date:   Sun, 27 Oct 2019 18:52:20 +0300
Message-Id: <b92e51e7ee180f1e31bfef808d8e20535c921f46.1572191466.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

submit->index is used only for inbound check in submission path (i.e.
head < ctx->sq_entries). However, it always will be true, as
1. it's already validated by io_get_sqring()
2. ctx->sq_entries can't be changedd inbetween, because of held
ctx->uring_lock and ctx->refs.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 fs/io_uring.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 949faf14345e..710a0e8c1334 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -276,7 +276,6 @@ struct io_ring_ctx {
 struct sqe_submit {
 	const struct io_uring_sqe	*sqe;
 	struct file			*ring_file;
-	unsigned short			index;
 	bool				has_user : 1;
 	bool				in_async : 1;
 	bool				needs_fixed_file : 1;
@@ -2169,9 +2168,6 @@ static int __io_submit_sqe(struct io_ring_ctx *ctx, struct io_kiocb *req,
 
 	req->user_data = READ_ONCE(s->sqe->user_data);
 
-	if (unlikely(s->index >= ctx->sq_entries))
-		return -EINVAL;
-
 	opcode = READ_ONCE(s->sqe->opcode);
 	switch (opcode) {
 	case IORING_OP_NOP:
@@ -2625,7 +2621,6 @@ static bool io_get_sqring(struct io_ring_ctx *ctx, struct sqe_submit *s)
 	head = READ_ONCE(sq_array[head & ctx->sq_mask]);
 	if (head < ctx->sq_entries) {
 		s->ring_file = NULL;
-		s->index = head;
 		s->sqe = &ctx->sq_sqes[head];
 		s->sequence = ctx->cached_sq_head;
 		ctx->cached_sq_head++;
-- 
2.23.0

