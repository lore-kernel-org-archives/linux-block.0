Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE7D9C4167B
	for <linux-block@archiver.kernel.org>; Fri,  9 Dec 2022 14:53:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbiLIOxs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 9 Dec 2022 09:53:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbiLIOxj (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 9 Dec 2022 09:53:39 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A4060371
        for <linux-block@vger.kernel.org>; Fri,  9 Dec 2022 06:53:38 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id gh17so12067215ejb.6
        for <linux-block@vger.kernel.org>; Fri, 09 Dec 2022 06:53:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T5KT6Auu94HJGq65sn5VmhXW8yJRnWzEtldTHa29AT0=;
        b=qH3VWd11DupxgvhV7pRjAnxBZRPHRVTf98egvIoxinGVQRaCd3ZF6czmLJrKGMYXsB
         RPHSkdAu9kOeJaTYhohXQXSGeMniGLXhcla20EEwDNTC1pwXdIdgGpwsv7c5MUKiVfJ4
         R1VvZPx8vqt/LI+/3wwHRHtRFyTNoI0svx/XUBUrBuvjF/bzvA/Y6OWRrm0xZtMvR/F+
         GYGXyzCyfra0P4oZkNg1YSYhQYcyfjze8MWS1K+ayD2T8KOWYRpy/oTWm5ghL2KGPbFm
         OyE/IwQEY7caV74dSK229wiG3ZJJvY53vrA2EAt4e0G0x3uKy7Z06SVhwwjmN7Rh4MdS
         DY/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T5KT6Auu94HJGq65sn5VmhXW8yJRnWzEtldTHa29AT0=;
        b=HIK+fqMbVGEOtxqhymqLcHSJUEaz1hxib42ZvNbwSYknHyAt+YEZeuh7cUiF5VNpli
         RQLPCC8gqYFdUlS1jJpsohXqdAEtcruv6wUPI8Ih9cil9GvXlNx4BuRWWDMtraHUfeen
         cMXwxxPABL4gefO2n8451r3y4b4biKaUcaOE0X1oET3aas9DAoBVFvtxzdnZxBvAvLh+
         H/AGGT9fFUIPaAr03d5qA5yM/ZUWgW2S4Lpe/M59mcfMkctBE+ZwNH+mAOfoY0ZTWNaZ
         4ja2sDV+1Ej02lRnwKdInPYqHbX0YiAgksNM2dTvP2GgWOogRmAorzP2kz1E9ToVxzfU
         BKGQ==
X-Gm-Message-State: ANoB5pmVOppf4BaekYE/zaF87uvE8llTtfR61LGlBS+QK/fzSE0Gc6O6
        0BoesitDVeBky2HSpSDUTA6JFQ==
X-Google-Smtp-Source: AA0mqf7RrKWHYaxtFEHbgrJNq8V3fsNHj2nP6OKdVzjocdU4FuZSfkiFMUFoeWmVa3n6s4SCj1sykw==
X-Received: by 2002:a17:906:3a96:b0:78d:f454:ba4a with SMTP id y22-20020a1709063a9600b0078df454ba4amr6226366ejd.73.1670597617418;
        Fri, 09 Dec 2022 06:53:37 -0800 (PST)
Received: from localhost.localdomain (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id bd21-20020a056402207500b0046bb7503d9asm728424edb.24.2022.12.09.06.53.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 06:53:36 -0800 (PST)
From:   =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        linux-block@vger.kernel.org,
        =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
Subject: [PATCH 7/8] drbd: interval tree: make removing an "empty" interval a no-op
Date:   Fri,  9 Dec 2022 15:53:26 +0100
Message-Id: <20221209145327.2272271-8-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221209145327.2272271-1-christoph.boehmwalder@linbit.com>
References: <20221209145327.2272271-1-christoph.boehmwalder@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Lars Ellenberg <lars.ellenberg@linbit.com>

Trying to remove an "empty" (just initialized, or "cleared") interval
from the tree, this results in an endless loop.

As we typically protect the tree with a spinlock_irq,
the result is a hung system.

Be nice to error cleanup code paths, ignore removal of empty intervals.

Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
 drivers/block/drbd/drbd_interval.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/block/drbd/drbd_interval.c b/drivers/block/drbd/drbd_interval.c
index 5024ffd6143d..b6aaf0d4d85b 100644
--- a/drivers/block/drbd/drbd_interval.c
+++ b/drivers/block/drbd/drbd_interval.c
@@ -95,6 +95,10 @@ drbd_contains_interval(struct rb_root *root, sector_t sector,
 void
 drbd_remove_interval(struct rb_root *root, struct drbd_interval *this)
 {
+	/* avoid endless loop */
+	if (drbd_interval_empty(this))
+		return;
+
 	rb_erase_augmented(&this->rb, root, &augment_callbacks);
 }
 
-- 
2.38.1

