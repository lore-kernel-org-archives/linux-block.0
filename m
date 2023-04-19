Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D55FC77B7A
	for <linux-block@archiver.kernel.org>; Wed, 19 Apr 2023 16:08:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233087AbjDSQIJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Apr 2023 12:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233038AbjDSQII (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Apr 2023 12:08:08 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5649D40C4
        for <linux-block@vger.kernel.org>; Wed, 19 Apr 2023 09:08:07 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1a6b17d6387so276755ad.0
        for <linux-block@vger.kernel.org>; Wed, 19 Apr 2023 09:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1681920486; x=1684512486;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QNBNMSl1jOPYogsKOmmzMd0l9YXo4Oz/6dQdAI0cTVA=;
        b=E5dJvb38qCe9GDaETkiEhAGJnDrvpkbqMNnIY3nxhtxj8YhkMhcO+bws/Iha9OGNEh
         2Bck9xdOzg0cS4YOuj4PmU1qChegI5UNQGN3mWURoc6zsB4Tj2jq5K8uAG+mqc2vbGrR
         NNy76dd9DD4+pE7i7fqFrUXxj9D9kCy7JfhbHMljoRmqVwqnc39e+eorQpMNIF0Bl2Os
         EgYI22cks0xiiO0Sql22sIh8PdGq/2BL1h2Y+cWNyvpUSTdy9ow3X46nsgDxoRluF0Zs
         0fUfrTG6TRxtRy55h3zcH/TstlDebppuayoVzVqN56cZrMKzNrT4F/24iWoZaNHE0aUb
         bW5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681920486; x=1684512486;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QNBNMSl1jOPYogsKOmmzMd0l9YXo4Oz/6dQdAI0cTVA=;
        b=NKBy6beMoB6JsuvK1mUsQ+Ctsc6ATE7YWWOKnIJNCDudTXzKZis6BS9ZqInvspJXYB
         McsTBUhsTyCZhkgNJem+NagpgFPymifH1zW5cLebkuIuBoCDcCv8rOTpApZeogkzsW1w
         Z/cB68BUVVyqaAP3gLvZgTgaqn8DuKJedga6U6bJ5XI90pPBZgwHJuyK7AFFiCtHgNYS
         oQIAOkI3PYpNdEWU4UEHXChQ93P+RO3seuaaX46lRhm/d5oE5w+/hQiM/qFLzVgVHCrM
         SNCLoC67Qx4vQ0QbPxUaxzoOY7/MvQEMfKTCWpx7Lc93nfOsQXc//CxJ8cCSYLMMXAS1
         3NOw==
X-Gm-Message-State: AAQBX9eskfQQAXMBkqqtjbnlS/dcOAVtvqMsKDgbHZpVkTE7oE28hf69
        VKl+POIDN+rV5dT2IXWTzCYajCvp+U+xHvcB3co=
X-Google-Smtp-Source: AKy350aYkvUhjF5+wFVi+nk10kObRNqXVR/Mp1xHXJ7qqFSDHfKlxBs1Bu3Of1cQuRvMET9BlVaaYQ==
X-Received: by 2002:a17:903:2308:b0:19a:a815:2877 with SMTP id d8-20020a170903230800b0019aa8152877mr22630722plh.6.1681920486589;
        Wed, 19 Apr 2023 09:08:06 -0700 (PDT)
Received: from localhost.localdomain ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id ik14-20020a17090b428e00b00246f9725ffcsm1566258pjb.33.2023.04.19.09.08.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 09:08:06 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     luhongfei@vivo.com, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4/6] Revert "io_uring: always go async for unsupported fadvise flags"
Date:   Wed, 19 Apr 2023 10:07:57 -0600
Message-Id: <20230419160759.568904-5-axboe@kernel.dk>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230419160759.568904-1-axboe@kernel.dk>
References: <20230419160759.568904-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This reverts commit c31cc60fddd11134031e7f9eb76812353cfaac84.

In preparation for handling this a bit differently, revert this
cleanup.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 io_uring/advise.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/io_uring/advise.c b/io_uring/advise.c
index 7085804c513c..cf600579bffe 100644
--- a/io_uring/advise.c
+++ b/io_uring/advise.c
@@ -62,18 +62,6 @@ int io_madvise(struct io_kiocb *req, unsigned int issue_flags)
 #endif
 }
 
-static bool io_fadvise_force_async(struct io_fadvise *fa)
-{
-	switch (fa->advice) {
-	case POSIX_FADV_NORMAL:
-	case POSIX_FADV_RANDOM:
-	case POSIX_FADV_SEQUENTIAL:
-		return false;
-	default:
-		return true;
-	}
-}
-
 int io_fadvise_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 {
 	struct io_fadvise *fa = io_kiocb_to_cmd(req, struct io_fadvise);
@@ -84,8 +72,6 @@ int io_fadvise_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 	fa->offset = READ_ONCE(sqe->off);
 	fa->len = READ_ONCE(sqe->len);
 	fa->advice = READ_ONCE(sqe->fadvise_advice);
-	if (io_fadvise_force_async(fa))
-		req->flags |= REQ_F_FORCE_ASYNC;
 	return 0;
 }
 
@@ -94,7 +80,16 @@ int io_fadvise(struct io_kiocb *req, unsigned int issue_flags)
 	struct io_fadvise *fa = io_kiocb_to_cmd(req, struct io_fadvise);
 	int ret;
 
-	WARN_ON_ONCE(issue_flags & IO_URING_F_NONBLOCK && io_fadvise_force_async(fa));
+	if (issue_flags & IO_URING_F_NONBLOCK) {
+		switch (fa->advice) {
+		case POSIX_FADV_NORMAL:
+		case POSIX_FADV_RANDOM:
+		case POSIX_FADV_SEQUENTIAL:
+			break;
+		default:
+			return -EAGAIN;
+		}
+	}
 
 	ret = vfs_fadvise(req->file, fa->offset, fa->len, fa->advice);
 	if (ret < 0)
-- 
2.39.2

