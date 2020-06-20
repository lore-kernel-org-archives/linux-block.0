Return-Path: <SRS0=essW=AB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0190CC433DF
	for <linux-block@archiver.kernel.org>; Sat, 20 Jun 2020 03:33:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D358E23372
	for <linux-block@archiver.kernel.org>; Sat, 20 Jun 2020 03:33:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="j8nQ3B7F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733041AbgFTDdu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 Jun 2020 23:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732845AbgFTDaY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 Jun 2020 23:30:24 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 800CAC0613EE
        for <linux-block@vger.kernel.org>; Fri, 19 Jun 2020 20:30:20 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id g12so4801527pll.10
        for <linux-block@vger.kernel.org>; Fri, 19 Jun 2020 20:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Fi8ab2CkfvIdd/5P+r0S5dxyJT2k4tSVWykkUvi99fU=;
        b=j8nQ3B7FpehCsunpSEVQSYjhSIMs22zucCRygwZBlcD7nkUj3GKDredCjm7jP++dYB
         i7TY+cL1cZ8JWvzIZIwoGoSA4hKFNbTalPofMuwWJS+BqEcADvjf61J9SbvMWxiL2Qla
         oIQyEGAM0IVcrPLyW1oKnN6H6KktioV1Ny5ps=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Fi8ab2CkfvIdd/5P+r0S5dxyJT2k4tSVWykkUvi99fU=;
        b=J1h/SpIkd88tEsKTdV96R+A8qyjhz/cmgri5BI3YSQraH1AoZAd+MbUBZ26cRJ5+Gr
         0LYDN5hQGXR8Mp4cKuYmrN9+Uvug9Gz93wBUNcsy6VqY3RwhOHjgqC30ny6l91G3SnMy
         JmeiTiMTjUwcVUpH9kMHpT7OX63T1AYomAbWxe7YpjSQpJKJa58ALcenKsYB5wIfYFt0
         sVYqLg0YhrKVJ3sG7zkj+Y+x93Zjnnxyefy9Bpguzh8WLLWQhk9zJH7JqvfbF0CpazDB
         A+JCBZNwEvOSBbj+LnPqKfwTQQ0bBVBlT0W3589mXEROfUH/u6RNE0N3bKGzPdAP2T3l
         CIgQ==
X-Gm-Message-State: AOAM531OxV33QhAdLzXK0lzZM5epN11W3mFSm5gVTVkbaO2nwN4PDuAo
        EKfN4RHse247AxYIa7HKg7Icfw==
X-Google-Smtp-Source: ABdhPJzKykKp69oTsLEAQ228A8aBga9uw6xzilqOJlYhvnET2ogoJrzcYkicI+7HggPAmmAR7pqRqg==
X-Received: by 2002:a17:90b:3614:: with SMTP id ml20mr6333214pjb.41.1592623820052;
        Fri, 19 Jun 2020 20:30:20 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p19sm7198155pff.116.2020.06.19.20.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2020 20:30:17 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Joe Perches <joe@perches.com>,
        Andy Whitcroft <apw@canonical.com>, x86@kernel.org,
        drbd-dev@lists.linbit.com, linux-block@vger.kernel.org,
        b43-dev@lists.infradead.org, netdev@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-wireless@vger.kernel.org,
        linux-ide@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-mm@kvack.org,
        clang-built-linux@googlegroups.com
Subject: [PATCH v2 01/16] docs: deprecated.rst: Add uninitialized_var()
Date:   Fri, 19 Jun 2020 20:29:52 -0700
Message-Id: <20200620033007.1444705-2-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200620033007.1444705-1-keescook@chromium.org>
References: <20200620033007.1444705-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Nothing should be using this macro, and the entire idea of tricking the
compiler into silencing such warnings is a mistake.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 Documentation/process/deprecated.rst | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/process/deprecated.rst b/Documentation/process/deprecated.rst
index 652e2aa02a66..943a926ecbbb 100644
--- a/Documentation/process/deprecated.rst
+++ b/Documentation/process/deprecated.rst
@@ -51,6 +51,24 @@ to make sure their systems do not continue running in the face of
 "unreachable" conditions. (For example, see commits like `this one
 <https://git.kernel.org/linus/d4689846881d160a4d12a514e991a740bcb5d65a>`_.)
 
+uninitialized_var()
+-------------------
+For any compiler warnings about uninitialized variables, just add
+an initializer. Using the uninitialized_var() macro (or similar
+warning-silencing tricks) is dangerous as it papers over `real bugs
+<https://lore.kernel.org/lkml/20200603174714.192027-1-glider@google.com/>`_
+(or can in the future), and suppresses unrelated compiler warnings
+(e.g. "unused variable"). If the compiler thinks it is uninitialized,
+either simply initialize the variable or make compiler changes. Keep in
+mind that in most cases, if an initialization is obviously redundant,
+the compiler's dead-store elimination pass will make sure there are no
+needless variable writes.
+
+As Linus has said, this macro
+`must <https://lore.kernel.org/lkml/CA+55aFw+Vbj0i=1TGqCR5vQkCzWJ0QxK6CernOU6eedsudAixw@mail.gmail.com/>`_
+`be <https://lore.kernel.org/lkml/CA+55aFwgbgqhbp1fkxvRKEpzyR5J8n1vKT1VZdz9knmPuXhOeg@mail.gmail.com/>`_
+`removed <https://lore.kernel.org/lkml/CA+55aFz2500WfbKXAx8s67wrm9=yVJu65TpLgN_ybYNv0VEOKA@mail.gmail.com/>`_.
+
 open-coded arithmetic in allocator arguments
 --------------------------------------------
 Dynamic size calculations (especially multiplication) should not be
-- 
2.25.1

