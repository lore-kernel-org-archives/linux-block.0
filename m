Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10CEDC433FE
	for <linux-block@archiver.kernel.org>; Wed, 29 Sep 2021 14:31:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA0D8613D3
	for <linux-block@archiver.kernel.org>; Wed, 29 Sep 2021 14:31:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344479AbhI2Oc5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Sep 2021 10:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344490AbhI2Oc5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Sep 2021 10:32:57 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A6F0C06161C
        for <linux-block@vger.kernel.org>; Wed, 29 Sep 2021 07:31:16 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id 62-20020aed2044000000b002a6aa209efaso8568422qta.18
        for <linux-block@vger.kernel.org>; Wed, 29 Sep 2021 07:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=rWICg8z18y6VVMgB2+FBawlhY9BT8cZzUVXfBU/5MDc=;
        b=lDmFatJxse2Wln+jGfebmXhp7ycDVxpvCtDN5lXIJGK6Cqt2tWheN/OsgOdlMKRBn3
         nUxGAmetg2Xz+ITdJ9SZKNJfMh3K1TV+RTJD7NtJAT3S0kEXXjbnWbZVRDi7I26Gw+pA
         if5ye7gfxc4hg/zbooMFmMgNyOvTDMfrx3DIO3HEzzx/lkeO+wqXumwFJHc4fl+9R3oa
         ILTW5xhoS3B4B4qYePulahGaD7oxojtUVWeolSwhNCj9jEffJ15zn8MOJO6TDQiG5Z8C
         JbAshmkT9/7neyVISnTlS9aGiexK4t1ibOVGuNmYhDEBaWxngYutYMXW7lquprr+bUDS
         xITg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=rWICg8z18y6VVMgB2+FBawlhY9BT8cZzUVXfBU/5MDc=;
        b=cBVxknyk8HbHYoj/MKr8THx1WatGa727F7g/MJGH/5OLovsOfHLRNSA0IhgDiDDnxL
         J7qOqhOR2WWbUDYl7kDeYkR+UA+DJTiua51k7HsJzkbvxaE5lyOTsj+Fo75esnTyJlYm
         A3+lss+AtL6XTOirQ821fzZ/Ml4SwqSBcCOQWxBdzDBlZlyIN47Tj8h+cLSTG8LUImCE
         //tNmZKCv0RRRUS82jd+iXbOHM0n8bLRvgK3mfyBjLTWzkjFZdLudzQwHYSu+cZnqlN2
         38wrR+mDDA1xDa0nklL5TEM0NVgJdKp67luE+aiXm7f/FAWp3B8aj6ylRFPK9acqcUl5
         c3Sg==
X-Gm-Message-State: AOAM533EZ422P+6amP1VmHTKu30MyqM38dNnuMk6OaHNry2W3oAhvbMz
        xq3155NNdDvqbi4Dx6dNJ4GU0PWGQDEZ
X-Google-Smtp-Source: ABdhPJwDV7ClEvzTaenTx9rrvJz3xctvGcdzsJSql0k1qJNvj4+7OO3EWhHwlFTBoaVZ+/f8jCZSYTGTNTbo
X-Received: from bg.sfo.corp.google.com ([2620:15c:11a:202:d5dd:2dee:3cc9:114])
 (user=bgeffon job=sendgmr) by 2002:a05:6214:1046:: with SMTP id
 l6mr11763064qvr.6.1632925875212; Wed, 29 Sep 2021 07:31:15 -0700 (PDT)
Date:   Wed, 29 Sep 2021 07:30:56 -0700
In-Reply-To: <20210917210640.214211-1-bgeffon@google.com>
Message-Id: <20210929143056.13067-1-bgeffon@google.com>
Mime-Version: 1.0
References: <20210917210640.214211-1-bgeffon@google.com>
X-Mailer: git-send-email 2.33.0.685.g46640cef36-goog
Subject: [PATCH v6] zram: Introduce an aged idle interface
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

  v5 -> v6:
        - Sergey's cleanup suggestions.

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
 drivers/block/zram/zram_drv.c               | 62 +++++++++++++++------
 2 files changed, 54 insertions(+), 16 deletions(-)

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
index fcaf2750f68f..4e76a75a7840 100644
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
@@ -314,14 +308,50 @@ static ssize_t idle_store(struct device *dev,
 		 */
 		zram_slot_lock(zram, index);
 		if (zram_allocated(zram, index) &&
-				!zram_test_flag(zram, index, ZRAM_UNDER_WB))
-			zram_set_flag(zram, index, ZRAM_IDLE);
+				!zram_test_flag(zram, index, ZRAM_UNDER_WB)) {
+#ifdef CONFIG_ZRAM_MEMORY_TRACKING
+			is_idle = !cutoff || ktime_after(cutoff, zram->table[index].ac_time);
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
+
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
+	/* A cutoff_time of 0 marks everything as idle, this is the "all" behavior */
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

