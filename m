Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28621C4332F
	for <linux-block@archiver.kernel.org>; Fri,  9 Dec 2022 14:53:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbiLIOxk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 9 Dec 2022 09:53:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbiLIOxh (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 9 Dec 2022 09:53:37 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA9B60B66
        for <linux-block@vger.kernel.org>; Fri,  9 Dec 2022 06:53:36 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id i15so3410895edf.2
        for <linux-block@vger.kernel.org>; Fri, 09 Dec 2022 06:53:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8SGWONfVHjklNBkXRu6sFYgnXokffLko1IC/BWEcSP8=;
        b=CFMhSCPpgXLUtR6ZiK2YFnEjmqjxsmtam0ueM6OrVLZCwoq1Oilpg6M5PZJ5VDSeRY
         2nE9gDgF744dYJmapJAukrxcvxghsFbizFHO8pW5DKE2bzJ3FsilMaxka5dKBEWkrFR4
         bxIYOOHLxBKLfut+dvsdXvJml72ts9e+HPqwQ4iEBjXFew8vsZmblks6fGeIbkP2nGs8
         tyYw5HkvY8I//dTSV7SXupiPcIQdsZUp8TVf4DuVTEdPoxPhV+9siPeVNOT9GGlyGMBc
         mIchahEZyIMQQwH165aDUoaTh7N0GnYCdaLRx0RV38O0s9CtpE6NIeVbckZg5bXk6bN6
         gveg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8SGWONfVHjklNBkXRu6sFYgnXokffLko1IC/BWEcSP8=;
        b=Bx/9LkTJSCXHnN/az19ReNOW70AJukzaTYuI3LocehAMsdnyURMZBXRkOc5GnCc1JL
         Q6IHfcmsIk/SXCD22R22qsMdsXk2m30Y8Ijg2HhWVOtOwBoZ4N33MNpHDTRoiP9sYSq8
         VGWh0+cptB+FkmEOZNSHKTl5pJNYEVDqnCkbFNXz/6ioFaXY8/ZSJ9GkF/AVknjjgO9M
         3n9K8Xtx45aUpfXuR+OVoT0UCGr0Wgtfs9iolEPapbAiLpwEkwPg37eAS8PU8Qwu4Phk
         YEDxHDBLruxKFL1t+OOdu1/jwvy5Ak8ybZaWhn0lQt/oKpGqoyIQgb6IarClekhuIk87
         1XTg==
X-Gm-Message-State: ANoB5plwNjTbog9S2Qnn73z6GZxofYHJChAxybEm3Ig/BTYfJdkDoYZb
        9dI2TyHLPSmfbwMzxu4VEMZC9A==
X-Google-Smtp-Source: AA0mqf5B8665LOfSRiKHkdYlF7U7pudYJLGfAmYc2LJBFOdrl94ZlNt0ilq4X+thHNKv4jvSoQf7Ew==
X-Received: by 2002:a05:6402:1f06:b0:461:7da0:f85a with SMTP id b6-20020a0564021f0600b004617da0f85amr5871865edb.5.1670597615018;
        Fri, 09 Dec 2022 06:53:35 -0800 (PST)
Received: from localhost.localdomain (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id bd21-20020a056402207500b0046bb7503d9asm728424edb.24.2022.12.09.06.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 06:53:34 -0800 (PST)
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
Subject: [PATCH 4/8] drbd: remove unnecessary assignment in vli_encode_bits
Date:   Fri,  9 Dec 2022 15:53:23 +0100
Message-Id: <20221209145327.2272271-5-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221209145327.2272271-1-christoph.boehmwalder@linbit.com>
References: <20221209145327.2272271-1-christoph.boehmwalder@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
Reviewed-by: Joel Colledge <joel.colledge@linbit.com>
---
 drivers/block/drbd/drbd_vli.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_vli.h b/drivers/block/drbd/drbd_vli.h
index 1ee81e3c2152..941c511cc4da 100644
--- a/drivers/block/drbd/drbd_vli.h
+++ b/drivers/block/drbd/drbd_vli.h
@@ -327,7 +327,7 @@ static inline int bitstream_get_bits(struct bitstream *bs, u64 *out, int bits)
  */
 static inline int vli_encode_bits(struct bitstream *bs, u64 in)
 {
-	u64 code = code;
+	u64 code;
 	int bits = __vli_encode_bits(&code, in);
 
 	if (bits <= 0)
-- 
2.38.1

