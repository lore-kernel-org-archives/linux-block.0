Return-Path: <SRS0=ZVtD=YS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DFA2CA9EBC
	for <linux-block@archiver.kernel.org>; Fri, 25 Oct 2019 09:31:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 069ED21D71
	for <linux-block@archiver.kernel.org>; Fri, 25 Oct 2019 09:31:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hGAvYoL9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438630AbfJYJbr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 25 Oct 2019 05:31:47 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33378 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405781AbfJYJbr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Oct 2019 05:31:47 -0400
Received: by mail-wm1-f68.google.com with SMTP id 6so3855258wmf.0;
        Fri, 25 Oct 2019 02:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wwqcelQMPV3TFsQAotbZk75eULqBsmycuG/dLtg7Yog=;
        b=hGAvYoL9HlckdcxCq/B0lI4kZnv3IL9Q00dHXsLic5/VBaDL+t2P4VcKB4MJWa79jf
         XvVXXT2OMocS6fFDBneO2sBJwtVMiV3wB5QFB898Lo27wkalRISHJeRLvmdeoOSIMGWo
         nnlT6t1NjqdtNCe9B2b3cDhvBP6AVwHlhcPH2saIkSx6ACoIDTUHVE+MO6M2jiYas64p
         iDNBNDJWLVvK8M8MwLJ6eprJ8M4bRLn9H6979q9ugPE6ARKKlWvmUXG0UpCTcbJeAT7e
         rVjYsCdSk8xKQTt2OJ5/iYx2rFr33vMfMO8HpFWt4zkvtlm6mATOCO5xcZDNzAN+c+Rb
         n1Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wwqcelQMPV3TFsQAotbZk75eULqBsmycuG/dLtg7Yog=;
        b=J9v0SxkGb2r3m/hi28XhVbHxRaWdmD8UtT4D6w41TGwKEDVZDb88CkwefAbv60UFI2
         KSavfaq6UL4LrreTbuc5tdZGSzHoME2pitEdvD8gfl6Rk67T1Fy7TvLlxIrqxkJlNJqc
         jh0/Bq+I5TCBDtWIqC1fDJ9HCgGfE36xKZIU2Mv9K+dH/xr5ZZVWtZZnzjtiReivDDgR
         zWrlB3Ztg3dHV3zo9psgnG0AYLPTKabT9u4a9GqgDUFQg78ddCGov/eJk1pJS1/Xjq6O
         T6nIsMvkzeLBMb+D8rOTs+zGCzw+3GgQ0+e56gGvcIM57S2/5CdqU/+iFpVvLoavAkey
         9xNg==
X-Gm-Message-State: APjAAAX16w6NoicP9TnNzvZiH274Cncj7NYyofMUHufacuXYGbLHbH33
        bS90HggPQRQNX0mi2girGnU=
X-Google-Smtp-Source: APXvYqwNZP/V/RZ92ydEBeugcb4gGumsxf8/uGiAm1wVppKOsokzxxHDMYgBVw/2WfZiVtqepzrDIg==
X-Received: by 2002:a1c:10b:: with SMTP id 11mr2497983wmb.118.1571995905298;
        Fri, 25 Oct 2019 02:31:45 -0700 (PDT)
Received: from localhost.localdomain ([109.126.132.16])
        by smtp.gmail.com with ESMTPSA id l7sm2054551wro.17.2019.10.25.02.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2019 02:31:44 -0700 (PDT)
From:   "Pavel Begunkov (Silence)" <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH 1/3] io_uring: Fix corrupted user_data
Date:   Fri, 25 Oct 2019 12:31:29 +0300
Message-Id: <53e2b76c28b82c98973efca2126d71ecf62e3fdb.1571991701.git.asml.silence@gmail.com>
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

There is a bug, where failed linked requests are returned not with
specified @user_data, but with garbage from a kernel stack.

The reason is that io_fail_links() uses req->user_data, which is
uninitialised when called from io_queue_sqe() on fail path.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 fs/io_uring.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 1b46c72f8975..0e141d905a5b 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2448,6 +2448,8 @@ static void io_submit_sqe(struct io_ring_ctx *ctx, struct sqe_submit *s,
 		return;
 	}
 
+	req->user_data = s->sqe->user_data;
+
 	/*
 	 * If we already have a head request, queue this one for async
 	 * submittal once the head completes. If we don't have a head but
-- 
2.23.0

