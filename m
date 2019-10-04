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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6722C4CED1
	for <linux-block@archiver.kernel.org>; Fri,  4 Oct 2019 08:25:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E685222C8
	for <linux-block@archiver.kernel.org>; Fri,  4 Oct 2019 08:25:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ReelzzAO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729462AbfJDIZ0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 4 Oct 2019 04:25:26 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38499 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728462AbfJDIZ0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 4 Oct 2019 04:25:26 -0400
Received: by mail-lj1-f194.google.com with SMTP id b20so5603065ljj.5;
        Fri, 04 Oct 2019 01:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OzdPwj1paj2i4ey/G9r5ww+KJ7CZQsPnyP1GnSZa7m0=;
        b=ReelzzAOspekrxwZdMb9F5gmm8wO5OAYe2KNKtKG9dsOU9u03kQtFkPQLrsBqy78VR
         0t9Lb6kezAXO4Q9xEVAEKNMKdVRsK0llRihoNhwhBIf2UHt4mXOG3ZgbUuENGaRE4KFH
         w+MRsKj+cSXGg6E34pyaEONSD12b3lN/y/bmSfg/bYmDB+c4DmBj92M8lNBfa+JRzkcp
         QQzbLkQQsaomPP+zRbg188eZeb1F47BelGPHHtBZ/hQhqDFSz/DFnZW1gYIxGt8alhG/
         L0KxAxU2+VRfBxOxwepBaK+lf8pAwPtqYF3nJ0SF1BlXvJyBtKgFpJVVXEMP0/yvvicd
         d7qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OzdPwj1paj2i4ey/G9r5ww+KJ7CZQsPnyP1GnSZa7m0=;
        b=k3HTlIPwufrJJaFphhcCrgmQThilwddg1W0zXcQNZRo6yCB2+gCboPGO5EvYXilKRK
         9rbEdoUYT0NOXI4sppnyFwl8eBYBDLO1UdBhkLRhZsdN0VO4V16xQy8/GzBcnR9aLi6H
         QuxD0F2O3GbrQMKrl10qc4xS/aCm6CXLiB49yHGbbSrrJjAsvmpR+ZAnZ0cMf5WLGayt
         6fVnZm9hkM/9nF64xComVQ1sDUJRqvHLjV2P016ITGRbZmhxoZOTV952G78rL2NGsFjT
         nn71zqiMPteWEi2uNfZiKKJQSWXdM6uU+i70yQI3RvGVHeZFZEOvVps+c6MkSs3RSCRG
         sROg==
X-Gm-Message-State: APjAAAUzlLRKx0/TvfNci3UO9C0NjfPOT8uZtWvL10k5IGLFsIc/dQW6
        KLgwffNRJH6xZYsNzLg7DIG/SeGL
X-Google-Smtp-Source: APXvYqzPlmAwgC1XqZT/EJzrUhHIpdCFSiHJbmGZPOe/mrv3+pM4Cf8HzJxeSLDupxA0A4Jbm5Gvew==
X-Received: by 2002:a2e:8ec1:: with SMTP id e1mr8890477ljl.14.1570177523994;
        Fri, 04 Oct 2019 01:25:23 -0700 (PDT)
Received: from localhost.localdomain (mm-61-74-122-178.mgts.dynamic.pppoe.byfly.by. [178.122.74.61])
        by smtp.gmail.com with ESMTPSA id q11sm1116765lje.52.2019.10.04.01.25.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2019 01:25:22 -0700 (PDT)
From:   "Pavel Begunkov (Silence)" <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH] io_uring: Fix reversed nonblock flag
Date:   Fri,  4 Oct 2019 11:25:17 +0300
Message-Id: <75be62996d115a3e2effa6753a6d803069131460.1570177340.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Pavel Begunkov <asml.silence@gmail.com>

io_queue_link_head() accepts @force_nonblock flag, but io_ring_submit()
passes something opposite.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 fs/io_uring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index c934f91c51e9..ffe66512ca07 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2761,7 +2761,7 @@ static int io_ring_submit(struct io_ring_ctx *ctx, unsigned int to_submit,
 
 	if (link)
 		io_queue_link_head(ctx, link, &link->submit, shadow_req,
-					block_for_last);
+					force_nonblock);
 	if (statep)
 		io_submit_state_end(statep);
 
-- 
2.23.0

