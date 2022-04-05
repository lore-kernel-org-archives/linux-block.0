Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 810BAC433F5
	for <linux-block@archiver.kernel.org>; Tue,  5 Apr 2022 05:31:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbiDEFdo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 5 Apr 2022 01:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbiDEFdn (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 5 Apr 2022 01:33:43 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2423CF5
        for <linux-block@vger.kernel.org>; Mon,  4 Apr 2022 22:31:45 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id t4so10166686pgc.1
        for <linux-block@vger.kernel.org>; Mon, 04 Apr 2022 22:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h3Vf4FUJ0isF+cXadavyquf3KHMIMtLSz6DlYulzjdw=;
        b=nnXzDETv8AeCgtfkOgH3gePqc6zlJUOMQXKJ2eL9XJGlKqzJTJ9tiDQTTAENVg5EBq
         gSeyJjqTGohdUvEiBL/ODgfD3SDFQcCrIOneFwbDikWMLyGO2f+PAIdQ8b/hGsybUz+L
         6iNUM0ZPC/8oee7FTDhtJYMLv6Q4ExvQTi7+cXXDN38tgVwo3aQnP0K6MbY3ZeyAuViY
         LF2qSljfRwiwG7sDpetenRCYafgyST8v9S4xpiUudOxdfRpC1r3tzspbEz3qrkkZoXut
         XN/1uDzfMEb92cNCq7k+Cpdrps5XZDewjha8UszCnq8D9qAm+jY0wng7Z5VWg0HVeXlj
         XGQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h3Vf4FUJ0isF+cXadavyquf3KHMIMtLSz6DlYulzjdw=;
        b=DsgGpJljUA/iCVt+N4X4y25WYJ+2HN4mqgwsvxZ1Fz27P/UBvTy23SonsY++oykzXk
         VoDYD2ZO2/cwz1GDVb/mywTd8dBzWrW/Brp2CY+eyfoOJUALzESEBcjVW27DCYL6w+pH
         k84FkT5vVDR2ieWsNe9fxiHC/11oYkxrEIDBFwAfZad0HaIxJ1LAS1MGzX7KCql7cf8A
         gI1EFNzXsxPP7DL9SRzBtikZGBMbIctkZLQInytVC3YpCuBpcUZjzUCK7dkEjHJ5bwCI
         r6j+/dt7s0hT5WL1g3P+xCEiOR0q/xhVdUklCxpImoaFQtzlh477y77jYhAS4xKF0Soi
         JMtQ==
X-Gm-Message-State: AOAM532pXUuC3Rm/liPY+hLhTFk3EgPeO2wHV9tWZFrlUs8EC6aGIPHU
        XZuIoCy9qvd0OqNnkle0o+E=
X-Google-Smtp-Source: ABdhPJyXggP2/pN02j/OeZb0Dswk5saYC5Rb7T+NRMv/3Ih69pmo15XyXkvlwiEUAJFPNpl/I3ezfg==
X-Received: by 2002:a05:6a02:114:b0:381:4931:1f96 with SMTP id bg20-20020a056a02011400b0038149311f96mr1427025pgb.331.1649136705226;
        Mon, 04 Apr 2022 22:31:45 -0700 (PDT)
Received: from localhost.localdomain ([114.200.4.15])
        by smtp.googlemail.com with ESMTPSA id g1-20020a17090adac100b001c67cedd84esm866141pjx.42.2022.04.04.22.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 22:31:44 -0700 (PDT)
From:   Suwan Kim <suwan.kim027@gmail.com>
To:     mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        pbonzini@redhat.com, mgurtovoy@nvidia.com, dongli.zhang@oracle.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, Suwan Kim <suwan.kim027@gmail.com>
Subject: [PATCH v4 0/2] virtio-blk: support polling I/O and mq_ops->queue_rqs()
Date:   Tue,  5 Apr 2022 14:31:20 +0900
Message-Id: <20220405053122.77626-1-suwan.kim027@gmail.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Sorry. I forgot to fix module parameter name in patch1.
So I resend it.

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

