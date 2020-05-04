Return-Path: <SRS0=XB/C=6S=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2422CC3A5A9
	for <linux-block@archiver.kernel.org>; Mon,  4 May 2020 15:35:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E2B52073B
	for <linux-block@archiver.kernel.org>; Mon,  4 May 2020 15:35:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728950AbgEDPfk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 May 2020 11:35:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:40174 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728381AbgEDPfk (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 4 May 2020 11:35:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 88434AFA9;
        Mon,  4 May 2020 15:35:40 +0000 (UTC)
From:   Coly Li <colyli@suse.de>
To:     axboe@kernel.dk
Cc:     linux-bcache@vger.kernel.org, linux-block@vger.kernel.org,
        Coly Li <colyli@suse.de>
Subject: [PATCH 0/2] bcache patches for Linux v5.7-rc5
Date:   Mon,  4 May 2020 23:35:27 +0800
Message-Id: <20200504153529.2242-1-colyli@suse.de>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

These two patches are in my testing directory for weeks and it is
about time to submit them for Linux v5.7-rc5.

The first one from Colin helps to remove unncessary local variables.
And Joe contributes second patch to improve the kernel message format
by remove extra '\n' from existing pr_format() and adds the '\n' to
the location of printing kernel messages. 

Please them for v5.7.

Thank you in advance.

Coly Li
---

Colin Ian King (1):
  bcache: remove redundant variables i and n

Joe Perches (1):
  bcache: Convert pr_<level> uses to a more typical style

 drivers/md/bcache/bcache.h    |   2 +-
 drivers/md/bcache/bset.c      |   6 +-
 drivers/md/bcache/btree.c     |  16 ++---
 drivers/md/bcache/extents.c   |  12 ++--
 drivers/md/bcache/io.c        |   8 +--
 drivers/md/bcache/journal.c   |  34 +++++-----
 drivers/md/bcache/request.c   |   6 +-
 drivers/md/bcache/super.c     | 123 +++++++++++++++++-----------------
 drivers/md/bcache/sysfs.c     |   8 +--
 drivers/md/bcache/writeback.c |   6 +-
 10 files changed, 110 insertions(+), 111 deletions(-)

-- 
2.25.0

