Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B1FFC433EF
	for <linux-block@archiver.kernel.org>; Tue, 14 Jun 2022 17:49:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345036AbiFNRtz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 Jun 2022 13:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345015AbiFNRtx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Jun 2022 13:49:53 -0400
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4835C33E3D
        for <linux-block@vger.kernel.org>; Tue, 14 Jun 2022 10:49:51 -0700 (PDT)
Received: by mail-pf1-f179.google.com with SMTP id 187so9200758pfu.9
        for <linux-block@vger.kernel.org>; Tue, 14 Jun 2022 10:49:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ijazmQq2yW2X1xXR+iIS6C/hKCrqQ/Y1vE7xDGzUs38=;
        b=K5HvYzAotRF6we42ArOIO2W+TanqsrQy8RlDYZScS82acQhihLPYyZ7WFtrLem4ETo
         6kQ+PofBryRuspfl23ZkaeWSFnykcnUpSWtzTnaMCIBHmvxOE0qv2JxwPbLcNcdz1AX8
         Ego3hXeId9I480hiCM257v34bYTu4PgG4KZyR3pAJ2oQ2ADhQWJfeEKEAhuYMQl2Fn6r
         mUGep/eUrC9a+IK3DQsKsJJZ3sijHMLGxJakZ6ronTzhl98ZwvDkc7UoiQf3ZSC3eZJq
         8Vw97fHl007+bGE/GGwRyiyVIWiIg4c57k72Zuy/a47CYotlYe99njDXlqI5oJ/bn7NT
         SwvA==
X-Gm-Message-State: AOAM5330jAKnmyrIpLURvEEFDX0MHvp40zoQr2TENG0azIcwLIK9MGHe
        Rpp5aeHDhIXK1YuRLvpgM/4=
X-Google-Smtp-Source: ABdhPJwhUGx0QKbIR78S0dDemmfpIRfcO4PpVHrA1G66cQ49FQMHGLFq8rYECRz2XpnJXTl5bmRfeg==
X-Received: by 2002:a05:6a00:1992:b0:51e:6d8c:3b0 with SMTP id d18-20020a056a00199200b0051e6d8c03b0mr5991974pfl.26.1655228990556;
        Tue, 14 Jun 2022 10:49:50 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:ab60:e1ea:e2eb:c1b6])
        by smtp.gmail.com with ESMTPSA id gd3-20020a17090b0fc300b001e2da6766ecsm9866922pjb.31.2022.06.14.10.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 10:49:49 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Khazhy Kumykov <khazhy@google.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 0/5] Improve zoned storage write performance
Date:   Tue, 14 Jun 2022 10:49:38 -0700
Message-Id: <20220614174943.611369-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

Measurements have shown that limiting the queue depth to one per sequential
zone has a significant negative performance impact on zoned UFS devices. Hence
this patch series that increases the queue depth for write commands for
sequential zones.

Please consider this patch series for kernel v5.20.

Thanks,

Bart.

Bart Van Assche (5):
  block: Introduce the blk_rq_is_seq_write() function
  scsi: Retry unaligned zoned writes
  nvme: Make the number of retries request specific
  nvme: Increase the number of retries for zoned writes
  block/mq-deadline: Remove zone locking

 block/mq-deadline.c       | 74 ++++-----------------------------------
 drivers/nvme/host/core.c  |  7 +++-
 drivers/nvme/host/nvme.h  |  1 +
 drivers/scsi/scsi_error.c |  6 ++++
 drivers/scsi/sd.c         |  2 ++
 include/linux/blk-mq.h    | 14 ++++++++
 6 files changed, 35 insertions(+), 69 deletions(-)

