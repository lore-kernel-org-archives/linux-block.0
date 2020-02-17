Return-Path: <SRS0=O1WO=4F=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7ABAC34022
	for <linux-block@archiver.kernel.org>; Mon, 17 Feb 2020 21:08:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84B52207FD
	for <linux-block@archiver.kernel.org>; Mon, 17 Feb 2020 21:08:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729782AbgBQVIr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Feb 2020 16:08:47 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:34746 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729468AbgBQVIq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Feb 2020 16:08:46 -0500
Received: by mail-pf1-f194.google.com with SMTP id i6so9552561pfc.1
        for <linux-block@vger.kernel.org>; Mon, 17 Feb 2020 13:08:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FKwY9/j6huw/6ZgzmHkAjivTR+Vpo1w90caxVOf6WnU=;
        b=l1yRUy0+HOdZW8LhoABCF2hhPG7dDAvrLrPHl11yVl1pemWAfEN2L9ivQGfNyqhHp7
         tWQlmc3ROsuiVyP7MrXnMuCeOQD7aBNH1pyYJ77drgIBRVJIm2nIR0yUxV9pVfX83ZVC
         PP5MI+6hp/mf3zCO7aXzTfyQCtdm6LkBRcT5DlHqrgx8Z9EeCH91IP7RxZrKLNgv00fu
         cPJOEtppxCTymNNfMnnhXimMNOcT3ybx/F5zl1WxiIkxDTVQuzwonZISkwJIkbdtI3y4
         08gN6X88DLoN+qYoNsQ7W8tPLpOhvx2j3qqT1kndm4uLAezDdRhaA0TnUxRheUSt0I4D
         GtYw==
X-Gm-Message-State: APjAAAVNyINVFcThVW6h/vRZrjeQEXwt3Vn0KDkDSHRLtLa+lEnEniGG
        epp0SMtArTaP55hLaEOmzNo=
X-Google-Smtp-Source: APXvYqxd1b2mzEWqySFUJJkdseOwFJWelBzyLyG6oSZM1mNkpV9qadiU9yvK4CL88+ngZ6zvJq9YUg==
X-Received: by 2002:a63:646:: with SMTP id 67mr19224512pgg.376.1581973726076;
        Mon, 17 Feb 2020 13:08:46 -0800 (PST)
Received: from asus.hsd1.ca.comcast.net ([2601:647:4000:d7:2474:e036:5bee:ca5b])
        by smtp.gmail.com with ESMTPSA id h13sm362952pjc.9.2020.02.17.13.08.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 13:08:45 -0800 (PST)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 0/5] Five patches related to changing the number of hardware queues
Date:   Mon, 17 Feb 2020 13:08:34 -0800
Message-Id: <20200217210839.28535-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.25.0
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

Bart Van Assche (5):
  blk-mq: Fix a comment in include/linux/blk-mq.h
  blk-mq: Keep set->nr_hw_queues and set->map[].nr_queues in sync
  blk-mq: Fix a recently introduced regression in
    blk_mq_realloc_hw_ctxs()
  null_blk: Suppress an UBSAN complaint triggered when setting
    'memory_backed'
  null_blk: Fix changing the number of hardware queues

 block/blk-mq.c                |  17 ++++--
 drivers/block/null_blk_main.c | 105 ++++++++++++++++++++++------------
 include/linux/blk-mq.h        |   5 +-
 3 files changed, 84 insertions(+), 43 deletions(-)

