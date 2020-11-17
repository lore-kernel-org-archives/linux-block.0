Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7ED1C5519F
	for <linux-block@archiver.kernel.org>; Tue, 17 Nov 2020 14:07:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8499620773
	for <linux-block@archiver.kernel.org>; Tue, 17 Nov 2020 14:07:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729828AbgKQOHD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 Nov 2020 09:07:03 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35336 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729021AbgKQOHC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Nov 2020 09:07:02 -0500
Received: by mail-pl1-f196.google.com with SMTP id x15so10291240pll.2;
        Tue, 17 Nov 2020 06:07:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o21xFA2+Pi882pZCudoWYgA/awgobRWXYeIb2vgi2Qw=;
        b=iSYTzG4VpAjzFIt6jE8oQ4FIX8IfX/7h7nXe0lgL0dhbNZ1qLcL15Mq39aJgcrW8w5
         sjgyGjdmo1IQzJhKOIo004A6i36xLbz2zm6HZMhmNzi3BBI8TtnrGEY1lXqF60pl8pUx
         8ZWdziiHwcE3kdn9PeC3jgf0laB9wLYEsdT+LIywqqcIA9AuK9pOARsc4fUtCBB/Q8Wo
         bgvhJUQCZj6WPvpF9kF/7eZkFXZqCcZZ7m/K+Qj9BlGprZGt5c3QgEg9GE3LckSUrLtr
         UM1dLIDnYTbyyroDROdb+N8sHnam5KL0Dzlh58YP+Ok6cayiz8BYM4n8ANkwmVGUFpwB
         RXxg==
X-Gm-Message-State: AOAM532MQ3QZrJMOwQ15T15lc6SkQ6B85nfgvo7LWgZMuvJZyxwz4vwG
        yX9R5qsH2dqtwrH1qmUMOU8=
X-Google-Smtp-Source: ABdhPJyNEO3rautFk4PH4+IEB7QxoZSfUawN6cN3e+SMemkj2Sk3dMf1sDq2Os8+DfOXtFuYYRBy7w==
X-Received: by 2002:a17:902:c383:b029:d6:991c:671b with SMTP id g3-20020a170902c383b02900d6991c671bmr17019279plg.51.1605622022396;
        Tue, 17 Nov 2020 06:07:02 -0800 (PST)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id q13sm21644163pfg.64.2020.11.17.06.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 06:07:00 -0800 (PST)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 6F2D840630; Tue, 17 Nov 2020 14:06:59 +0000 (UTC)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk
Cc:     bvanassche@acm.org, ming.lei@redhat.com, hch@infradead.org,
        jack@suse.cz, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH] block: fix userspace documentation reference for del_gendisk()
Date:   Tue, 17 Nov 2020 14:06:58 +0000
Message-Id: <20201117140658.12199-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.23.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Commit b5bd357cf8b ("block: add docs for gendisk / request_queue refcount
helpers") has a typo where it references drivers for del_gendisk() when we
instead meant userspace, as the reference is to the userspace experience.
This fixes this.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 block/genhd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 0a273211fec2..9511620f558a 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -880,8 +880,8 @@ static void invalidate_partition(struct gendisk *disk, int partno)
  * with put_disk(), which should be called after del_gendisk(), if
  * __device_add_disk() was used.
  *
- * Drivers exist which depend on the release of the gendisk to be synchronous,
- * it should not be deferred.
+ * Userspace may exist which depends on the release of the gendisk to be
+ * synchronous, it should not be deferred.
  *
  * Context: can sleep
  */
-- 
2.28.0

