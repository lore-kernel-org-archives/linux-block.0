Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77B70C433EF
	for <linux-block@archiver.kernel.org>; Thu, 23 Sep 2021 13:01:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E72061090
	for <linux-block@archiver.kernel.org>; Thu, 23 Sep 2021 13:01:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241174AbhIWNDC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Sep 2021 09:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241128AbhIWNDC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Sep 2021 09:03:02 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7ADEC061756
        for <linux-block@vger.kernel.org>; Thu, 23 Sep 2021 06:01:30 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id h9-20020a05621413a900b0037a2d3eaf8fso20133406qvz.8
        for <linux-block@vger.kernel.org>; Thu, 23 Sep 2021 06:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=pxyBWuKYUEov5soFeTBimqgoL558mN/tf852xqM/Zqo=;
        b=r8WLR+56J08ce48W5i1Ta72091Yy7+G3KDkggHmFEeLudlz6X9TIPKPl7zLt5b8YP6
         xqVpNHomVs02rJJFY4oqMvc6ch8CcEktMyaGkcsQm5pU9PdRYKnau89KONnDQRHH1n2a
         hOcQRdjxDu9NOes9AvipCOqt/gE4rIl9MPX4mVZGjklP/e04fRSKwck/F9VPq9QPadFK
         6qSZaaUqlfn9sfcBpVoVZSmgxGPcTeeGyfMeE1HH4iuehWy6epf0XLggiSjToaa6EQxI
         7jgkDev499nBQw9+0e/QNDaJuO46T4nz+BLhUOBr/LAuJrOCWXP9BkdY0ek5ROEj2ePj
         21og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=pxyBWuKYUEov5soFeTBimqgoL558mN/tf852xqM/Zqo=;
        b=ucje21awi2PdZ/HDMX8VnIlaqAyjG6VCjIxc+ISD1xmduuAEWd+1Pv6Snc5hhiBdm/
         5BQRCdx86rgxmvRE6V++1kGu2kJh6JN74Lr7Lnw9Rx5AXpFh3ykloGbQXZZ9Sshd8VPP
         ehSJ6+mH+AQMUSx+BxLyef13Ko62NLeqAn4Oqrwhnd+Fm1zunQb3Au/K2DXCVOg928a9
         ner1SHAJ+a5ZsCZ4lB7YvPtzITf2RYBT5bLB4z7KLQRZyfrD8p2RGijLf470HhFKHJv6
         GWfuZgYiC2ubB/TqYhIkC+C/xhQYprNWSDz5/bEu0vRp4Z73xCWLxbwgRJbZatdP+ZTg
         AAlw==
X-Gm-Message-State: AOAM532yozE0/AMfclNL3UkaoVoufGY3H8DoymIt9BMupp4Kk88qYJAP
        z5FH6x3BwxNtRSD1VcceXMaDZ1uv+hAE
X-Google-Smtp-Source: ABdhPJw7oMApFbF6oIkMNDIAUTQH8qglqsd9JNK8qnUs+c892g99qRkOefc5ePGTLKqpXxQzW+d0ObUY9qE1
X-Received: from bg.sfo.corp.google.com ([2620:15c:11a:202:f538:540c:f838:6293])
 (user=bgeffon job=sendgmr) by 2002:a05:6214:11f0:: with SMTP id
 e16mr4275880qvu.30.1632402088768; Thu, 23 Sep 2021 06:01:28 -0700 (PDT)
Date:   Thu, 23 Sep 2021 06:01:15 -0700
In-Reply-To: <20210917210640.214211-1-bgeffon@google.com>
Message-Id: <20210923130115.1344361-1-bgeffon@google.com>
Mime-Version: 1.0
References: <20210917210640.214211-1-bgeffon@google.com>
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
Subject: [PATCH v4] zram: Introduce an aged idle interface
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

  v3 -> v4:
        - Remove base10 restriction.

  v2 -> v3:
	- Correct unused variable warning when
	  CONFIG_ZRAM_MEMORY_TRACKING is not enabled.
  v1 -> v2:
	- Switch to using existing idle file.
	- Dont compare ktime directly.

Signed-off-by: Brian Geffon <bgeffon@google.com>
---
 Documentation/admin-guide/blockdev/zram.rst |  8 +++
 drivers/block/zram/zram_drv.c               | 60 +++++++++++++++------
 2 files changed, 52 insertions(+), 16 deletions(-)

diff --git a/Documentation/admin-guide/blockdev/zram.rst b/Documentation/admin-guide/blockdev/zram.rst
index 700329d25f57..3e11926a4df9 100644
--- a/Documentation/admin-guide/blockdev/zram.rst
+++ b/Documentation/admin-guide/blockdev/zram.rst
@@ -328,6 +328,14 @@ as idle::
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
index fcaf2750f68f..ca15d60262fa 100644
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
+ **/
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
@@ -314,14 +308,48 @@ static ssize_t idle_store(struct device *dev,
 		 */
 		zram_slot_lock(zram, index);
 		if (zram_allocated(zram, index) &&
-				!zram_test_flag(zram, index, ZRAM_UNDER_WB))
-			zram_set_flag(zram, index, ZRAM_IDLE);
+				!zram_test_flag(zram, index, ZRAM_UNDER_WB)) {
+#ifdef CONFIG_ZRAM_MEMORY_TRACKING
+			is_idle = (!cutoff || ktime_after(cutoff, zram->table[index].ac_time));
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
+#ifdef CONFIG_ZRAM_MEMORY_TRACKING
+		u64 age_sec;
+		/* If it did not parse as 'all' try to treat it as an integer */
+		if (!kstrtoull(buf, 0, &age_sec))
+			cutoff_time = ktime_sub(ktime_get_boottime(),
+					ns_to_ktime(age_sec * NSEC_PER_SEC));
+		else
+#endif
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
2.33.0.464.g1972c5931b-goog

