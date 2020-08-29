Return-Path: <SRS0=CCtz=CH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E001C433E2
	for <linux-block@archiver.kernel.org>; Sat, 29 Aug 2020 15:32:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84373208A9
	for <linux-block@archiver.kernel.org>; Sat, 29 Aug 2020 15:32:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728235AbgH2Pcq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 29 Aug 2020 11:32:46 -0400
Received: from mail-pg1-f171.google.com ([209.85.215.171]:45800 "EHLO
        mail-pg1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728196AbgH2Pcp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 29 Aug 2020 11:32:45 -0400
Received: by mail-pg1-f171.google.com with SMTP id 67so1896754pgd.12
        for <linux-block@vger.kernel.org>; Sat, 29 Aug 2020 08:32:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bwBvPhzWsgBMA4B93AZzg5eo/lFdR101ys5gclkTz9k=;
        b=kPz8JB71zXSaE/2/IJrqGQ3KIBw0U9GYn2y7MVrDoT2VwMfXOn0F8scaqn4cKUO28j
         1AYSG5NGp7Gz0WW1m64KTIi6XyxMoQNrRwdKGvL3MiHnXLuf4fTbyqZ62wNoXOeHWOY2
         iteG+vxSZuBwYnIUYuenGOPcX4P/vkl8N5scsuPMf6779m68vWSwPh2Y1fP0MlqyEU6r
         G5PupmO0yHzWZmpNTySEW6YKutRZVQfbL2bg92PuPcSF7TqBwvYYVCB8bcck6BEkiu+B
         kcuhNWYKiE6Op5aXdGHeDlVh7Kx/VWM1TfhekKAvRkB2aQ35HdzJoY9xLXHBlSxxkLdU
         6Ouw==
X-Gm-Message-State: AOAM5325vI6PePq9lQuG4vU2iEcLm8DhZJWcrZdZCg3Z/1AnZVmuSsSW
        27ezsirHmSrwU1FBpF2GZe3UGUFppc/mZQ==
X-Google-Smtp-Source: ABdhPJxlMGWzjpDeG454J8od1jHKSel7r0h1mstGi3paW/6nHqcoi8dnfmlH+/FwwMmJEmkuMqsVmA==
X-Received: by 2002:a65:4083:: with SMTP id t3mr1500745pgp.201.1598715164916;
        Sat, 29 Aug 2020 08:32:44 -0700 (PDT)
Received: from sagi-Latitude-7490.hsd1.ca.comcast.net ([2601:647:4802:9070:b43d:4be3:4cfb:fd9e])
        by smtp.gmail.com with ESMTPSA id p184sm3182347pfb.47.2020.08.29.08.32.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2020 08:32:44 -0700 (PDT)
From:   Sagi Grimberg <sagi@grimberg.me>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Subject: [GIT PULL] nvme fixes for 5.9 next rc
Date:   Sat, 29 Aug 2020 08:32:43 -0700
Message-Id: <20200829153243.324252-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hey Jens,

Some more nvme fixes:
- instance leak and io boundary fixes from Keith
- fc locking fix from Christophe
- various tcp/rdma reset during traffic fixes from Me
- pci use-after-free fix from Tong
- tcp target null deref fix from Ziye

Please pull.

The following changes since commit a433d7217feab712ff69ef5cc2a86f95ed1aca40:

  Merge branch 'md-fixes' of https://git.kernel.org/pub/scm/linux/kernel/git/song/md into block-5.9 (2020-08-28 07:52:02 -0600)

are available in the Git repository at:

  ssh://git.infradead.org/var/lib/git/nvme.git nvme-5.9-rc

for you to fetch changes up to 7ad92f656bddff4cf8f641e0e3b1acd4eb9644cb:

  nvme-pci: cancel nvme device request before disabling (2020-08-28 16:43:57 -0700)

----------------------------------------------------------------
Christophe JAILLET (1):
      nvmet-fc: Fix a missed _irqsave version of spin_lock in 'nvmet_fc_fod_op_done()'

Keith Busch (2):
      nvme: fix controller instance leak
      nvme: only use power of two io boundaries

Sagi Grimberg (9):
      nvme-fabrics: don't check state NVME_CTRL_NEW for request acceptance
      nvme: have nvme_wait_freeze_timeout return if it timed out
      nvme-tcp: serialize controller teardown sequences
      nvme-tcp: fix timeout handler
      nvme-tcp: fix reset hang if controller died in the middle of a reset
      nvme-rdma: serialize controller teardown sequences
      nvme-rdma: fix timeout handler
      nvme-rdma: fix reset hang if controller died in the middle of a reset
      nvme: Fix NULL dereference for pci nvme controllers

Tong Zhang (1):
      nvme-pci: cancel nvme device request before disabling

Ziye Yang (1):
      nvmet-tcp: Fix NULL dereference when a connect data comes in h2cdata pdu

 drivers/nvme/host/core.c    | 56 ++++++++++++++++++++++++-------
 drivers/nvme/host/fabrics.c |  1 -
 drivers/nvme/host/nvme.h    |  2 +-
 drivers/nvme/host/pci.c     |  4 +--
 drivers/nvme/host/rdma.c    | 68 ++++++++++++++++++++++++++++----------
 drivers/nvme/host/tcp.c     | 80 ++++++++++++++++++++++++++++++++-------------
 drivers/nvme/target/fc.c    |  4 +--
 drivers/nvme/target/tcp.c   | 10 +++++-
 8 files changed, 167 insertions(+), 58 deletions(-)
