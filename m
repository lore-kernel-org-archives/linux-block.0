Return-Path: <SRS0=kdGS=CM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4D9DC433E2
	for <linux-block@archiver.kernel.org>; Thu,  3 Sep 2020 23:53:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77BC9206B7
	for <linux-block@archiver.kernel.org>; Thu,  3 Sep 2020 23:53:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729411AbgICXxv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 3 Sep 2020 19:53:51 -0400
Received: from mail-wm1-f43.google.com ([209.85.128.43]:34153 "EHLO
        mail-wm1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbgICXxr (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 3 Sep 2020 19:53:47 -0400
Received: by mail-wm1-f43.google.com with SMTP id c19so6356052wmd.1
        for <linux-block@vger.kernel.org>; Thu, 03 Sep 2020 16:53:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=41aue9Z2+0Jna6WTjt/oRp/zuBiUQmkW7wUAEMo5DEw=;
        b=W+wTjDOiquUmG4SOFHE66TUi/7Om52N6KnLLWdq5EVAZAoV/Y2A0VnK4leN5OvdAO5
         p3T1o56txz5niRhZNi7x4yRk7KYytHSnIEua721t0iJEcOvU0dO2YRsxyhHBE2Qw++YL
         Oa9rqe3Q/70CPtm02WCg6F3mgN4UuHpH5drdoXCPPjQx0Mk+xwKDt0gEZ9psIN4Zfrkr
         Gqke+CFyApl8ZSNa6mRmY+NMyUE+1rgaS2oLGQnV+ixfXCPNEXC3m6ZgieDTV7kCe5Vs
         ZbQo66ZqFyHgOjLaSzJDnbOhZ/CtdjzLDMosAeJo6Cw1iX585n72HOaOsirnYNDs9pgb
         Tlfw==
X-Gm-Message-State: AOAM530eOv7ihFd7CYrSXFfsJm8jFHmMEVMCE/TF+3M7I0YtyZ+lroPB
        SKP7cIuylIkgvQS3iTJffeFwondY25vleQ==
X-Google-Smtp-Source: ABdhPJwXPP0YdJVg2SFl+KD6ZC7ExS7iGEtNZ2nMlZFg2LDJknlYF94J3TbS6pGgRj0zRnzyPYwITg==
X-Received: by 2002:a7b:c35a:: with SMTP id l26mr4880114wmj.42.1599177225548;
        Thu, 03 Sep 2020 16:53:45 -0700 (PDT)
Received: from localhost.localdomain ([2601:647:4802:9070:79a5:e112:bd7c:4b29])
        by smtp.gmail.com with ESMTPSA id u17sm7024992wmm.4.2020.09.03.16.53.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 16:53:44 -0700 (PDT)
From:   Sagi Grimberg <sagi@grimberg.me>
To:     linux-block@vger.kernel.org, Omar Sandoval <osandov@osandov.com>
Cc:     linux-nvme@lists.infradead.org,
        Logan Gunthorpe <logang@deltatee.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Subject: [PATCH v7 0/7] blktests: Add support to run nvme tests with tcp/rdma transports
Date:   Thu,  3 Sep 2020 16:53:30 -0700
Message-Id: <20200903235337.527880-1-sagi@grimberg.me>
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

Changes from v6:
- fix _nvme_discover wrong use of subsysnqn that is never passed
- move shellcheck fixes to the correct patches (not fix in subsequent patches)
Changes from v5:
- fix shellcheck errors
Changes from v4:
- removed extra paranthesis
- load either rdma_rxe or siw for rdma transport tests
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
 tests/nvme/012     |  14 ++---
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
 tests/nvme/rc      | 127 ++++++++++++++++++++++++++++++++++++++++++---
 tests/nvmeof-mp/rc |  13 -----
 tests/srp/rc       |  13 -----
 35 files changed, 327 insertions(+), 192 deletions(-)

-- 
2.25.1

