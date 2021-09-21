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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C778BC433EF
	for <linux-block@archiver.kernel.org>; Tue, 21 Sep 2021 19:43:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE3936112F
	for <linux-block@archiver.kernel.org>; Tue, 21 Sep 2021 19:43:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233487AbhIUTpV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 Sep 2021 15:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232590AbhIUTpV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Sep 2021 15:45:21 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D698C061574
        for <linux-block@vger.kernel.org>; Tue, 21 Sep 2021 12:43:52 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id r18-20020ad454b2000000b00380e8260f8eso3919250qvy.20
        for <linux-block@vger.kernel.org>; Tue, 21 Sep 2021 12:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=2Nm1E5fYqM+jWf7/uwd5uL7JDVTYKQ4yOjBmP2vLC7A=;
        b=l0xqSrhqSkKXdp/rvmYs8zyIR70QOI6I5dr8fZW0m08B3GQjc1LkUj5ugdeRsW4OnA
         ud3rmYa8VLKBZsmz7EYPviKVZUVPLt+p8NcyFq8096f32Kl/GWrtuyjuijc+k/PuVieR
         bg1RZQB0vwjGqy4iN37tJff2FKPu/ID2aGLBe/v07/HRIsvdzA1+VbEDzMJP91iI+ukH
         /ngZF4wqqpmp8ngWZbB3+0MvD5gS4qADo8ptyO2/sE/78WUKPaT5Slew/p38J+pSiapN
         d5bDowJfR2NspIiCl626IGQocuEfzcsGy/vUh3nQOGjWBSFi5kN5n6zLBH4NMdr5r7XI
         fvpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=2Nm1E5fYqM+jWf7/uwd5uL7JDVTYKQ4yOjBmP2vLC7A=;
        b=Qvi9OilTNXLF3gHtdxWMneS/5tDvn2N9QywzIWDYHlWqoLmAgadVMkS2QyIzZi/vFn
         K88+85S4T6dZfD3w12AJrwJ4rlsLgQ6Fy3XaOqN4VZ5eRSry2RMLZSt3pQJDO7DIa4bK
         uIlPtjMXTIKhUMtUuk9u341YnxgTMGKcSvYEjhM8RuPo92Oo5YrVqafH70sbrahwJp82
         iA1DqPGbnAKWkqqfVYycNZuU6lPCbpWgJDXjS7Mt4evQvRRF7sFbwYiDALWMRjqpPg8B
         E8JcHnpWnp37pihN66NHwnbT7cqkearkBfOvMWKzEpEqZCi2+7RkZwu16Ib+pgPQVuj6
         75KA==
X-Gm-Message-State: AOAM532G4qkVkuwDdDaV3HiPaB7YIG9tEx1GpBp8a+tMV0fsNEcWSdbc
        M3nq8zzFUNzM/Cp2oOHPJy2syIjL/E3H
X-Google-Smtp-Source: ABdhPJxWrW0rnQTiixq/QHDVbCorUbBGLON5MX5vtuNZgZBTS4hKgMla75LEfH7uBmH9qzwQKz5J2t68DDW6
X-Received: from bg.sfo.corp.google.com ([2620:15c:11a:202:4ba8:c770:5378:a8b7])
 (user=bgeffon job=sendgmr) by 2002:a05:6214:1425:: with SMTP id
 o5mr32729818qvx.5.1632253431404; Tue, 21 Sep 2021 12:43:51 -0700 (PDT)
Date:   Tue, 21 Sep 2021 12:43:36 -0700
In-Reply-To: <20210917210640.214211-1-bgeffon@google.com>
Message-Id: <20210921194336.947226-1-bgeffon@google.com>
Mime-Version: 1.0
References: <20210917210640.214211-1-bgeffon@google.com>
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
Subject: [PATCH v3] zram: Introduce an aged idle interface
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
index 700329d25f57..8c8a92e5c00c 100644
--- a/Documentation/admin-guide/blockdev/zram.rst
+++ b/Documentation/admin-guide/blockdev/zram.rst
@@ -328,6 +328,14 @@ as idle::
 From now on, any pages on zram are idle pages. The idle mark
 will be removed until someone requests access of the block.
 IOW, unless there is access request, those pages are still idle pages.
+Additionally, when CONFIG_ZRAM_MEMORY_TRACKING is enabled pages can be
+marked as idle based on how long (in seconds) it's been since they were
+last accessed, in seconds::
+
+        echo 86400 > /sys/block/zramX/idle
+
+In this example all pages which haven't been accessed in more than 86400
+seconds (one day) will be marked idle.
 
 Admin can request writeback of those idle pages at right timing via::
 
diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index fcaf2750f68f..2af5cdb8da1a 100644
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
+		if (!kstrtoull(buf, 10, &age_sec))
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

