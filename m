Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85BD1C433F5
	for <linux-block@archiver.kernel.org>; Fri, 24 Sep 2021 16:11:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62D5661242
	for <linux-block@archiver.kernel.org>; Fri, 24 Sep 2021 16:11:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347297AbhIXQNV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 24 Sep 2021 12:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236860AbhIXQNU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Sep 2021 12:13:20 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2652CC061571
        for <linux-block@vger.kernel.org>; Fri, 24 Sep 2021 09:11:47 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id p23-20020a05620a22f700b003d5ac11ac5cso33906920qki.15
        for <linux-block@vger.kernel.org>; Fri, 24 Sep 2021 09:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=h/BzDykRlB6GOyA2BcmGWRmoSP3v2KwlwqsQH6GthJ0=;
        b=s097uqR1pTgijhwOq0jlwx+Q2b2NZ+PCa5o+adbYM7F93XKYGLPfqkd4v/iLqpvD0V
         CxbmhuaDNwo5V8KrPZig96VwdD5xKZl+Fby4Px9Zl5fV9qfYQSABO9qRSvPpWcRWnsGt
         yJcwYZlySBuH126e2RBVNAysxJIS7n2NnvtO0JwQow0roBBJQtaNHmKl6Jwkw9Ho8v0N
         UyVmB27QDbgb+KGzyEOW/xMSDGc5HTb8Crvk+B9fTHDLiuCtYpIFDr+DF5xPMXHOnqHu
         fP3/k2TYo63Z87Z/778QS7eR37Ha/DGG73iVFl7xVzBovqiOpGGBfQFkD5J/65tiOzWr
         duXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=h/BzDykRlB6GOyA2BcmGWRmoSP3v2KwlwqsQH6GthJ0=;
        b=pIWz8IkS7tMQJHsMudyHQSHR8/gnoyCJoi//cJJvBjDTIxPWgUFZlRlhVjxnCjXStv
         CFpZQN8Hdjnxr7GpbJx5ehVsqvAFH/3T+H1AryaaMSXPzA7LHmscKLw1cRDMQXnWuviM
         QsjOvT6+cE/Wl68jVDvqMBqQdrzXW6BA0hWGLw43znMrJ7rM+uvlqnyYxPww3VTsetWd
         2B6mxP27NcnSAGnFG6vzv1+/4wffBdSl5/X1aHhk6ExRXvXn+zRnI5eB/Wg21J0VuT9G
         xPzKC5OdPHGWUi2Wem3wfkNqNS5ft+rITwZ+Hp4trxRev/d5Di5K/jZSVIxkdOPq6HEL
         5pkA==
X-Gm-Message-State: AOAM532GViSTr06KQYfreKVpTe5kmEp0g4/ni1GgRumtbeTs/o7zGpNg
        03JSgFqMkkIMruHDdSHldmE2ajYv4Rtr
X-Google-Smtp-Source: ABdhPJw34MswgTp2VNuMhvwGOr41NrkDRg6aw14eaPbHovMNQpUoWHD9mf7BIT4LQ/zZ6bjgF/O9UohxCDBl
X-Received: from bg.sfo.corp.google.com ([2620:15c:11a:202:20fb:24e3:1670:2a67])
 (user=bgeffon job=sendgmr) by 2002:a0c:ab51:: with SMTP id
 i17mr10455643qvb.39.1632499906312; Fri, 24 Sep 2021 09:11:46 -0700 (PDT)
Date:   Fri, 24 Sep 2021 09:11:28 -0700
In-Reply-To: <20210917210640.214211-1-bgeffon@google.com>
Message-Id: <20210924161128.1508015-1-bgeffon@google.com>
Mime-Version: 1.0
References: <20210917210640.214211-1-bgeffon@google.com>
X-Mailer: git-send-email 2.33.0.685.g46640cef36-goog
Subject: [PATCH v5] zram: Introduce an aged idle interface
From:   Brian Geffon <bgeffon@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Minchan Kim <minchan@kernel.org>, Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-block@vger.kernel.org,
        Suleiman Souhlal <suleiman@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Brian Geffon <bgeffon@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This change introduces an aged idle interface to the existing
idle sysfs file for zram.

When CONFIG_ZRAM_MEMORY_TRACKING is enabled the idle file
now also accepts an integer argument. This integer is the
age (in seconds) of pages to mark as idle. The idle file
still supports 'all' as it always has. This new approach
allows for much more control over which pages get marked
as idle.

  v4 -> v5:
	- Andrew's suggestions to use IS_ENABLED and
	  cleanup comment.

  v3 -> v4:
        - Remove base10 restriction.

  v2 -> v3:
        - Correct unused variable warning when
          CONFIG_ZRAM_MEMORY_TRACKING is not enabled.
  v1 -> v2:
        - Switch to using existing idle file.
        - Dont compare ktime directly.

