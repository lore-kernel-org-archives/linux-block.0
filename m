Return-Path: <SRS0=ZVtD=YS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7760CA9EA0
	for <linux-block@archiver.kernel.org>; Fri, 25 Oct 2019 09:31:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC67421D7F
	for <linux-block@archiver.kernel.org>; Fri, 25 Oct 2019 09:31:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q/bVBEeB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408835AbfJYJbv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 25 Oct 2019 05:31:51 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33669 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438658AbfJYJbv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Oct 2019 05:31:51 -0400
Received: by mail-wr1-f65.google.com with SMTP id s1so1525406wro.0;
        Fri, 25 Oct 2019 02:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=77A9mrU+GvtRghygf59d/zr0EDg/QRoehlw2HaK8WGw=;
        b=Q/bVBEeBy5tn//kvTzIw8xbzOxwDulRXcCUWsPpI8xQ6ggu0HmedYpLkER8xsKbfjV
         AFpOxBm+U+vwz+IIZpRK2UwME7D/Rp56Zi6J+MHzhnLufJMwYsinSvFdTL8fNS1Fiu8h
         ppc3Fke/XsQ5VDC/mYoNXf2OI5oWftNfG27SNvXdgRJu2uEpEOERnbLjEXun37HwOn2z
         il/O+0xNfYM8n+vgcQLtJWP1L/C3FhBbFlqMEQ/pFlSCra2R/C6JNJWjH0PKrcNRR7aq
         U+jvbZRK+/psfuBjSU+PgdVM1tfi5aBLh4hzualXLH5rggJjwbhe2JRr5LaboKvjwOnD
         28NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=77A9mrU+GvtRghygf59d/zr0EDg/QRoehlw2HaK8WGw=;
        b=tHo0r/1/HcHrKrowyzemEfv1kuRedSh2Rdine4jJ1gUx48t3MinA/ro50on/yAZEas
         p5Q/uHAZ83h8G1tH4OD1y3+aqZLIsmrsIlV1lhWcL7qLr/GtYokoU8TgdPLbZ448IEYZ
         7mhlJeAPi2koHEYFsjXgQffdLitP+B4xDX77C2OAp5Sn2FNFWPU9wftPqCmAR+ilnHH8
         yc1A1Q9/7SqCoD1zl9KWInB5IEW+FIpLKp/U7myq3S7OXqusYj5Q63ThNj23R0xToC3f
         UVJJcdxASjvX8kOswuc/K2s1pJ0FnPQWGHm9Xt8nWp8Vm40O1x+Z9tyPO0YIciCdxeHt
         m+dQ==
X-Gm-Message-State: APjAAAVfpn6Ijgb05dr2Hi/531FmeP/qD0o0eLbRJVzlx1rSqpQXIvnL
        0pKeGzlKGWvgdIB3+JKjQOo=
X-Google-Smtp-Source: APXvYqwrEopp9G/Q+1sxJJWFLmASvDAv315NCV9IEEkbnpTD+PMY12Z8Jo4hHk0tAxrx6iy/pjdIGg==
X-Received: by 2002:adf:ee03:: with SMTP id y3mr2026446wrn.116.1571995909648;
        Fri, 25 Oct 2019 02:31:49 -0700 (PDT)
Received: from localhost.localdomain ([109.126.132.16])
        by smtp.gmail.com with ESMTPSA id l7sm2054551wro.17.2019.10.25.02.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 02:31:49 -0700 (PDT)
From:   "Pavel Begunkov (Silence)" <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH 3/3] io_uring: Fix race for sqes with userspace
Date:   Fri, 25 Oct 2019 12:31:31 +0300
Message-Id: <cfb7206ba1ac48615fd705ac74fc2d554a0c5422.1571991701.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1571991701.git.asml.silence@gmail.com>
References: <cover.1571991701.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Pavel Begunkov <asml.silence@gmail.com>

io_ring_submit() finalises with
1. io_commit_sqring(), which releases sqes to the userspace
2. Then calls to io_queue_link_head(), accessing released head's sqe

Reorder them.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 fs/io_uring.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 949c82a40d16..32f6598ecae9 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2795,13 +2795,14 @@ static int io_ring_submit(struct io_ring_ctx *ctx, unsigned int to_submit)
 		submit++;
 		io_submit_sqe(ctx, &s, statep, &link);
 	}
-	io_commit_sqring(ctx);
 
 	if (link)
 		io_queue_link_head(ctx, link, &link->submit, shadow_req);
 	if (statep)
 		io_submit_state_end(statep);
 
+	io_commit_sqring(ctx);
+
 	return submit;
 }
 
-- 
2.23.0

