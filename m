Return-Path: <SRS0=B3LW=3V=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 927C3C33CB3
	for <linux-block@archiver.kernel.org>; Sat,  1 Feb 2020 14:42:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DD72206F0
	for <linux-block@archiver.kernel.org>; Sat,  1 Feb 2020 14:42:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726523AbgBAOmr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 1 Feb 2020 09:42:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:59020 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726497AbgBAOmr (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 1 Feb 2020 09:42:47 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id CCD47AAFD;
        Sat,  1 Feb 2020 14:42:45 +0000 (UTC)
From:   Coly Li <colyli@suse.de>
To:     axboe@kernel.dk
Cc:     linux-bcache@vger.kernel.org, linux-block@vger.kernel.org,
        Coly Li <colyli@suse.de>
Subject: [PATCH 0/5] bcache patches for Linux v5.6-rc1
Date:   Sat,  1 Feb 2020 22:42:30 +0800
Message-Id: <20200201144235.94110-1-colyli@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

Here are the bcache patches for Linux v5.6-rc1. All the patches are
tested and survived my I/O pressure tests for 24+ hours intotal.

Please take them. Thank you in advance.

Coly Li
---

Coly Li (5):
  bcache: fix memory corruption in bch_cache_accounting_clear()
  bcache: explicity type cast in bset_bkey_last()
  bcache: add readahead cache policy options via sysfs interface
  bcache: fix incorrect data type usage in btree_flush_write()
  bcache: check return value of prio_read()

 drivers/md/bcache/bcache.h  |  3 +++
 drivers/md/bcache/bset.h    |  3 ++-
 drivers/md/bcache/journal.c |  3 ++-
 drivers/md/bcache/request.c | 17 ++++++++++++-----
 drivers/md/bcache/stats.c   | 10 +++++++---
 drivers/md/bcache/super.c   | 21 ++++++++++++++++-----
 drivers/md/bcache/sysfs.c   | 22 ++++++++++++++++++++++
 7 files changed, 64 insertions(+), 15 deletions(-)

-- 
2.16.4

