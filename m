Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF89EC2B9F4
	for <linux-block@archiver.kernel.org>; Fri, 18 Jun 2021 00:45:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD352613BA
	for <linux-block@archiver.kernel.org>; Fri, 18 Jun 2021 00:45:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233218AbhFRArP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Jun 2021 20:47:15 -0400
Received: from mail-pl1-f177.google.com ([209.85.214.177]:40735 "EHLO
        mail-pl1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232027AbhFRArO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Jun 2021 20:47:14 -0400
Received: by mail-pl1-f177.google.com with SMTP id m17so634481plx.7
        for <linux-block@vger.kernel.org>; Thu, 17 Jun 2021 17:45:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HFD4qg+WgnWfNvH7KLlSvTM461cF+t2pSBZn/xRUmw4=;
        b=mFmntLtQwUx1eetViHEGHzqyvgb8tR0XEXt8kCC5OQcrcEZHeGJW7lAKBCOv7e/yy1
         NawBK/7piWeEzmthGOjVQfhdPjS6s8QLkr4z53cNeCgMRy3glwR1v+6VwBK7iXXR+aaR
         6QUHKpspa71f4ARrhKpuKGFuLS6sKJjlQGO/gS3gYu4TjIpsitTsaCyth6m9MbdTbmG0
         ZXXxLrk/PEtYwNPU13Md0BdZYZCJ4LCnDwRA3UV6oLpkdLnyWjnaL7jJLf5S801lEvFO
         mkVVwBYDLYx/hma+lo5JQ4YJNwOiSpelMY9usFr9xm4RWm01+/TidJgOEVaEoIzRzo1M
         ZaHg==
X-Gm-Message-State: AOAM533aXEqeOQtRHxUXPRFvoQtrVXd0+D1fXAdxdmR+OHSl59cKuuUi
        Yg+cukB42eEUh975YpZFEjw=
X-Google-Smtp-Source: ABdhPJxwIHvDWzFEjk2j9YOISARsCpxcrRAj+hlzqGMO7dXUhobUrnkvnJgPGOlGdCRfi6sK2+ulmA==
X-Received: by 2002:a17:90b:3709:: with SMTP id mg9mr8111532pjb.47.1623977105140;
        Thu, 17 Jun 2021 17:45:05 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net (c-73-241-217-19.hsd1.ca.comcast.net. [73.241.217.19])
        by smtp.gmail.com with ESMTPSA id b10sm6215573pff.14.2021.06.17.17.45.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 17:45:04 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: [PATCH v3 01/16] block/Kconfig: Make the BLK_WBT and BLK_WBT_MQ entries consecutive
Date:   Thu, 17 Jun 2021 17:44:41 -0700
Message-Id: <20210618004456.7280-2-bvanassche@acm.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618004456.7280-1-bvanassche@acm.org>
References: <20210618004456.7280-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

These entries were consecutive at the time of their introduction but are no
longer consecutive. Make these again consecutive. Additionally, modify the
help text since it refers to blk-mq and since the legacy block layer has
been removed.

Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
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
