Return-Path: <SRS0=Ij7C=UE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8A0FC282DE
	for <linux-block@archiver.kernel.org>; Wed,  5 Jun 2019 07:27:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6D712075C
	for <linux-block@archiver.kernel.org>; Wed,  5 Jun 2019 07:27:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbfFEH1Z (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Jun 2019 03:27:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:41126 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726477AbfFEH1Z (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 5 Jun 2019 03:27:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C826CAE08;
        Wed,  5 Jun 2019 07:27:23 +0000 (UTC)
From:   Coly Li <colyli@suse.de>
To:     linux-bcache@vger.kernel.org
Cc:     linux-block@vger.kernel.org, Coly Li <colyli@suse.de>
Subject: [PATCH 0/6] fix for a race in btree_flush_write()
Date:   Wed,  5 Jun 2019 15:27:12 +0800
Message-Id: <20190605072718.121379-1-colyli@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

There is a race happens in btree_flush_write() which may cause
system hang or panic. This patch set is an effor to fix such race,
and it is also necessary for the jouranl-no-space deadlock fixes. 

Any review or comments is welcome.

Thanks in advance.

Coly Li
---

Coly Li (6):
  bcache: Revert "bcache: fix high CPU occupancy during journal"
  bcache: Revert "bcache: free heap cache_set->flush_btree in
    bch_journal_free"
  bcache: set largest seq to ja->seq[bucket_index] in
    journal_read_bucket()
  bcache: remove retry_flush_write from struct cache_set
  bcache: fix race in btree_flush_write()
  bcache: add reclaimed_journal_buckets to struct cache_set

 drivers/md/bcache/bcache.h  |   4 +-
 drivers/md/bcache/btree.c   |  15 +++++-
 drivers/md/bcache/btree.h   |   2 +
 drivers/md/bcache/journal.c | 111 ++++++++++++++++++++++++++++----------------
 drivers/md/bcache/journal.h |   4 ++
 drivers/md/bcache/sysfs.c   |  10 ++--
 drivers/md/bcache/util.h    |   2 -
 7 files changed, 97 insertions(+), 51 deletions(-)

-- 
2.16.4

