Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FFCAC433ED
	for <linux-block@archiver.kernel.org>; Fri, 30 Apr 2021 10:36:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D22761003
	for <linux-block@archiver.kernel.org>; Fri, 30 Apr 2021 10:36:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbhD3Khp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Apr 2021 06:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbhD3Khn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Apr 2021 06:37:43 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FA9FC06174A;
        Fri, 30 Apr 2021 03:36:55 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id x5so19722705wrv.13;
        Fri, 30 Apr 2021 03:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CUFZeTpcHMP1urWpVFPmMieR1E/+Me56taeXWYDj7jc=;
        b=AX07m7umB5vWVPy4PiZsuRVfDiDlHjhU+3CkmygevTwUwQqkQQ9HV9FdU7Qcu8zV7Y
         xA1kiMKFf9il4t7RoVoZELwZHbDJmZe1e1qg1TNu7hAaxzBNZUqC/HFFUSNxsDo56j2Q
         RydxB2jDpCUXewNiYiFvBzomngfobSn7zDewPzUCWMsroFIzTGW+qCGrB0cz03fY4o+w
         4lQ9eyxL1Fw3i/fO8XuNLduI4RkBDLlR6r6aZa/+VgPxgpoLHFggkO1U/xK3PmYQhO4a
         f5ZvLRGddtGBP4ql2R76m+c+76UkFfXl56eQW35qx56uFk1o/TF+B3IVZOff1fpT3qzd
         x8+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CUFZeTpcHMP1urWpVFPmMieR1E/+Me56taeXWYDj7jc=;
        b=j+YctqyEPlshkCSCWJ8mZk4xcFbVteEE/RmeMzO3wkqS/nYqtvEaf+ynJVwqMbicj3
         e1cbFOl34myZJEeo0U6qnZFyRQ9uPhhIqIX51TeX1zhYVMR+LZQZ97zJy+RVk+eMBqC/
         m2j4CIP6OY5Ny1KM4KYYItS91iCiwlwWa1kCay1jd6L2QYXARhBEq+WeddVmDaxxs2B6
         71GC9B/jXE4BBpnNTg20OE7cM0qbLIpXGBCMmjT2Rj3cG7x7ehgCz4wQZ4kZYC8Mpx+h
         vewAGPRpzBNoqjjFnZE92JuEXWSEF/pnZaernkV2XbhMRuRpfSElLlzhx1KcbWBcuMsW
         9N7g==
X-Gm-Message-State: AOAM530Q3zhfhTSRo+Ub7JyjktY0dHp2d3rRvqMw+R1vCWGd5fYlxtT+
        nTQszwb5I36v6k5MmCfv6clUBg07tUUq0A==
X-Google-Smtp-Source: ABdhPJwD8m4x8ybi8a4G2a0kelm+OgJuPtQ/0oX8XRO+FTs6ZzmAN1ouhImADBjiG1aURe7wXEBZng==
X-Received: by 2002:a5d:6452:: with SMTP id d18mr5843668wrw.127.1619779014072;
        Fri, 30 Apr 2021 03:36:54 -0700 (PDT)
Received: from sohaib-vm.localdomain ([156.200.177.207])
        by smtp.gmail.com with ESMTPSA id n3sm2738353wmi.7.2021.04.30.03.36.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 03:36:53 -0700 (PDT)
From:   Sohaib Mohamed <sohaib.amhmd@gmail.com>
Cc:     a.fatoum@pengutronix.de, sohaib.amhmd@gmail.com,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Jens Axboe <axboe@kernel.dk>,
        virtualization@lists.linux-foundation.org (open list:VIRTIO BLOCK AND
        SCSI DRIVERS),
        linux-block@vger.kernel.org (open list:BLOCK LAYER),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] virtio_blk: cleanups: remove check obsoleted by CONFIG_LBDAF removal
Date:   Fri, 30 Apr 2021 12:36:11 +0200
Message-Id: <20210430103611.77345-1-sohaib.amhmd@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Sohaib <sohaib.amhmd@gmail.com>

Prior to 72deb455b5ec ("block: remove CONFIG_LBDAF"), it was optional if
the 32-bit kernel support block device and/or file sizes larger than 2 TiB
(considering the sector size is 512 bytes)
But now sector_t and blkcnt_t are always 64-bit in size.

Suggested-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
Signed-off-by: Sohaib Mohammed <sohaib.amhmd@gmail.com>
---
 drivers/block/virtio_blk.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index b9fa3ef5b57c..18db60995100 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -447,13 +447,6 @@ static void virtblk_update_capacity(struct virtio_blk *vblk, bool resize)
 	/* Host must always specify the capacity. */
 	virtio_cread(vdev, struct virtio_blk_config, capacity, &capacity);
 
-	/* If capacity is too big, truncate with warning. */
-	if ((sector_t)capacity != capacity) {
-		dev_warn(&vdev->dev, "Capacity %llu too large: truncating\n",
-			 (unsigned long long)capacity);
-		capacity = (sector_t)-1;
-	}
-
 	nblocks = DIV_ROUND_UP_ULL(capacity, queue_logical_block_size(q) >> 9);
 
 	string_get_size(nblocks, queue_logical_block_size(q),
-- 
2.25.1

