Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CE50C4320A
	for <linux-block@archiver.kernel.org>; Wed, 18 Aug 2021 15:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87540610FA
	for <linux-block@archiver.kernel.org>; Wed, 18 Aug 2021 15:47:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236531AbhHRPsP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 18 Aug 2021 11:48:15 -0400
Received: from mail-lf1-f44.google.com ([209.85.167.44]:46887 "EHLO
        mail-lf1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240060AbhHRPsM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Aug 2021 11:48:12 -0400
Received: by mail-lf1-f44.google.com with SMTP id u22so5520954lfq.13;
        Wed, 18 Aug 2021 08:47:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dEDUliLc2qrFYYbpwGoL3AeOYmTJ041IXVBP+u79Zy0=;
        b=PuW+7NltJ0sMKCWza9vpojkwxQ7xAKZqOEMCq8/9MIfWL59rDm/9hZaiz3NG5awhXX
         wCK/AzD3J54KG3ReaufsfOoR82lyOKWllBNE4vH6j6ndYnv+lhFBePOu7+7cPE+O1rie
         7e/nD5hgrxjZFO54Pi/ywAMflvXwPCTEO8g2XneABwm3+ETDI0z0HIJfr/ZNHz6sGXSS
         R08bS+lirhuQK1B+9jpSgjPuhpDffP42RwjY/47XPeNfSmE+PZGDv8QyRz/xbaGLmGk1
         A065VXCji6SO7x2vBhraVJp5nYhGeBluT7DlUgaw8CrEezZOPUYRyuYl+kCJkWK9LLhC
         iwrw==
X-Gm-Message-State: AOAM532Nut5CHNHFPgvMKTrBfRMogcCg3WFiYR2uADk2XLqb3tiFBIN6
        PP4oQafZVy0qyj1dMxfKdH+9m7PhUeiMBaK4
X-Google-Smtp-Source: ABdhPJwtnKUf8dXunIBVcILoF/7iUwhJlN+CcBF7EUEtUNE8kE0EEYVLyZ36O8kFfcN2zSzuUFHoLQ==
X-Received: by 2002:ac2:4856:: with SMTP id 22mr5918526lfy.638.1629301653187;
        Wed, 18 Aug 2021 08:47:33 -0700 (PDT)
Received: from localhost.localdomain (broadband-188-32-236-56.ip.moscow.rt.ru. [188.32.236.56])
        by smtp.googlemail.com with ESMTPSA id j4sm23808ljh.120.2021.08.18.08.47.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 08:47:32 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     linux-kselftest@vger.kernel.org
Cc:     Denis Efremov <efremov@linux.com>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Jiri Kosina <jkosina@suse.cz>, Willy Tarreau <w@1wt.eu>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [RFC PATCH 2/5] gen_initramfs.sh: use absolute path for gen_init_cpio
Date:   Wed, 18 Aug 2021 18:46:43 +0300
Message-Id: <20210818154646.925351-3-efremov@linux.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210818154646.925351-1-efremov@linux.com>
References: <20210818154646.925351-1-efremov@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Use absolute path to call gen_init_cpio. This allows one
to use gen_initramfs.sh from any directory.

Cc: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Denis Efremov <efremov@linux.com>
---
 usr/gen_initramfs.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/usr/gen_initramfs.sh b/usr/gen_initramfs.sh
index 63476bb70b41..2e4a86181c79 100755
--- a/usr/gen_initramfs.sh
+++ b/usr/gen_initramfs.sh
@@ -244,4 +244,4 @@ if test -n "$KBUILD_BUILD_TIMESTAMP"; then
 		timestamp="-t $timestamp"
 	fi
 fi
-usr/gen_init_cpio $timestamp $cpio_list > $output
+"$(dirname "$0")"/gen_init_cpio $timestamp $cpio_list > $output
-- 
2.31.1

