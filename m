Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2BABC07E99
	for <linux-block@archiver.kernel.org>; Mon,  5 Jul 2021 10:01:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D925613C1
	for <linux-block@archiver.kernel.org>; Mon,  5 Jul 2021 10:01:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbhGEKDj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 5 Jul 2021 06:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbhGEKDj (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 5 Jul 2021 06:03:39 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E76C061760
        for <linux-block@vger.kernel.org>; Mon,  5 Jul 2021 03:01:02 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id q91so11425435pjk.3
        for <linux-block@vger.kernel.org>; Mon, 05 Jul 2021 03:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zPOrmC1RXgcNJnX31Ibadv5UuQd9PEZ0WGKKpWH0dQY=;
        b=CecTSE6KZsVLTnN0u8fmrWPe/xgLjU6zHobrJl+2rjWm7HX3HMGsn6A+uDgr0+mbC1
         NbfpMp9kQ3BkLhDtsFYhR8DjNIn6svn2+Ei2OheU4ZlrCkprEhA5GuHR/2ocyuaToFGJ
         +tppQnF9dPsY2Crq5b63AaeLMEQbpYbQJEodIg08UHnejItxDI6twSiyNGIehK2naIgC
         7LErc8V5x5EKE2SX3VrY3r80u2XIL8yJsS3ET5vNfdHuBTOZw+I9JUDryPf5+RqFW4uz
         J9DLwifnNrUDktJjG3cbx5UNGbKxN168793V0DrnCYA1LizlAvCAqwkbC1Q9xwBkCkOP
         s2BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zPOrmC1RXgcNJnX31Ibadv5UuQd9PEZ0WGKKpWH0dQY=;
        b=O1yKjl0e5rzuSpiiSHb3QHiULv26ZkCCkOf74XMwS/kP2f+o8k2tJZwgqnen/RvmtU
         GzTt+UnIq4ucyjiatTy0gWwkF0lXV/dLYZqu6oimlLp1Fs/V57qHbEE5bXZDcNjslAtE
         JGYYE8TcbXtv7zjK0duos+8HLZl1LgFYYa3keYyM2RkJw9YIj79YC26foCKu09NuZcaP
         OAk5ncP7O4XDMf33SfyryWbYx5YMKHREyBewPwkQwBde0nYB8edMdVNrBwyh70Tcy1qf
         5SyPc8tK6vA4jVTRzNxJmrZFOBU9Dtq6CjJhKiMEHuFNBdM1UcqzPBNJGDqMflf89xKu
         OJqw==
X-Gm-Message-State: AOAM533pEhyPe6YXgAt1WdluQJMw1r7emM8X/fbNZkBKeerdjFKCUO2Q
        ihRRf9sh3QIrVQCOyr/9z8XV
X-Google-Smtp-Source: ABdhPJzHbop2tIyt7b+CLnVYCy4yRROCsyMt4bNGBhnLwAxog31fNWlijaENvAL2w0znsqFJHNBCVw==
X-Received: by 2002:a17:90b:198a:: with SMTP id mv10mr14686315pjb.67.1625479262030;
        Mon, 05 Jul 2021 03:01:02 -0700 (PDT)
Received: from localhost ([139.177.225.237])
        by smtp.gmail.com with ESMTPSA id s6sm1287849pjp.45.2021.07.05.03.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 03:01:01 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        axboe@kernel.dk
Cc:     virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4] virtio-blk: Add validation for block size in config space
Date:   Mon,  5 Jul 2021 18:00:06 +0800
Message-Id: <20210705100006.90-1-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This ensures that we will not use an invalid block size
in config space (might come from an untrusted device).

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
---
 drivers/block/virtio_blk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index e4bd3b1fc3c2..e9d7747c3cc0 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -819,7 +819,7 @@ static int virtblk_probe(struct virtio_device *vdev)
 	err = virtio_cread_feature(vdev, VIRTIO_BLK_F_BLK_SIZE,
 				   struct virtio_blk_config, blk_size,
 				   &blk_size);
-	if (!err)
+	if (!err && blk_size >= SECTOR_SIZE && blk_size <= PAGE_SIZE)
 		blk_queue_logical_block_size(q, blk_size);
 	else
 		blk_size = queue_logical_block_size(q);
-- 
2.11.0

