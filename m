Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14027C433F5
	for <linux-block@archiver.kernel.org>; Mon,  4 Apr 2022 09:28:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346666AbiDDJaY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Apr 2022 05:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbiDDJaY (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Apr 2022 05:30:24 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9935AB09
        for <linux-block@vger.kernel.org>; Mon,  4 Apr 2022 02:28:28 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id q142so6095354pgq.9
        for <linux-block@vger.kernel.org>; Mon, 04 Apr 2022 02:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zd9XouQ6Euh6JcTwrkKaFcPZp9AB87K1+lIHwtjtbBs=;
        b=bjviuswOoQV/dIZsv1mSwPjnFA3VBCe3FNrrJEN/ZvQg78dAgtxlIs17q0svblfnw2
         QayqRuHVkT1Z3Deej+ijQQIbZq5U6BGC/ebv8ahEyTC4NR7O2hLsO6HpC21lT8V7+Q/7
         1N5Q/IVy/aPp380a00yRFcKK7EvoUgPtkV/jUQ5zGFCu8SrT1ESAqdbzisYc8MAp8uyY
         DJ46LpIF32fdW+rCDkgXaeRIFHplnWvXbrlKGv2+HtaB3/ks+nrfk7w+JySV7MYUqHL+
         L7jUhvrmqOH278m0u4/2BMMzBU0RC9mXPvqjJVQFk1+0biLlDccESRfxH10PU6EqYLMb
         JGQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zd9XouQ6Euh6JcTwrkKaFcPZp9AB87K1+lIHwtjtbBs=;
        b=zWQIoE80H0YBOC2ScWJdFfy9JBtLMIBSf3xvcP8x8UGYgYqn3U6wpvummmWvQ+V0Mk
         BW2+zHv1glgzREZ9Rt3i8JbKHKZ3P92mzpGNJJ9LbUtPo09YnXK9cMD++fxLQOm4iAkj
         DE4XOSFFt6K3AIlRproUCgxGoLORLV6/tD8iDTOErXKskmDTRhWxlxdIBcE5YYkPr0Tb
         WKsWQXNHb2h1IGEBoEZ9dxv5SCKeMjOxmWEqov+YuwvopPp8SndglQOqL7ssjwTZBpBb
         E4lBIr6a7suq1OSLn7fOyFGe1Sk2jmz7/CY5Eg7CCeiOkvs9pCY/1Urx1Gg7bOabWDK7
         /tNg==
X-Gm-Message-State: AOAM5327zuX5v5GWfFhLbUPyDg3HgRZhny7JcrizAH8qouk7rErGaLXv
        1+Affa3wQCz/PySiWJIlxqM=
X-Google-Smtp-Source: ABdhPJxCbVRXD5lM10iwHWziNnWd+ou9/7ZOsXjVHI4+PBawwQ0b0GjezYIL7mX1x0lt10WnzduOLg==
X-Received: by 2002:a05:6a00:1256:b0:4fb:1374:2f65 with SMTP id u22-20020a056a00125600b004fb13742f65mr23261753pfi.72.1649064508098;
        Mon, 04 Apr 2022 02:28:28 -0700 (PDT)
Received: from localhost.localdomain ([114.200.4.15])
        by smtp.googlemail.com with ESMTPSA id x9-20020a17090a970900b001ca6c59b350sm6187675pjo.2.2022.04.04.02.28.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 02:28:27 -0700 (PDT)
From:   Suwan Kim <suwan.kim027@gmail.com>
To:     mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        pbonzini@redhat.com, mgurtovoy@nvidia.com, dongli.zhang@oracle.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, Suwan Kim <suwan.kim027@gmail.com>
Subject: [PATCH v4 0/2] virtio-blk: support polling I/O and mq_ops->queue_rqs()
Date:   Mon,  4 Apr 2022 18:28:03 +0900
Message-Id: <20220404092805.77643-1-suwan.kim027@gmail.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch serise adds support for polling I/O and mq_ops->queue_rqs()
to virtio-blk driver.

Changes

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

 drivers/block/virtio_blk.c | 222 ++++++++++++++++++++++++++++++++++---
 1 file changed, 207 insertions(+), 15 deletions(-)

-- 
2.26.3

