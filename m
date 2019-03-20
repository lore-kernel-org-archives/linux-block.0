Return-Path: <SRS0=ireV=RX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 165E8C43381
	for <linux-block@archiver.kernel.org>; Wed, 20 Mar 2019 20:15:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E70AC218A2
	for <linux-block@archiver.kernel.org>; Wed, 20 Mar 2019 20:15:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbfCTUPI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Mar 2019 16:15:08 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41808 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbfCTUPI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Mar 2019 16:15:08 -0400
Received: by mail-pf1-f196.google.com with SMTP id d25so2702275pfn.8
        for <linux-block@vger.kernel.org>; Wed, 20 Mar 2019 13:15:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PBr9JQsijSEgbmcFXvVnHlK/O1mbMgcP30YAv593lmg=;
        b=sVpcujTTJg5iCuDVcME5g/OrdnGXifBrb8coM4cnkPg/uoaX6YzDiBFkpjLo3iBU5e
         YGFzCT3vjf5wq9Tu0HpmlJTzSamiO6dru97ivtA/BSPEA5Px3vBciZEg8WHi7ovKxEbU
         VA9DbfJ8AVV+LD97RaFdvroIRip9KmXdb2Ax9q9dzyOIa8H7bVggSfLHKOGsz5DXhNJh
         KwQKTGYsocvuN8hqJBy9ee/XMerYdskdn8yEanW3dAPrrL0APvR0stY1/Gh8Hrun2bCG
         ULHW9OQum0UN+iQ3hcWvLCsYfp7BVR9qgdyH8pCEQ9gO/I/B21VGCAF7IuKoBRZVELaL
         soEg==
X-Gm-Message-State: APjAAAWM0uOYVSAyVrDj5pOfPJvKTca0/zFM4t6YCFI5VV6ZVkOZ9yl4
        lvnmSJwMOqjq5EU1LwdGTag=
X-Google-Smtp-Source: APXvYqycQLcRjqsrr8b/Fs1lYFqPbUzxm+4B42XAddWrkDmuEaLKhA28QEEQ1VU+zq7KBIeWA9my1Q==
X-Received: by 2002:a65:4648:: with SMTP id k8mr9456299pgr.44.1553112907321;
        Wed, 20 Mar 2019 13:15:07 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:203:5cdc:422c:7b28:ebb5])
        by smtp.gmail.com with ESMTPSA id m69sm6312735pfi.151.2019.03.20.13.15.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 13:15:06 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Josef Bacik <jbacik@fb.com>
Subject: [PATCH] blk-iolatency: #include "blk.h"
Date:   Wed, 20 Mar 2019 13:15:01 -0700
Message-Id: <20190320201501.36751-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.20.GIT
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch avoids that the following warning is reported when building
with W=1:

block/blk-iolatency.c:734:5: warning: no previous prototype for 'blk_iolatency_init' [-Wmissing-prototypes]

Cc: Josef Bacik <jbacik@fb.com>
Fixes: d70675121546 ("block: introduce blk-iolatency io controller") # v4.19
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-iolatency.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
index 2620baa1f699..507212d75ee2 100644
--- a/block/blk-iolatency.c
+++ b/block/blk-iolatency.c
@@ -75,6 +75,7 @@
 #include <linux/blk-mq.h>
 #include "blk-rq-qos.h"
 #include "blk-stat.h"
+#include "blk.h"
 
 #define DEFAULT_SCALE_COOKIE 1000000U
 
-- 
2.21.0.155.ge902e9bcae20

