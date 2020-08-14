Return-Path: <SRS0=DF0J=BY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48AA2C433DF
	for <linux-block@archiver.kernel.org>; Fri, 14 Aug 2020 06:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BF2D20791
	for <linux-block@archiver.kernel.org>; Fri, 14 Aug 2020 06:18:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726122AbgHNGS1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 14 Aug 2020 02:18:27 -0400
Received: from mail-wm1-f53.google.com ([209.85.128.53]:38955 "EHLO
        mail-wm1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726110AbgHNGS1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Aug 2020 02:18:27 -0400
Received: by mail-wm1-f53.google.com with SMTP id g75so6960389wme.4
        for <linux-block@vger.kernel.org>; Thu, 13 Aug 2020 23:18:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+rPYJl+zwBo7bcedu39vEi+OGKsxylV+CZ1OMf5GpV4=;
        b=AIlPNbcEoS5+Br9f8b3ZJLl5jM9tABtUVPlNGF9pE3BnUAQ53kgoXzN1zcZh0bO7Wn
         eDUXyLTZi8qpxXxU7T3QvZ8urkDEM1DM2nhC1HFBsXpC6dkkNmORzNNf0WK+TSmhGGfU
         N/tb2Ycp4W5Vsshar0UbBK8T45i78hUB/94Tv7pWIuGjxC5XyLqMdY+K7jdBTxU+bYXG
         6HIXsrIp3IgD2BclmfqRBpjNVL0msO3mtYb36+fyZC8LTaFbyYqHpr6tp8pJ2nkoGbUz
         vaZU0ITYsa8xDD8Zoa5KnfRNBhTdVF1ZMVxUoU50Js1/EiJzf+CEYL4ZqgcZjCEMm73H
         l0fQ==
X-Gm-Message-State: AOAM531mOPwT/khP2pu66O/o/SW3SSfcZCKdiISlDYI8OXyYD9DkgGD8
        r7DjSvFkE6225W0wo8tn8Do=
X-Google-Smtp-Source: ABdhPJyjydJfKcPmycuYrS140FSMY1IjFNikbpoug3vRzD7Md5IVQ5410WrFCxmmsp5jbZKargZlHA==
X-Received: by 2002:a1c:9616:: with SMTP id y22mr1077901wmd.100.1597385905332;
        Thu, 13 Aug 2020 23:18:25 -0700 (PDT)
Received: from localhost.localdomain ([2601:647:4802:9070:51f:3472:bc7:2f4f])
        by smtp.gmail.com with ESMTPSA id l21sm12278131wmj.25.2020.08.13.23.18.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 23:18:24 -0700 (PDT)
From:   Sagi Grimberg <sagi@grimberg.me>
To:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Omar Sandoval <osandov@osandov.com>
Cc:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH v4 0/7] blktests: Add support to run nvme tests with tcp/rdma transports
Date:   Thu, 13 Aug 2020 23:18:08 -0700
Message-Id: <20200814061815.536540-1-sagi@grimberg.me>
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

$ nvme_trtype=[loop|tcp|rdma] ./check nvme

This buys us some nice coverage on some more transport types. We also add
some transport type specific helpers to mark tests that are relevant only
for a single transport.

Changes from v3:
- remove unload_module from tests/srp/rc
- fixed test run cmd
Changes from v2:
- changed patch 6 to move unload_module to common/rc
- changed helper to be named _require_nvme_trtype_is_fabrics
Changes from v1:
- added patch to remove use of module_unload
- move trtype agnostic logig helpers in patch #3

Sagi Grimberg (7):
  nvme: consolidate nvme requirements based on transport type
  nvme: consolidate some nvme-cli utility functions
  nvme: make tests transport type agnostic
  tests/nvme: restrict tests to specific transports
  nvme: support nvme-tcp when runinng tests
  common: move module_unload to common
  nvme: support rdma transport type

 common/rc          |  13 +++++
 tests/nvme/002     |   8 +--
 tests/nvme/003     |  10 ++--
 tests/nvme/004     |  12 +++--
 tests/nvme/005     |  15 +++---
 tests/nvme/006     |   7 +--
 tests/nvme/007     |   5 +-
 tests/nvme/008     |  13 ++---
 tests/nvme/009     |  11 ++--
 tests/nvme/010     |  13 ++---
 tests/nvme/011     |  13 ++---
 tests/nvme/012     |  14 +++---
 tests/nvme/013     |  13 ++---
 tests/nvme/014     |  13 ++---
 tests/nvme/015     |  12 +++--
 tests/nvme/016     |   7 +--
 tests/nvme/017     |   7 +--
 tests/nvme/018     |  13 ++---
 tests/nvme/019     |  13 ++---
 tests/nvme/020     |  11 ++--
 tests/nvme/021     |  13 ++---
 tests/nvme/022     |  13 ++---
 tests/nvme/023     |  13 ++---
 tests/nvme/024     |  13 ++---
 tests/nvme/025     |  13 ++---
 tests/nvme/026     |  13 ++---
 tests/nvme/027     |  13 ++---
 tests/nvme/028     |  15 +++---
 tests/nvme/029     |  13 ++---
 tests/nvme/030     |   8 +--
 tests/nvme/031     |  12 ++---
 tests/nvme/032     |   4 ++
 tests/nvme/rc      | 122 ++++++++++++++++++++++++++++++++++++++++++---
 tests/nvmeof-mp/rc |  13 -----
 tests/srp/rc       |  13 -----
 35 files changed, 322 insertions(+), 192 deletions(-)

-- 
2.25.1

