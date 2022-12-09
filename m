Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FC6CC04FDE
	for <linux-block@archiver.kernel.org>; Fri,  9 Dec 2022 14:53:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbiLIOxh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 9 Dec 2022 09:53:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbiLIOxg (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 9 Dec 2022 09:53:36 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E68D65FBB0
        for <linux-block@vger.kernel.org>; Fri,  9 Dec 2022 06:53:34 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id l11so3404650edb.4
        for <linux-block@vger.kernel.org>; Fri, 09 Dec 2022 06:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HcVlem0HZR7YKz5CwTwpHOGM7j8McIJNietyZfce8tM=;
        b=77ztn6yxYoQdI/YjNQ64stUrZKMYVjJNZx3RqQPwE5Wzgy2iNARTjl57kwyY9Zcf5v
         AoRy0cMdwuO3oXgyaDlqa4AO0FQSK0M/l5ILUynxqoovllneXCqvEsb3dQq/sF1bqG+0
         JDKKUch4nKy4Ckc+IkGNltsHt/14NWOSaDiKrHLI80U0yPjRxtNg1MJo/h8NYBZTKE8C
         0Y3c4Y3/0C7eLUMc15WErXKWHsHUP4MOMLoanzaXBXv991Quu3cx5lLBxhP6nHeJgAsu
         +zjMJS6eDVORei+1mDjWhF2h6MknRksnGeFhC7GR70deNL08vL680eWJaG7nF6IhyTlq
         PYPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HcVlem0HZR7YKz5CwTwpHOGM7j8McIJNietyZfce8tM=;
        b=RQpEXZOI6Sl3JKCKEohE2Nxr8OvDD39pXfB9RVSmGzniacEM9YIV0UU5maLIxxXB9+
         rfgJLHKAHAkxBE3r0kdmnK+H0+SbOZJLmTqazNmnmQjy02m8N4r/sfvCq5BANosAj4Bg
         wSiqoarXgplKgMY5v37qkOacBmLxetfhVms8oYPo10xXI3K/oA0b3Y8IOluIJ+9sHHGM
         p+WGEcG5Aw+9BumKFpn197wDmUwLrSP9YmEzxd05aPrK4Cxj9ykV34xZILxrkgQqqKpN
         GbzIVuFDXSNuKcipcSqNIGoI7m/G46VnEVZKKqkot74A7AdR6gzJCA9KAMXLeYMGd2r7
         Waeg==
X-Gm-Message-State: ANoB5pm8AvZeR8BlsanLdgK6LQGPnCtVn0hqq2dVqXQvLZ5EniXP+S5d
        fPYtz3QB64yoe8diN6zs0yAzIg==
X-Google-Smtp-Source: AA0mqf4QBPxAoxCzOvfQ8ZV6Q8UrQRb+58nSkaX+fyojG9uAWnXpr9Q7MI6KTomuZ8maaIi8/DhqUw==
X-Received: by 2002:a05:6402:4501:b0:461:de81:d194 with SMTP id ez1-20020a056402450100b00461de81d194mr5113173edb.31.1670597613561;
        Fri, 09 Dec 2022 06:53:33 -0800 (PST)
Received: from localhost.localdomain (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id bd21-20020a056402207500b0046bb7503d9asm728424edb.24.2022.12.09.06.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 06:53:33 -0800 (PST)
From:   =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        linux-block@vger.kernel.org,
        Robert Altnoeder <robert.altnoeder@linbit.com>,
        =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>,
        Joel Colledge <joel.colledge@linbit.com>
Subject: [PATCH 2/8] drbd: fix DRBD_VOLUME_MAX 65535 -> 65534
Date:   Fri,  9 Dec 2022 15:53:21 +0100
Message-Id: <20221209145327.2272271-3-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221209145327.2272271-1-christoph.boehmwalder@linbit.com>
References: <20221209145327.2272271-1-christoph.boehmwalder@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Robert Altnoeder <robert.altnoeder@linbit.com>

The protocol uses -1 as a reserved value for
'no specific volume', and since the protocol field
is a 16 bit unsigned value, -1 is converted to
65535. Therefore, limit the range of valid volume
numbers to [0, 65534].

Signed-off-by: Robert Altnoeder <robert.altnoeder@linbit.com>
Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
Reviewed-by: Joel Colledge <joel.colledge@linbit.com>
---
 include/linux/drbd_limits.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/drbd_limits.h b/include/linux/drbd_limits.h
index d64271ccece4..058f7600f79c 100644
--- a/include/linux/drbd_limits.h
+++ b/include/linux/drbd_limits.h
@@ -21,7 +21,7 @@
 #define DRBD_MINOR_COUNT_DEF 32
 #define DRBD_MINOR_COUNT_SCALE '1'
 
-#define DRBD_VOLUME_MAX 65535
+#define DRBD_VOLUME_MAX 65534
 
 #define DRBD_DIALOG_REFRESH_MIN 0
 #define DRBD_DIALOG_REFRESH_MAX 600
-- 
2.38.1

