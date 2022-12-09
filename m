Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D237FC4708D
	for <linux-block@archiver.kernel.org>; Fri,  9 Dec 2022 14:53:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbiLIOxi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 9 Dec 2022 09:53:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbiLIOxg (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 9 Dec 2022 09:53:36 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B3985F6FE
        for <linux-block@vger.kernel.org>; Fri,  9 Dec 2022 06:53:34 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id m19so3386864edj.8
        for <linux-block@vger.kernel.org>; Fri, 09 Dec 2022 06:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sQNKuz5965naByKUS4y1VIo8yUx5dsUc2Lu+3dW2kE8=;
        b=DULViScp0ZVXctPxlfv4qNn3cbilafSOKGMk8dRJw6i79Vudl6DOMfT79rpjRXPf0h
         Cby/vdu1mbCSR5Pn1rz+wJ/UCZYjXWxxXHWINZiipWv4QJoPQadESG07ukq3PX2z1e2y
         QaX76pV4y0QLJ8BAT8gHsy28rsADUqeOHOembmFs70/VOMQVVf6Ubt31LYagnvEc0GJa
         p8KQ4d9Iw3OGQI2KTwoVqlFWfGfaJcfFe/egS5Kmqj2CN19y216WgrcyU94kOCDH7OOt
         P+yF159+WVZEXSM6ECXkVUZ4IbilDRTHiXQ2/MLbb3HqoB3wSY2oZTo8gVb4MzO7CMJC
         G1hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sQNKuz5965naByKUS4y1VIo8yUx5dsUc2Lu+3dW2kE8=;
        b=N4txrRoJCaQV5V9BXnto7Ob7kD4xhRhFEWA8gLuuSYUPS7orC4nkMN8CZFLaK2nwxE
         lEsDp8whR2+V5U1KkhajxjRNfgkvVMVy/EAHvGfoMeM86hPv0sPtDt3UdASdPy12bVpK
         2dNBJ50cwoTPpe/j7RemIB/pc8VQkhNWTlO2bcNoB0b1MSy7esPU5iR63ReUMHyJjWDW
         m39Yqje3791aprafiaHfS5CkIDQRWBilrwrj4yBxg3X65nahPPuakoeS5oMl9eVtiA7a
         AP5WxPXZHf9kLCdD65VgLIgHpB6bgNi9Qh456liF0+oHgMZCaobCfPO01urx2KtfV6iz
         gSwg==
X-Gm-Message-State: ANoB5pkNDUOP9+UC9ssC1JQgcMdburD9m+kFE2+6y/xWPnDQaW8VQUCa
        jVpP5Uax54xTANJOJPqJo9t32Q==
X-Google-Smtp-Source: AA0mqf5/exKOQ2UtDww2W1sqkCHfaWxm6TJeIW8pBJLUQGIbDQbARma3JEOCV+NUeA1Xc09JANibUw==
X-Received: by 2002:a05:6402:25c7:b0:461:c5b4:a7d0 with SMTP id x7-20020a05640225c700b00461c5b4a7d0mr5638007edb.24.1670597612854;
        Fri, 09 Dec 2022 06:53:32 -0800 (PST)
Received: from localhost.localdomain (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id bd21-20020a056402207500b0046bb7503d9asm728424edb.24.2022.12.09.06.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 06:53:32 -0800 (PST)
From:   =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        linux-block@vger.kernel.org,
        =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>,
        Joel Colledge <joel.colledge@linbit.com>
Subject: [PATCH 1/8] drbd: adjust drbd_limits license header
Date:   Fri,  9 Dec 2022 15:53:20 +0100
Message-Id: <20221209145327.2272271-2-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221209145327.2272271-1-christoph.boehmwalder@linbit.com>
References: <20221209145327.2272271-1-christoph.boehmwalder@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

See also commit 93c68cc46a07 ("drbd: use consistent license"). We only
want to license drbd under GPL-2.0, so use the corresponding SPDX header
consistently.

Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
Reviewed-by: Joel Colledge <joel.colledge@linbit.com>
---
 include/linux/drbd_limits.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/drbd_limits.h b/include/linux/drbd_limits.h
index 9e33f7038bea..d64271ccece4 100644
--- a/include/linux/drbd_limits.h
+++ b/include/linux/drbd_limits.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0 */
+/* SPDX-License-Identifier: GPL-2.0-only */
 /*
   drbd_limits.h
   This file is part of DRBD by Philipp Reisner and Lars Ellenberg.
-- 
2.38.1

