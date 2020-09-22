Return-Path: <SRS0=ZsbB=C7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58804C4346E
	for <linux-block@archiver.kernel.org>; Tue, 22 Sep 2020 02:32:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12628207C4
	for <linux-block@archiver.kernel.org>; Tue, 22 Sep 2020 02:32:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dq91tf1p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729704AbgIVCcy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Sep 2020 22:32:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729379AbgIVCcy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Sep 2020 22:32:54 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C09C061755
        for <linux-block@vger.kernel.org>; Mon, 21 Sep 2020 19:32:54 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id v54so14389366qtj.7
        for <linux-block@vger.kernel.org>; Mon, 21 Sep 2020 19:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=DeORg/Avi6UTarc0WAXwKqD4ftKvKnlgc2tVUh2+vWc=;
        b=Dq91tf1pichKv+Yv7WjvO61yuDfXxiO/K+zHgzixr8RAU8Lo1w0wipOAsi+Oit/NUl
         0vsufMp37sLNZt/3iQDpRxvqLNkAS3SVayQn/4zIr/jCSDHdVhbmExUnMvgo3SSrLsHx
         Bc1BhdmhXFllyZ6Z2Zjw4bStH3uozVz41BZ3UreoMMtmM52DqPw9YQ8Lpq+uDAst0KA/
         oowGcFoIIR74roEjxJClm0Uhc36c5dfM6TbU1wH4qg+MUupobYsaKmlR6sN636OwVWQ6
         hMyHp85M9Al1g0w2TIP7xHYYGDJ6luLY2P+GOKBv3hIYqgig3lk4btk0vngTbRttgUoX
         YNgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=DeORg/Avi6UTarc0WAXwKqD4ftKvKnlgc2tVUh2+vWc=;
        b=MDQdkZdNJWpHWJyHTPDGVkXZ7hsj41eR8ZTTpTm9V4+N6UmIi3BlfHQ5QwtjMIQ2v9
         UbSAJyFcQCFpbHgHdAkaSRLbJs4KM6FNb8Ecr27pT2tc4KzdEUyo2/p+tSS4GXMZ+tA/
         huWKi0i0X05WD6BZPDg+PC0GiolxQK4ZN7sURcagwUIXXoi32GnPyVWx7DFDbou1fo4e
         k1rPD7g+BhN98eokQiKkwm/whdqZ5fg8Lmd1lELm/QdDL+uaFAYjsIz1Nr7jJiYiX45M
         Y3QNQ+vMEIJIdfpRNu9BEIycjZoZBLNO7v7QPpAYlYTaa6YFSER2YUnAJ+q2z9kW4UQb
         4rmw==
X-Gm-Message-State: AOAM532W8AdwEhlvmFxhNN82gMaI/PJvIAJMMqSWcV7NqubFHZjDZD99
        lqvDPc0pwPpr6JSEsJu/YP4=
X-Google-Smtp-Source: ABdhPJyUJXhBcMnkCVVrqqHfUi0f3qbcsL6V/AQb+KvF0wSzxIh2h4/hIr1mbauuYqmLR6B9gjMb1A==
X-Received: by 2002:aed:29a6:: with SMTP id o35mr2676430qtd.123.1600741973292;
        Mon, 21 Sep 2020 19:32:53 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id v15sm10853900qkg.108.2020.09.21.19.32.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 19:32:51 -0700 (PDT)
Sender: Mike Snitzer <snitzer@gmail.com>
From:   Mike Snitzer <snitzer@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Ming Lei <ming.lei@redhat.com>,
        Vijayendra Suman <vijayendra.suman@oracle.com>,
        dm-devel@redhat.com, linux-block@vger.kernel.org
Subject: [PATCH v3 0/6] dm: fix then improve bio splitting
Date:   Mon, 21 Sep 2020 22:32:45 -0400
Message-Id: <20200922023251.47712-1-snitzer@redhat.com>
X-Mailer: git-send-email 2.15.0
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

Patches 1 and 2 are queued for me to send to Linus later this week.

Patches 3 and 4 are block core and should get picked up for 5.10.
Jens, please pick them up. I revised the header for patch 4 to give
better context for use-case where non power-of-2 chunk_sectors
occurs. Patch 4 enables DM to switch to using blk_max_size_offset() in
Patch 6.

Patches 5 and 6 just show how DM will be enhanced for 5.10 once
patches 3 and 4 land in the block tree.

Mike Snitzer (6):
  dm: fix bio splitting and its bio completion order for regular IO
  dm: fix comment in dm_process_bio()
  block: use lcm_not_zero() when stacking chunk_sectors
  block: allow 'chunk_sectors' to be non-power-of-2
  dm table: stack 'chunk_sectors' limit to account for target-specific splitting
  dm: change max_io_len() to use blk_max_size_offset()

 block/blk-settings.c   | 22 ++++++++++++----------
 drivers/md/dm-table.c  |  5 +++++
 drivers/md/dm.c        | 47 +++++++++++++----------------------------------
 include/linux/blkdev.h | 12 +++++++++---
 4 files changed, 39 insertions(+), 47 deletions(-)

-- 
2.15.0

