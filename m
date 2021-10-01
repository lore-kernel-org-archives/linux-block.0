Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9299FC433F5
	for <linux-block@archiver.kernel.org>; Fri,  1 Oct 2021 18:16:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 694AA61411
	for <linux-block@archiver.kernel.org>; Fri,  1 Oct 2021 18:16:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354864AbhJASSW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 1 Oct 2021 14:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbhJASSW (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 1 Oct 2021 14:18:22 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E082C061775
        for <linux-block@vger.kernel.org>; Fri,  1 Oct 2021 11:16:37 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id bv15-20020ad4488f000000b003827388ecfcso14004920qvb.5
        for <linux-block@vger.kernel.org>; Fri, 01 Oct 2021 11:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=hcUl3oIGrwuelQo171PiNoZTnRPOWfpk2tqnEmzSPUM=;
        b=U3DVvg5YX2tw78WA0Ma0btjs8nGR6214yfthJjRFJzABQJAr4AKKvnTiDKhJD4yGJE
         mTNP93z3WZPREcWF3MuzV6X4LtvxjnMVSgVAy2kQcOtDjbm4mWMLarJ12xaUG3PMPKS8
         WuLXtTzxigOHJLl6X15GLtjRX63mRhUQs9PB5QgnayqT+3cdkxSo60QSTsScYEZkCVJB
         rh9pXGZkHxot98fMChmh6P3mB6SoxRkshnAOcN784IEP6U2BKqp4/POJpkg0UuFXbz5p
         at7mNmpzAAA+sqsOulSp1+0ddZ6LYrmpVgFZHFF0M8Ydh2d8YXfIjHV5SvZuVbgsML/Y
         Didw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=hcUl3oIGrwuelQo171PiNoZTnRPOWfpk2tqnEmzSPUM=;
        b=dL7gbRrvkaAY2Nlqw2JAS9rarVCZHd5UIbGdLkqcmt1+S5cNcZcW9zXCHOxn5mnjAm
         7RvNkBDUgx7MfDuNKIllozt6nTaT8r7wN85toUkAZbDGgxsVkHZuFNWxH3DGn69viKOY
         giY1ox8r33wOVcWariHPeyJfQGaKClL/HLRiNVh/uag63ZebO/gsx3fyySbL0KahJq3F
         jDDjclRyQOZL6ww5f1ZCGO0qKvPxeIhXQAGIuGgmeM04pur61vy8SvkBUjsXwqSRG+Y6
         ypvpywgc+s9HzCo6gcxuDJWGtKQ5u1eQjDBlGO9MnEP2xMmpghPoUIBaY4BY5lIFr7LM
         p0Uw==
X-Gm-Message-State: AOAM533MOpaa1MNltIeWLfX0uO69RjJ26sdGyEZeNFlHJP30ov757JNW
        +HcYCUvepVQwHxXbyAtKILayh4+Osz7X
X-Google-Smtp-Source: ABdhPJzDnSE+EX9s57FI34EkdjuBVpq4eMQ7zpwsHvBPxiVUB2waooHWFd5M88cumNrwRUlCxamXk2cBZbwo
X-Received: from bg.sfo.corp.google.com ([2620:15c:11a:202:8b2d:acba:ea70:44e7])
 (user=bgeffon job=sendgmr) by 2002:a05:6214:226c:: with SMTP id
 gs12mr5905396qvb.58.1633112196862; Fri, 01 Oct 2021 11:16:36 -0700 (PDT)
Date:   Fri,  1 Oct 2021 11:16:27 -0700
Message-Id: <20211001181627.394921-1-bgeffon@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.800.g4c38ced690-goog
Subject: [PATCH] zram: Allow backing device to be assigned after init
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

There does not appear to be a technical reason to not
allow the zram backing device to be assigned after the
zram device is initialized.

This change will allow for the backing device to be assigned
as long as no backing device is already assigned. In that
event backing_dev would return -EEXIST.

Signed-off-by: Brian Geffon <bgeffon@google.com>
---
 drivers/block/zram/zram_drv.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index fcaf2750f68f..12b4555ee079 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -462,9 +462,9 @@ static ssize_t backing_dev_store(struct device *dev,
 		return -ENOMEM;
 
 	down_write(&zram->init_lock);
-	if (init_done(zram)) {
-		pr_info("Can't setup backing device for initialized device\n");
-		err = -EBUSY;
+	if (zram->backing_dev) {
+		pr_info("Backing device is already assigned\n");
+		err = -EEXIST;
 		goto out;
 	}
 
-- 
2.33.0.800.g4c38ced690-goog

