Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC8C2C6FD1D
	for <linux-block@archiver.kernel.org>; Mon, 20 Mar 2023 23:51:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbjCTXvR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Mar 2023 19:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjCTXvP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Mar 2023 19:51:15 -0400
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FFE1303C9
        for <linux-block@vger.kernel.org>; Mon, 20 Mar 2023 16:50:46 -0700 (PDT)
Received: by mail-pf1-f173.google.com with SMTP id u20so7526179pfk.12
        for <linux-block@vger.kernel.org>; Mon, 20 Mar 2023 16:50:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679356172;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pdKLcVc+7El/WA370xDUtF/38uPNy/Dn6+18f802cRI=;
        b=E0l2vIZleN7dPgs5e7yIxEMCUc68HPoeMFav3kdosZZlpAhbhwTSg0wt/5g/0wWSWH
         lQg3LdyS3CvDjV5pGifZh4+XiFq7AFhaI8wwLyEuk0VBMKn+sFU+r5JILjnSeZFOfM86
         YGmjQDTpDxbPbw1W4nXPaIg7NBtTbU/XmQFXYCNMb0J+YRRhxaBQQeFFhocpUHq8TTbk
         JCBoCzDIWgLLdDFIKO9Qk0BrZdr+uOtib18ZcbIjkoq9O17+JDoi2cR5Rq3fP31mQvdK
         OksXJ7UVVqZxBulkFHwCtwlbGHszMro201+pwNB+Z1N8GsCknrlozRanvxWUQxQUyQ+M
         FU/Q==
X-Gm-Message-State: AO0yUKVeEMb0YjcAUh0/gpLl8iZjMw6OyvWON4ggHUc/entKcmKbtYqJ
        6XCFKEtx8nn++BFY5+pWQ8GnFidkUBY=
X-Google-Smtp-Source: AK7set+xa+au8IRondjzAMNhHIbWiEcvJBhFTAG2MDDdMKw10+YmVddLYOqx7k4a6scIvrn1F4qb9A==
X-Received: by 2002:a62:1dc7:0:b0:5a8:b07b:82dc with SMTP id d190-20020a621dc7000000b005a8b07b82dcmr529663pfd.0.1679356171715;
        Mon, 20 Mar 2023 16:49:31 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:ad26:bef0:6406:d659])
        by smtp.gmail.com with ESMTPSA id j23-20020aa78dd7000000b0058bf2ae9694sm6915907pfr.156.2023.03.20.16.49.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 16:49:31 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v2 0/3] Submit zoned requests in LBA order per zone
Date:   Mon, 20 Mar 2023 16:49:02 -0700
Message-Id: <20230320234905.3832131-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.40.0.rc1.284.g88254d51c5-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

For zoned storage it is essential that writes are submitted in LBA order per
zone. This patch series ensures this for bio splitting and requeuing. Please
consider this patch series for the next merge window.

Thanks,

Bart.

Changes compared to v1:
- Renamed bio_nr_segments() into bio_chain_nr_segments().
- Fixed the number of segments calculation in __bio_split_to_limits().
- Added a patch for the requeuing code path.

Bart Van Assche (3):
  block: Split blk_recalc_rq_segments()
  block: Split and submit bios in LBA order
  block: Preserve LBA order when requeuing

 block/blk-merge.c | 49 ++++++++++++++++++++++++++++++++---------------
 block/blk-mq.c    | 45 +++++++++++++++++++++++++++++++++++++------
 block/blk.h       |  2 ++
 3 files changed, 75 insertions(+), 21 deletions(-)

