Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 444ACC54EBE
	for <linux-block@archiver.kernel.org>; Fri, 13 Jan 2023 12:45:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241471AbjAMMpL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 13 Jan 2023 07:45:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241985AbjAMMoQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Jan 2023 07:44:16 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35926101F9
        for <linux-block@vger.kernel.org>; Fri, 13 Jan 2023 04:36:30 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id fy8so51883771ejc.13
        for <linux-block@vger.kernel.org>; Fri, 13 Jan 2023 04:36:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T5KT6Auu94HJGq65sn5VmhXW8yJRnWzEtldTHa29AT0=;
        b=iEvtkhCXslE72xJ4rRq1o4dPaZjuX9JLsa7ypmZFDHZvO1spA7qgOqdlMIgNqmOd4Q
         BmnYm1AreZ0f08H6qA5zzq1vhit1vtTePd21UHj1cHFD1HjWkkgvd6vUd0NYq3Flo4tW
         PU4z44ieH6GRE99WOpB7LDRHJPfdP/JK0iDdurBhlgpJdztFtfu1wNuJqycRTt4DfmwJ
         DKQGPJsW0QdNBPlwzpGCReJQBTQGz5fJbIzvrcijgWMbeBy62bZDqSBq0eYILOugbfBK
         POQt3cU00BEvXOTS6Px7H7/seYT2YAjrwmY0BkAOAChZsa+VBCMGVy2V6DjUXPacBhb7
         5YvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T5KT6Auu94HJGq65sn5VmhXW8yJRnWzEtldTHa29AT0=;
        b=MeXr7PLRrJD6Uq7/KXUb9gxItuB1ccZkUdlwm2OvqJ3rjgUZvaXMlzvdEfEuRmDLxo
         SECC1Zfc8QSsbTS2zg+Vq2/PZfeD7MZtv8vZinY/qTKDYUm6KfNNzLkj4fbCLyUGfmeu
         mwudCCkosoGdvUZjHsVEDNFH5IoAHm0BT847Qmvz5l8dyYDBDKi86cP/ieOCZqUzojWp
         jRI/y/68UhFu1rnPP7oE5IxkLCMuiuliI1js9PXTt3svaxgX5GU/Dzr++V3SCzpD0ggV
         LSyBdwgO2dfsg1Y0vhe26jtVbERL/jH0NK/foaDKUqa7/RXE3rcovVUD8zjO+3DNKMNp
         wI2g==
X-Gm-Message-State: AFqh2kpHez/KIeMJqdwRwW60k022KX3ZtxXNgyhz9CnJb4/1rLA2AmLI
        P9mpUJRxuTvsKIe3E6Ax1uT4vA==
X-Google-Smtp-Source: AMrXdXv2f3WJ7TxaCpga5NoHE+9yIqEbHRcFtx8jGKJkLWIR0zf6tV2L+T7DlJE4PxvQYKOiiXMw5A==
X-Received: by 2002:a17:907:7f12:b0:7c1:9eb:845b with SMTP id qf18-20020a1709077f1200b007c109eb845bmr3841305ejc.16.1673613348224;
        Fri, 13 Jan 2023 04:35:48 -0800 (PST)
Received: from localhost.localdomain (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id 17-20020a170906329100b007c0bb571da5sm8402496ejw.41.2023.01.13.04.35.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 04:35:47 -0800 (PST)
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
Date:   Fri, 13 Jan 2023 13:35:37 +0100
Message-Id: <20230113123538.144276-8-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230113123538.144276-1-christoph.boehmwalder@linbit.com>
References: <20230113123538.144276-1-christoph.boehmwalder@linbit.com>
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

