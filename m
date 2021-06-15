Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 469D8C48BE5
	for <linux-block@archiver.kernel.org>; Tue, 15 Jun 2021 10:48:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21AFD6142B
	for <linux-block@archiver.kernel.org>; Tue, 15 Jun 2021 10:48:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231502AbhFOKui (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Jun 2021 06:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231337AbhFOKuh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Jun 2021 06:50:37 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 568C7C061574
        for <linux-block@vger.kernel.org>; Tue, 15 Jun 2021 03:48:33 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id g22so6014462pgk.1
        for <linux-block@vger.kernel.org>; Tue, 15 Jun 2021 03:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WdD620LAuh+zdkdFnt6lNMuLD4Se0RjUXXyrRg3LSdI=;
        b=k6fGeowr5S4OWzFSVxVu59P3nQGVdL87Z7WC1vj3M4PC0ADAeYVb0bivQ+dXprQ2Uq
         zFlMKEt4IpTxgya9f5OMRAOhUsmtVH9VC2aB0ms7vdEi+ZJRkvTOPcT5xuozuunk8y1q
         27Cu3WdMSeW2e5ZENtq/2woUsfMHK4sxowmshZ/YA8eHHptU5nhyId9N14P/CNc8E8lv
         BKguteD9e1J/DposFfDT/Hb60fJ7NOnIzDAPQoS2nHdrvgLTfIVKuFSaNoangf0xzDXC
         KLsrTsw8h3TwNe34hivnGEi0jCDwfg3rGqfi6V/xa6EIHWWaYQns0Zle3wCgFmx0zUAL
         YCiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WdD620LAuh+zdkdFnt6lNMuLD4Se0RjUXXyrRg3LSdI=;
        b=AaM4lN4bOeLfpBLoCAZkhETzvn+nuirIV51i8VsyCFqDu70gpI6pwa25uyMS/krRes
         QxU12EUBrfUozRgRRZvlWqgUkHufTvb9husw3kB8Un1YleURl4SxsSLGS9sEo1TPdTzs
         ccFrCA7ySOrBKUGD9rvQuy2s/FAYN05vkGTUKYStbN934gDmAVQuH7XDGXnaX1ospGxJ
         kUZI2SJL1dKbr/ZbvgjbFBEGa6dwzeDXD7lCTeVHYiYT+zgQ8c33AjGqOkTCVIrcBkv/
         qQx3Dmurom22xE5qHY7smbeRh1JCKALTvf7BtlvK5LoZYbOPv5qBpUoG2OvgCPXg3B7P
         Am4w==
X-Gm-Message-State: AOAM53127iyopHxDW3hIbvd43MJOEFK8zBTImfgtymLAKqLiclFNFauk
        Hv8d608dB8wzfJ2+ojDGJjRq
X-Google-Smtp-Source: ABdhPJzl/nkn3/Z8TNrrue6WsPSXZp7LdC8FJV7fH6izqMFpnk1tNpG3TlfEYiBe6BYAWO5bg9lMqw==
X-Received: by 2002:a62:2c92:0:b029:2ef:6118:a934 with SMTP id s140-20020a622c920000b02902ef6118a934mr3912976pfs.80.1623754112819;
        Tue, 15 Jun 2021 03:48:32 -0700 (PDT)
Received: from localhost ([61.120.150.78])
        by smtp.gmail.com with ESMTPSA id w206sm15032759pff.1.2021.06.15.03.48.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 03:48:32 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        axboe@kernel.dk
Cc:     virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] virtio-blk: Add validation for block size in config space
Date:   Tue, 15 Jun 2021 18:48:10 +0800
Message-Id: <20210615104810.151-1-xieyongji@bytedance.com>
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
index b9fa3ef5b57c..85ae3b27ea4b 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -827,7 +827,7 @@ static int virtblk_probe(struct virtio_device *vdev)
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

