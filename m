Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E41E9C433F5
	for <linux-block@archiver.kernel.org>; Fri,  4 Mar 2022 10:01:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239135AbiCDKCF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 4 Mar 2022 05:02:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239026AbiCDKCF (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 4 Mar 2022 05:02:05 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6200919BE7E
        for <linux-block@vger.kernel.org>; Fri,  4 Mar 2022 02:01:17 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id p3-20020a17090a680300b001bbfb9d760eso10214518pjj.2
        for <linux-block@vger.kernel.org>; Fri, 04 Mar 2022 02:01:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=unTalB5dEpk0d2rLSok98CUKf5ocP3+9BVSJOkXBlF0=;
        b=Ki2MviPi/0ZazZ6C/Ggw9CFEQ/rdT3Wb5ThnvJ4mcg3DyPR2qCvB5A8CIdI36HsAPg
         02ggPhEDMHDmScXAP0K3dlUy2/hUdwDF3iROGWyMbqIVd1PvzHFpGnppSymP/1iYmWxa
         X35+RRolDY3FpTmcHL3botSP4184S86qz2T0u34wlbBKYx/4giOVpgUqGHD4tg0xzE8+
         sj6itUx2YcvVgbSMt1PO0fVYpVA1mHv9WjY91VG7PUofK8AHQhPhcxbV+1LvXYkvAb+O
         xP+UA99ndCs7Cf5x3kY8tDqNXjPtPTExFMdA297KCwDpyPYlK7ax509pzwHYIsLQ+11z
         IKbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=unTalB5dEpk0d2rLSok98CUKf5ocP3+9BVSJOkXBlF0=;
        b=I0OQMZimirY3cDTYmJGHx9ZG6eNj6seJ/2LX+Udf24GSQ8wYV1F+iU4pmbsShc1BC3
         n1f+7mD27Zzp6z3OyidMIMtrkrqa+xPbUyjECGE6z13k4wJx+BU12+hHvBs+DRt/5z+3
         axNwumhpFha+nrgqrifFcCVqNL33cXsYc074e4h8/fgdbkTgfHMww7+YAj4BZDW8K9pi
         EWhC4YWlJoYDic+hnKlPZ4EGIHnUDVea3c88r677kZcg9sg6S61xXT8jmyUeSZnUHdZX
         qCy1v9xyVsHy7q3JAKfvhy/2GvcFKU96ISya998qFrkN3R46H3CxDVPq1rca4dg5/P6P
         C+9g==
X-Gm-Message-State: AOAM533F3UF09uti3fPLBm2D29P/xaUKZy73J3InV4DL9IHGe2TwvxME
        tcdZMJev/zktEP/ZzXjS0LsqzwiyHTaA
X-Google-Smtp-Source: ABdhPJz9mRHndI4k9iwXhQrG+K9i4OaTEJqeBsLCNA3yIZQIpc2BMn6nnpX9NJpSmoibME28T+hSXA==
X-Received: by 2002:a17:902:8c8c:b0:150:739b:8ab1 with SMTP id t12-20020a1709028c8c00b00150739b8ab1mr35823267plo.3.1646388076586;
        Fri, 04 Mar 2022 02:01:16 -0800 (PST)
Received: from localhost ([139.177.225.237])
        by smtp.gmail.com with ESMTPSA id x5-20020aa79a45000000b004c9d286809csm5910538pfj.61.2022.03.04.02.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 02:01:15 -0800 (PST)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     mst@redhat.com, jasowang@redhat.com, axboe@kernel.dk,
        hch@infradead.org, mgurtovoy@nvidia.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org
Subject: [PATCH v3 1/2] virtio-blk: Don't use MAX_DISCARD_SEGMENTS if max_discard_seg is zero
Date:   Fri,  4 Mar 2022 18:00:57 +0800
Message-Id: <20220304100058.116-1-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Currently the value of max_discard_segment will be set to
MAX_DISCARD_SEGMENTS (256) with no basis in hardware if device
set 0 to max_discard_seg in configuration space. It's incorrect
since the device might not be able to handle such large descriptors.
To fix it, let's follow max_segments restrictions in this case.

Fixes: 1f23816b8eb8 ("virtio_blk: add discard and write zeroes support")
Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
---
 drivers/block/virtio_blk.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index c443cd64fc9b..7fc2c8b97077 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -925,9 +925,15 @@ static int virtblk_probe(struct virtio_device *vdev)
 
 		virtio_cread(vdev, struct virtio_blk_config, max_discard_seg,
 			     &v);
+
+		/*
+		 * max_discard_seg == 0 is out of spec but we always
+		 * handled it.
+		 */
+		if (!v)
+			v = sg_elems - 2;
 		blk_queue_max_discard_segments(q,
-					       min_not_zero(v,
-							    MAX_DISCARD_SEGMENTS));
+					       min(v, MAX_DISCARD_SEGMENTS));
 
 		blk_queue_flag_set(QUEUE_FLAG_DISCARD, q);
 	}
-- 
2.20.1

