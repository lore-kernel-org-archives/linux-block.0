Return-Path: <SRS0=nSht=BN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 797E3C433DF
	for <linux-block@archiver.kernel.org>; Mon,  3 Aug 2020 06:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FAC12075A
	for <linux-block@archiver.kernel.org>; Mon,  3 Aug 2020 06:48:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725840AbgHCGsp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 3 Aug 2020 02:48:45 -0400
Received: from mail-wr1-f45.google.com ([209.85.221.45]:42276 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbgHCGsp (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 3 Aug 2020 02:48:45 -0400
Received: by mail-wr1-f45.google.com with SMTP id r4so30117812wrx.9
        for <linux-block@vger.kernel.org>; Sun, 02 Aug 2020 23:48:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ah7+Fdla9BLpnlB5TAyVE+EsnlJ3z0oSf241X879VJg=;
        b=NXLAgY6wzjqfuUFF26Lrxh17kI8WTgsMTE7fqHOJSnBZcDBi1nXAi5h+Fd864Y+WPs
         LMbHgICljL+C4IvqhQI2skC9hbHoMxKAGIbAybEq26Q2t2AzB3MfY+dgfueNPCSOuNYU
         2fzSFQuobG7y0n52Hxh+UITyCzSnKYoovg11WevC3QfV28aD89BfVjKWLb5Y2pzHJ6pP
         u24X/LlMHiYJy8SGbwPHxPXxB1pv+MWFF4weqN1vWPoyH0Rcqq+r6KVHGcJqY1ttJQax
         9xQYnX+lciTfJgnEmTZpdj7zLal3WZHi/O1+CZR++EMjXDkM5w93bjswIUxBRLg7dawl
         f22g==
X-Gm-Message-State: AOAM532thSeflmO9c7+r+/PfwzlpTYSKLv7CqKvNyz4YCJD0l8hoYUWZ
        zSvyGcbNUfDPYyzjBUwYd6k=
X-Google-Smtp-Source: ABdhPJz7q0GMxDdL+HvRPj165/7m7+t+eCym1gpeLsxSz0TlYtAAE8Z3tQOA+YTu8geOkWTip7N82w==
X-Received: by 2002:adf:9526:: with SMTP id 35mr14576749wrs.326.1596437323137;
        Sun, 02 Aug 2020 23:48:43 -0700 (PDT)
Received: from localhost.localdomain ([2601:647:4802:9070:6dac:e394:c378:553e])
        by smtp.gmail.com with ESMTPSA id z6sm23740647wrs.36.2020.08.02.23.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2020 23:48:42 -0700 (PDT)
From:   Sagi Grimberg <sagi@grimberg.me>
To:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        Omar Sandoval <osandov@osandov.com>,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: [PATCH rfc 0/6] blktests: Add support to run nvme tests with tcp/rdma transports
Date:   Sun,  2 Aug 2020 23:48:29 -0700
Message-Id: <20200803064835.67927-1-sagi@grimberg.me>
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

Sagi Grimberg (6):
  nvme: consolidate nvme requirements based on transport type
  nvme: consolidate some nvme-cli utility functions
  nvme: make tests transport type agnostic
  tests/nvme: restrict tests to specific transports
  nvme: support nvme-tcp when runinng tests
  nvme: support rdma transport type

 tests/nvme/002 |   8 ++--
 tests/nvme/003 |  10 ++--
 tests/nvme/004 |  12 +++--
 tests/nvme/005 |  15 +++---
 tests/nvme/006 |   7 +--
 tests/nvme/007 |   5 +-
 tests/nvme/008 |  13 +++---
 tests/nvme/009 |  11 +++--
 tests/nvme/010 |  13 +++---
 tests/nvme/011 |  13 +++---
 tests/nvme/012 |  14 +++---
 tests/nvme/013 |  13 +++---
 tests/nvme/014 |  13 +++---
 tests/nvme/015 |  12 +++--
 tests/nvme/016 |   7 +--
 tests/nvme/017 |   7 +--
 tests/nvme/018 |  13 +++---
 tests/nvme/019 |  13 +++---
 tests/nvme/020 |  11 +++--
 tests/nvme/021 |  13 +++---
 tests/nvme/022 |  13 +++---
 tests/nvme/023 |  13 +++---
 tests/nvme/024 |  13 +++---
 tests/nvme/025 |  13 +++---
 tests/nvme/026 |  13 +++---
 tests/nvme/027 |  13 +++---
 tests/nvme/028 |  15 +++---
 tests/nvme/029 |  13 +++---
 tests/nvme/030 |   8 ++--
 tests/nvme/031 |  12 ++---
 tests/nvme/032 |   4 ++
 tests/nvme/rc  | 122 +++++++++++++++++++++++++++++++++++++++++++++----
 32 files changed, 309 insertions(+), 166 deletions(-)

-- 
2.25.1

