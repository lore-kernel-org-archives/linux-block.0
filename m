Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5166DC432BE
	for <linux-block@archiver.kernel.org>; Tue, 27 Jul 2021 21:08:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D0C960FC4
	for <linux-block@archiver.kernel.org>; Tue, 27 Jul 2021 21:08:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234342AbhG0VIr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Jul 2021 17:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233487AbhG0VIN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Jul 2021 17:08:13 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6703C0619C0
        for <linux-block@vger.kernel.org>; Tue, 27 Jul 2021 14:07:04 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id k4-20020a17090a5144b02901731c776526so6630474pjm.4
        for <linux-block@vger.kernel.org>; Tue, 27 Jul 2021 14:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3614TVaw9LF0d4ZTPxFRYVM1NwtwuaIqOAakzdvkIfc=;
        b=clV0Gq5oIj0iMf/0TjNaHBfl9gFowEEPRY6F12E4uHkupoBZLOBAOjcr6hanGqNJ/D
         Ou+0N0Rgv9rhpZQ75K6fWWlwQIAJeQwEbGM40/xLoMchxBkeod+sf82FLeOvb290o5QL
         mySzWEkrdI1XTTrAkdIJlo6oyBUo3Ktd4nSiw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3614TVaw9LF0d4ZTPxFRYVM1NwtwuaIqOAakzdvkIfc=;
        b=WOojYcgwgmitV3mkffteEeq5fMLGmAcFW9Hou5gbZH3GWX4lGkKhdxIjtqtuuSXXJN
         5QbW1cjSATEIDqSKrT29cnlz9CxAi5Yg86WvWxdwcL2ermAsU7r0ekTgBogtQUIQ5y4k
         gFMlCiXsyF+Xpcx6VgqMADhyvViPYooL2XvSPNvpz5QUxDmgtIuDFfm+IG/b2fToBTRT
         aq+iO/j4bBiE9zNoY5EOFgnv8dTPKy3+rcOLu5HFO5Bg7WN3qRk/DAkyT718FCX6XLTi
         sr97Bjllo3zGrwfBXqtOh8RnHjy5TQbpp/n4TXlYsYtB9uh7aTbKIi6bIY5SPF9YPexu
         kJeQ==
X-Gm-Message-State: AOAM532GZj5oHoQQYEhVpdjAO8ZAqRhsuENQPCyqbKYM6/AsUvaZC+ln
        gjdKOPOuYvgC38prQ9CV1icFEg==
X-Google-Smtp-Source: ABdhPJzheM2xvO7r2KOy5JsPyHkQ5gmU070FcB/CrWaIBKULL/3U7eU4WZmglR8JYkwU1AHc0DVlNQ==
X-Received: by 2002:aa7:9086:0:b029:39b:6377:17c1 with SMTP id i6-20020aa790860000b029039b637717c1mr9604180pfa.11.1627420024334;
        Tue, 27 Jul 2021 14:07:04 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b13sm4545729pfl.49.2021.07.27.14.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 14:07:02 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-hardening@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Keith Packard <keithpac@amazon.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-staging@lists.linux.dev, linux-block@vger.kernel.org,
        linux-kbuild@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: [PATCH 61/64] Makefile: Enable -Warray-bounds
Date:   Tue, 27 Jul 2021 13:58:52 -0700
Message-Id: <20210727205855.411487-62-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210727205855.411487-1-keescook@chromium.org>
References: <20210727205855.411487-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1002; h=from:subject; bh=iIOagZzyF2xdp8n7enwD6qkgQ1o9k/a7rFZX1PVnmxg=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhAHOOq3GxY9uHkpfXPpohPWhLzKrRlLl+w0yr5nG9 o51n+4eJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYQBzjgAKCRCJcvTf3G3AJhXFD/ 9eNQSeUQPuzmwtU/NaiBjngkDUoTXVXv6KDOoXdN0EeDJr9dzNsPU4RUC2Yb7oNKtodqx9qr3F53BT txNpJNl/VSlLBo4MV0T1xF/z3OZoiHCgrhEK6jQQWkJ8g9DbwYCORPaM3KmjKoReDaEVCdUqLLgRLI bgnGYGgyZ8hwan3FbBKFMQwKRDx8sMPqQJUlxpC/0p1LlB5klJYif9tuDWpKW1liKmjqsack/xN7n0 V/cjUuTEEPcy51sw8cSiGkQYLx3KXX0nBtDSFN2xWj3EOY9Bm2RgpOqUqsPFAyinaCqQ43AtocYK4G EWC3c+pF5KODB9bWmzxaiWfcbQnr/qmuRE0npmKCThCFAdIG0L/zSn17BagAoxn/bfs7o1XTo9UQ6L K2E4D3ANbhN9AYyDSrP3MqqguYb7FfMwTv2zQNOLIoHqk90Ys/REfQ6FbJ9b4n+s+hlR2hs9IoQ0+Y 3LfKCSZCrYfZ2rhefZPYVzbWfzbM2+wTL1DtshJ1M+gKFcPfZ663TaMLREqy9r9mTtgswUne36LhxD ZfCNhpXpDpbsenQfUmuciUrsKoatyitqkdd4dOEVsAVIZ7jI+dZ2TTRu6UgVdfpiRIdWgIUBmXNdyf QZyNNzVnUyr2dpmTN5/GnRpfSS+N/XiRxODtkuSEXrfjk1fZDATTwSfL3kKA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

With the recent fixes for flexible arrays and expanded FORTIFY_SOURCE
coverage, it is now possible to enable -Warray-bounds. Since both
GCC and Clang include -Warray-bounds in -Wall, we just need to stop
disabling it.

Co-developed-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Makefile b/Makefile
index 6f781a199624..77d01ba3d4e1 100644
--- a/Makefile
+++ b/Makefile
@@ -1089,7 +1089,6 @@ KBUILD_CFLAGS += $(call cc-disable-warning, stringop-truncation)
 
 # We'll want to enable this eventually, but it's not going away for 5.7 at least
 KBUILD_CFLAGS += $(call cc-disable-warning, zero-length-bounds)
-KBUILD_CFLAGS += $(call cc-disable-warning, array-bounds)
 KBUILD_CFLAGS += $(call cc-disable-warning, stringop-overflow)
 
 # Another good warning that we'll want to enable eventually
-- 
2.30.2

