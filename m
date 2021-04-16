Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DACFC433B4
	for <linux-block@archiver.kernel.org>; Fri, 16 Apr 2021 08:35:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4547C61166
	for <linux-block@archiver.kernel.org>; Fri, 16 Apr 2021 08:35:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240513AbhDPIgM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Apr 2021 04:36:12 -0400
Received: from mail-qt1-f180.google.com ([209.85.160.180]:46725 "EHLO
        mail-qt1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240500AbhDPIgL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Apr 2021 04:36:11 -0400
Received: by mail-qt1-f180.google.com with SMTP id d6so1973078qtx.13;
        Fri, 16 Apr 2021 01:35:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DXu78L1cWa3O40BlxHBypy2EDCIHUvn4ujVswlz20VI=;
        b=EjJFyQJ9oxWiw+2qNf7HZfImIc4SLSDSlyG4j528th4CdufdvCT9Bi/wAzXklmr7lY
         84mjfMM0AYk/IMat0Qv/UwFY30rOLihYEzT34fA5LwFX5oF+gEewK5SbhYfiZxn4QM2B
         HN29gyfYHHhybxVdHQrXJiPREUvEWxEb+rnE0L1yn5Blc/sJwS4TfoeT4IpDDSN1qXmG
         wKZAYFt7jMmNq4fsfpCL8jXRfT+qSQuIOYtEIY+WSZknCc/FvqAIij0j6Z01AQ3a56eC
         cIwRD2qTnkUdwIYV0Rr+rHncwwhJm6JXJ6Dx0Pd/OR8f0840Z6qAkIEautl/kt+sswQI
         pvHQ==
X-Gm-Message-State: AOAM533H1oYilk7dRZhaJMRNcWXSzvWOyE574pvJLHJLUea3vlcrsauk
        ttOo7QNdV/oewuPfSWbEOngIn2NCXiW4bQ==
X-Google-Smtp-Source: ABdhPJzqIpQ2leik764+IfGqMOAd+ma6XX7Ib4BJS+Ow4/ke/cXs5QjDWaLsxMOVD+F1T6msW49eZQ==
X-Received: by 2002:ac8:594d:: with SMTP id 13mr6940953qtz.151.1618562145427;
        Fri, 16 Apr 2021 01:35:45 -0700 (PDT)
Received: from black.ru.oracle.com (broadband-188-32-236-56.ip.moscow.rt.ru. [188.32.236.56])
        by smtp.googlemail.com with ESMTPSA id k17sm3363778qtp.26.2021.04.16.01.35.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Apr 2021 01:35:45 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     linux-block@vger.kernel.org
Cc:     Denis Efremov <efremov@linux.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] floppy: cleanups: remove FLOPPY_SILENT_DCL_CLEAR undef
Date:   Fri, 16 Apr 2021 11:34:49 +0300
Message-Id: <20210416083449.72700-6-efremov@linux.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210416083449.72700-1-efremov@linux.com>
References: <20210416083449.72700-1-efremov@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

FLOPPY_SILENT_DCL_CLEAR is not defined anywhere and comes from pre-git
era. Just drop this undef. There is FD_SILENT_DCL_CLEAR which is really
used.

Signed-off-by: Denis Efremov <efremov@linux.com>
---
 drivers/block/floppy.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index c584657bacab..678ea45f2388 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -145,8 +145,6 @@
  * Better audit of register_blkdev.
  */
 
-#undef  FLOPPY_SILENT_DCL_CLEAR
-
 #define REALLY_SLOW_IO
 
 #define DEBUGT 2
-- 
2.30.2

