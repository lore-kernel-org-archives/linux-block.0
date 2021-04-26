Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26D06C433ED
	for <linux-block@archiver.kernel.org>; Mon, 26 Apr 2021 18:50:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E156461152
	for <linux-block@archiver.kernel.org>; Mon, 26 Apr 2021 18:50:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239061AbhDZSv0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Apr 2021 14:51:26 -0400
Received: from mail-pl1-f177.google.com ([209.85.214.177]:41534 "EHLO
        mail-pl1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239046AbhDZSvZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Apr 2021 14:51:25 -0400
Received: by mail-pl1-f177.google.com with SMTP id e2so25124043plh.8;
        Mon, 26 Apr 2021 11:50:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Wn5pIko3dOXofM/RbH3aZI70BecBWmubQ/kDe1VUkfo=;
        b=Tp0ywh5Uz47jy9EX8awoja4EKbqo1QTioQb+8acBEXeIX3TsQH+Sl4lxHkCoS25YJx
         tQW1OVBa/yqCHnmJfnRDRM+wR9VsIu/8hQwRL2EZ24vcuC6L2JDiP06hg1x+YCHO3+BJ
         k2xTKrN1CpzibcAbvoetYOa25dtoy6E3d91Xl7yrQHzGIbIItNXs4jrTIjV0wuMJLm4q
         hm/e0TmyuSKvZVyesZJZnhh8yKVILVhKmPVO2yt7ZHgeFkQcAjEqdLHghXwHu+VegOWy
         8VFoq+vO7CBOcwralLp7EM8UhrIPClXfKjHevnQPndWD3W31NCbYp0A7obcHR/O21fEz
         pDnQ==
X-Gm-Message-State: AOAM532nyciUTXwvGDWZi+dHbkTVWl59FBbs8HZdXbNhC6cdoB1zWNfO
        lq9FMQVONLySaB1f+Js2fWzsskurrbxPIg==
X-Google-Smtp-Source: ABdhPJyegXR5DFg1SodW3RL/mziuH29Sy6vHZzC77suWL4kugISgBTw5I/1Zk+IUtXfQWhoMw8XCow==
X-Received: by 2002:a17:90a:9511:: with SMTP id t17mr505675pjo.235.1619463043268;
        Mon, 26 Apr 2021 11:50:43 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id s32sm399847pfw.2.2021.04.26.11.50.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 11:50:42 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 7AD85403A2; Mon, 26 Apr 2021 18:50:41 +0000 (UTC)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk
Cc:     bvanassche@acm.org, ming.lei@redhat.com, hch@infradead.org,
        jack@suse.cz, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v2] block: fix userspace documentation reference for del_gendisk()
Date:   Mon, 26 Apr 2021 18:50:40 +0000
Message-Id: <20210426185040.24580-1-mcgrof@kernel.org>
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
index 39ca97b0edc6..e077adfcd1a2 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -594,8 +594,8 @@ EXPORT_SYMBOL(device_add_disk_no_queue_reg);
  * with put_disk(), which should be called after del_gendisk(), if
  * __device_add_disk() was used.
  *
- * Drivers exist which depend on the release of the gendisk to be synchronous,
- * it should not be deferred.
+ * Userspace software may depend on the release of the gendisk to be
+ * synchronous, it should not be deferred.
  *
  * Context: can sleep
  */
-- 
2.29.2

