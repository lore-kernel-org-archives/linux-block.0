Return-Path: <SRS0=9W5b=XZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A515C35280
	for <linux-block@archiver.kernel.org>; Mon, 30 Sep 2019 23:01:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A104206BB
	for <linux-block@archiver.kernel.org>; Mon, 30 Sep 2019 23:01:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728073AbfI3XBF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 30 Sep 2019 19:01:05 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44771 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726789AbfI3XBF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Sep 2019 19:01:05 -0400
Received: by mail-pg1-f193.google.com with SMTP id i14so8189098pgt.11
        for <linux-block@vger.kernel.org>; Mon, 30 Sep 2019 16:01:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zhEbudMbPtcbeSY/tmaL3JYTvyPttnYPu5OVMgOG1L0=;
        b=JDeO1XLneZ+q7NNtqfHyNwojA3xG6rrhNgy3s8cSCnF30XoHBOd7IthM1QhWFVv6iJ
         1zx3nGA+NvMeaZ6QwqgIn/GGlul11nac6ZFBYCOQ5wYY9V56kIsOm6SugLXcGsYg4woE
         5VY+k7xQp6Ssijc7TLSnVpgNbzQUGffBM0UlROlSdOHbjVZAjyDrAWm3G8iS8EvEeKot
         V7uVa0eiuPzIPQ5Hwr6evABtSUKGqNo1dOV7k2ROS91+/E+nFo0nE+kcBjXIYJHnNHOj
         aQpKbXUarft8O6F+z+1chdcaxUGeGttcH2LvHZXSwuG61rGx6816uX9YPQlmblvSxuHk
         kO9Q==
X-Gm-Message-State: APjAAAVugbHPVSEbkAJyJcFSbl4uP6cI+NxmLTtXnzeO/whTNt3NGCVZ
        YOu8/6b3tvn1mJpAKKOkCUIIG9UD
X-Google-Smtp-Source: APXvYqzoSrniWqooNuHouuGpJ+Nd/F0NWSshGaTK3EMvZLM961cdnRWM3JH4ngSmzZKitE+jL14krg==
X-Received: by 2002:aa7:998d:: with SMTP id k13mr24369807pfh.134.1569884464672;
        Mon, 30 Sep 2019 16:01:04 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id 74sm15071747pfy.78.2019.09.30.16.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2019 16:01:03 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@infradead.org>,
        Ming Lei <ming.lei@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH 7/8] null_blk: Improve nullb_device_##NAME##_store() readability
Date:   Mon, 30 Sep 2019 16:00:46 -0700
Message-Id: <20190930230047.44113-8-bvanassche@acm.org>
X-Mailer: git-send-email 2.23.0.444.g18eeb5a265-goog
In-Reply-To: <20190930230047.44113-1-bvanassche@acm.org>
References: <20190930230047.44113-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Introduce a local variable to make the code easier to read. This patch
does not change any functionality but makes the next patch in this
series easier to read.

Cc: Christoph Hellwig <hch@infradead.org>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/block/null_blk_main.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.c
index 0e7da5015ccd..f5747cfd806f 100644
--- a/drivers/block/null_blk_main.c
+++ b/drivers/block/null_blk_main.c
@@ -274,10 +274,11 @@ static ssize_t									\
 nullb_device_##NAME##_store(struct config_item *item, const char *page,		\
 			    size_t count)					\
 {										\
-	if (test_bit(NULLB_DEV_FL_CONFIGURED, &to_nullb_device(item)->flags))	\
+	struct nullb_device *dev = to_nullb_device(item);			\
+										\
+	if (test_bit(NULLB_DEV_FL_CONFIGURED, &dev->flags))			\
 		return -EBUSY;							\
-	return nullb_device_##TYPE##_attr_store(				\
-			&to_nullb_device(item)->NAME, page, count);		\
+	return nullb_device_##TYPE##_attr_store(&dev->NAME, page, count);	\
 }										\
 CONFIGFS_ATTR(nullb_device_, NAME);
 
-- 
2.23.0.444.g18eeb5a265-goog

