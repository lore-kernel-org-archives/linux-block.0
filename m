Return-Path: <SRS0=5EYj=43=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EDF7C10DCE
	for <linux-block@archiver.kernel.org>; Tue, 10 Mar 2020 04:26:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22ACA24655
	for <linux-block@archiver.kernel.org>; Tue, 10 Mar 2020 04:26:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725999AbgCJE0d (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 Mar 2020 00:26:33 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34573 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbgCJE0d (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Mar 2020 00:26:33 -0400
Received: by mail-pl1-f193.google.com with SMTP id a23so2210960plm.1
        for <linux-block@vger.kernel.org>; Mon, 09 Mar 2020 21:26:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZGvsG9q++u7T5lUZ0oHO6PeoOMlnI07CRsPQdBdQLW4=;
        b=iTuWtBnRtdsHsjx5FFceS0B2DJkq/D3vUiBl4NRjezvFlW1PNuhDBitjWJJV8X8Yu5
         YKenGdeSO4BvBfBzwLYbf+AHnTkLYdUAcvQ5iZLnGF183xP1H5BY6DmSgoqowNHpfuKU
         ti4Xf+7Ltkf23ud0R/uRq3ILnVRaPWng62tjhS/OJbZGEKIZSQQ5YJU1vQ86QLu+OrSQ
         mqVc0KQoVsFEmJxzNrnJ+SK2AL0y2yHnrQDNf/OGyIqknIVd2GioLVQsGPq+jTUiVQUo
         t7EMifQriPQnd5grHoE9IndzXV2IRtZ2kowQvRZdRvJiyVwL8n9nLctHTIQZrMc+DI4w
         TEMQ==
X-Gm-Message-State: ANhLgQ3x6L1zkOVwP1aqWBlcImXilzgpO9+L+h3CS0t5kyaQtfUHYyhQ
        vAX66Pd6bpz3qBx1ztb2+/s=
X-Google-Smtp-Source: ADFU+vv5GiXwFwyglSrPbK1tkJdAiYaZ6RmA1jG0KY8MsmnhbGzWeViApk8yhx9HG7+m7SFrTmUSMg==
X-Received: by 2002:a17:902:b10c:: with SMTP id q12mr19659216plr.303.1583814390505;
        Mon, 09 Mar 2020 21:26:30 -0700 (PDT)
Received: from asus.hsd1.ca.comcast.net ([2601:647:4000:d7:c0e4:71da:7a83:2357])
        by smtp.gmail.com with ESMTPSA id l189sm5963240pga.64.2020.03.09.21.26.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 21:26:29 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v4 0/8] Improve changing the number of hardware queues
Date:   Mon,  9 Mar 2020 21:26:15 -0700
Message-Id: <20200310042623.20779-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

These patches are what I came up with while analyzing syzbot and blktests
complaints related to dynamically changing the number of hardware queues.
Please consider these patches for the upstream kernel.

Thanks,

Bart.

Changes compared to v3:
- Added more Reviewed-by tags.

Changes compared to v2:
- Changed patch 2/8 such that .nr_queues is only set if nr_maps == 1.

Changes compared to v1:
- Reworked patch 2/8 as requested by Ming.
- Added three new null_blk patches.

Bart Van Assche (8):
  blk-mq: Fix a comment in include/linux/blk-mq.h
  blk-mq: Keep set->nr_hw_queues and set->map[].nr_queues in sync
  blk-mq: Fix a recently introduced regression in
    blk_mq_realloc_hw_ctxs()
  null_blk: Suppress an UBSAN complaint triggered when setting
    'memory_backed'
  null_blk: Fix changing the number of hardware queues
  null_blk: Fix the null_add_dev() error path
  null_blk: Handle null_add_dev() failures properly
  null_blk: Add support for init_hctx() fault injection

 block/blk-mq.c                |   9 ++-
 drivers/block/null_blk_main.c | 124 +++++++++++++++++++++++-----------
 include/linux/blk-mq.h        |   5 +-
 3 files changed, 97 insertions(+), 41 deletions(-)

