Return-Path: <SRS0=RDeE=T7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52C2EC28CC0
	for <linux-block@archiver.kernel.org>; Fri, 31 May 2019 00:01:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AC562597B
	for <linux-block@archiver.kernel.org>; Fri, 31 May 2019 00:01:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbfEaABH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 May 2019 20:01:07 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44745 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726372AbfEaABH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 May 2019 20:01:07 -0400
Received: by mail-pl1-f196.google.com with SMTP id c5so3196675pll.11
        for <linux-block@vger.kernel.org>; Thu, 30 May 2019 17:01:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pIGx/kPzD1UuzqJRC374QGxG0VTa+UTXUWjNfmuqFB8=;
        b=LfhiSaGyEBmYVmzybqb/fcm3sZI7xTt1pZ1aoZiCoOwZrORluoa+KngAkWa6s5LbgA
         oi4i8dujh4IYI2yWHu8jBPKVnn8DgPj58cbhioJ9wVmMyVy7S4/VjeZXIAaTbONfDQAu
         bnlIJFQ5BBOhFY7n5zoLW9Gbcas3ncPONuQwNWuZhxmQuCfmlaAPXM1JO+kr8EOui/Xt
         /WpQ9stCifmCcYYgK6pjP2lKk/54LRP2ctT7P4HZyPreQtd8iPZHKRrJheGrdvTmUm5y
         5PAUXHAwqiVHPBBgv607WluY0+iE6q6Y3ezpFyzm7T0ycxGcZHiOAI1CfnV+RRKn6kGj
         4XhA==
X-Gm-Message-State: APjAAAXzxhmfbO0BA4YiZGLIEdYrFMBONQ+cfDfGa97qFlaajmZQvQvw
        Icf2DrfYs6kSP4UD615mQFE=
X-Google-Smtp-Source: APXvYqxn3RER5XFmroyAtKs4ghp4IpcGz15IqC8sqxP80rrFQpfOs04n9i4BDxkamCp5jd+G95zdKg==
X-Received: by 2002:a17:902:b10f:: with SMTP id q15mr6207254plr.257.1559260866611;
        Thu, 30 May 2019 17:01:06 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id g8sm3539851pjp.17.2019.05.30.17.01.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 May 2019 17:01:05 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 5/8] block: Fix rq_qos_wait() kernel-doc header
Date:   Thu, 30 May 2019 17:00:50 -0700
Message-Id: <20190531000053.64053-6-bvanassche@acm.org>
X-Mailer: git-send-email 2.20.GIT
In-Reply-To: <20190531000053.64053-1-bvanassche@acm.org>
References: <20190531000053.64053-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add documentation for the @rqw argument and change " - " into ": ".

Fixes: 84f603246db9 ("block: add rq_qos_wait to rq_qos") # v5.0-rc1~52^2~140.
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-rq-qos.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/block/blk-rq-qos.c b/block/blk-rq-qos.c
index 3f55b56f24bc..659ccb8b693f 100644
--- a/block/blk-rq-qos.c
+++ b/block/blk-rq-qos.c
@@ -209,9 +209,10 @@ static int rq_qos_wake_function(struct wait_queue_entry *curr,
 
 /**
  * rq_qos_wait - throttle on a rqw if we need to
- * @private_data - caller provided specific data
- * @acquire_inflight_cb - inc the rqw->inflight counter if we can
- * @cleanup_cb - the callback to cleanup in case we race with a waker
+ * @rqw: rqw to throttle on
+ * @private_data: caller provided specific data
+ * @acquire_inflight_cb: inc the rqw->inflight counter if we can
+ * @cleanup_cb: the callback to cleanup in case we race with a waker
  *
  * This provides a uniform place for the rq_qos users to do their throttling.
  * Since you can end up with a lot of things sleeping at once, this manages the
-- 
2.22.0.rc1

