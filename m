Return-Path: <SRS0=mumx=BQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EA81C433E0
	for <linux-block@archiver.kernel.org>; Thu,  6 Aug 2020 19:15:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3958221E2
	for <linux-block@archiver.kernel.org>; Thu,  6 Aug 2020 19:15:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725817AbgHFTPW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Aug 2020 15:15:22 -0400
Received: from mail-pj1-f43.google.com ([209.85.216.43]:56287 "EHLO
        mail-pj1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725272AbgHFTPV (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Aug 2020 15:15:21 -0400
Received: by mail-pj1-f43.google.com with SMTP id 2so7345291pjx.5
        for <linux-block@vger.kernel.org>; Thu, 06 Aug 2020 12:15:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JypsJ0h7s72m23H6GigPawWwJJNonSHqnIBYNNnmBSo=;
        b=VlcG6nEMBSjSrsXf1T0yOv8OoNUzrOPCXXo0NPwXNo2T4vfNO2nNOmhaBlc7KdcK8/
         hgmD+clfaaeQVztBQRZxpU1snxVuMzABUXkQzMO6j2VOczJiSF0k9wOXG7w4KAW0qUwN
         OTXssBefYsgmdBNHKWUVkiGt4V9ZIFJHUIccxEnZkg4uLaBEKbfuNj4OvcrltEwN5EVt
         iZ1ajRi9qqTjyPK7I2SevVYngnJPF0hyibBqRHem4XjAXf7OpR3CwOpTxiLpJPoGLYUU
         J9kr6Ce+UKWKpYIRfd2lb6jtYypeeqZhFpCY3UA4ELydrIXWn5vI7IDDmgi8gtU6plO6
         2m+w==
X-Gm-Message-State: AOAM530CLRPnS20YCtTlqCuZ3GxN8ncfpEKGsCInvKnnYjEZtpGk7Ha3
        xrYU6j+k5yTnD0rqOw2jkY0=
X-Google-Smtp-Source: ABdhPJxYYSrd/dTe+3M2cP56OgT9CkGaJH2lfqWcW1dGHPbAlKUeQmoHJHIntb3i5CEr+AV1DcS7Qg==
X-Received: by 2002:a17:902:d303:: with SMTP id b3mr9404776plc.101.1596741321078;
        Thu, 06 Aug 2020 12:15:21 -0700 (PDT)
Received: from localhost.localdomain ([2601:647:4802:9070:d88d:857c:b14c:519a])
        by smtp.gmail.com with ESMTPSA id q16sm9784014pfg.153.2020.08.06.12.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2020 12:15:20 -0700 (PDT)
From:   Sagi Grimberg <sagi@grimberg.me>
To:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Omar Sandoval <osandov@osandov.com>
Cc:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH v2 0/7] blktests: Add support to run nvme tests with tcp/rdma transports
Date:   Thu,  6 Aug 2020 12:15:11 -0700
Message-Id: <20200806191518.593880-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We have a collection of nvme tests, but all run with nvme-loop. This
is the easiest to run on a standalone machine. However its very much possible
to run nvme-tcp and nvme-rdma using a loopback network. Add capability to run
tests with a new environment variable to set the transport type $nvme_trtype.

$ nvme_trtype=[loop|tcp|rdma] ./check test/nvme

This buys us some nice coverage on some more transport types. We also add
some transport type specific helpers to mark tests that are relevant only
for a single transport.

Changes from v1:
- added patch to remove use of module_unload
- move trtype agnostic logig helpers in patch #3

Sagi Grimberg (7):
  nvme: consolidate nvme requirements based on transport type
  nvme: consolidate some nvme-cli utility functions
  nvme: make tests transport type agnostic
  tests/nvme: restrict tests to specific transports
  nvme: support nvme-tcp when runinng tests
  common/multipath-over-rdma: don't retry module unload
  nvme: support rdma transport type

 common/multipath-over-rdma |   4 +-
 tests/nvme/002             |   8 ++-
 tests/nvme/003             |  10 +--
 tests/nvme/004             |  12 ++--
 tests/nvme/005             |  15 ++---
 tests/nvme/006             |   7 ++-
 tests/nvme/007             |   5 +-
 tests/nvme/008             |  13 ++--
 tests/nvme/009             |  11 ++--
 tests/nvme/010             |  13 ++--
 tests/nvme/011             |  13 ++--
 tests/nvme/012             |  14 +++--
 tests/nvme/013             |  13 ++--
 tests/nvme/014             |  13 ++--
 tests/nvme/015             |  12 ++--
 tests/nvme/016             |   7 ++-
 tests/nvme/017             |   7 ++-
 tests/nvme/018             |  13 ++--
 tests/nvme/019             |  13 ++--
 tests/nvme/020             |  11 ++--
 tests/nvme/021             |  13 ++--
 tests/nvme/022             |  13 ++--
 tests/nvme/023             |  13 ++--
 tests/nvme/024             |  13 ++--
 tests/nvme/025             |  13 ++--
 tests/nvme/026             |  13 ++--
 tests/nvme/027             |  13 ++--
 tests/nvme/028             |  15 ++---
 tests/nvme/029             |  13 ++--
 tests/nvme/030             |   8 +--
 tests/nvme/031             |  12 ++--
 tests/nvme/032             |   4 ++
 tests/nvme/rc              | 122 ++++++++++++++++++++++++++++++++++---
 33 files changed, 311 insertions(+), 168 deletions(-)

-- 
2.25.1

