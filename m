Return-Path: <SRS0=XMJ3=U3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BA73C4321A
	for <linux-block@archiver.kernel.org>; Fri, 28 Jun 2019 20:07:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7794208CB
	for <linux-block@archiver.kernel.org>; Fri, 28 Jun 2019 20:07:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbfF1UH4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Jun 2019 16:07:56 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41589 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726809AbfF1UH4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Jun 2019 16:07:56 -0400
Received: by mail-pl1-f195.google.com with SMTP id m7so3819367pls.8
        for <linux-block@vger.kernel.org>; Fri, 28 Jun 2019 13:07:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BbPCld27i5b7rRPlkqpOl7AnJoTAFBIz3QGKk54uvC8=;
        b=LHRK2yFiaACvZgnk/OFTXKXdnD7taI/bA5RhVU5wgBNCooP/84ZbTcNnYXj8rxAcKz
         iQbxp3ANfds0VLdO7Tt3moC1e5slRaS14UeBlWYYB19WfAah9hTaM2TiXWlLJgbWyqRg
         GFYk2BLkPWL0jutDI9zulQO2Y1lEWvGXIo5vC1rWCQMjGWNiQmQJTRc+gHSTteeVuehE
         c0dnIjhWBpSpSd4eLqIHeazotsxDY/gVEpCRqsUwtOmEWyHOscSJRyfjW97ri6YqPLIO
         UhA5U07rHWJ/ag1sJ62PaJ95igUMOr+yBHIa8vC/oOTzvVttMbhqhrhfgJ2Lc4kJZ3AK
         yfsg==
X-Gm-Message-State: APjAAAWXIL7MKymJyW198ZMjBZUhQj+9iOXE/ywGgawRj6c6xXUa9XVH
        ERnrv6VlfN06ODfMUUK+DMn320Q71mU=
X-Google-Smtp-Source: APXvYqyBCQ0p0jyi/PIdlPv+Q/UfJVfgOJ6HvlrJKEPazO46COqn0jWsYnYPldjQxkgOHJI4deMKnQ==
X-Received: by 2002:a17:902:8b88:: with SMTP id ay8mr13276469plb.139.1561752475617;
        Fri, 28 Jun 2019 13:07:55 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id 65sm1186010pff.148.2019.06.28.13.07.54
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 28 Jun 2019 13:07:54 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 1/4] block, documentation: Fix wbt_lat_usec documentation
Date:   Fri, 28 Jun 2019 13:07:42 -0700
Message-Id: <20190628200745.206110-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
In-Reply-To: <20190628200745.206110-1-bvanassche@acm.org>
References: <20190628200745.206110-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Fix the spelling of the wbt_lat_usec sysfs attribute.

Fixes: 87760e5eef35 ("block: hook up writeback throttling") # v4.10.
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 Documentation/block/queue-sysfs.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/block/queue-sysfs.txt b/Documentation/block/queue-sysfs.txt
index 83b457e24bba..3eaf86806621 100644
--- a/Documentation/block/queue-sysfs.txt
+++ b/Documentation/block/queue-sysfs.txt
@@ -185,8 +185,8 @@ This is the number of bytes the device can write in a single write-same
 command.  A value of '0' means write-same is not supported by this
 device.
 
-wb_lat_usec (RW)
-----------------
+wbt_lat_usec (RW)
+-----------------
 If the device is registered for writeback throttling, then this file shows
 the target minimum read latency. If this latency is exceeded in a given
 window of time (see wb_window_usec), then the writeback throttling will start
-- 
2.22.0.410.gd8fdbe21b5-goog

