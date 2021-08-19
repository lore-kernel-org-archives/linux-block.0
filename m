Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12428C4320A
	for <linux-block@archiver.kernel.org>; Thu, 19 Aug 2021 02:51:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F041B610A5
	for <linux-block@archiver.kernel.org>; Thu, 19 Aug 2021 02:51:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236154AbhHSCv4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 18 Aug 2021 22:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235957AbhHSCvr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Aug 2021 22:51:47 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C457C061796;
        Wed, 18 Aug 2021 19:51:11 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id l36-20020a0568302b24b0290517526ce5e3so6808943otv.11;
        Wed, 18 Aug 2021 19:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gLq26oGhJkSVR5HWnDcMPok9R/cYfBLnVyDwU8dlv5w=;
        b=suB3ljiNGnGxG6Bp3moMcQsr25VLohaoWgkBBn6zRRbfsz7DTrraZ9YDFmz8dLR7Eq
         7APEqWaAg2p4NgF0jwLhL4Ix/ZxcQoKYky7OacWw5PLP6bqRczjFV2tdrZ/JRF/XM6DB
         66XwukMKDx5tRBJ4nQw2jvkm6yMjamsgdna14nwWTfomG3Zyy/S2BbKy/yWGzQYQJzOV
         OTqsj/UZQwhOgr8YrhyEzJcqCLHYhLCUZuTzhzoCB+9wRPvB+mIeRR61D+TI1OWSSKcr
         c1oYu/bGS78EHatKwKrsshufA34PvQan4ri1e4v2d437zE6dLrXdMjMpqEyreasBwcOJ
         CGfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gLq26oGhJkSVR5HWnDcMPok9R/cYfBLnVyDwU8dlv5w=;
        b=KO2wKZUhB2eEQky6jE2DQfFL3rO7Q2JDD1RIBSAFww2Z/FpKLcaf8hdZMYHzqsjHva
         Ux2KOMhJ7z4LpyflgFG00x3CJTBHLNyYQ+f9nMWXtg0uKs1W3Ebzfl6vJOGAyvNCxjvv
         qRBMq5oIsfkEGtqQAAYJK6SM179jlqET8+/xZSr/dQjHMV7o5Yj8+uTIsIrNalYOyNpW
         MCnJvLIKgQvOlYmrUjqJy61Nh24sl9BxuCkvBhmusGZdGCbH45UU41AQjwU9+bE4vfPq
         8428+C7IUEJJQ2j3G1elMbr+zmf20hExH1sMtN9LU0FVonfeN75AXSNKfVk/+C7hdCn5
         viFw==
X-Gm-Message-State: AOAM531TKxKneu97zGIJ4Q/z2lFdXua54+P8dtNuGUPK83JAalQ0tb1n
        GDr3zzZxU/wxTrtcoGZogwVC2UmbGr8Ta3Gu
X-Google-Smtp-Source: ABdhPJzlam1Dquw74l0eyIrxHOMvo3DoH1h7lrZKoDXGbh79W+Ks0D1jZowdb36CXuthHv0/38p/zA==
X-Received: by 2002:a9d:6f0a:: with SMTP id n10mr9825670otq.190.1629341470771;
        Wed, 18 Aug 2021 19:51:10 -0700 (PDT)
Received: from ian.penurio.us ([47.184.51.90])
        by smtp.gmail.com with ESMTPSA id w15sm156792oiw.19.2021.08.18.19.51.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 19:51:10 -0700 (PDT)
From:   Ian Pilcher <arequipeno@gmail.com>
To:     linux-block@vger.kernel.org, linux-leds@vger.kernel.org
Cc:     axboe@kernel.dk, pavel@ucw.cz, kabel@kernel.org,
        linux-kernel@vger.kernel.org, kernelnewbies@kernelnewbies.org
Subject: [RFC PATCH v3 09/18] ledtrig-blkdev: Add function to disassociate a device from all LEDs
Date:   Wed, 18 Aug 2021 21:50:44 -0500
Message-Id: <20210819025053.222710-10-arequipeno@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210819025053.222710-1-arequipeno@gmail.com>
References: <20210819025053.222710-1-arequipeno@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Called when block device is being removed

Signed-off-by: Ian Pilcher <arequipeno@gmail.com>
---
 drivers/leds/trigger/ledtrig-blkdev.c | 31 +++++++++++++++++++++++++++
 include/linux/leds.h                  |  4 ++++
 2 files changed, 35 insertions(+)

diff --git a/drivers/leds/trigger/ledtrig-blkdev.c b/drivers/leds/trigger/ledtrig-blkdev.c
index 447fc81ae0c5..2072cc904616 100644
--- a/drivers/leds/trigger/ledtrig-blkdev.c
+++ b/drivers/leds/trigger/ledtrig-blkdev.c
@@ -281,3 +281,34 @@ static void blkdev_disk_delete(struct ledtrig_blkdev_led *const led,
 exit_unlock:
 	mutex_unlock(&ledtrig_blkdev_mutex);
 }
+
+
+/*
+ *
+ *	Disassociate all LEDs from a block device (because it's going away)
+ *
+ */
+
+/**
+ * ledtrig_blkdev_disk_cleanup - remove a block device from the blkdev LED
+ * trigger
+ * @disk:	the disk to be removed
+ */
+void ledtrig_blkdev_disk_cleanup(struct gendisk *const gd)
+{
+	struct ledtrig_blkdev_link *link;
+	struct hlist_node *next;
+
+	mutex_lock(&ledtrig_blkdev_mutex);
+
+	if (gd->ledtrig != NULL) {
+
+		hlist_for_each_entry_safe(link, next,
+					  &gd->ledtrig->leds, disk_leds_node) {
+			blkdev_disk_del_locked(link->led, link, gd->ledtrig);
+		}
+	}
+
+	mutex_unlock(&ledtrig_blkdev_mutex);
+}
+EXPORT_SYMBOL_GPL(ledtrig_blkdev_disk_cleanup);
diff --git a/include/linux/leds.h b/include/linux/leds.h
index 6b67650d8797..98c479814988 100644
--- a/include/linux/leds.h
+++ b/include/linux/leds.h
@@ -609,10 +609,14 @@ static inline void ledtrig_blkdev_disk_init(struct gendisk *const gd)
 {
 	gd->ledtrig = NULL;
 }
+void ledtrig_blkdev_disk_cleanup(struct gendisk *const gd);
 #else	/* CONFIG_LEDS_TRIGGER_BLKDEV */
 static inline void ledtrig_blkdev_disk_init(const struct gendisk *gd)
 {
 }
+static inline void ledtrig_blkdev_disk_cleanup(const struct gendisk *gd)
+{
+}
 #endif	/* CONFIG_LEDS_TRIGGER_BLKDEV */
 
 #endif		/* __LINUX_LEDS_H_INCLUDED */
-- 
2.31.1

