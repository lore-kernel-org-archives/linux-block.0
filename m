Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10F02C0015E
	for <linux-block@archiver.kernel.org>; Fri, 21 Jul 2023 17:28:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbjGUR17 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 Jul 2023 13:27:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231433AbjGUR1q (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 Jul 2023 13:27:46 -0400
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DD75198D
        for <linux-block@vger.kernel.org>; Fri, 21 Jul 2023 10:27:45 -0700 (PDT)
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6686708c986so1911610b3a.0
        for <linux-block@vger.kernel.org>; Fri, 21 Jul 2023 10:27:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689960465; x=1690565265;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e+ZWqL47uenxrTRJtNc3OjfBC2vjrgWoi9bKb9Q4Jxw=;
        b=Ae6HgVKDdg8Ae6uBZLgUMMHpnkSDPKLJJ164v4foO+t19KwUqdqIfURsz3MhwYc0D4
         GKjemDEudJxUKSwXG1enlIt8MuQ2Jd+S+gTthG+ozmI+uJT3fqKjlYHXYmJXpd7AkfBw
         F0DQYGBs3FxcFl8j5l8FLnLdBQuZvvKnwlm4fDwMMRR1rLEs7fl1C2amMQdKNF7ImO6a
         1UL1NlNtnTyFbpSrh5J0R8h1wF0BWcph2JGlXptCmmCT/sTV/hJMG99sHlsFN9O5qMDJ
         lZBjgbu4YLE4z3xz1nJu7EeXZniKRQwwerg3Ku4D1xAIa+t/P/em8oIey2q38CL9RmVT
         YiGQ==
X-Gm-Message-State: ABy/qLZrPWOXANQH3QUTNWVGWA+Zuo/KWfHk4Qq+8g3RQO6g10wff6ij
        PxWLnvKrGi4lj+h2ePJp6dg=
X-Google-Smtp-Source: APBJJlEfySHOC85c7Rd5C7tcXVMuv2NViHLWthWs2zA4t6q6Fe37ahzg9IjCtrDtmqYsrSd/wU/CfA==
X-Received: by 2002:a05:6a21:3385:b0:137:a9d7:d8cc with SMTP id yy5-20020a056a21338500b00137a9d7d8ccmr3003079pzb.24.1689960464803;
        Fri, 21 Jul 2023 10:27:44 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:5043:9124:70cb:43f9])
        by smtp.gmail.com with ESMTPSA id jj13-20020a170903048d00b001b83db0bcf2sm3790961plb.141.2023.07.21.10.27.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 10:27:44 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v3 0/3] Improve performance for BLK_MQ_F_BLOCKING drivers
Date:   Fri, 21 Jul 2023 10:27:27 -0700
Message-ID: <20230721172731.955724-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
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

Changes compared to v2:
- Improved the descriptions of patches 1/3 and 2/3.
- Added a comment in patch 2/3.
- In patch 3/3, included a change for blk_execute_rq_nowait() since I noticed
  that this function may be called from a context where it is not allowed to
  sleep (nvme_uring_cmd_io() for NVMe over TCP).

Changes compared to v1:
- Fixed support for the combination BLK_MQ_F_BLOCKING + BLIST_SINGLELUN.

Bart Van Assche (3):
  scsi: Inline scsi_kick_queue()
  scsi: Remove a blk_mq_run_hw_queues() call
  block: Improve performance for BLK_MQ_F_BLOCKING drivers

 block/blk-mq.c          | 17 +++++++++++------
 drivers/scsi/scsi_lib.c | 12 ++++--------
 2 files changed, 15 insertions(+), 14 deletions(-)

