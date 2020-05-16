Return-Path: <SRS0=73YH=66=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6073FC433DF
	for <linux-block@archiver.kernel.org>; Sat, 16 May 2020 14:10:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4411E20735
	for <linux-block@archiver.kernel.org>; Sat, 16 May 2020 14:10:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726298AbgEPOKT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 16 May 2020 10:10:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:47068 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726266AbgEPOKT (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 16 May 2020 10:10:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 9D1CAACB1;
        Sat, 16 May 2020 14:10:20 +0000 (UTC)
From:   Coly Li <colyli@suse.de>
To:     linux-bcache@vger.kernel.org
Cc:     linux-block@vger.kernel.org, Coly Li <colyli@suse.de>
Subject: [PATCH 0/3] bcache-tools: suport zoned device as making backing evice
Date:   Sat, 16 May 2020 22:09:37 +0800
Message-Id: <20200516140940.101190-1-colyli@suse.de>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi folks,

This series is for bcache-tools to support making zoned device as
bcache backing device.

There are two major ideas to support zoned device as bcache backing
device,
- The super block data_offset should be aligned to zone size. By default
  the data_offset is set to 1 zone size for zoned backing device.
- Writeback mode is not supported yet. If the cache mode is explicitly
  set to writeback, print message to terminal to inform users that the
  cache mode is converted to wrightthough.

After the data_offset and cache mode is set properly, the rested stuffs
for zoned device support are from bcache driver in Linux kernel.

Thanks for your review in advance.

Coly Li
---

Coly Li (3):
  bcache-tools: set zoned size aligned data_offset on backing device for
    zoned devive
  bcache-tools: add is_zoned_device()
  bcache-tools: convert writeback to writethrough mode for zoned backing
    device

 Makefile |  4 +--
 make.c   | 20 +++++++++++-
 zoned.c  | 94 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 zoned.h  | 14 +++++++++
 4 files changed, 129 insertions(+), 3 deletions(-)
 create mode 100644 zoned.c
 create mode 100644 zoned.h

-- 
2.25.0

