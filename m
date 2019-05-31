Return-Path: <SRS0=RDeE=T7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96B37C28CC0
	for <linux-block@archiver.kernel.org>; Fri, 31 May 2019 00:01:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A8D225972
	for <linux-block@archiver.kernel.org>; Fri, 31 May 2019 00:01:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbfEaABE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 May 2019 20:01:04 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44460 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726372AbfEaABE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 May 2019 20:01:04 -0400
Received: by mail-pf1-f193.google.com with SMTP id c9so1708786pfc.11
        for <linux-block@vger.kernel.org>; Thu, 30 May 2019 17:01:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jCjDZsVjBZxQ6kJ1PIfBWI62jvhoKBpe4unwu7E80yo=;
        b=Y2Xw2KCy3sIZhVzpY0etmj10DEjqDoYQV28Gb9KxZ9Fxl1k7MBzXA5b35d1oQd9JUP
         GPEazAXRRsVjMGjPtX0n6/ERCK5ydrwlfp7Dt+HQu+CDy1ecEnJH7DI0YRZMMaxyGs22
         lmuNtc+JhjIgU8maoVsLcB+5fWImUsrLp5trlFnLyWq2MSky7IqnHhD+T+5ViA6l0vQk
         ELMcuQvJGeChqz8H8EXD3nq9EzO838RXyzvvla5kucC2ifa0sOdv6KCcXvYSQdUYY/Cu
         K79G2cZkiAqp+ClTTKExE/mXz2j3STWWWAsnKzVTbEzCkOdEgTT9/OMcsMM5gBRHmv1c
         60wg==
X-Gm-Message-State: APjAAAVf7qqvlu7c+wL78Xl84KlFllK1lrsTVDn6ORir4MQ/moAQrfI9
        L00bGvQ4EEUpFFaMpRGElYdaWfFj
X-Google-Smtp-Source: APXvYqypPqkIifh5Nnyud85OTTvr6YED5ixndi2nofSS9t2KUye9yha0UH9QYbRattOnSn5Dtjzj6w==
X-Received: by 2002:a63:4c54:: with SMTP id m20mr6058764pgl.316.1559260863956;
        Thu, 30 May 2019 17:01:03 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id g8sm3539851pjp.17.2019.05.30.17.01.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 May 2019 17:01:03 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH 3/8] block: Fix throtl_pending_timer_fn() kernel-doc header
Date:   Thu, 30 May 2019 17:00:48 -0700
Message-Id: <20190531000053.64053-4-bvanassche@acm.org>
X-Mailer: git-send-email 2.20.GIT
In-Reply-To: <20190531000053.64053-1-bvanassche@acm.org>
References: <20190531000053.64053-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Commit e99e88a9d2b0 renamed a function argument without updating the
corresponding kernel-doc header. Update the kernel-doc header.

Cc: Kees Cook <keescook@chromium.org>
Fixes: e99e88a9d2b0 ("treewide: setup_timer() -> timer_setup()") # v4.15.
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/blk-throttle.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 1b97a73d2fb1..9ea7c0ecad10 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -1220,7 +1220,7 @@ static bool throtl_can_upgrade(struct throtl_data *td,
 	struct throtl_grp *this_tg);
 /**
  * throtl_pending_timer_fn - timer function for service_queue->pending_timer
- * @arg: the throtl_service_queue being serviced
+ * @t: the pending_timer member of the throtl_service_queue being serviced
  *
  * This timer is armed when a child throtl_grp with active bio's become
  * pending and queued on the service_queue's pending_tree and expires when
-- 
2.22.0.rc1

