Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E146C4320A
	for <linux-block@archiver.kernel.org>; Thu,  5 Aug 2021 17:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2FBC61104
	for <linux-block@archiver.kernel.org>; Thu,  5 Aug 2021 17:34:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232889AbhHERfJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 5 Aug 2021 13:35:09 -0400
Received: from mail-pj1-f41.google.com ([209.85.216.41]:54099 "EHLO
        mail-pj1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbhHERfJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 5 Aug 2021 13:35:09 -0400
Received: by mail-pj1-f41.google.com with SMTP id j1so10611035pjv.3
        for <linux-block@vger.kernel.org>; Thu, 05 Aug 2021 10:34:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LABzdpXyykPPOCHBzYOCe3SuIz8mmVvZVRxgU+IznSY=;
        b=sJOv3bxXbS4O0mZVE4lyt1++kQebZasEtQV5+NjfXfx9kBHUWAD0eH42hqhgYZ/Quo
         kEa3do+gjmN5awzkDKVwwdv2J3ddsizKK5JGYc9RqJ9ZOLZloYghf3i8KDYpS7j2Y1o6
         ebYkGH5hI8yEPN4rsKmxrA8Pc0xjjuWeoCgraA4a+DQxT3YSc2svx74x2PR8EHbkQXP4
         t6bVAcJdDxM3+bBAWt/pdrxrm5N86cqdxM/6/9DJKdkoaKCKpwpQINvPFpYQWrK7zYT/
         oDN/zB7Exy7w82qWJ2Klhx+uhihAYl2wXxblXOn1U6HYRyW6uDs6O+eDWUsXpTYsCeb1
         xl4A==
X-Gm-Message-State: AOAM530TWv2mMPue2Mb+COpRSKkmVm5Yw9WQG2lGJbaspBHJ1P/3sVc1
        idg9mtc25dZcfos06p3cBg8=
X-Google-Smtp-Source: ABdhPJyXRxm4u80ZT0rJY47soAPO8T0M4KYAD+cL8ZsoK4wCypQlemh+QCye6A4JXOHy2dBmynMpiQ==
X-Received: by 2002:a17:902:aa47:b029:12b:9f00:4fa9 with SMTP id c7-20020a170902aa47b029012b9f004fa9mr4904546plr.1.1628184894867;
        Thu, 05 Aug 2021 10:34:54 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:1:93c2:eaf5:530d:627d])
        by smtp.gmail.com with ESMTPSA id g6sm7486642pfh.111.2021.08.05.10.34.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 10:34:54 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH] block/partitions/ldm.c: Fix a kernel-doc warning
Date:   Thu,  5 Aug 2021 10:34:47 -0700
Message-Id: <20210805173447.3249906-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.32.0.605.g8dce9f2422-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Fix the following kernel-doc warning that appears when building with W=1:

block/partitions/ldm.c:31: warning: expecting prototype for ldm().
Prototype was for ldm_debug() instead

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/partitions/ldm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/partitions/ldm.c b/block/partitions/ldm.c
index cc86534c80ad..b8b518d7fb77 100644
--- a/block/partitions/ldm.c
+++ b/block/partitions/ldm.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
-/**
+/*
  * ldm - Support for Windows Logical Disk Manager (Dynamic Disks)
  *
  * Copyright (C) 2001,2002 Richard Russon <ldm@flatcap.org>
