Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1443AC56201
	for <linux-block@archiver.kernel.org>; Thu, 19 Nov 2020 15:33:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F32B2222A
	for <linux-block@archiver.kernel.org>; Thu, 19 Nov 2020 15:33:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="StPY5tN5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbgKSPdH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 19 Nov 2020 10:33:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727513AbgKSPdG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 19 Nov 2020 10:33:06 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B54C0613D4;
        Thu, 19 Nov 2020 07:33:06 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id s25so8493207ejy.6;
        Thu, 19 Nov 2020 07:33:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=sFYsMGmOpK2x4QIviMW7uuidVMr9J7XluhnZW1l09Wk=;
        b=StPY5tN5VAfKv4uWxkdpEA8p5ZVTA1L+pQ9JhBSobscj5LrYtzPM8iiEw0Zj7DA6dO
         6/HjguHrscTyXFA8pM93ilRJBN69VX3ae7cXzYKZeYoA1MeaklpaOCWmDT8/dEkMIu8j
         satnwS2f402EMwRkLWTBdJpM7PY3cP6faAhitemb20r/MqL5dlU+jnlvp76J1OSVhcli
         oKAjKE2fzkrDVrq76bUHtkGpiSCCY8TNuM0qnW1jhgfdoOH5m1+RWOh41D8YvzFTi2NZ
         AyMcC7Tv744hnPrd2tFkGBah5U+yN36BzjehNuS0DIXdtjJPhAbFHOBmmkizq3nR2XKP
         HriQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sFYsMGmOpK2x4QIviMW7uuidVMr9J7XluhnZW1l09Wk=;
        b=lWufVpbwQz4zFs1YTzQeDUg4JmtMEVJMo5BnI3p4QP9Mj7JdwWV3Tv/ABfXQlZNC+l
         YsEy0P0TxZ6aUg6cjVvYuxhUYdjwU2y6u3z6Sy47HORON1+ZzyWOUDh91YMu/xnAVuoz
         rYhFiJjvj0rm/8rqIaQiXNq8qKGhyNtQufkcLm8CLZuIAzdbIeb+c4lOvn7J77/T4Pcd
         ACgfO2Jg/66DOzqcsUJx3OztUAiq/zZ//1ese/J11qfwpO9nz9MXjQIObksj0GYkhd4h
         hHfsYSMmwvbtQNVFSONcx2t/752TNbkmZRHJbFZBLazc19kZxvxDPzGm9vxTheobyV6V
         ZibQ==
X-Gm-Message-State: AOAM5324lgna4Z+PnO1UoK0hBf4svShxB3WemQHdjSpR3zpYH25yCwri
        /njUFTeMcDwbPXCDLHlIk6wrHHqToejk/w==
X-Google-Smtp-Source: ABdhPJwxuK0ZItBAQZ8zBn4p87medVgNiMcX4WT9XRG513M40yp5Q9zSbvoIIN9eN9RAkgOtQieZCg==
X-Received: by 2002:a17:906:e2c3:: with SMTP id gr3mr28209617ejb.471.1605799985120;
        Thu, 19 Nov 2020 07:33:05 -0800 (PST)
Received: from localhost.localdomain (host109-152-100-135.range109-152.btcentralplus.com. [109.152.100.135])
        by smtp.gmail.com with ESMTPSA id u7sm3595612ejf.83.2020.11.19.07.33.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2020 07:33:04 -0800 (PST)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] iov_iter: optimise iter type checking
Date:   Thu, 19 Nov 2020 15:29:43 +0000
Message-Id: <9bc27cb3ef6ab49b6b2ccee3db6613838aee17af.1605799583.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1605799583.git.asml.silence@gmail.com>
References: <cover.1605799583.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The problem here is that iov_iter_is_*() helpers check types for
equality, but all iterate_* helpers do bitwise ands. This confuses
a compiler, so even if some cases were handled separately with
iov_iter_is_*(), it can't eliminate and skip unreachable branches in
following iterate*().

E.g. iov_iter_npages() first handles bvecs and discards, but
iterate_all_kinds() still generate branches for them.

Making checks consistent solves that.

size lib/iov_iter.o
before:
   text    data     bss     dec     hex filename
  24409     805       0   25214    627e lib/iov_iter.o

after:
   text    data     bss     dec     hex filename
  23785     793       0   24578    6002 lib/iov_iter.o

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 include/linux/uio.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/uio.h b/include/linux/uio.h
index 72d88566694e..c5970b2d3307 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -57,27 +57,27 @@ static inline enum iter_type iov_iter_type(const struct iov_iter *i)
 
 static inline bool iter_is_iovec(const struct iov_iter *i)
 {
-	return iov_iter_type(i) == ITER_IOVEC;
+	return iov_iter_type(i) & ITER_IOVEC;
 }
 
 static inline bool iov_iter_is_kvec(const struct iov_iter *i)
 {
-	return iov_iter_type(i) == ITER_KVEC;
+	return iov_iter_type(i) & ITER_KVEC;
 }
 
 static inline bool iov_iter_is_bvec(const struct iov_iter *i)
 {
-	return iov_iter_type(i) == ITER_BVEC;
+	return iov_iter_type(i) & ITER_BVEC;
 }
 
 static inline bool iov_iter_is_pipe(const struct iov_iter *i)
 {
-	return iov_iter_type(i) == ITER_PIPE;
+	return iov_iter_type(i) & ITER_PIPE;
 }
 
 static inline bool iov_iter_is_discard(const struct iov_iter *i)
 {
-	return iov_iter_type(i) == ITER_DISCARD;
+	return iov_iter_type(i) & ITER_DISCARD;
 }
 
 static inline unsigned char iov_iter_rw(const struct iov_iter *i)
-- 
2.24.0

