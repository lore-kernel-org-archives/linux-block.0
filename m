Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46941C4320A
	for <linux-block@archiver.kernel.org>; Thu, 19 Aug 2021 02:51:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FE966108F
	for <linux-block@archiver.kernel.org>; Thu, 19 Aug 2021 02:51:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236085AbhHSCvw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 18 Aug 2021 22:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235922AbhHSCvq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Aug 2021 22:51:46 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFA1AC061764;
        Wed, 18 Aug 2021 19:51:10 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id w22-20020a056830411600b0048bcf4c6bd9so6844474ott.8;
        Wed, 18 Aug 2021 19:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M/NUaTEslE7hYgIeaV8Kn3/oBWy9c6O39iYX3Cnl+Lo=;
        b=FqT2S8VM3TK55vvDvRvBBb+HuJWK6vQOYFPfdnhPDrr0IykKsGbNrPAvPhTXgfIIcP
         FuzaZjlxskiilziBJgyAjUWa1YZkiBBela1eK/vlmyJH164vkghksiPpQ1e63JA0yXQ7
         y5MRszITcbmp1Ig4BUr8lNXMlXtmzPNiAfepGDOlzvQW0ZDIGBSszXYn/wivjhGg1BlM
         DHjZo6FRR2PllWqFxd4F8nwLQTR7PvUMiaMHzcEJUYX/yyHfN9Ru5mbm+hKE07OF1wZ4
         ii+bQThK1RQYAJ9TqHjBx/ooAll1VSk9sPhOqXY2alkf/3zX26LI4IOJcLxwaNulpbEw
         M9wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M/NUaTEslE7hYgIeaV8Kn3/oBWy9c6O39iYX3Cnl+Lo=;
        b=gl6tQxt5AUQL2YgqKurMv1v33slsvX2LHAvlU3gD+mySLItxQhRbbsJaVu68YnS0Xc
         /z9kZG9uwgAlAyB441Ar4O1KAweVUKLfn4lmeGmEGhIqHLTtN17G9WvaIWcImvIZhXhW
         Gseqsg9OYnYRZR3jFaPkhjc35SanYMhDZaC0c7t0ZGnD2k3MYLOpST4veuH4eihL/p89
         OxmjYGsAMG3SD6CjsBvX7h5TQwwNoZm9pedWBPI3gpOKMyfwy8FyvXuAX2AXZMcVDzpt
         ca8LH6nvsLTQ3IEKxOL0z1+16gKDUwVcud6+czjLn/SmiJuFZznuBekYBDA6ZI6EPHVs
         6hDw==
X-Gm-Message-State: AOAM5318CenAQGURMgpv9fh9y6r6csSddlA2wuiKpq5wgXJ6cSDh01v3
        QdtvWbwrVUHlFlGsA268xNqiAbrTsytwnM4n
X-Google-Smtp-Source: ABdhPJy6HDMBN4qeDBPKHvTHqMK0xe6cVxyZEXGaXvEpfIv1mQoQcMcUv/7BZC+N+gf63ph0Id2SAw==
X-Received: by 2002:a9d:6505:: with SMTP id i5mr4501523otl.284.1629341470011;
        Wed, 18 Aug 2021 19:51:10 -0700 (PDT)
Received: from ian.penurio.us ([47.184.51.90])
        by smtp.gmail.com with ESMTPSA id w15sm156792oiw.19.2021.08.18.19.51.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 19:51:09 -0700 (PDT)
From:   Ian Pilcher <arequipeno@gmail.com>
To:     linux-block@vger.kernel.org, linux-leds@vger.kernel.org
Cc:     axboe@kernel.dk, pavel@ucw.cz, kabel@kernel.org,
        linux-kernel@vger.kernel.org, kernelnewbies@kernelnewbies.org
Subject: [RFC PATCH v3 08/18] ledtrig-blkdev: Add function to remove LED/device association
Date:   Wed, 18 Aug 2021 21:50:43 -0500
Message-Id: <20210819025053.222710-9-arequipeno@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210819025053.222710-1-arequipeno@gmail.com>
References: <20210819025053.222710-1-arequipeno@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Remove symlinks in /sys/class/leds/<led>/block_devices and
/sys/block/<disk>/blkdev_leds

Decrement reference count on /sys/block/<disk>/blkdev_leds
directory (removes directory when empty)

Cancel delayed work when disassociating last device

Signed-off-by: Ian Pilcher <arequipeno@gmail.com>
---
 drivers/leds/trigger/ledtrig-blkdev.c | 56 +++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/drivers/leds/trigger/ledtrig-blkdev.c b/drivers/leds/trigger/ledtrig-blkdev.c
index e9c23824c33c..447fc81ae0c5 100644
--- a/drivers/leds/trigger/ledtrig-blkdev.c
+++ b/drivers/leds/trigger/ledtrig-blkdev.c
@@ -225,3 +225,59 @@ static void blkdev_process(struct work_struct *const work)
 	delay = READ_ONCE(ledtrig_blkdev_interval);
 	WARN_ON_ONCE(!schedule_delayed_work(&ledtrig_blkdev_work, delay));
 }
+
+
+/*
+ *
+ *	Disassociate a block device from an LED
+ *
+ */
+
+static void blkdev_disk_del_locked(struct ledtrig_blkdev_led *const led,
+				   struct ledtrig_blkdev_link *const link,
+				   struct ledtrig_blkdev_disk *const disk)
+{
+	--ledtrig_blkdev_count;
+
+	if (ledtrig_blkdev_count == 0)
+		WARN_ON(!cancel_delayed_work_sync(&ledtrig_blkdev_work));
+
+	sysfs_remove_link(led->dir, disk->gd->disk_name);
+	sysfs_remove_link(disk->dir, led->led_dev->name);
+	kobject_put(disk->dir);
+
+	hlist_del(&link->led_disks_node);
+	hlist_del(&link->disk_leds_node);
+	kfree(link);
+
+	if (hlist_empty(&disk->leds)) {
+		disk->gd->ledtrig = NULL;
+		kfree(disk);
+	}
+
+	put_device(disk_to_dev(disk->gd));
+}
+
+static void blkdev_disk_delete(struct ledtrig_blkdev_led *const led,
+			       const char *const disk_name,
+			       const size_t name_len)
+{
+	struct ledtrig_blkdev_link *link;
+
+	mutex_lock(&ledtrig_blkdev_mutex);
+
+	hlist_for_each_entry(link, &led->disks, led_disks_node) {
+
+		if (blkdev_streq(link->disk->gd->disk_name,
+						disk_name, name_len)) {
+			blkdev_disk_del_locked(led, link, link->disk);
+			goto exit_unlock;
+		}
+	}
+
+	pr_info("blkdev LED: %.*s not associated with LED %s\n",
+		(int)name_len, disk_name, led->led_dev->name);
+
+exit_unlock:
+	mutex_unlock(&ledtrig_blkdev_mutex);
+}
-- 
2.31.1

