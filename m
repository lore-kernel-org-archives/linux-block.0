Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2DA9C001DE
	for <linux-block@archiver.kernel.org>; Wed, 19 Jul 2023 18:23:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbjGSSXR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Jul 2023 14:23:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjGSSXP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Jul 2023 14:23:15 -0400
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 878A4B6
        for <linux-block@vger.kernel.org>; Wed, 19 Jul 2023 11:23:14 -0700 (PDT)
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1b89600a37fso45327645ad.2
        for <linux-block@vger.kernel.org>; Wed, 19 Jul 2023 11:23:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689790994; x=1692382994;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dMypFVN/5gLK7RD8sQpOnM7/panZLGIs3+qmkKRe8qs=;
        b=Z91p9M9mmQDjFptq9Lpe6kqE2Jp1mF1oODEiUdSCmJQfXrZlN6LCb6eJQF/cVHrysy
         4EXISDeinUUnmQsuSUQ83X5867dtnCAl0iFueAxeumatYFIv8hYHOaKGX/lGQ6Jt0gVf
         YPcm0B/JkdwLpFuyKpKlf9ykU6c8087UoLxGOybgILrcTQ1K3VgCH9xaUqq+4Nb/CATb
         OaxYky64WyePUeBh0gnfJ4s3zM3WCA49c9aXc47IQZWDQntL/FXaNR9cgPMuQ5M8oiss
         aa68M4lGGov5QwXUB+0uxe47OqozeO9Lv22jKmL8M3eS62EnhyO9klG7t/yk5dx1fb/x
         vcQA==
X-Gm-Message-State: ABy/qLbA8wONr29YUF78rwG6AH0SIbjKgmKc3TbwaIxcRYy4s0RsEP2u
        8Xzu+MxWIbDhUuiFB3HH4As=
X-Google-Smtp-Source: APBJJlGNePZJgrf7FZROrm1bqQv2jbJ5ElalEjyqDZMVGQY4fWIGRffBW4eN9TCR0Huo6kb1KPQfUw==
X-Received: by 2002:a17:903:249:b0:1bb:1e69:28be with SMTP id j9-20020a170903024900b001bb1e6928bemr15175601plh.42.1689790993842;
        Wed, 19 Jul 2023 11:23:13 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:a2ab:183f:c76c:d30d])
        by smtp.gmail.com with ESMTPSA id l16-20020a170903245000b001bb33ee4057sm4316061pls.43.2023.07.19.11.23.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 11:23:13 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v2 0/3] Improve performance for BLK_MQ_F_BLOCKING drivers
Date:   Wed, 19 Jul 2023 11:22:39 -0700
Message-ID: <20230719182243.2810134-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

Request queues are run asynchronously if BLK_MQ_F_BLOCKING has been set. This
results in suboptimal performance. This patch series improves performance if
BLK_MQ_F_BLOCKING has been set by running request queues synchronously
whenever possible.

Please consider this patch series for the next merge window.

Thanks,

Bart.

Changes compared to v1:
- Fixed support for the combination BLK_MQ_F_BLOCKING + BLIST_SINGLELUN.

Bart Van Assche (3):
  scsi: Inline scsi_kick_queue()
  scsi: Remove a blk_mq_run_hw_queues() call
  block: Improve performance for BLK_MQ_F_BLOCKING drivers

 block/blk-mq.c          | 17 +++++++++++------
 drivers/scsi/scsi_lib.c | 11 +++--------
 2 files changed, 14 insertions(+), 14 deletions(-)

