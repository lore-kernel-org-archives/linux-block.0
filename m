Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51C11EB64D9
	for <linux-block@archiver.kernel.org>; Thu,  6 Jul 2023 20:14:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232317AbjGFUOa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Jul 2023 16:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231636AbjGFUO3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Jul 2023 16:14:29 -0400
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B49C71BFF
        for <linux-block@vger.kernel.org>; Thu,  6 Jul 2023 13:14:28 -0700 (PDT)
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1b88e5b3834so5119155ad.3
        for <linux-block@vger.kernel.org>; Thu, 06 Jul 2023 13:14:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688674468; x=1691266468;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n57SPeezC/tK+OEHVThMjucwjn649VoKhBuNWpVqRYU=;
        b=PRonJV+H3wWqc2ehqkfSnhC+yvQVf6rK5WBW5UprI+axwNRpjDT99rm/oMioDotxWq
         75OaGJNV2/oiq6DRm6WqZ8EgeH9AySv2V9s8cnN+b9FLrr4ry05ZMTiWKO5UMaLtic5t
         WE/JzmUGPzQsKz1dgSr39qXXVm0CPDH6AP550/TOLuVHNOt5HkLAduyiZ1Igrq73ujch
         5RJI0dMH5yc7Pypr/BZDgLiCC9qpK2OECVjyV8Y5AigayorRluzihxwvLxkRvPee0stY
         KqgS2UReE3bh1Wune1iY4h2hrfF6douxs8r3r4w2ThxLv2s4i4FNIJp8nVxcL7iGarCh
         +dIQ==
X-Gm-Message-State: ABy/qLZHDdar9ZRa6wQC2nQdwy9RLH5p0Bdhot3Zk4yo994BqWbpLEP0
        jcePvvc43VXPDlMezHHaI5I=
X-Google-Smtp-Source: APBJJlEY0qTvE40n2UYNY9JRqRim6yf9SAoGCoO1L23iDgcY2CLOy8ps4VufPL70+7ECaNwOhRDUfw==
X-Received: by 2002:a17:902:d902:b0:1b3:cf98:a20b with SMTP id c2-20020a170902d90200b001b3cf98a20bmr1988234plz.54.1688674468013;
        Thu, 06 Jul 2023 13:14:28 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:a75c:9545:5328:a233])
        by smtp.gmail.com with ESMTPSA id i19-20020a170902eb5300b001b9be2e2b3esm208611pli.277.2023.07.06.13.14.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 13:14:27 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.de>,
        Damien Le Moal <dlemoal@kernel.org>,
        Shaun Tancheff <shaun.tancheff@seagate.com>,
        Damien Le Moal <damien.lemoal@hgst.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH] block: Fix a source code comment in include/uapi/linux/blkzoned.h
Date:   Thu,  6 Jul 2023 13:14:12 -0700
Message-ID: <20230706201422.3987341-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Fix the symbolic names for zone conditions in the blkzoned.h header
file.

Cc: Hannes Reinecke <hare@suse.de>
Cc: Damien Le Moal <dlemoal@kernel.org>
Fixes: 6a0cb1bc106f ("block: Implement support for zoned block devices")
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 include/uapi/linux/blkzoned.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/uapi/linux/blkzoned.h b/include/uapi/linux/blkzoned.h
index b80fcc9ea525..f85743ef6e7d 100644
--- a/include/uapi/linux/blkzoned.h
+++ b/include/uapi/linux/blkzoned.h
@@ -51,13 +51,13 @@ enum blk_zone_type {
  *
  * The Zone Condition state machine in the ZBC/ZAC standards maps the above
  * deinitions as:
- *   - ZC1: Empty         | BLK_ZONE_EMPTY
+ *   - ZC1: Empty         | BLK_ZONE_COND_EMPTY
  *   - ZC2: Implicit Open | BLK_ZONE_COND_IMP_OPEN
  *   - ZC3: Explicit Open | BLK_ZONE_COND_EXP_OPEN
- *   - ZC4: Closed        | BLK_ZONE_CLOSED
- *   - ZC5: Full          | BLK_ZONE_FULL
- *   - ZC6: Read Only     | BLK_ZONE_READONLY
- *   - ZC7: Offline       | BLK_ZONE_OFFLINE
+ *   - ZC4: Closed        | BLK_ZONE_COND_CLOSED
+ *   - ZC5: Full          | BLK_ZONE_COND_FULL
+ *   - ZC6: Read Only     | BLK_ZONE_COND_READONLY
+ *   - ZC7: Offline       | BLK_ZONE_COND_OFFLINE
  *
  * Conditions 0x5 to 0xC are reserved by the current ZBC/ZAC spec and should
  * be considered invalid.
