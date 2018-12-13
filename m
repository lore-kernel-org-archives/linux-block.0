Return-Path: <SRS0=8pZC=OW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F6F6C65BAE
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 14:54:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 068272086D
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 14:54:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 068272086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728613AbeLMOyk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Dec 2018 09:54:40 -0500
Received: from mx2.suse.de ([195.135.220.15]:51296 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727822AbeLMOyk (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Dec 2018 09:54:40 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A94B7AD5C;
        Thu, 13 Dec 2018 14:54:38 +0000 (UTC)
From:   Coly Li <colyli@suse.de>
To:     linux-bcache@vger.kernel.org, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, Coly Li <colyli@suse.de>
Subject: [PATCH 00/12] bcache patches for Linux v4.21 
Date:   Thu, 13 Dec 2018 22:53:45 +0800
Message-Id: <20181213145357.38528-1-colyli@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

Here are the patches for Linux v4.21.

The patches from me are for a set of disabled-by-default optimization
for writeback cache mode, which are used by some users I know. Guoju
Fang contributes a patch to add number of keys in
trace_bcache_journal_write(). And there are 6 patchges are from Shenghui
Wang, which removes an unncessary NULL check for
debugfs_remove_recursive() and debugfs_remove(), adds useful code
comments for bcache, and improves sysfs information display for bcache
writeback rate parameters.

We don't have important or big change in this run. Please take these
patches.

Thanks in advance.

Coly Li
---
Coly Li (5):
  bcache: introduce force_wake_up_gc()
  bcache: option to automatically run gc thread after writeback
    accomplished
  bcache: add MODULE_DESCRIPTION information
  bcache: make cutoff_writeback and cutoff_writeback_sync tunnable
  bcache: set writeback_percent in a flexible range

Guoju Fang (1):
  bcache: print number of keys in trace_bcache_journal_write

Shenghui Wang (6):
  bcache: add comment for cache_set->fill_iter
  bcache: do not check if debug dentry is ERR or NULL explicitly on
    remove
  bcache: update comment for bch_data_insert
  bcache: update comment in sysfs.c
  bcache: do not mark writeback_running until backing dev attached to
    cache_set
  bcache: cannot set writeback_running via sysfs if no writeback kthread
    created

 drivers/md/bcache/bcache.h    | 20 +++++++++++++-
 drivers/md/bcache/btree.c     |  5 ++++
 drivers/md/bcache/btree.h     | 18 +++++++++++++
 drivers/md/bcache/debug.c     |  3 +--
 drivers/md/bcache/journal.c   |  2 +-
 drivers/md/bcache/request.c   |  6 ++---
 drivers/md/bcache/super.c     | 48 +++++++++++++++++++++++++++++++---
 drivers/md/bcache/sysfs.c     | 61 +++++++++++++++++++++++++++++--------------
 drivers/md/bcache/writeback.c | 30 ++++++++++++++++++++-
 drivers/md/bcache/writeback.h | 12 +++++++--
 include/trace/events/bcache.h | 27 ++++++++++++++++---
 11 files changed, 195 insertions(+), 37 deletions(-)

-- 
2.16.4

