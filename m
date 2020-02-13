Return-Path: <SRS0=GmId=4B=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8423EC2BA83
	for <linux-block@archiver.kernel.org>; Thu, 13 Feb 2020 14:12:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65A7D24649
	for <linux-block@archiver.kernel.org>; Thu, 13 Feb 2020 14:12:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730210AbgBMOMS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Feb 2020 09:12:18 -0500
Received: from mx2.suse.de ([195.135.220.15]:50248 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730078AbgBMOMS (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Feb 2020 09:12:18 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 38057AE34;
        Thu, 13 Feb 2020 14:12:17 +0000 (UTC)
From:   Coly Li <colyli@suse.de>
To:     axboe@kernel.dk
Cc:     linux-bcache@vger.kernel.org, linux-block@vger.kernel.org,
        Coly Li <colyli@suse.de>
Subject: [PATCH 0/3] bcache patches for Linux v5.6-rc2 
Date:   Thu, 13 Feb 2020 22:12:04 +0800
Message-Id: <20200213141207.77219-1-colyli@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

Here are 3 minor fixes Linux v5.6-rc2. The first 2 patches fix
kthread creating failure during bcache cache set starts up. The
last patch is a code clean up.

Please take them. Thanks in advance.

Coly Li
---
Coly Li (3):
  bcache: ignore pending signals when creating gc and allocator thread
  bcache: Revert "bcache: shrink btree node cache after
    bch_btree_check()"
  bcache: remove macro nr_to_fifo_front()

 drivers/md/bcache/alloc.c   | 18 ++++++++++++++++--
 drivers/md/bcache/btree.c   | 13 +++++++++++++
 drivers/md/bcache/journal.c |  7 ++-----
 drivers/md/bcache/super.c   | 17 -----------------
 4 files changed, 31 insertions(+), 24 deletions(-)

-- 
2.16.4

