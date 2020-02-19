Return-Path: <SRS0=ya0H=4H=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF56FC34047
	for <linux-block@archiver.kernel.org>; Wed, 19 Feb 2020 16:35:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B270724654
	for <linux-block@archiver.kernel.org>; Wed, 19 Feb 2020 16:35:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="IxS5D35P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbgBSQfb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Feb 2020 11:35:31 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39048 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726712AbgBSQfb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Feb 2020 11:35:31 -0500
Received: by mail-pf1-f196.google.com with SMTP id 84so317911pfy.6
        for <linux-block@vger.kernel.org>; Wed, 19 Feb 2020 08:35:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=we5icCwKH7wtzWPIKFMGX7T64gNUQ2rwppnXpkujsgc=;
        b=IxS5D35PUpZ4W/W31ACAmHqS3zXpV4fPjKTP0qt5vHjRmQ7ULld7JCJqEyV0megCWh
         V5GZ0KwVmyxbQdp2DdaFejehLEKOw79WA48wlkTsOgG6/JWPjM3lttecWoE/LuAIs47Y
         vMsW7/tS7tUErcbQGNOH0GgYwABxpZTHOC3O4dEX/rR9YCX3QiznBmtNdCC6uEuzeSSP
         wutfWn8NgKPjYNOZgs+wVagKI6ddJaWoaBq+R5NG5ZTm6PMWj19m0a0jh/Cm4d7V6V8I
         rryQ+pvrkIXryG9AH7UwTGAs/4djVgIfcqwPdN7oPoi7m4DuRjy44IPbvkH/lMhqRpMy
         txUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=we5icCwKH7wtzWPIKFMGX7T64gNUQ2rwppnXpkujsgc=;
        b=D6f9d8x2c2zDyg/wBhSGcHnoPR968tU5tbvK55vTuupaC7Slr1BU1SvfiO5fCIO9z2
         kX8UdVbSZBBUuyET51B/E1QF2RowR2a6GPji3LIY+yg7UWyaUmagIi6xO2cTZfW/PEy8
         Ie7d4gom7UOnBPSgL3rDQaXBbU71ZCnQl/Gt6lr1QiVbnC4ECwYecaq7ApfxFnEWGvyu
         qteTqMSSl/mpTAD13v2MzC2a3nqxk9faaNzwD7Z6YhoawP3X7X/nabKu9DkD4XjldHhQ
         QGm4756J8TTbR+NqNodwQEzKmxicc+A39Z4DKZSvP37TTfIm2VPRfpPX1Tt5Q07+HniA
         dcmg==
X-Gm-Message-State: APjAAAXT30HDEGPuvQtfEvT9M6v13VTXTdw+oHaLqbQC7xySQ68GOIii
        /+2kGrWyAKTnv0JgkrSUGTPtSw==
X-Google-Smtp-Source: APXvYqwSdsODu7zccpKrFxgdkqZ2V3Tz2ufXcP/EGIacggwu+HvE1k0rOH2EfuwurNPaMsFtl6GLfQ==
X-Received: by 2002:a63:4e63:: with SMTP id o35mr27453704pgl.279.1582130130574;
        Wed, 19 Feb 2020 08:35:30 -0800 (PST)
Received: from nb01257.pb.local ([240e:82:3:25f6:4c45:9495:5474:a6b5])
        by smtp.gmail.com with ESMTPSA id c10sm194921pgj.49.2020.02.19.08.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 08:35:29 -0800 (PST)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH] block: fix comment for blk_cloned_rq_check_limits
Date:   Wed, 19 Feb 2020 17:34:15 +0100
Message-Id: <20200219163415.7618-1-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Since the later description mentioned "checked against the new queue
limits", so make the change to avoid confusion.

Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
 block/blk-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 9019f6a7adf8..6d36c2ad40ba 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1202,7 +1202,7 @@ EXPORT_SYMBOL(submit_bio);
 
 /**
  * blk_cloned_rq_check_limits - Helper function to check a cloned request
- *                              for new the queue limits
+ *                              for the new queue limits
  * @q:  the queue
  * @rq: the request being checked
  *
-- 
2.17.1

