Return-Path: <SRS0=xSfi=W4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67280C3A5A4
	for <linux-block@archiver.kernel.org>; Sun,  1 Sep 2019 23:28:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A09A21874
	for <linux-block@archiver.kernel.org>; Sun,  1 Sep 2019 23:28:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wp5HaRHA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729281AbfIAX2I (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 1 Sep 2019 19:28:08 -0400
Received: from mail-qt1-f178.google.com ([209.85.160.178]:42384 "EHLO
        mail-qt1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728942AbfIAX2H (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 1 Sep 2019 19:28:07 -0400
Received: by mail-qt1-f178.google.com with SMTP id t12so13869092qtp.9;
        Sun, 01 Sep 2019 16:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IOtx7l84MPXynmgXCYJf5E15TmATCvqG4rOFaFL2SA4=;
        b=Wp5HaRHASIHCODfUeLAAzOC23HItb1Go+WDhRgxvo4VWMTdSc2zBQEY6aq8oSAoruH
         aZPSuqNOKig3GZS9+4YM450qX2eO5hOCtEvarIwOmLhZ03JEo9FLYjmaMfksJl5EqKBl
         ynC2MW7W3YEm8KcjgUg3Tj7EXwpfRkDseICqtxFr1BRhvbKuJ0vFBKsITPke+UW8t6zm
         hwEU0jU5XGG6JQHwCDy/0P1zwgqqy1tB/VFv8LRMHx1r0m9nzdYRYTv/Vcear3WvvMiq
         mfgKBupzSIdAOCe/xe5gkJqJojUjvror7ruGFiN2s7NknxrDkl/pvLCUpIyIP4LBcK6r
         3c5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IOtx7l84MPXynmgXCYJf5E15TmATCvqG4rOFaFL2SA4=;
        b=TRn8jLZ5m9eGhWeLbheVT2A4b5C5PmolBzZA642Z6obwKpho3jAdrcR2/drIZaltq5
         UaxBIwhfdqFXt3UZGDPwCVDhr/FiGLNqHIDBFBifcH1vj1kRBqVJoNpc/4P91e+rB3bz
         BZi6++s6kCRqcdZ72KJeLY0PUFatcOec6dfdnsYHA+uOIvA2hCjlDotK9eBroagBUKbE
         B1nwrQTeO8cVurdg47O5Yb8IjjqqXwS1qipl/DfqLBWZaVE27Wcb8IcP5KBLDgLDjWf6
         JyAgg4r3rWs7X5nUEdDt7NKO0e/wRZ7QhFQ0AAhwInCSEEgcLTS2Pw2NZWm06oxAUYHE
         9Esw==
X-Gm-Message-State: APjAAAV37fLUTB3PJz6Urg1ftIcUVuE5A4+kQZuMTsEAqYXaZkTYH3EL
        WDylJXfH/8qiWaVRqj/Y5R1LvDYP
X-Google-Smtp-Source: APXvYqxSJJvNWHqjYbwQRrVBhgjY4bAmoxWOIEDSLYXPT1VgzriPGXorgeZ2Z/iPO01ADOFVga7XBw==
X-Received: by 2002:ac8:670a:: with SMTP id e10mr26209333qtp.244.1567380486717;
        Sun, 01 Sep 2019 16:28:06 -0700 (PDT)
Received: from localhost.localdomain (200.146.53.87.dynamic.dialup.gvt.net.br. [200.146.53.87])
        by smtp.gmail.com with ESMTPSA id p59sm5684085qtd.75.2019.09.01.16.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Sep 2019 16:28:06 -0700 (PDT)
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        axboe@kernel.dk
Cc:     Marcos Paulo de Souza <marcos.souza.org@gmail.com>,
        Hannes Reinecke <hare@suse.com>
Subject: [PATCH v2 3/4] Documenation: switching-sched: Remove notes about elevator argument
Date:   Sun,  1 Sep 2019 20:29:15 -0300
Message-Id: <20190901232916.4692-4-marcos.souza.org@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190901232916.4692-1-marcos.souza.org@gmail.com>
References: <20190828011930.29791-5-marcos.souza.org@gmail.com>
 <20190901232916.4692-1-marcos.souza.org@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This argument was ignored since blk-mq was set as default, so remove it
from documentation.

Signed-off-by: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Reviewed-by: Hannes Reinecke <hare@suse.com>
---
 Documentation/block/switching-sched.rst | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/Documentation/block/switching-sched.rst b/Documentation/block/switching-sched.rst
index 42042417380e..520f6b857544 100644
--- a/Documentation/block/switching-sched.rst
+++ b/Documentation/block/switching-sched.rst
@@ -2,10 +2,6 @@
 Switching Scheduler
 ===================
 
-To choose IO schedulers at boot time, use the argument 'elevator=deadline'.
-'noop' and 'cfq' (the default) are also available. IO schedulers are assigned
-globally at boot time only presently.
-
 Each io queue has a set of io scheduler tunables associated with it. These
 tunables control how the io scheduler works. You can find these entries
 in::
-- 
2.22.0

