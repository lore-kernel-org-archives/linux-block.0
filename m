Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67111C433EF
	for <linux-block@archiver.kernel.org>; Tue,  5 Apr 2022 19:56:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbiDET6S (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 5 Apr 2022 15:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1455076AbiDEP7f (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 5 Apr 2022 11:59:35 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A6B91E95CC
        for <linux-block@vger.kernel.org>; Tue,  5 Apr 2022 08:09:40 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id c15-20020a17090a8d0f00b001c9c81d9648so2954449pjo.2
        for <linux-block@vger.kernel.org>; Tue, 05 Apr 2022 08:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=birwgMJ/GyAreHIntEZu73KBqJWVeBwDCcPlO3uWGT4=;
        b=BMe+wkAEroPJWGxkQSQDe8gQLEMcvGo8H8Tg8G9IECYUw16ZHGcOMTR9bmxrWUOvG4
         giJ6E2Pea/PYNaEPHu3VIyBDsus1ywZhM70ZYRE/42OHvP/MHxwb7yWygipCyGMzvJRl
         2l/e5JgCJaXREOSGqE+vpumsDUnEGY7nCAlxSdpnE0nD+ZCrqjcuzu6SpO77PUMXoNFe
         xgpuDO/6lUpC9C+d0n9iDMrECzq4HRbnaWBLAoIWW69QeLBWC61IeCpvSa+mNRQ5wYmy
         B1/wXymUtC+QQL3fSYnSmg7hAYKwhBbHWObYnLd17VXf0JfjgcFeXurYhXmZ4SrsTyJU
         CRLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=birwgMJ/GyAreHIntEZu73KBqJWVeBwDCcPlO3uWGT4=;
        b=jlxW2tQKFoag+Ompvuf7h5OOdNYoiKdUHuB1bLx2WCZ/WX/wgKSAHLnqlsFwUc+c1J
         QCsCkG+JM669uvBUKJz4U76WftrfZlq0HCXM4yVJgjoov3U1oKewluS/iAhAARAW/rKO
         hgTMVSzY2phCXNnAMmxJudDC4UVyP15fp14WEpg7wpwx4jRDFGYZRBUfOu5BYA4kl1u0
         8AAdXELNcJcx24qezu8bguo3aeajgl6XLq/Gk6m+cWZpJNlZyAoBIv6ppGF5mYr7Tq9X
         b6Vh51BVQIpSohPszbn/nqJTRTeQUasgjyr+zcYcWZ9B/0DCyY+o4UvWPuQZ1ppQBRaz
         TNHw==
X-Gm-Message-State: AOAM533mdb8rG2fdPLgikVYINbFfBJT8rEh/PUoQ9ZH+F1BQyBgbux6e
        5xrul3oiG8QDST8lFHK7LD0=
X-Google-Smtp-Source: ABdhPJz/avUNBV5Iq/SVbXVLVY98n5duR6AnyXHCGOKHeUl55/5Uq2xFhPQzNxRbEvXET8K9w7pjSw==
X-Received: by 2002:a17:90b:4a4b:b0:1c6:4398:523c with SMTP id lb11-20020a17090b4a4b00b001c64398523cmr4565195pjb.50.1649171380136;
        Tue, 05 Apr 2022 08:09:40 -0700 (PDT)
Received: from localhost.localdomain ([114.200.4.15])
        by smtp.googlemail.com with ESMTPSA id y2-20020a056a00190200b004fa865d1fd3sm16071772pfi.86.2022.04.05.08.09.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 08:09:38 -0700 (PDT)
From:   Suwan Kim <suwan.kim027@gmail.com>
To:     mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        pbonzini@redhat.com, mgurtovoy@nvidia.com, dongli.zhang@oracle.com,
        hch@infradead.org
Cc:     virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, Suwan Kim <suwan.kim027@gmail.com>
Subject: [PATCH v5 0/2] virtio-blk: support polling I/O and mq_ops->queue_rqs()
Date:   Wed,  6 Apr 2022 00:09:22 +0900
Message-Id: <20220405150924.147021-1-suwan.kim027@gmail.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch serise adds support for polling I/O and mq_ops->queue_rqs()
to virtio-blk driver.

Changes

v4 -> v5
    - patch1 : virtblk_poll
        - Replace "req_done" with "found" in virtblk_poll()
        - Split for loop into two distinct for loop in init_vq()
          that sets callback function for each default/poll queues
        - Replace "if (i == HCTX_TYPE_DEFAULT)" with "i != HCTX_TYPE_POLL"
          in virtblk_map_queues()
        - Replace "virtblk_unmap_data(req, vbr);" with
          "virtblk_unmap_data(req, blk_mq_rq_to_pdu(req);"
          in virtblk_complete_batch()
    
    - patch2 : virtio_queue_rqs
        - Instead of using vbr.sg_num field, use vbr->sg_table.nents.
          So, remove sg_num field in struct virtblk_req
        - Drop the unnecessary argument of virtblk_add_req() because it
          doens't need "data_sg" and "have_data". It can be derived from "vbr"
          argument.
        - Add Reviewed-by tag from Stefan

v3 -> v4
    - patch1 : virtblk_poll
        - Add print the number of default/read/poll queues in init_vq()
        - Add blk_mq_start_stopped_hw_queues() to virtblk_poll()
              virtblk_poll()
                  ...
                  if (req_done)
                                   blk_mq_start_stopped_hw_queues(vblk->disk->queue, true);
                  ...

    - patch2 : virtio_queue_rqs
        - Modify virtio_queue_rqs() to hold lock only once when it adds
          requests to virtqueue just before virtqueue notify.
          It will guarantee that virtio_queue_rqs() will not use
          previous req again.

v2 -> v3
        - Fix warning by kernel test robot
          
            static int virtblk_poll()
                ...
                if (!blk_mq_add_to_batch(req, iob, virtblk_result(vbr),
                                                   -> vbr->status,

v1 -> v2
        - To receive the number of poll queues from user,
          use module parameter instead of QEMU uapi change.

        - Add the comment about virtblk_map_queues().

        - Add support for mq_ops->queue_rqs() to implement submit side
          batch.

Suwan Kim (2):
  virtio-blk: support polling I/O
  virtio-blk: support mq_ops->queue_rqs()

 drivers/block/virtio_blk.c | 229 +++++++++++++++++++++++++++++++++----
 1 file changed, 206 insertions(+), 23 deletions(-)

-- 
2.26.3

