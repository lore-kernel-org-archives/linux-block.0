Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85E50C433B4
	for <linux-block@archiver.kernel.org>; Mon, 26 Apr 2021 16:30:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 600C3611CE
	for <linux-block@archiver.kernel.org>; Mon, 26 Apr 2021 16:30:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234400AbhDZQba (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Apr 2021 12:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234385AbhDZQb3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Apr 2021 12:31:29 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E7FC06175F
        for <linux-block@vger.kernel.org>; Mon, 26 Apr 2021 09:30:46 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id i24so6884611edy.8
        for <linux-block@vger.kernel.org>; Mon, 26 Apr 2021 09:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sY7pwJ5XUrAgwm6qxLiYO/Kvi5B35cZY3vNXeQfDpAM=;
        b=Mhnn9Sqg4R0YVY6mscnaoTlrM7x3U9DbcTy9UdrV0GQC389ZTI/taRj5CkWIv8C3ao
         4Zho3We6JccxVbi47DrX5C3bAyLqEl+20uEaVP4PzUEb3EOQ3glpoFmSNrKg2ZwbqQjU
         hooRn9fHo+AtPJb9NaTmDF1WgFAqRPyl2pgPfgdJkfwXdpYZspHAF0Bcru7+FxI62tiD
         0XmaDoHB4aKXQUJ0Ukyu/DsHh615F9bRotbFdhO7Y74g+et+XewMPhKiuD4I6p7G85g+
         4xjNz34UtHSjwDzVhO3H6Qovmvdc+OJ3EUjiMeY5R5a/RgqBu1UVjhwPvIlZPOxYkQge
         kMjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sY7pwJ5XUrAgwm6qxLiYO/Kvi5B35cZY3vNXeQfDpAM=;
        b=HcdZ41vccHurC5PYrDAF21rEEPWj4dWUKDx0pRA93CTd+Xw7XbFF8RkdY2eQI7Xu9L
         KiDp7n1T7J8b3nwpAaz9y188yGF+xVb8OvJPhTl4TCrGR8qKp/LMj8EmgyNTecBEUgJ7
         ZN4mGhpIVIGa929EGsFcYOXjelZM1d9NKM1G45K25oPam/E7UaBMot6rIRppPsVp/ly5
         jlQVWltsYsYG/CdJ/Pt8Gc8xE5gLHqWeCm91UZLBuUZS+YAjVU2/SJdadvdWHtSa+noe
         P7StS22UxYNzaJKX51BNrmAQ5DqlEY7wyog/bDXVmASu4dCc/Mb1kav8SBRDewWtUdnK
         NOHA==
X-Gm-Message-State: AOAM530ZrzQgktA/I7ae6Pi9SNWxN1r7kerQ/6KR82aPd3NpMSK5B9q+
        nqglgmZDVQsxm1hYFDqno9HYEJuzFGWsS84hVUM=
X-Google-Smtp-Source: ABdhPJydqvL5CYnnJgS8/QIp6pHbsixoj+Uw/m4nB4dtt/U5awp7VfdALWcLY2epud1bqGyXI0dAbg==
X-Received: by 2002:a05:6402:617:: with SMTP id n23mr10260006edv.45.1619454645350;
        Mon, 26 Apr 2021 09:30:45 -0700 (PDT)
Received: from localhost.localdomain (85-127-190-169.dsl.dynamic.surfer.at. [85.127.190.169])
        by smtp.gmail.com with ESMTPSA id gt33sm11688479ejc.89.2021.04.26.09.30.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 09:30:44 -0700 (PDT)
Received: from localhost.localdomain (localhost [127.0.0.1])
        by localhost.localdomain (8.15.2/8.15.2) with ESMTPS id 13QGUiXp3454465
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Mon, 26 Apr 2021 18:30:44 +0200
Received: (from christoph@localhost)
        by localhost.localdomain (8.15.2/8.15.2/Submit) id 13QGUh403454464;
        Mon, 26 Apr 2021 18:30:43 +0200
From:   =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
To:     drbd-dev@tron.linbit.com
Cc:     Philipp Reisner <philipp.reisner@linbit.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>, stable@vger.kernel.org
Subject: [PATCH] drbd: fix potential silent data corruption
Date:   Mon, 26 Apr 2021 18:30:32 +0200
Message-Id: <20210426163032.3454129-1-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Lars Ellenberg <lars.ellenberg@linbit.com>

Scenario:
---------

bio chain generated by blk_queue_split().
Some split bio fails and propagates its error status to the "parent" bio.
But then the (last part of the) parent bio itself completes without error.

We would clobber the already recorded error status with BLK_STS_OK,
causing silent data corruption.

Reproducer:
-----------

How to trigger this in the real world within seconds:

DRBD on top of degraded parity raid,
small stripe_cache_size, large read_ahead setting.
Drop page cache (sysctl vm.drop_caches=1, fadvise "DONTNEED",
umount and mount again, "reboot").

Cause significant read ahead.

Large read ahead request is split by blk_queue_split().
Parts of the read ahead that are already in the stripe cache,
or find an available stripe cache to use, can be serviced.
Parts of the read ahead that would need "too much work",
would need to wait for a "stripe_head" to become available,
are rejected immediately.

For larger read ahead requests that are split in many pieces, it is very
likely that some "splits" will be serviced, but then the stripe cache is
exhausted/busy, and the remaining ones will be rejected.

Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
Cc: <stable@vger.kernel.org> # 4.13.x
---

Note: this will need to be backported to versions prior to 4.13 too, but
the API changed in the meantime (from the new bio->bi_status to the old
bio->bi_error). I will send a separate patch for these older versions.

In addition, the generic bio_endio/bio_chain_endio has to be fixed in
a similar way for versions before 4.6. This equates to a backport of
upstream commit af3e3a5259e3 ("block: don't unecessarily clobber bi_error
for chained bios").

 drivers/block/drbd/drbd_req.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_req.c b/drivers/block/drbd/drbd_req.c
index 9398c2c2cb2d..a384a58de1fd 100644
--- a/drivers/block/drbd/drbd_req.c
+++ b/drivers/block/drbd/drbd_req.c
@@ -180,7 +180,8 @@ void start_new_tl_epoch(struct drbd_connection *connection)
 void complete_master_bio(struct drbd_device *device,
 		struct bio_and_error *m)
 {
-	m->bio->bi_status = errno_to_blk_status(m->error);
+	if (unlikely(m->error))
+		m->bio->bi_status = errno_to_blk_status(m->error);
 	bio_endio(m->bio);
 	dec_ap_bio(device);
 }
-- 
2.26.3

