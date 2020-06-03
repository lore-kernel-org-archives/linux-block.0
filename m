Return-Path: <SRS0=EWxa=7Q=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7978CC433E0
	for <linux-block@archiver.kernel.org>; Wed,  3 Jun 2020 23:33:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 533682077D
	for <linux-block@archiver.kernel.org>; Wed,  3 Jun 2020 23:33:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YTEneSOL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgFCXdO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Jun 2020 19:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbgFCXcV (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 Jun 2020 19:32:21 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD65FC0085C2
        for <linux-block@vger.kernel.org>; Wed,  3 Jun 2020 16:32:18 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id m1so2703817pgk.1
        for <linux-block@vger.kernel.org>; Wed, 03 Jun 2020 16:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3Hqe0fSnXDR9BQhToHGwDvWeXmOn6wXlTM1ZNtQBNo0=;
        b=YTEneSOLG0G03VL7npO7bUdyovAOz/rWIhWyhFR63irmezy8TdYcAkK240HUiwVQWE
         l1+wS3Zsf9sMrntm2h4pD25VpYQ6IwLesvsppd1RMdvcr3jcMToX3FgASNyJIcm+17M+
         RgKR5xqROZSaXLSFW/JQA7YcOaR/t1jFVii4U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3Hqe0fSnXDR9BQhToHGwDvWeXmOn6wXlTM1ZNtQBNo0=;
        b=D97JOOA3vYLsgemAQnuit3yyO+ycmoRjmBFiSkoMHPhdvaUT5pCb6zCKtTrEIer70t
         OUHn83hvTXSuF9O0BJ53EILv+AYv7pxQGnI+s7lLCxbNRRolF+tUfGrcbg0I04+87nT4
         xe2M0qkl7oLeMdpDuY76HQgKOazTa3M2rBp20F+epB1fijtG6Jq8LTXgpGlWumxFZ8qa
         qbJ63FNBIEXpv+aZH9NqutEmCvx9kA/pHb95jGzuFC5xA6ryC/6NGoMY7lq0ALohf+qK
         7mcrBoljv6r4yXklzKB4e27KbU3FgJ0nsqUTTiQwZMA3pwQ0LbeFQeHJMKWg4x1Y0+Yc
         riCg==
X-Gm-Message-State: AOAM533EyGCT1Wvoxjejfso6IRB5ZMX1p+m6wOgd3LkZMELzroG5Phtd
        /1V357nCHIjGKksXJ1mPrucNZw==
X-Google-Smtp-Source: ABdhPJyfJH3U7PUxTmeWYwI+KnsyVJ3CXtEz238mctrUyUOZNrrAJx63byFxfj5FXVnOwJj3WTFGgg==
X-Received: by 2002:a65:41c8:: with SMTP id b8mr1632114pgq.265.1591227138290;
        Wed, 03 Jun 2020 16:32:18 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l3sm3402369pju.43.2020.06.03.16.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2020 16:32:16 -0700 (PDT)
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
        linux-wireless@vger.kernel.org, linux-ide@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-mm@kvack.org, clang-built-linux@googlegroups.com
Subject: [PATCH 05/10] ide: Remove uninitialized_var() usage
Date:   Wed,  3 Jun 2020 16:31:58 -0700
Message-Id: <20200603233203.1695403-6-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200603233203.1695403-1-keescook@chromium.org>
References: <20200603233203.1695403-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Using uninitialized_var() is dangerous as it papers over real bugs[1]
(or can in the future), and suppresses unrelated compiler warnings (e.g.
"unused variable"). If the compiler thinks it is uninitialized, either
simply initialize the variable or make compiler changes. As a precursor
to removing[2] this[3] macro[4], just remove this variable since it was
actually unused:

drivers/ide/ide-taskfile.c:232:34: warning: unused variable 'flags' [-Wunused-variable]
        unsigned long uninitialized_var(flags);
                                        ^

[1] https://lore.kernel.org/lkml/20200603174714.192027-1-glider@google.com/
[2] https://lore.kernel.org/lkml/CA+55aFw+Vbj0i=1TGqCR5vQkCzWJ0QxK6CernOU6eedsudAixw@mail.gmail.com/
[3] https://lore.kernel.org/lkml/CA+55aFwgbgqhbp1fkxvRKEpzyR5J8n1vKT1VZdz9knmPuXhOeg@mail.gmail.com/
[4] https://lore.kernel.org/lkml/CA+55aFz2500WfbKXAx8s67wrm9=yVJu65TpLgN_ybYNv0VEOKA@mail.gmail.com/

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/ide/ide-taskfile.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/ide/ide-taskfile.c b/drivers/ide/ide-taskfile.c
index aab6a10435b6..a26f85ab58a9 100644
--- a/drivers/ide/ide-taskfile.c
+++ b/drivers/ide/ide-taskfile.c
@@ -229,7 +229,6 @@ void ide_pio_bytes(ide_drive_t *drive, struct ide_cmd *cmd,
 	ide_hwif_t *hwif = drive->hwif;
 	struct scatterlist *sg = hwif->sg_table;
 	struct scatterlist *cursg = cmd->cursg;
-	unsigned long uninitialized_var(flags);
 	struct page *page;
 	unsigned int offset;
 	u8 *buf;
-- 
2.25.1

