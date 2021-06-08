Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11027C47082
	for <linux-block@archiver.kernel.org>; Tue,  8 Jun 2021 23:07:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E728461361
	for <linux-block@archiver.kernel.org>; Tue,  8 Jun 2021 23:07:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232208AbhFHXJU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Jun 2021 19:09:20 -0400
Received: from mail-pj1-f51.google.com ([209.85.216.51]:34329 "EHLO
        mail-pj1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234074AbhFHXJU (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Jun 2021 19:09:20 -0400
Received: by mail-pj1-f51.google.com with SMTP id g6-20020a17090adac6b029015d1a9a6f1aso2567232pjx.1
        for <linux-block@vger.kernel.org>; Tue, 08 Jun 2021 16:07:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1i84vOGYAYDqgpeOnmCS0aBbdkIOmIlw00w56H4OlYg=;
        b=Gsjn7qwYzhUjRowI7JSE4tTvdPvVw4je8gB2WKuvnKur8ARU53io+TR4gxmE1d5val
         VxHewR6YZKI1/e0IDTqstZO2kYNNa4JA2kRLhdrxIDBgFJuAlWMks6TBjZogzEemQVT8
         jnBWQwlWvytxuJyayTTMNj3RXbdzqpx8sJ2f8k6zNJdmgzm/ZJVw74cwC5SAfLUWVZFJ
         TwBEYUhjEuLgH8k50GO/uI+lJzEqb1SPB8FdHWpxXNdC4wZtmQ+mo1+Rr6N2ekXZ/1pF
         zKTEmdX7OO0g7yp/aTeIo1z9hJz9A7oFbcQTS8RbS64ffd/j45BWHns9lG5L2Qd9ou13
         z/Ng==
X-Gm-Message-State: AOAM530B2/Wf18aZArj5TjOGzcJZ/sIkA7s+78ubbllzTfgVQNyobZoJ
        IRrIo9gsHrXMMD8KsNMD5Cg=
X-Google-Smtp-Source: ABdhPJwIX/b1mR9cDzzb8ZAXoVrj/trqqlLItxMoBYdnudTjJjqCAqJm/aB25SNw7sLosQRp22IPKg==
X-Received: by 2002:a17:903:1c6:b029:113:2b74:56ad with SMTP id e6-20020a17090301c6b02901132b7456admr2426532plh.55.1623193632572;
        Tue, 08 Jun 2021 16:07:12 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id s21sm11395838pfw.57.2021.06.08.16.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 16:07:12 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: [PATCH 01/14] block/Kconfig: Make the BLK_WBT and BLK_WBT_MQ entries consecutive
Date:   Tue,  8 Jun 2021 16:06:50 -0700
Message-Id: <20210608230703.19510-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210608230703.19510-1-bvanassche@acm.org>
References: <20210608230703.19510-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

These entries were consecutive at the time of their introduction but are no
longer consecutive. Make these again consecutive. Additionally, modify the
help text since it refers to blk-mq and since the legacy block layer has
been removed.

Cc: Damien Le Moal <damien.lemoal@wdc.com>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: Himanshu Madhani <himanshu.madhani@oracle.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/Kconfig | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/block/Kconfig b/block/Kconfig
index a2297edfdde8..6685578b2a20 100644
--- a/block/Kconfig
+++ b/block/Kconfig
@@ -133,6 +133,13 @@ config BLK_WBT
 	dynamically on an algorithm loosely based on CoDel, factoring in
 	the realtime performance of the disk.
 
+config BLK_WBT_MQ
+	bool "Enable writeback throttling by default"
+	default y
+	depends on BLK_WBT
+	help
+	Enable writeback throttling by default for request-based block devices.
+
 config BLK_CGROUP_IOLATENCY
 	bool "Enable support for latency based cgroup IO protection"
 	depends on BLK_CGROUP=y
@@ -155,13 +162,6 @@ config BLK_CGROUP_IOCOST
 	distributes IO capacity between different groups based on
 	their share of the overall weight distribution.
 
-config BLK_WBT_MQ
-	bool "Multiqueue writeback throttling"
-	default y
-	depends on BLK_WBT
-	help
-	Enable writeback throttling by default on multiqueue devices.
-
 config BLK_DEBUG_FS
 	bool "Block layer debugging information in debugfs"
 	default y
