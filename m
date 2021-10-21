Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A1E7C433EF
	for <linux-block@archiver.kernel.org>; Thu, 21 Oct 2021 06:51:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7873C61362
	for <linux-block@archiver.kernel.org>; Thu, 21 Oct 2021 06:51:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231228AbhJUGxm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Oct 2021 02:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbhJUGxl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Oct 2021 02:53:41 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA51FC06161C;
        Wed, 20 Oct 2021 23:51:22 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id x66so1670858pfx.13;
        Wed, 20 Oct 2021 23:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4IT569PC5azMfJUgBeCpQwHxR9xWFaiNqcnPd3IC73s=;
        b=q3pSCZDRL5KRM3nvMGV2JXBH/4b6ox9NxeQKc+0sSfJ777k+A0GZnc86SKVZm8B6FP
         KiZFZcKa2lKX0xrSbZroAher8ZC35dXlFmyWaFImSw6Bxx7FR/E1+HvowzD0zQ1GtIyM
         SVjBPAcBWR4c60+CeEGyMTq0P6DQR55mf9MXq9XB6cAy6xTapHI1ybFdwpW58QXaWXJ+
         8h6QidGoNMOJQspJNWmYXM5ZVodysciypEoAfx/zHNfrrvJ83QUgjT8keumD/10XFWiF
         8hIr7rVqE30Y4ot56oqV7xAPFqqDaYw7vjWiSq/TgQqNLPSMOoLHICJj0wgsqaBTDPEk
         JUYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4IT569PC5azMfJUgBeCpQwHxR9xWFaiNqcnPd3IC73s=;
        b=Fhr5Qus8A6Zc3JwUjoOzn4Py7nA2aABFaGaUmBfm/2ehqP74YQCBnqSnhCMAAJwvpj
         MUMnqgvUbWIZfir6e1yAMI35yoWkmTkrXHDvK+YUkcxcYivyXzHuGrSysj+u+jK2H9qS
         WEU8voOnVuKPjin4aX7Kzrf8PT96DTtJxAlQqWtP02t0lHVPY/GyQmLJoQzinfhMcpre
         +tcN/wgL9zcDylXwB/gletDwHEbjIwldf0Ja4UIHjxaXnnZ2MEucbNeCOy9PlM5iBqgX
         jPPbUjguMwFW32OGpW1QKRiUjycGB96FyTaOSOXzlqc0u4UyDpO9iDhZWtyqqqN7yDA/
         Q3uA==
X-Gm-Message-State: AOAM531tO8gv87inYNqgxhGQfrTvs+KMo5x8pojVcBOaTv+m/8wF35HS
        i5Y1JXNTKbpOI/3KCDSnJFU=
X-Google-Smtp-Source: ABdhPJz0BJlpzbnAEevj8A4yskyuz6x05+ew4k5oZvbTEUsltQEBNmRkeig+0JTifRTceHvzgu4sig==
X-Received: by 2002:a62:e510:0:b0:44c:e06e:80dd with SMTP id n16-20020a62e510000000b0044ce06e80ddmr3623411pff.48.1634799082315;
        Wed, 20 Oct 2021 23:51:22 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id r14sm4063254pgn.91.2021.10.20.23.51.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 23:51:21 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: ye.guojin@zte.com.cn
To:     mst@redhat.com
Cc:     jasowang@redhat.com, pbonzini@redhat.com, stefanha@redhat.com,
        axboe@kernel.dk, virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ye Guojin <ye.guojin@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] virtio-blk: fixup coccinelle warnings
Date:   Thu, 21 Oct 2021 06:51:11 +0000
Message-Id: <20211021065111.1047824-1-ye.guojin@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Ye Guojin <ye.guojin@zte.com.cn>

coccicheck complains about the use of snprintf() in sysfs show
functions:
WARNING  use scnprintf or sprintf

Use sysfs_emit instead of scnprintf or sprintf makes more sense.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Ye Guojin <ye.guojin@zte.com.cn>
---
 drivers/block/virtio_blk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 303caf2d17d0..8a71b2f9f4b7 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -624,7 +624,7 @@ cache_type_show(struct device *dev, struct device_attribute *attr, char *buf)
 	u8 writeback = virtblk_get_cache_mode(vblk->vdev);
 
 	BUG_ON(writeback >= ARRAY_SIZE(virtblk_cache_types));
-	return snprintf(buf, 40, "%s\n", virtblk_cache_types[writeback]);
+	return sysfs_emit(buf, "%s\n", virtblk_cache_types[writeback]);
 }
 
 static DEVICE_ATTR_RW(cache_type);
-- 
2.25.1