Signed-off-by: Brian Geffon <bgeffon@google.com>
Acked-by: Minchan Kim <minchan@kernel.org>
---
 Documentation/admin-guide/blockdev/zram.rst |  8 +++
 drivers/block/zram/zram_drv.c               | 61 +++++++++++++++------
 2 files changed, 53 insertions(+), 16 deletions(-)

diff --git a/Documentation/admin-guide/blockdev/zram.rst b/Documentation/admin-guide/blockdev/zram.rst
index a6fd1f9b5faf..c66efb2eeac3 100644
--- a/Documentation/admin-guide/blockdev/zram.rst
+++ b/Documentation/admin-guide/blockdev/zram.rst
@@ -327,6 +327,14 @@ as idle::
 From now on, any pages on zram are idle pages. The idle mark
 will be removed until someone requests access of the block.
 IOW, unless there is access request, those pages are still idle pages.
+Additionally, when CONFIG_ZRAM_MEMORY_TRACKING is enabled pages can be
+marked as idle based on how long (in seconds) it's been since they were
+last accessed::
+
+        echo 86400 > /sys/block/zramX/idle
+
+In this example all pages which haven't been accessed in more than 86400
+seconds (one day) will be marked idle.
 
 Admin can request writeback of those idle pages at right timing via::
 
diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index d291bedeef8e..33282f04ea32 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -291,22 +291,16 @@ static ssize_t mem_used_max_store(struct device *dev,
 	return len;
 }
 
-static ssize_t idle_store(struct device *dev,
-		struct device_attribute *attr, const char *buf, size_t len)
+/*
+ * Mark all pages which are older than or equal to cutoff as IDLE.
+ * Callers should hold the zram init lock in read mode
+ */
+static void mark_idle(struct zram *zram, ktime_t cutoff)
 {
-	struct zram *zram = dev_to_zram(dev);
+	int is_idle = 1;
 	unsigned long nr_pages = zram->disksize >> PAGE_SHIFT;
 	int index;
 
-	if (!sysfs_streq(buf, "all"))
-		return -EINVAL;
-
-	down_read(&zram->init_lock);
-	if (!init_done(zram)) {
-		up_read(&zram->init_lock);
-		return -EINVAL;
-	}
-
 	for (index = 0; index < nr_pages; index++) {
 		/*
 		 * Do not mark ZRAM_UNDER_WB slot as ZRAM_IDLE to close race.
@@ -314,14 +308,49 @@ static ssize_t idle_store(struct device *dev,
 		 */
 		zram_slot_lock(zram, index);
 		if (zram_allocated(zram, index) &&
-				!zram_test_flag(zram, index, ZRAM_UNDER_WB))
-			zram_set_flag(zram, index, ZRAM_IDLE);
+				!zram_test_flag(zram, index, ZRAM_UNDER_WB)) {
+#ifdef CONFIG_ZRAM_MEMORY_TRACKING
+				is_idle = (!cutoff || ktime_after(cutoff, zram->table[index].ac_time));
+#endif
+			if (is_idle)
+				zram_set_flag(zram, index, ZRAM_IDLE);
+		}
 		zram_slot_unlock(zram, index);
 	}
+}
 
-	up_read(&zram->init_lock);
+static ssize_t idle_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t len)
+{
+	struct zram *zram = dev_to_zram(dev);
+	ktime_t cutoff_time = 0;
+	ssize_t rv = -EINVAL;
 
-	return len;
+	if (!sysfs_streq(buf, "all")) {
+		/*
+		 * If it did not parse as 'all' try to treat it as an integer when
+		 * we have memory tracking enabled.
+		 */
+		u64 age_sec;
+		if (IS_ENABLED(CONFIG_ZRAM_MEMORY_TRACKING) && !kstrtoull(buf, 0, &age_sec))
+			cutoff_time = ktime_sub(ktime_get_boottime(),
+					ns_to_ktime(age_sec * NSEC_PER_SEC));
+		else
+			goto out;
+	}
+
+	down_read(&zram->init_lock);
+	if (!init_done(zram))
+		goto out_unlock;
+
+	/* A age_sec of 0 marks everything as idle, this is the "all" behavior */
+	mark_idle(zram, cutoff_time);
+	rv = len;
+
+out_unlock:
+	up_read(&zram->init_lock);
+out:
+	return rv;
 }
 
 #ifdef CONFIG_ZRAM_WRITEBACK
-- 
2.33.0.685.g46640cef36-goog

