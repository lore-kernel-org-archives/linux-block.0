Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53B62C43334
	for <linux-block@archiver.kernel.org>; Tue, 14 Jun 2022 17:57:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233032AbiFNR5i (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 Jun 2022 13:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344504AbiFNR5h (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Jun 2022 13:57:37 -0400
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C9622B15
        for <linux-block@vger.kernel.org>; Tue, 14 Jun 2022 10:57:31 -0700 (PDT)
Received: by mail-pj1-f44.google.com with SMTP id g10-20020a17090a708a00b001ea8aadd42bso9809050pjk.0
        for <linux-block@vger.kernel.org>; Tue, 14 Jun 2022 10:57:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=PIlXYXW6zPMdNDrGiG1XquSOM4n1wp8mt7+I7Iey53A=;
        b=MQ2yoB8pPZCoXK9T4Q6U2xPMVQ+46OA/en7uMrc5EwcKIAPbzEEGfPNUsr5QJw3kfq
         S32xKKnBN9U0DzDGXu0sTXLUwtnHJLclbo9YjD+I8cmuH4PvXy6abnLY8Z2x5Kws4lb2
         gSFLQtrddHwHBYUKpM0K9jrEehr9/1xXRDueiTnYpIN/vequfI8OmEz3wHaydsKCdcrS
         NRMYQ3/sekpgglhtx9STvG9jM6TThecm263eeZ4iiYmF3G21QuqQWE1sEMzD4L/6r2fr
         6TXmZMKJoeTWpBj1oegoRDVXHRnD8sxftTKxWbzgPRX+NeS9JZ/7EwzZ0zk4j7kGA7V/
         /KKw==
X-Gm-Message-State: AJIora9VGdwNAeYJJvmO2L61iMCN684vFgZFsimZNdMWdgcpgVpoFsjP
        QiHBUXVn1aj/F9pyybYtRE4=
X-Google-Smtp-Source: AGRyM1viJmuOoaRS0ThVHcwdoPXz5q383kV527CVolgCWZkYTe4AcDdLLhdyXNIZCLfP5YP9Y9uDug==
X-Received: by 2002:a17:90a:9405:b0:1ea:b00e:3520 with SMTP id r5-20020a17090a940500b001eab00e3520mr5839436pjo.80.1655229450901;
        Tue, 14 Jun 2022 10:57:30 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:ab60:e1ea:e2eb:c1b6])
        by smtp.gmail.com with ESMTPSA id ij25-20020a170902ab5900b0015e8d4eb1f7sm7519666plb.65.2022.06.14.10.57.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 10:57:30 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 0/3] Three small block layer patches
Date:   Tue, 14 Jun 2022 10:57:22 -0700
Message-Id: <20220614175725.612878-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

These three patches are what I came up with while reading block layer code in
preparation of the patch series for improving zoned write performance.

Please consider this patch series for kernel v5.20.

Thanks,

Bart.

Bart Van Assche (3):
  blk-iocost: Simplify ioc_rqos_done()
  block: Rename a blk_mq_map_queue() argument
  block: Specify the operation type when calling blk_mq_map_queue()

 block/blk-iocost.c |  2 +-
 block/blk-mq.c     |  2 +-
 block/blk-mq.h     | 12 ++++++------
 3 files changed, 8 insertions(+), 8 deletions(-)

