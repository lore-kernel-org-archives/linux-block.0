Return-Path: <SRS0=rVNK=CL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D34DC433E2
	for <linux-block@archiver.kernel.org>; Wed,  2 Sep 2020 22:29:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 043F020826
	for <linux-block@archiver.kernel.org>; Wed,  2 Sep 2020 22:29:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbgIBW3G (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Sep 2020 18:29:06 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39838 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726226AbgIBW3F (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Sep 2020 18:29:05 -0400
Received: by mail-pf1-f196.google.com with SMTP id u128so540155pfb.6
        for <linux-block@vger.kernel.org>; Wed, 02 Sep 2020 15:29:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QB80bawriL9TWwvvbTbwiYdPscPjsyS88Mfd6mT5A5c=;
        b=Y+vJqA7Oh7A7calPi8ot/WWW4jbukedD0DXU7kwnO8rcoW96a6eIlGAKnDWLPn2lgX
         LJi1Ud1JDEXgaTuW9NL2q90A75OC9xOmvPD1kAqkOqGyOA2srBsPlGA/jErohHJN7DC7
         agr9zguQDSrUGFkG9tBbrhJ5lIecX2E0jaY+8ULGuxh8Jst7hT00j8v5uZr3XikTQMQh
         z7b+TxMLFn46PFtSO6188IKcpPaprI+2cBJ5BxY6wPSiuChYTiEdkMGOwj1y4I8xJSnc
         wj1cxGSZ8SH6i53kwdU+Xx+PyhOtEz6/pf33uq7Cp+QduPX13KVKOGLLIlpIjCS7v2Z9
         lbOg==
X-Gm-Message-State: AOAM532VIDDNSp6CEWhUHGqW64sssOlkVk5tUiKDgrn0JfC7E8okbYlp
        90rJHUUkLPd6foEmU+m7d4mLNbIpLjx9rg==
X-Google-Smtp-Source: ABdhPJxdwNIYxuNbYCk+JgILhuLm7wxFQ7+hQjeoyGp9zF1ZfiJp794fY91m7eKiltkA2j6RxCPpvA==
X-Received: by 2002:a17:902:7788:: with SMTP id o8mr518768pll.43.1599085744572;
        Wed, 02 Sep 2020 15:29:04 -0700 (PDT)
Received: from sagi-Latitude-7490.hsd1.ca.comcast.net ([2601:647:4802:9070:4025:ed24:701e:8cf3])
        by smtp.gmail.com with ESMTPSA id p184sm569293pfb.47.2020.09.02.15.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2020 15:29:03 -0700 (PDT)
From:   Sagi Grimberg <sagi@grimberg.me>
To:     linux-block@vger.kernel.org, Omar Sandoval <osandov@osandov.com>
Cc:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: [PATCH v5 0/7] blktests: Add support to run nvme tests with tcp/rdma transports
Date:   Wed,  2 Sep 2020 15:28:54 -0700
Message-Id: <20200902222901.408217-1-sagi@grimberg.me>
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

