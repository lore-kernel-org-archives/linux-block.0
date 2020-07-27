Return-Path: <SRS0=68Kh=BG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B41EC433E1
	for <linux-block@archiver.kernel.org>; Mon, 27 Jul 2020 23:10:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70E6D20809
	for <linux-block@archiver.kernel.org>; Mon, 27 Jul 2020 23:10:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbgG0XK0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Jul 2020 19:10:26 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39412 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbgG0XK0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Jul 2020 19:10:26 -0400
Received: by mail-pl1-f196.google.com with SMTP id b9so8945278plx.6
        for <linux-block@vger.kernel.org>; Mon, 27 Jul 2020 16:10:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s7HvE7cCk+QXElSFNz6NUM8zZE/EqHMoDCQdYPstf08=;
        b=ssI+U2ryILsep4aIy4RW8pO+TwBK0qrgnTyjUO/7HNWWrtmiDte+hlz9w+Mp4PAWYY
         K51nCr8SlmMCTH52stBC6p7B+FB3zKQJ0CWWZiIatqSdHl/fWUa1uOVTFS3wJ5BZyw0X
         ahypkGe2nMWCpLlU4+xCOWYFo+bbY7I/hX4nBSG5pk0W1y3esNbX1LrtR+ZfqIfh2Ig0
         yDF5/zUZxQqlj7qTAelS4BFeKnGHtVujGJMHj5tajIMLpIJKfK8YYHNIA2fPF4cPZa4P
         U8JsLyisVSeJBP1srcYQAEhhaqVyrWkEbvAkgI3U+DYCNk8hZMIx6R0NJXtSRPDBUTVi
         eWpA==
X-Gm-Message-State: AOAM530+Ow4DfGVpwP1dSbHw32FExk3FCEXzN/KpSyuq35KNbcNivuzl
        V7AyL7gbKZsGKZJBooKf1Ck=
X-Google-Smtp-Source: ABdhPJx7LHZGg8iU5uE+1Tv25WzLucK/Z41popy2MTwXO+9/xIZXLSbghsX29tkbwFA4+eDsITraiw==
X-Received: by 2002:a17:902:7b85:: with SMTP id w5mr20109833pll.22.1595891425539;
        Mon, 27 Jul 2020 16:10:25 -0700 (PDT)
Received: from sagi-Latitude-7490.hsd1.ca.comcast.net ([2601:647:4802:9070:5d7d:f206:b163:f30b])
        by smtp.gmail.com with ESMTPSA id z190sm7407171pfz.67.2020.07.27.16.10.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 16:10:24 -0700 (PDT)
From:   Sagi Grimberg <sagi@grimberg.me>
To:     linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lin <mlin@kernel.org>,
        Chao Leng <lengchao@huawei.com>
Subject: [PATCH v5 0/2] improve nvme quiesce time for large amount of namespaces
Date:   Mon, 27 Jul 2020 16:10:20 -0700
Message-Id: <20200727231022.307602-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This set improves the quiesce time when using a large set of
namespaces, which also improves I/O failover time in a multipath environment.

We improve for both non-blocking hctxs and blocking hctxs introducing
blk_mq_[un]quiesce_tagset which works on all request queues over a given
tagset in parallel (which is the case in nvme) for both tagset types (blocking
and non-blocking);

Changes from v4:
- introduce blk_mq_[un]quiesce_tagset as one interface
- move nvme core to use this interface

Changes from v3:
- make hctx->rcu_sync dynamically allocated from the heap instead
  of a static member function

Changes from v2:
- made blk_mq_quiesce_queue_async operate on both blocking and
  non-blocking hctxs.
- removed separation between blocking vs. non-blocking queues
- dropeed patch from Chao
- dropped nvme-rdma test patch

Changes from v1:
- trivial typo fixes

*** SUBJECT HERE ***

*** BLURB HERE ***

Sagi Grimberg (2):
  blk-mq: add tagset quiesce interface
  nvme: use blk_mq_[un]quiesce_tagset

 block/blk-mq.c           | 66 ++++++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/core.c | 14 ++-------
 include/linux/blk-mq.h   |  4 +++
 3 files changed, 72 insertions(+), 12 deletions(-)

-- 
2.25.1

