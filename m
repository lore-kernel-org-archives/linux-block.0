Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FDD4C001B0
	for <linux-block@archiver.kernel.org>; Mon, 14 Aug 2023 21:59:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233162AbjHNV7H (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Aug 2023 17:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbjHNV6g (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Aug 2023 17:58:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD9210E5
        for <linux-block@vger.kernel.org>; Mon, 14 Aug 2023 14:58:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 45ECC65A16
        for <linux-block@vger.kernel.org>; Mon, 14 Aug 2023 21:58:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31705C433C7;
        Mon, 14 Aug 2023 21:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692050314;
        bh=ymy6RdxGwMayhneoy9gCSERho6u9L6JLtGW/P+dHFf8=;
        h=From:To:Cc:Subject:Date:From;
        b=gjc8l0b9hFAvVR4gIBNu1+rVC35abECcXduSiiBepPU5m7G+Ia3KtecZyo/SXRzdx
         XRqUoj/BWAxP1bVHmmtMl6rnVngEeVH5JkYQKKR8C2Yc29kKzGcTmt9/7ejjBUfC0K
         e2K8lwZE2zJXbWm972Xmc+kgt1v+g8FFkLLPnf53zZYpXg4DEhmXRv47m4+AZiFJQW
         UG2fUV5GfGrXsWj0CJfIiZR9ZxfvQMOZRFAG3CvgwLpGi3kNYhZza5yatqiX8hXp+8
         NU1NbBZAqDEu6PbuFpMlRDBlP6h8yjmPLtQmML8zC6Jzxx2pIjFN4tT9grTyyT5+Fx
         x1RepBBYLyA0Q==
From:   Damien Le Moal <dlemoal@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Cc:     Igor Pylypiv <ipylypiv@google.com>
Subject: [PATCH] block: uapi: Fix compilation errors using ioprio.h with C++
Date:   Tue, 15 Aug 2023 06:58:32 +0900
Message-ID: <20230814215833.259286-1-dlemoal@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The use of the "class" argument name in the ioprio_value() inline
function in include/uapi/linux/ioprio.h confuses C++ compilers
resulting in compilation errors such as:

/usr/include/linux/ioprio.h:110:43: error: expected primary-expression before ‘int’
  110 | static __always_inline __u16 ioprio_value(int class, int level, int hint)
      |                                           ^~~

for user C++ programs including linux/ioprio.h.

Avoid these errors by renaming the arguments of the ioprio_value()
function to prioclass, priolevel and priohint. For consistency, the
arguments of the IOPRIO_PRIO_VALUE() and IOPRIO_PRIO_VALUE_HINT() macros
are also renamed in the same manner.

Reported-by: Igor Pylypiv <ipylypiv@google.com>
Fixes: 01584c1e2337 ("scsi: block: Improve ioprio value validity checks")
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 include/uapi/linux/ioprio.h | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/include/uapi/linux/ioprio.h b/include/uapi/linux/ioprio.h
index 99440b2e8c35..bee2bdb0eedb 100644
--- a/include/uapi/linux/ioprio.h
+++ b/include/uapi/linux/ioprio.h
@@ -107,20 +107,21 @@ enum {
 /*
  * Return an I/O priority value based on a class, a level and a hint.
  */
-static __always_inline __u16 ioprio_value(int class, int level, int hint)
+static __always_inline __u16 ioprio_value(int prioclass, int priolevel,
+					  int priohint)
 {
-	if (IOPRIO_BAD_VALUE(class, IOPRIO_NR_CLASSES) ||
-	    IOPRIO_BAD_VALUE(level, IOPRIO_NR_LEVELS) ||
-	    IOPRIO_BAD_VALUE(hint, IOPRIO_NR_HINTS))
+	if (IOPRIO_BAD_VALUE(prioclass, IOPRIO_NR_CLASSES) ||
+	    IOPRIO_BAD_VALUE(priolevel, IOPRIO_NR_LEVELS) ||
+	    IOPRIO_BAD_VALUE(priohint, IOPRIO_NR_HINTS))
 		return IOPRIO_CLASS_INVALID << IOPRIO_CLASS_SHIFT;
 
-	return (class << IOPRIO_CLASS_SHIFT) |
-		(hint << IOPRIO_HINT_SHIFT) | level;
+	return (prioclass << IOPRIO_CLASS_SHIFT) |
+		(priohint << IOPRIO_HINT_SHIFT) | priolevel;
 }
 
-#define IOPRIO_PRIO_VALUE(class, level)			\
-	ioprio_value(class, level, IOPRIO_HINT_NONE)
-#define IOPRIO_PRIO_VALUE_HINT(class, level, hint)	\
-	ioprio_value(class, level, hint)
+#define IOPRIO_PRIO_VALUE(prioclass, priolevel)			\
+	ioprio_value(prioclass, priolevel, IOPRIO_HINT_NONE)
+#define IOPRIO_PRIO_VALUE_HINT(prioclass, priolevel, priohint)	\
+	ioprio_value(prioclass, priolevel, priohint)
 
 #endif /* _UAPI_LINUX_IOPRIO_H */
-- 
2.41.0

