Return-Path: <SRS0=2P2f=BV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01545C433DF
	for <linux-block@archiver.kernel.org>; Tue, 11 Aug 2020 21:01:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3ECA20771
	for <linux-block@archiver.kernel.org>; Tue, 11 Aug 2020 21:01:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726115AbgHKVBH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Aug 2020 17:01:07 -0400
Received: from mail-pl1-f174.google.com ([209.85.214.174]:43052 "EHLO
        mail-pl1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbgHKVBG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Aug 2020 17:01:06 -0400
Received: by mail-pl1-f174.google.com with SMTP id t10so102410plz.10
        for <linux-block@vger.kernel.org>; Tue, 11 Aug 2020 14:01:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2M/NkPwr5H4y0EaA8vvnqwXlS7IQXN7YAERbtmkGJNY=;
        b=A59wn6GAbSI1vXWVM29AEI3p/oONK5/3Kc4EMNAkNDcvRUZwCIbRzFsCpINFTGS/An
         dFi/TlftXdk+7H78lZotirzSKBfPi+6+2UI61MrCUzQQS1z7+nMPJfjg4ERUADBw4GVC
         aeR77qn8m2mdfJ0fpQIGUAmIqptbyu6JjL29IFz6epQQ+8D21OL+vxPR5qdBAQx6FD7e
         wWH+7m+UMQ4XBQbRkMSWGehBhCDtZv0Vn3bWjbEaAgvr7uj/+4ZrxSlIi7t/enSzigfR
         OcKHsfn1//9RUxwd3cGUyBjsoiyJFzLiRNMwe/vjtjRx6RRfVhVN8wEzEgnBmqX17lFC
         O3TA==
X-Gm-Message-State: AOAM533PWagswFbiXGgqdU4xRmpX15aecGHuYu3sF5hc958eVCzaRXXY
        TJFbkerLD20GclTu90kwJEI=
X-Google-Smtp-Source: ABdhPJxx/dr7cGE5Ub9Nwurqe4S+Z+H1ybsv0Bd9Fm1GGYZp2Ccrl3ctVztF1An6mET1ko9AkJPJyw==
X-Received: by 2002:a17:90a:c505:: with SMTP id k5mr2668093pjt.188.1597179665743;
        Tue, 11 Aug 2020 14:01:05 -0700 (PDT)
Received: from localhost.localdomain ([2601:647:4802:9070:b58b:5460:6ed2:8ff9])
        by smtp.gmail.com with ESMTPSA id o17sm59370pgn.73.2020.08.11.14.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2020 14:01:04 -0700 (PDT)
From:   Sagi Grimberg <sagi@grimberg.me>
To:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Omar Sandoval <osandov@osandov.com>
Cc:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v3 0/7] blktests: Add support to run nvme tests with tcp/rdma transports
Date:   Tue, 11 Aug 2020 14:00:55 -0700
Message-Id: <20200811210102.194287-1-sagi@grimberg.me>
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
 34 files changed, 322 insertions(+), 179 deletions(-)

-- 
2.25.1

