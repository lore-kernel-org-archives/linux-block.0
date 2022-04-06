Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DFBCC433EF
	for <linux-block@archiver.kernel.org>; Wed,  6 Apr 2022 17:28:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238738AbiDFRa3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Apr 2022 13:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238849AbiDFR35 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Apr 2022 13:29:57 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42C5A15DA9A
        for <linux-block@vger.kernel.org>; Wed,  6 Apr 2022 08:32:51 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id t13so2498337pgn.8
        for <linux-block@vger.kernel.org>; Wed, 06 Apr 2022 08:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ErBuc0fYs970d3f0N05Eu3ehpUJLXpNgYhytz+tLQXs=;
        b=TdLNhP7MWw1LW5kU4b2M44iwNenprwdnNJPKc4HsZr66IkqhO4Zozfj8dKHjbFdd5b
         9eb/D+xywtlyzZm86d7TdNZy8Nw4Hwnpq8D9Ar9bqlw7j/+S3YX16XchjlNga6tPd8bj
         OOK2GHFKQHpzu2PJIWlnLSQviu78Z4s1QUcLmmATQtVCID7eftDUc30NF1cugkE2kQwM
         1rFnzS+ZrL60DyhIhM6adlO9TUbfXuvtG5Xp1jWQQrvxi3cjJqCprVhKCrMDctRt2Y6J
         p/GHVMv/1DLDzQ3H7bR543IMdX38WCeZARfDVBHHfarC5Q4XGRf0GoGYvMqp3EghF3PY
         /pbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ErBuc0fYs970d3f0N05Eu3ehpUJLXpNgYhytz+tLQXs=;
        b=hz9qtYrTm19K1tzf3pD4+xoeGvJ7ZHxBWI7FoXf/bOsFPwm/Li7Wn6pr6cgudTguFM
         Gsm4RafZ1IP9GG3UuCFCvZuu4KbOuJUiEcTEaZZ++b58w4vpzLoxT92WuCm6V/LuiJvC
         SR229BWbpWahPNqO38gSRZrunEz6vF4HmE5mf0o5KWXMrDKGsylSalKReVDYm/B5r9iT
         HTrUm9tHK4a17WE3gtkOftCsV5oYC+tYb5+5kw9rWmwHIel0A9lafWJTyv/Z9hgLUouV
         pzkxtODbyHlUTwdIUKZUhGz3LOUi1+xlOkUruyuRLRQnrLM+pBDuoAAV4tPEQQThDTbi
         Rm4Q==
X-Gm-Message-State: AOAM530EkHLt9JDHWfctZ3yCOufDUYLyqsEHUB96P1FTVsrIeV1EpNOr
        koVJzgjcJ4JgTTe3KXKsuzg=
X-Google-Smtp-Source: ABdhPJy9VEi2gY4GrS8vbY36uhREfq4hlcGyYoyGz6E5UQi/+KZgMh1K+FbRBlCGDoklHR65K+5kCA==
X-Received: by 2002:a05:6a00:1a0a:b0:4fc:d6c5:f3f1 with SMTP id g10-20020a056a001a0a00b004fcd6c5f3f1mr9409386pfv.45.1649259170617;
        Wed, 06 Apr 2022 08:32:50 -0700 (PDT)
Received: from localhost.localdomain ([114.200.4.15])
        by smtp.googlemail.com with ESMTPSA id f31-20020a17090a702200b001ca996866b5sm6024037pjk.12.2022.04.06.08.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 08:32:49 -0700 (PDT)
From:   Suwan Kim <suwan.kim027@gmail.com>
To:     mst@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        pbonzini@redhat.com, mgurtovoy@nvidia.com, dongli.zhang@oracle.com,
        hch@infradead.org, elliott@hpe.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-block@vger.kernel.org, Suwan Kim <suwan.kim027@gmail.com>
Subject: [PATCH v6 0/2] virtio-blk: support polling I/O and mq_ops->queue_rqs()
Date:   Thu,  7 Apr 2022 00:32:05 +0900
Message-Id: <20220406153207.163134-1-suwan.kim027@gmail.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch serise adds support for polling I/O and mq_ops->queue_rqs()
to virtio-blk driver.

Changes

v5 -> v6
    - patch1 : virtblk_poll
        - Remove memset in init_vq()
        - Fix space indent in init_vq()
        - Replace if condition with positive check in virtblk_map_queues()
                if (i == HCTX_TYPE_POLL)
                        blk_mq_map_queues(&set->map[i]);
                else
                        blk_mq_virtio_map_queues(&set->map[i], vblk->vdev, 0);
        - Add Reviewed-by tags
    
    - patch2 : virtio_queue_rqs
        - Add Reviewed-by tags

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

 drivers/block/virtio_blk.c | 220 +++++++++++++++++++++++++++++++++----
 1 file changed, 201 insertions(+), 19 deletions(-)

-- 
2.26.3

