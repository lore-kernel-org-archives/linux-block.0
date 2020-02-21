Return-Path: <SRS0=LczR=4J=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D7D7C11D00
	for <linux-block@archiver.kernel.org>; Fri, 21 Feb 2020 03:22:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF24220716
	for <linux-block@archiver.kernel.org>; Fri, 21 Feb 2020 03:22:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729546AbgBUDWy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Feb 2020 22:22:54 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38048 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729280AbgBUDWy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Feb 2020 22:22:54 -0500
Received: by mail-pg1-f193.google.com with SMTP id d6so274585pgn.5
        for <linux-block@vger.kernel.org>; Thu, 20 Feb 2020 19:22:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dPbcxVIOZuhittEgCBVXi38halsp6POVD4/0VhqAmKw=;
        b=mxke0ZFdj6UVC/K5D0ZwGxiMAtqDy+pApWUuobAZleB4WEpG8Py+wMgHYpWlT/1fPM
         3D2X8yVmhyziPXLdGUNlzhRu1ybhcJkit/V+pnQZJ5nwqgWOdDvfGL+X6Vya6TV3Rooc
         /czYWNsfqrCcjKhO/h7jcNYhFgRmKNcGxMekXkJ9VKGn24xth5qSECQy6bWJiE0SDTQC
         vibdHUN4yMaTF86rNzwPyqehJKsA5cQNavWeLvRXVf6HkprWzgm9iF4NflotL/80YA+e
         PTiO8ksVbScriJvtopJknRlgZhgcq9kG4fEuwngVpwM3hAYjNsEdSwMd5DbaUwuCZsxU
         meVA==
X-Gm-Message-State: APjAAAUvlclAwWFXWMCmqAyPaFGXOc+rez8HK6kUi4kH93MUKsFTHAkY
        Cuee+0SfyIefj8vAWEnOvn1UrP7aV3g=
X-Google-Smtp-Source: APXvYqyiMnnQ16DuAuWmbZJG/GZXd2l4mzE8aT2eLk8kiQYOdurQiYN/GppXier2wjKK9O5eKp0IIQ==
X-Received: by 2002:a62:790e:: with SMTP id u14mr36304786pfc.174.1582255373452;
        Thu, 20 Feb 2020 19:22:53 -0800 (PST)
Received: from asus.hsd1.ca.comcast.net ([2601:647:4000:d7:e57a:a1b3:1a44:bb8c])
        by smtp.gmail.com with ESMTPSA id x197sm1010517pfc.1.2020.02.20.19.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2020 19:22:52 -0800 (PST)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v3 0/8] Improve changing the number of hardware queues
Date:   Thu, 20 Feb 2020 19:22:35 -0800
Message-Id: <20200221032243.9708-1-bvanassche@acm.org>
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

