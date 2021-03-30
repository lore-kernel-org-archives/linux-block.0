Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 249D3C433DB
	for <linux-block@archiver.kernel.org>; Tue, 30 Mar 2021 07:38:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD66261989
	for <linux-block@archiver.kernel.org>; Tue, 30 Mar 2021 07:38:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbhC3HiF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Mar 2021 03:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbhC3Hh7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Mar 2021 03:37:59 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2EB7C061762
        for <linux-block@vger.kernel.org>; Tue, 30 Mar 2021 00:37:58 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id o19so17038869edc.3
        for <linux-block@vger.kernel.org>; Tue, 30 Mar 2021 00:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ddO9eelXvjBp3hvrJGg17PhlxijRjIk5UjXMC0YYOFM=;
        b=jKT6t/yf4qtgltTGURUNEFZsYi+lu48bhBGKiNHly3SYm+Ee6mkIW4X3+dL05VaLOk
         cKH/4NxlkWldAC9kYw/4D/b5SVUyzYQsfC0Q+VvG2ovmkiwwE0FwXJrRNHCZzBjMPbe8
         FXs7/nZi5BeNoWBGrSO83BR7zTh3UBU3Mz9O4xmr7pNW8Sox9w9U8PCMmTUF2QwW38O/
         mFSUWYXec4gqsq/ygKm9jbh6pVOjK8sWMBzYENRpuGA+JfiXY6Myu0bgOOqVp7EgsxOj
         aVDsMVC7Z4NC1kI/h8dv9UpaRXkGc1+cyt2FafBdOceE44qbcmamP092vW8gGHf13PIP
         A5JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ddO9eelXvjBp3hvrJGg17PhlxijRjIk5UjXMC0YYOFM=;
        b=FoHFELcgSURN/vQE93tppu8N/XAdj8JOxGJvz2HMonuYlQ4nF1m4BNABu8e+cErG1t
         mVCHd9tBAfLPxUen3pckhelnOm6BMoIevLkMBfUaMkh6AHJYDAa6uo+37REIWmt6Exz4
         1enjD3wdWRwiOamUp0gqwQphV90u00qny4wKxrvZG0TKkjGfNfH5mTS4YxkY+IXq6wxX
         AKNMnKL9b0Rj46uc3YbvdwAueiKtpH5OHmtZTfiQ0HDVo+gy0WoStUKkCHINxlqShOWO
         //q7AhGegMu2dqtpTNqJWWuaQojCdn2KvJxovs0ViVDCd8/jm+c/MI5TkgVGwkqWQ01r
         +bjA==
X-Gm-Message-State: AOAM530khOqiPfmR2kW0QzNnOJkIwRwbyzTGUH3KzwLBAnxu40Zycj1/
        iSzW8lRUZGfrQWjBk69dQsjP4IUY/CPY+A==
X-Google-Smtp-Source: ABdhPJz70EZtMwVkd1lYWF/r0W29te7WR+iv+zHt7RecJQPNBoj/dF2oEbql90MA9dQQ72zkzKQMYg==
X-Received: by 2002:a05:6402:30a2:: with SMTP id df2mr31823519edb.29.1617089877284;
        Tue, 30 Mar 2021 00:37:57 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aeee5.dynamic.kabel-deutschland.de. [95.90.238.229])
        by smtp.googlemail.com with ESMTPSA id a3sm9556180ejv.40.2021.03.30.00.37.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 00:37:56 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Md Haris Iqbal <haris.iqbal@cloud.ionos.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>
Subject: [PATCHv2 for-next 01/24] MAINTAINERS: Change maintainer for rnbd module
Date:   Tue, 30 Mar 2021 09:37:29 +0200
Message-Id: <20210330073752.1465613-2-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210330073752.1465613-1-gi-oh.kim@ionos.com>
References: <20210330073752.1465613-1-gi-oh.kim@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Danil Kipnis <danil.kipnis@cloud.ionos.com>

Danil steps down, Haris will take over.
Also update email address to ionos.com, the old
cloud.ionos.com will still work for some time.

Signed-off-by: Danil Kipnis <danil.kipnis@cloud.ionos.com>
Acked-by: Md Haris Iqbal <haris.iqbal@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index bf947775390c..723ba354dce6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15358,8 +15358,8 @@ N:	riscv
 K:	riscv
 
 RNBD BLOCK DRIVERS
-M:	Danil Kipnis <danil.kipnis@cloud.ionos.com>
-M:	Jack Wang <jinpu.wang@cloud.ionos.com>
+M:	Md. Haris Iqbal <haris.iqbal@ionos.com>
+M:	Jack Wang <jinpu.wang@ionos.com>
 L:	linux-block@vger.kernel.org
 S:	Maintained
 F:	drivers/block/rnbd/
-- 
2.25.1

