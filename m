Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1462C433FE
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 21:24:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C307861355
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 21:24:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbhJSV0t (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Oct 2021 17:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbhJSV0s (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Oct 2021 17:26:48 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 345B2C06161C
        for <linux-block@vger.kernel.org>; Tue, 19 Oct 2021 14:24:35 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id g2so14544803wme.4
        for <linux-block@vger.kernel.org>; Tue, 19 Oct 2021 14:24:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eqByaVwNH1eDBgQxrWe4ZD3BlTfVAS6fttIbCtAyDOI=;
        b=pIUX/q7WhHPLBIVr/tMHIGuHsyHHwYs/7Mon24mXi6hc/vTdvM1INgZ2wVbY4DCLZX
         BUZuGmHjn6r2D8ginDbyM7T7vMGVnmWc8RY+itLzOUgERJmppvIDuA6Dyt5vKDHkpAfq
         4MFf7fsHCzhzh7dV3FYNaw1VdWpjh/d8Hn23u2j3Zs6UFi9EhCQM4YN49hVLary+iziS
         s9T9kP/21AOw8zUNHi8VX4DxzDt6IRALGKWpIeEpdmwJami6pPzFqxjeDadbw/B1+qPo
         3I7duSi+euPj5dgMweTzNcYAu/Bixv/Xx8S/mC/t93oY+whXiGktu56o5d9Gw/MR886G
         6L0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eqByaVwNH1eDBgQxrWe4ZD3BlTfVAS6fttIbCtAyDOI=;
        b=14StiLRRbMI0vVRAmUN9vZmBtplE7f1EG7UViodU5qSg0dR1MASUCO0jYtOCYIDV/t
         wN2ZVcYMWdA3OdZahdTAq57N8XEc22z74QOFYnyOFAKsLlDdWU1plpsAIrzLq5pmodY6
         3v2pnprBFVaqi0hPR35vNqWC0YXpu0zR5aKDQjXeNjUE32f3rrOdwYIiuCQwhbChAO7c
         x2flIqd+tJraCvFJYEU+9Do/FoyvSSzI68DnKOqp5H4vK++Uvm2jVhZ5hOVuCYx4sg9t
         TGp3TIXn5wloRYw7CqWZq++XXwLCllzZmu8sNbByt7UF/bSNzqPo+VIYE/j5wqyuEOOI
         Ss4w==
X-Gm-Message-State: AOAM533XCeCPQTi/hEddRyS6WIioZ0Zx+akDTrXyWy9bVDqCOibewjrr
        hMlU7waVLqNX4luraEK1GQHR8bnkW2Roxg==
X-Google-Smtp-Source: ABdhPJyR5+Ls5k9SMipR1qjzRAYTS9yAQr3bSKFPGNj1gknME7g7J81CJh/5hCRwW5Wld3DTdEtjqQ==
X-Received: by 2002:a1c:2246:: with SMTP id i67mr9185501wmi.72.1634678673622;
        Tue, 19 Oct 2021 14:24:33 -0700 (PDT)
Received: from 127.0.0.1localhost ([185.69.145.194])
        by smtp.gmail.com with ESMTPSA id m14sm216020wms.25.2021.10.19.14.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 14:24:33 -0700 (PDT)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>,
        Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH 01/16] block: turn macro helpers into inline functions
Date:   Tue, 19 Oct 2021 22:24:10 +0100
Message-Id: <a6dbe9a09b7e0695803a944a7f27ecb8480a7409.1634676157.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1634676157.git.asml.silence@gmail.com>
References: <cover.1634676157.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Replace bio_set_dev() with an identical inline helper and move it
further to fix a dependency problem with bio_associate_blkg(). Do the
same for bio_copy_dev().

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 include/linux/bio.h | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/include/linux/bio.h b/include/linux/bio.h
index 9538f20ffaa5..b12453d7b8a8 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -430,22 +430,6 @@ void zero_fill_bio(struct bio *bio);
 
 extern const char *bio_devname(struct bio *bio, char *buffer);
 
-#define bio_set_dev(bio, bdev) 				\
-do {							\
-	bio_clear_flag(bio, BIO_REMAPPED);		\
-	if ((bio)->bi_bdev != (bdev))			\
-		bio_clear_flag(bio, BIO_THROTTLED);	\
-	(bio)->bi_bdev = (bdev);			\
-	bio_associate_blkg(bio);			\
-} while (0)
-
-#define bio_copy_dev(dst, src)			\
-do {						\
-	bio_clear_flag(dst, BIO_REMAPPED);		\
-	(dst)->bi_bdev = (src)->bi_bdev;	\
-	bio_clone_blkg_association(dst, src);	\
-} while (0)
-
 #define bio_dev(bio) \
 	disk_devt((bio)->bi_bdev->bd_disk)
 
@@ -463,6 +447,22 @@ static inline void bio_clone_blkg_association(struct bio *dst,
 					      struct bio *src) { }
 #endif	/* CONFIG_BLK_CGROUP */
 
+static inline void bio_set_dev(struct bio *bio, struct block_device *bdev)
+{
+	bio_clear_flag(bio, BIO_REMAPPED);
+	if (bio->bi_bdev != bdev)
+		bio_clear_flag(bio, BIO_THROTTLED);
+	bio->bi_bdev = bdev;
+	bio_associate_blkg(bio);
+}
+
+static inline void bio_copy_dev(struct bio *dst, struct bio *src)
+{
+	bio_clear_flag(dst, BIO_REMAPPED);
+	dst->bi_bdev = src->bi_bdev;
+	bio_clone_blkg_association(dst, src);
+}
+
 /*
  * BIO list management for use by remapping drivers (e.g. DM or MD) and loop.
  *
-- 
2.33.1

