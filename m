Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 255C8C4167B
	for <linux-block@archiver.kernel.org>; Fri,  9 Dec 2022 14:54:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbiLIOyD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 9 Dec 2022 09:54:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbiLIOxp (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 9 Dec 2022 09:53:45 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B673461741
        for <linux-block@vger.kernel.org>; Fri,  9 Dec 2022 06:53:39 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id e13so3394728edj.7
        for <linux-block@vger.kernel.org>; Fri, 09 Dec 2022 06:53:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w8l6YI6ll5WTtemsFOxZHnG0tRV3sgRpFSwrNSjhQUI=;
        b=QFl7VoOtaGk5JJJiTD/4KIC5FLgDPhNuBOMrb3WnSAoODL2ltc52rELA5f6yl7Bn7j
         mYbNUsXfDCJ75uQrG1lZrpy8vrWDSlLuNc+DwsQQohwm/k745BMOpiYBdnk8YyDlL9Fq
         7eDn+Dtw+CSLH6wmrmqvtN68OZ461bwi3ogQi4pmiDXFrr15Amw9K+7sAjoYiCPtv/mc
         PMf+aDonj+6iew+Dh+5hsyQ1LSgQ6rvpmF51QrTg0U24d6fmLo6yxPrsR37jHc1CbRMJ
         tBqK9JcG0+r3Xk6QRttN7gv2gLonVRU/cK8VMDIfHh+fZ3qa8enXQbuW2vEfMals9jM0
         IO5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w8l6YI6ll5WTtemsFOxZHnG0tRV3sgRpFSwrNSjhQUI=;
        b=B5WX7oprWnmdxG9JHgRpYv8RuT1U85IaFHOU1iaBW33MX6WBMsO82i5SqJ118z0e8p
         wbV/IC0BtGLAAyyzbdVRc6KnudH0H7tcbbFd11N4gl6Tj7SKND2zWNdtWMnK8vBRpLvU
         3ZtiGhCyboUCt2QdPY3mGlT4u8r/m2pPIQxJ5KgDPMSJNeoQAGK0mYxrvdEpIzI+g07S
         8YhEx0XLcWb8q+neolWPlO2yHLYMCJT6NeFJzFvtjycs7xHVtT5Emm+PBGkVR1oAC5Cl
         iODwc0XyncFSy9u9y10fbehFMDUVxlSRSttfltB0X9EoK9VWBTSsPkjTHSLnMvzMdBSI
         7r8Q==
X-Gm-Message-State: ANoB5pkVxzqEamCnNK26TPVl5XZNMvOZxhEQiTwggZzFIXDErO18oCqL
        Vg0C+vkJDfdh0jtGXQMheJ7sUg==
X-Google-Smtp-Source: AA0mqf7iTbuKTrRATtfWNUUyFaIEQ2x3dRPnmp/q01kefuttCVcLa6LUxjn6tqOZ2JV/H/DHj4tTxw==
X-Received: by 2002:aa7:cd46:0:b0:46d:e3f8:4ed4 with SMTP id v6-20020aa7cd46000000b0046de3f84ed4mr2215720edw.21.1670597618194;
        Fri, 09 Dec 2022 06:53:38 -0800 (PST)
Received: from localhost.localdomain (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id bd21-20020a056402207500b0046bb7503d9asm728424edb.24.2022.12.09.06.53.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 06:53:37 -0800 (PST)
From:   =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        linux-block@vger.kernel.org,
        Andreas Gruenbacher <agruen@linbit.com>,
        =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
Subject: [PATCH 8/8] drbd: drbd_insert_interval(): Clarify comment
Date:   Fri,  9 Dec 2022 15:53:27 +0100
Message-Id: <20221209145327.2272271-9-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221209145327.2272271-1-christoph.boehmwalder@linbit.com>
References: <20221209145327.2272271-1-christoph.boehmwalder@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Andreas Gruenbacher <agruen@linbit.com>

Signed-off-by: Andreas Gruenbacher <agruen@linbit.com>
Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
 drivers/block/drbd/drbd_interval.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_interval.c b/drivers/block/drbd/drbd_interval.c
index b6aaf0d4d85b..873beda6de24 100644
--- a/drivers/block/drbd/drbd_interval.c
+++ b/drivers/block/drbd/drbd_interval.c
@@ -58,7 +58,7 @@ drbd_insert_interval(struct rb_root *root, struct drbd_interval *this)
  * drbd_contains_interval  -  check if a tree contains a given interval
  * @root:	red black tree root
  * @sector:	start sector of @interval
- * @interval:	may not be a valid pointer
+ * @interval:	may be an invalid pointer
  *
  * Returns if the tree contains the node @interval with start sector @start.
  * Does not dereference @interval until @interval is known to be a valid object
-- 
2.38.1

