Return-Path: <SRS0=4wZT=BB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65150C433E2
	for <linux-block@archiver.kernel.org>; Wed, 22 Jul 2020 10:27:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38B1920729
	for <linux-block@archiver.kernel.org>; Wed, 22 Jul 2020 10:27:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="d5v3GZHu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728599AbgGVK1P (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Jul 2020 06:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731203AbgGVK1P (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Jul 2020 06:27:15 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7E55C0619DE
        for <linux-block@vger.kernel.org>; Wed, 22 Jul 2020 03:27:14 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id n22so1659070ejy.3
        for <linux-block@vger.kernel.org>; Wed, 22 Jul 2020 03:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=W+7tLjvt0BWcidRoTzG/t7+SsWX9LjazHSpPYqjY3Ww=;
        b=d5v3GZHuvndVFZ4GbqVfkTFs7OOHi8ljIpC0aKgQ/WOBIHLU75JigzwZFkEgJtTh93
         W6JCr8eyU956r/Igl8qOgsKaHnmVl8vg7KdwNC+xvHqTcQDXGZiWoorQho80EzecNEiB
         pwjxz1lP9Ii6xLI1U0HCzw25kZ6l+TmK1Ud7u0K947ZrmdtBuQrr1mdvQnhZfPAQJNSj
         5KvxFIZigLUrl6JsYs+AdiCdr+Ng1MFuxI/slxcga5kK9AgaHB6J5f1t2j0jZCSvDA1v
         nfknyK7ckegpUUgCvJRyjdciS55N+h+UG7g8Lv+t9VwxQ583ZpXnKG6yaVNmSyQmvFdk
         bhzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=W+7tLjvt0BWcidRoTzG/t7+SsWX9LjazHSpPYqjY3Ww=;
        b=oSPXd1WJqYqePLim4/8ne0AVydwKzDvhQ3pHqino93Ma2vYPnJs9p+pyNzdOO37Bv7
         ZvKJtuNJSaONzMJ7IdQyFMLYg0YwyEYer9P4aOSZ61YcKSzWplO5lUe+w21cDEVvzygd
         VCro0ORTt19HzTSId5cRmgJWGiCs9dQ/fXnHUCW+m/U/TjRB520vUK7254Yo6oJTYy2g
         TBdUBc9USeU4XelI00bz1FtE8V0+5JMp1HZ1Sta1Vad1cFFPTAkjHugsOw38b+493niS
         lsqccPcpdEnyNMkdtplx1T983K7498eJDE/PQuUijsu3M6RV9WEpXCqPM7avELX07UiC
         Cg0A==
X-Gm-Message-State: AOAM533RksJ2NLuepanthH2tgne5EvToLrxzvf18j6sDhO6pfUequ1I0
        vc+wxA64GrTI6GkoTGtigdW/RA==
X-Google-Smtp-Source: ABdhPJy3fxGJbp5Tgeh6OHqOTEc60aTjyYy6Gy8z45ccS1gWZxsKuWiTmAfGWI6q021kOk0eZc9ioQ==
X-Received: by 2002:a17:906:9716:: with SMTP id k22mr29563349ejx.200.1595413633487;
        Wed, 22 Jul 2020 03:27:13 -0700 (PDT)
Received: from ls00508.pb.local ([2001:1438:4010:2540:c136:467c:a322:7c9f])
        by smtp.gmail.com with ESMTPSA id w17sm18581044eju.42.2020.07.22.03.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 03:27:13 -0700 (PDT)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     danil.kipnis@cloud.ionos.com, jinpu.wang@cloud.ionos.com,
        axboe@kernel.dk
Cc:     linux-block@vger.kernel.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH 2/2] rnbd: no need to set bi_end_io in rnbd_bio_map_kern
Date:   Wed, 22 Jul 2020 12:26:53 +0200
Message-Id: <20200722102653.19224-3-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200722102653.19224-1-guoqing.jiang@cloud.ionos.com>
References: <20200722102653.19224-1-guoqing.jiang@cloud.ionos.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Since we always set bi_end_io after call rnbd_bio_map_kern, so the
setting in rnbd_bio_map_kern is redundant.

Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
 drivers/block/rnbd/rnbd-srv-dev.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/block/rnbd/rnbd-srv-dev.c b/drivers/block/rnbd/rnbd-srv-dev.c
index 49c62b506c9b..b241a099aeae 100644
--- a/drivers/block/rnbd/rnbd-srv-dev.c
+++ b/drivers/block/rnbd/rnbd-srv-dev.c
@@ -99,6 +99,5 @@ struct bio *rnbd_bio_map_kern(void *data, struct bio_set *bs,
 		offset = 0;
 	}
 
-	bio->bi_end_io = bio_put;
 	return bio;
 }
-- 
2.17.1

