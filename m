Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEADCC04FE3
	for <linux-block@archiver.kernel.org>; Tue, 10 Aug 2021 05:16:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C800C60551
	for <linux-block@archiver.kernel.org>; Tue, 10 Aug 2021 05:16:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231620AbhHJFQa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 Aug 2021 01:16:30 -0400
Received: from mail-pl1-f179.google.com ([209.85.214.179]:37671 "EHLO
        mail-pl1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237545AbhHJFQa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Aug 2021 01:16:30 -0400
Received: by mail-pl1-f179.google.com with SMTP id j3so19404418plx.4;
        Mon, 09 Aug 2021 22:16:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BW62UdyAeP6Hxu4FI3jN0xK38DlYeFTwDBp1OLeZUcU=;
        b=n1bq4LB5F29B0vBq6RFLWoHxMaCh7WtpG/8dNdccqONOMXAACBf15rx1TqnYAKnVrd
         myTrYlaV8axEfNHhht9JIDvWdPxEQd8cDrVLgN+LvdTFNEskZcCekJ1nDry/aXZWWmx9
         JRtkUIh08D84zZEdjdX02wL2aSUnYZdRYX84H7F7KTr0ZreNEoDrKhx2iYJVGwvqdXNl
         p/2Xm/whumi2E/y7EdD4xc8vJMLHqoOzFmL+4Ni8d1J/lDZTSJahGb1AaGb+WW7nehit
         L3npuiGqHhN7LpfmByhiC8yhSDnjciwNeehO997VijxiYb2Au2sIv3TAqU6efDAn0lZ6
         NvbA==
X-Gm-Message-State: AOAM531ZnrPppHRhldECxPw+yLuopZcoNrfy71djIAwkhYCEPG5Mk8Ca
        +4wGa/ru2c0RQuL4FdK+H7M=
X-Google-Smtp-Source: ABdhPJynpmgaY91l+LqTU3DP/b+uovj3RNBtFYEKZkN3zAf1PFd9r87qxZ7mHnYFDLVf1Z6DHAL4Lg==
X-Received: by 2002:aa7:8503:0:b029:3bb:6253:345d with SMTP id v3-20020aa785030000b02903bb6253345dmr21079658pfn.35.1628572568306;
        Mon, 09 Aug 2021 22:16:08 -0700 (PDT)
Received: from localhost ([191.96.121.128])
        by smtp.gmail.com with ESMTPSA id b3sm22117996pfi.179.2021.08.09.22.16.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Aug 2021 22:16:07 -0700 (PDT)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     lucas.demarchi@intel.com, linux-modules@vger.kernel.org
Cc:     live-patching@vger.kernel.org, fstests@vger.kernel.org,
        linux-block@vger.kernel.org, hare@suse.de, dgilbert@interlog.com,
        jeyu@kernel.org, osandov@fb.com, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v2 1/3] libkmod: add a library notice log level print
Date:   Mon,  9 Aug 2021 22:16:00 -0700
Message-Id: <20210810051602.3067384-2-mcgrof@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210810051602.3067384-1-mcgrof@kernel.org>
References: <20210810051602.3067384-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When you use pass the -v argument to modprobe we bump
the log level from the default modprobe log level of
LOG_WARNING (4) to LOG_NOTICE (5), however the library
only has avaiable to print:

 #define DBG(ctx, arg...) kmod_log_cond(ctx, LOG_DEBUG, ## arg)
 #define INFO(ctx, arg...) kmod_log_cond(ctx, LOG_INFO, ## arg)
 #define ERR(ctx, arg...) kmod_log_cond(ctx, LOG_ERR, ## arg)

LOG_INFO (6) however is too high of a level for it to be
effective at printing anything when modprobe -v is passed.
And so the only way in which modprobe -v can trigger the
library to print a verbose message is to use ERR() but that
always prints something and we don't want that in some
situations.

We need to add a new log level macro which uses LOG_NOTICE (5)
for a "normal but significant condition" which users and developers
can use to look underneath the hood to confirm if a situation is
happening.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 libkmod/libkmod-internal.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/libkmod/libkmod-internal.h b/libkmod/libkmod-internal.h
index 398af9c..2e5e1bc 100644
--- a/libkmod/libkmod-internal.h
+++ b/libkmod/libkmod-internal.h
@@ -25,10 +25,12 @@ static _always_inline_ _printf_format_(2, 3) void
 #  else
 #    define DBG(ctx, arg...) kmod_log_null(ctx, ## arg)
 #  endif
+#  define NOTICE(ctx, arg...) kmod_log_cond(ctx, LOG_NOTICE, ## arg)
 #  define INFO(ctx, arg...) kmod_log_cond(ctx, LOG_INFO, ## arg)
 #  define ERR(ctx, arg...) kmod_log_cond(ctx, LOG_ERR, ## arg)
 #else
 #  define DBG(ctx, arg...) kmod_log_null(ctx, ## arg)
+#  define NOTICE(ctx, arg...) kmod_log_cond(ctx, LOG_NOTICE, ## arg)
 #  define INFO(ctx, arg...) kmod_log_null(ctx, ## arg)
 #  define ERR(ctx, arg...) kmod_log_null(ctx, ## arg)
 #endif
-- 
2.30.2

