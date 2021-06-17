Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8807C2B9F4
	for <linux-block@archiver.kernel.org>; Thu, 17 Jun 2021 09:21:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E62C613D5
	for <linux-block@archiver.kernel.org>; Thu, 17 Jun 2021 09:21:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbhFQJX5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Jun 2021 05:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbhFQJX5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Jun 2021 05:23:57 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3034DC061574;
        Thu, 17 Jun 2021 02:21:50 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id m2so4457311pgk.7;
        Thu, 17 Jun 2021 02:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MjsgFk/OhGmlyJ9GkStbusQuxohzSr2Dr8cvabytXHY=;
        b=RKBazyE/iOSOGeAmvhw7ob6qBNoGdlYLkINn9y/wKri5cOtojSjkMkkzrbEDQkFmsw
         TG5olJiPpWKXPkGKaAHjSkPnJWaVzcGmWnh0f7Kn39y2rtkss5rS3tFcUudyHDTVUWFQ
         amg1ml5G8U0vdKR4Kolk4m6qO9gzk944/Uyngefd65QBCaonRbZG8gMyiuMeFwXx+awT
         sen/fAKLWgqzhYJIxxrl6fhbauI4/oBrO8Qwg6hwVwjqKNQ670xEXQCsTFfIZz0hDf79
         Q+2jn7kCXWGXAFhpa2pqXZ/NCoOTG9plmXABtU3Nx+qKkJCC38g3Fxc0ZWPKwYfNb8la
         eFsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MjsgFk/OhGmlyJ9GkStbusQuxohzSr2Dr8cvabytXHY=;
        b=DE7/rgnH4LHZxgNDOy8XUaf2HH8tkCUzzMT6Kh/8ljZqijlT+rPR5YvOUSp2dCDRsH
         0LsVB0r1u1THESizNcYgDup5xJLH81MQzzihrPJeDJT5cH7UELYzZs7LGShVVpuxiceY
         JRodk+PLU9gNtUraYxRq/UZ/dVx1/lb+rs/MfEKcxQySQq8vXwVguLEdh3gfMY/gTUqr
         chk3pzA9NxdLCeFVVV5R68TNkxKjR/K4S+1OUB9/TfdMUuJRB4Iu4BvNIYMnEO/5VcRd
         PPr4keeK8rRnHnlTtZrzFhtZpmq5+zZlI7SMl70/FCx2xnjTO2dzfh1UTy1na0OhBeCx
         OE0g==
X-Gm-Message-State: AOAM533ctsW/w7/D5fvRez3JyrZMlBnG++nFq+Ar/7bb7U7ZsxcjKPJN
        AlVTlOFB9JKdWUbjpnH0Qcs=
X-Google-Smtp-Source: ABdhPJxZSlvznUD/LnFtSXnCP+oNyD0cSKUXJLDJllcY/fa9oZZufuRZx2HQZO6pw9+feqlxFHi0jQ==
X-Received: by 2002:aa7:949c:0:b029:2fa:c881:dd0 with SMTP id z28-20020aa7949c0000b02902fac8810dd0mr4329426pfk.9.1623921709657;
        Thu, 17 Jun 2021 02:21:49 -0700 (PDT)
Received: from localhost.localdomain ([118.200.190.93])
        by smtp.gmail.com with ESMTPSA id v14sm5090542pgo.89.2021.06.17.02.21.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 02:21:49 -0700 (PDT)
From:   Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
To:     axboe@kernel.dk
Cc:     Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org, gregkh@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+6a8a0d93c91e8fbf2e80@syzkaller.appspotmail.com
Subject: [PATCH] block: break circular locks in blk_request_module
Date:   Thu, 17 Jun 2021 17:20:16 +0800
Message-Id: <20210617092016.522985-1-desmondcheongzx@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Syzbot reported a circular locking dependency:
https://syzkaller.appspot.com/bug?id=7bd106c28e846d1023d4ca915718b1a0905444cb

This happens because of the following lock dependencies:

1. loop_ctl_mutex -> bdev->bd_mutex (when loop_control_ioctl calls
loop_remove, which then calls del_gendisk; this also happens in
loop_exit which eventually calls loop_remove)

2. bdev->bd_mutex -> mtd_table_mutex (when blkdev_get_by_dev calls
__blkdev_get, which then calls blktrans_open)

3. mtd_table_mutex -> major_names_lock (when register_mtd_blktrans
calls __register_blkdev)

4. major_names_lock -> loop_ctl_mutex (when blk_request_module calls
loop_probe)

Hence there's an overall dependency of:

loop_ctl_mutex   ----------> bdev->bd_mutex
      ^                            |
      |                            |
      |                            v
major_names_lock <---------  mtd_table_mutex

We can break this circular dependency by saving the reference to
probe in blk_request_module, then calling it after releasing
major_names_lock. This is safe because even if struct blk_major_name
is freed, the reference to the probe function is still valid.

Reported-and-tested-by: syzbot+6a8a0d93c91e8fbf2e80@syzkaller.appspotmail.com
Signed-off-by: Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
---
 block/genhd.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/block/genhd.c b/block/genhd.c
index 9f8cb7beaad1..ccaa5cf620f5 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -676,12 +676,14 @@ void blk_request_module(dev_t devt)
 {
 	unsigned int major = MAJOR(devt);
 	struct blk_major_name **n;
+	void (*probe)(dev_t devt);
 
 	mutex_lock(&major_names_lock);
 	for (n = &major_names[major_to_index(major)]; *n; n = &(*n)->next) {
 		if ((*n)->major == major && (*n)->probe) {
-			(*n)->probe(devt);
+			probe = (*n)->probe;
 			mutex_unlock(&major_names_lock);
+			probe(devt);
 			return;
 		}
 	}
-- 
2.25.1

