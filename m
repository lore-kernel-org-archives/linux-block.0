Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-24.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D4FBC4320A
	for <linux-block@archiver.kernel.org>; Tue, 27 Jul 2021 21:00:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FBA160FA0
	for <linux-block@archiver.kernel.org>; Tue, 27 Jul 2021 21:00:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233019AbhG0VA3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Jul 2021 17:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233564AbhG0U7f (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Jul 2021 16:59:35 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 661C7C0613D5
        for <linux-block@vger.kernel.org>; Tue, 27 Jul 2021 13:59:13 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id a4-20020a17090aa504b0290176a0d2b67aso6632913pjq.2
        for <linux-block@vger.kernel.org>; Tue, 27 Jul 2021 13:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VM7uWZbkUfYnHDd5ZNIAVnDbZvywZy43PN6h2gF7C7c=;
        b=oBkhd6x8PpRaO8QoO+UEqARpklYQ85EbQwaaqZSpUTzsIkrs1pGiuH526VcUurLUkS
         +gkvSbxFz3vGB1BF1YQeauyWi9ev8hnzhng3t5uiTcBEZberDOU2lSJPBM+aa6yDkfTe
         HmjxMNfk6GT/foIn5FNaX7+ENNmF5UhcQ22mM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VM7uWZbkUfYnHDd5ZNIAVnDbZvywZy43PN6h2gF7C7c=;
        b=LvCiXxqAtWM20X6zRuXzFFFHwA8irzsj95wi1Wxn/boBPsJCw8KoPheLhLOjJUPBe0
         8K0BTfokQeu4x13yhgQWUkdAszRuyY1YA9jftzHFvX+VH/Dxli+IH9eJLQz1m1xtdny2
         7q8xEkzjtd2SYSD0nVV/FGCV9oXl55gEgHs0POhMTQhFpFY1RwVOGZ2R4AFwp6CRh8E7
         U7Tzoxm9TDllTu6Y1g6aGVhYhmNWzR4uPUKSdTgonsH6wBUNK3JjCAKSgCt3Nc3sYu77
         wSIqc2JCzKaLplKpWKePd+3MjPvXwVujGPZtg7zjfUuyvJdvnSgq4JQIz7uZK8APlxuR
         7pNg==
X-Gm-Message-State: AOAM533SxsDQkcd9yJ0C9zHXY3I43Bh1/Y70hiIKiimf632br5YPM5KS
        KvsMrUDOw1epjfHeEVZVOUMaKg==
X-Google-Smtp-Source: ABdhPJzvwIujwX2h82eYkbdvoMbJ+ZJVnzoCXczVsCM4H67j0yiuDjVnUU+OKLLA11yr/7OVmcSq6g==
X-Received: by 2002:a63:b4d:: with SMTP id a13mr22272005pgl.404.1627419552873;
        Tue, 27 Jul 2021 13:59:12 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e23sm3796816pjt.8.2021.07.27.13.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 13:59:09 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-hardening@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Keith Packard <keithpac@amazon.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-staging@lists.linux.dev, linux-block@vger.kernel.org,
        linux-kbuild@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: [PATCH 28/64] compiler_types.h: Remove __compiletime_object_size()
Date:   Tue, 27 Jul 2021 13:58:19 -0700
Message-Id: <20210727205855.411487-29-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210727205855.411487-1-keescook@chromium.org>
References: <20210727205855.411487-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2278; h=from:subject; bh=26+UkQF9u4QR73rE2ugmnkAtGgRJVqdRH0gVQ+miGJI=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhAHOGx79zwuZNTkBGJbxUTLtc6LvVjffViSXdghqh ZCh8w1mJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYQBzhgAKCRCJcvTf3G3AJoOuD/ 9QhIBj8Ac1dYCQqsKDnl8+GV1Fmwz5NE+vrrmgysyx4iAIh5Hi9gSJVcciJHuWfxsYbsfjbgYy0kX1 fb3zQvUIkMQIB2igKikLexaw/u/aMZvCk9Z5omDCckYav5xDMDxop57SAnRwDmI5ma37g307rYAPXK 3MKhIW4uQWUEg9VD//gprsbS2OpIiwxkghySrauZU6lUWDXOFDxi3e7AnfeRnLBMm5P9R7uYb1c63i CCLVixc36sEWt5n1A3nVhugbXoR7XhzcCKsn6dHqVUwhOr0WC1NiDHg09PcpuJ/iyIKZftDHqUPqg6 5qiwdJ4fNBuagx0+hD1UYhVyC4D8uCcU5JbpSaMhqA5ruisKG07SgLC2mW64QD5KC1l5vxwssi27Ef 7z6+Z9XE9eAIUfHNMPoPePEDUngERmhsvmWGVOt9xejvTsuIr7a0dLku55mNRDgPOr3kKzwatg+19w b9l9CzMUNItXijvnyBQc/Vqy1SAb0lYpmUGz8MBzs95DcaaAGbaZmpWiUWaHQ5s823F8qG3r/1SSM/ zjI2/ycPgCzFufboCXRAyrLfLL7g8dxi7bDg8lAiPKcigIIGX0UbyaLeH8fulCViw1XPIwojOh5Gqh 6Oqz9uM0LoNmL8ecwuaSepH7hTO/bHW05UdooSY1mofMkUQTUBDoMmiCWncw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Since all compilers support __builtin_object_size(), and there is only
one user of __compiletime_object_size, remove it to avoid the needless
indirection. This lets Clang reason about check_copy_size() correctly.

Link: https://github.com/ClangBuiltLinux/linux/issues/1179
Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/compiler-gcc.h   | 2 --
 include/linux/compiler_types.h | 4 ----
 include/linux/thread_info.h    | 2 +-
 3 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index cb9217fc60af..01985821944b 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -41,8 +41,6 @@
 
 #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
 
-#define __compiletime_object_size(obj) __builtin_object_size(obj, 0)
-
 #define __compiletime_warning(message) __attribute__((__warning__(message)))
 #define __compiletime_error(message) __attribute__((__error__(message)))
 
diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index e4ea86fc584d..c43308b0a9a9 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -290,10 +290,6 @@ struct ftrace_likely_data {
 	(sizeof(t) == sizeof(char) || sizeof(t) == sizeof(short) || \
 	 sizeof(t) == sizeof(int) || sizeof(t) == sizeof(long))
 
-/* Compile time object size, -1 for unknown */
-#ifndef __compiletime_object_size
-# define __compiletime_object_size(obj) -1
-#endif
 #ifndef __compiletime_warning
 # define __compiletime_warning(message)
 #endif
diff --git a/include/linux/thread_info.h b/include/linux/thread_info.h
index 0999f6317978..ad0c4e041030 100644
--- a/include/linux/thread_info.h
+++ b/include/linux/thread_info.h
@@ -203,7 +203,7 @@ static inline void copy_overflow(int size, unsigned long count)
 static __always_inline __must_check bool
 check_copy_size(const void *addr, size_t bytes, bool is_source)
 {
-	int sz = __compiletime_object_size(addr);
+	int sz = __builtin_object_size(addr, 0);
 	if (unlikely(sz >= 0 && sz < bytes)) {
 		if (!__builtin_constant_p(bytes))
 			copy_overflow(sz, bytes);
-- 
2.30.2

