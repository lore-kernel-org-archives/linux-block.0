Return-Path: <SRS0=68Kh=BG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93CDBC433E0
	for <linux-block@archiver.kernel.org>; Mon, 27 Jul 2020 22:07:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 784582075D
	for <linux-block@archiver.kernel.org>; Mon, 27 Jul 2020 22:07:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726193AbgG0WHU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Jul 2020 18:07:20 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44878 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726183AbgG0WHU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Jul 2020 18:07:20 -0400
Received: by mail-pl1-f194.google.com with SMTP id w17so8878671ply.11
        for <linux-block@vger.kernel.org>; Mon, 27 Jul 2020 15:07:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YxOSCyarMo8rd+alRxzcI3/88MQ1TYcQ700rV7z57xc=;
        b=JRgoW96bdhrN1rWXuR+6obpXJzyscJHsJBFXz+QrZ8NElrzK5zt91THBgadulfVxhu
         ErmJLJAo3GlxFOiy8fxbFcx70b8bYZRpykIXPKrNUWjRLvvjAPmEthEl/LwzKcDwrlUE
         Jwv/RKEMVIce3/GGv+Kk/6W7lpAEIXVOK8s8kE9m2UMlTZwU2gGLH4HEV+e3QbWF4u5M
         KxrhxvTr4pFsDhG+fSAKvddxPdTmnEM0HlBy5ab5e/ncq4NRNS81/qcHQsrF6RmeIOVH
         mAtT9R8o7QFDwliySDFQJiNGez/QE//Aq8HuvZTYUx3hcA5TjtgfNJUwPZcf7U9lWTG3
         O9Ww==
X-Gm-Message-State: AOAM5336AUpBgRjzKmvZal8LUCMmn2L9w0kXKmeRrOJQz9ubcs+Vhjfc
        oBtmeB0wS98NmupWoeFUTxjXrdwM
X-Google-Smtp-Source: ABdhPJxf7FRgOdPk5QoVXH2ofVHKyyJCM4+9R4zv4WLmfRw3A3wmDSNBb33BZjq55Q411B8o+Hpt5A==
X-Received: by 2002:a17:902:446:: with SMTP id 64mr20732180ple.157.1595887639723;
        Mon, 27 Jul 2020 15:07:19 -0700 (PDT)
Received: from sagi-Latitude-7490.hsd1.ca.comcast.net ([2601:647:4802:9070:5d7d:f206:b163:f30b])
        by smtp.gmail.com with ESMTPSA id s4sm2309519pfh.128.2020.07.27.15.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 15:07:19 -0700 (PDT)
From:   Sagi Grimberg <sagi@grimberg.me>
To:     linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lin <mlin@kernel.org>,
        Chao Leng <lengchao@huawei.com>
Subject: [PATCH v4 0/2] improve quiesce time for large amount of namespaces
Date:   Mon, 27 Jul 2020 15:07:15 -0700
Message-Id: <20200727220717.278116-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This set improves the quiesce time when using a large set of
namespaces, which also improves I/O failover time in a multipath environment.

We improve for both non-blocking hctxs (e.g. pci, fc, rdma nvme transports)
and blocking hctxs (e.g. tcp nvme transport) by splitting queue quiesce to
blk_mq_quiesce_queue_async call_(s)rcu and blk_mq_quiesce_queue_async_wait
to wait for it to complete. These calls are meant to be called in parallel
for different queues.

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

Sagi Grimberg (2):
  blk-mq: add async quiesce interface
  nvme: improve quiesce time for large amount of namespaces

 block/blk-mq.c           | 46 ++++++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/core.c |  4 +++-
 include/linux/blk-mq.h   |  4 ++++
 3 files changed, 53 insertions(+), 1 deletion(-)

-- 
2.25.1

