Return-Path: <SRS0=FxMo=OH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07D42C43610
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 11:20:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C559F20832
	for <linux-block@archiver.kernel.org>; Wed, 28 Nov 2018 11:20:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="17KDu/J0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C559F20832
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=javigon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728000AbeK1WVp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Nov 2018 17:21:45 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:46208 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727678AbeK1WVo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Nov 2018 17:21:44 -0500
Received: by mail-ed1-f68.google.com with SMTP id o10so21705260edt.13
        for <linux-block@vger.kernel.org>; Wed, 28 Nov 2018 03:20:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zwp4X6Ypxw1nnLLxi/i3YFFpGyOD035ZsmbDeY8aCZc=;
        b=17KDu/J0u0hJoBMRI3TTWUW4C9LbCaRuP7V4FpoWiq1ZFU5/UVasRgH5Hkp0I/NCyC
         pkmC1QgIyIOEkKRE/PW+HL+GSpuAjtGP9PCiHqHHqqKTFel85nRL+IjXjFHNuzX1jFES
         JuCeDLQl2hWBqKxJAxqpS0WdQ6CI2H7sYdo434+8f/3Zh1Fn0VFrE/9l6CkvFbL5yfyR
         a7BD+ClixoBTwmTziDu0G01aj7xH2E4kFy2KnZ1+BaTQHpW9NGIHRgslIqaDFfSECXYj
         EUgpvQUpUkXMBoftDn+ZTWP9j+zFoY+YFRTTAe15ybTse+CdiCq1+oesfwA3eDR3u/hf
         m0Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zwp4X6Ypxw1nnLLxi/i3YFFpGyOD035ZsmbDeY8aCZc=;
        b=ZJ00rlFaBYQ5ICRajpJ5ISBRAqWd/0E312vccSW+/fvUQUQWzRjxgiurpuoKXyfefh
         JS/hr9Q3YQKEVWWLcC5yB3tKyregP/t0FRhdYcIXP10Jr/Xi8GS+hWgZ8nTfdRXqCuor
         n1nrqqDn9aDnHHAtrlvjjOhkgW2d2lfXGi5gU/kfYVy4cAbTZAb1RpP/tRxXAKgNcxhn
         xZQSQxT75xQhFLvhmHj0DFDxE9peOfrbo/kkZuP3PAehdPOYjNLilX+KncckBrukAA6D
         MZxqS8BlCKpUY9EhyBiGJZT1AbeuxO+zm/pJormRNz8kG11/0LulA0rFFmjhjGjNJ5tl
         vsow==
X-Gm-Message-State: AA+aEWa6NLjtVGgF5I9OsCju0EATD6+YCuMX747jtEXQkdTtWlknXwuw
        CXd6SQJDQDllQjqtp0tTNXtPbw==
X-Google-Smtp-Source: AFSGD/XE8XbWUvrERqWYygt27jzz5C5DIunRTWBGbMl8bQZrvJanZESibDpF784djgK4p9sW8vFZuQ==
X-Received: by 2002:a50:8ad6:: with SMTP id k22mr1546975edk.189.1543404024643;
        Wed, 28 Nov 2018 03:20:24 -0800 (PST)
Received: from ch-wrk-javier.cnexlabs.com (6164211-cl69.boa.fiberby.dk. [193.106.164.211])
        by smtp.gmail.com with ESMTPSA id z39sm1765504edb.81.2018.11.28.03.20.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 28 Nov 2018 03:20:24 -0800 (PST)
From:   "=?UTF-8?q?Javier=20Gonz=C3=A1lez?=" <javier@javigon.com>
X-Google-Original-From: =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
To:     mb@lightnvm.io
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@cnexlabs.com>
Subject: [PATCH] lightnvm: pblk: add comments wrt locking in recovery path
Date:   Wed, 28 Nov 2018 12:20:16 +0100
Message-Id: <1543404016-14902-1-git-send-email-javier@cnexlabs.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

pblk's recovery path is single threaded and therefore a number of
assumptions regarding concurrency can be made. To avoid confusion, make
this explicit with a couple of comments in the code.

Signed-off-by: Javier González <javier@cnexlabs.com>
---
 drivers/lightnvm/pblk-core.c     | 1 +
 drivers/lightnvm/pblk-recovery.c | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/drivers/lightnvm/pblk-core.c b/drivers/lightnvm/pblk-core.c
index 44c5dc046912..f1b411e7c7c9 100644
--- a/drivers/lightnvm/pblk-core.c
+++ b/drivers/lightnvm/pblk-core.c
@@ -1276,6 +1276,7 @@ static int pblk_line_prepare(struct pblk *pblk, struct pblk_line *line)
 	return 0;
 }
 
+/* Line allocations in the recovery path are always single threaded */
 int pblk_line_recov_alloc(struct pblk *pblk, struct pblk_line *line)
 {
 	struct pblk_line_mgmt *l_mg = &pblk->l_mg;
diff --git a/drivers/lightnvm/pblk-recovery.c b/drivers/lightnvm/pblk-recovery.c
index 416d9840544b..4c726506a831 100644
--- a/drivers/lightnvm/pblk-recovery.c
+++ b/drivers/lightnvm/pblk-recovery.c
@@ -13,6 +13,9 @@
  * General Public License for more details.
  *
  * pblk-recovery.c - pblk's recovery path
+ *
+ * The L2P recovery path is single threaded as the L2P table is updated in order
+ * following the line sequence ID.
  */
 
 #include "pblk.h"
-- 
2.7.4

