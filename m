Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B7ACC433ED
	for <linux-block@archiver.kernel.org>; Tue,  6 Apr 2021 07:07:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BFFB613C3
	for <linux-block@archiver.kernel.org>; Tue,  6 Apr 2021 07:07:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244150AbhDFHH3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Apr 2021 03:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244152AbhDFHH3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Apr 2021 03:07:29 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16131C061756
        for <linux-block@vger.kernel.org>; Tue,  6 Apr 2021 00:07:22 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id k8so7792331edn.6
        for <linux-block@vger.kernel.org>; Tue, 06 Apr 2021 00:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ddO9eelXvjBp3hvrJGg17PhlxijRjIk5UjXMC0YYOFM=;
        b=c776AqyHciC961n8389x5uwFIXlpdtuFOep0Blv2rAgADs717wvW60/aJHuhz4gliU
         mnfHQ0QP5hpV/mglBfeLzJQTkEjHpKnRVPYYw1rG2LacEhqC+AE9fZV5uE6pjzUlTRa0
         QUxZDZJPnjW+Dat5ZcYT++brRJYJtwUAg77Q9W9mgy1COVd2s1ekqbuETjTdXW5VGLEv
         BBDpIHWLMbd0+fLyMLfmN2+VN9R7/fsTmOaT6GmY9g1ARW2rAXDBEOqMNDUgNaC3Tx0u
         GHUCRcK+2B25TZDw2V556t1IxgMtxgMOmIdud2vkM8+5DOekqaa8T+gPn1uCWuZiKOo1
         QDRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ddO9eelXvjBp3hvrJGg17PhlxijRjIk5UjXMC0YYOFM=;
        b=mJnx/O62TiAdsmqeYQR9qARB0j8dl86OCmbetnr1vyFQDN5GorFuYQCz9UgRCPZSeH
         0AA6fH12sQ6B3jpqHX44NQtUQnELogBP1O0aGr34yYHAQmdj931cTW/neYQPNPOgoNq+
         eSbmlBOvbU6rIoPKk1Z5k0/Zq+kPAJZTIV/FE2ut33pPiGL/l9owN98ew8xAvHJHXMsL
         8qifD/twlv+lj0pyxwWoNnyeDPtfJIPE1r+jIPXA+rq4DofdoNO2XpQGG0N0+++4dYYg
         MCAMDi8FKJeNlMSP8nQyGS6AlpWxlL8YkJuGs5ulRAjTUTdfyMKMJ5ZawR+OklnV5I13
         G3rA==
X-Gm-Message-State: AOAM531klFeR6uAnwPw1eeMotijwAI9POmLbUhipro632dCvCQG6hIDV
        +rZlqbco3EGYHzkRAW+wrMSCfaE3wFcMMw==
X-Google-Smtp-Source: ABdhPJxewG8ZOSm4rvRtTvTmgNL4ESU4vDF2D/949Ode5vihmM0QEA5S/H9J10ozkFgqb71DfquMmA==
X-Received: by 2002:a05:6402:26c9:: with SMTP id x9mr35537139edd.322.1617692840711;
        Tue, 06 Apr 2021 00:07:20 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aeee5.dynamic.kabel-deutschland.de. [95.90.238.229])
        by smtp.googlemail.com with ESMTPSA id rh6sm3976566ejb.39.2021.04.06.00.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 00:07:20 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-block@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        bvanassche@acm.org, haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Md Haris Iqbal <haris.iqbal@cloud.ionos.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>
Subject: [PATCHv3 for-next 01/19] MAINTAINERS: Change maintainer for rnbd module
Date:   Tue,  6 Apr 2021 09:06:58 +0200
Message-Id: <20210406070716.168541-2-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210406070716.168541-1-gi-oh.kim@ionos.com>
References: <20210406070716.168541-1-gi-oh.kim@ionos.com>
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

