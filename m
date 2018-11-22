Return-Path: <SRS0=CtFQ=OB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A981C43441
	for <linux-block@archiver.kernel.org>; Thu, 22 Nov 2018 15:19:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E34B120685
	for <linux-block@archiver.kernel.org>; Thu, 22 Nov 2018 15:19:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E34B120685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732273AbeKWB7a (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 22 Nov 2018 20:59:30 -0500
Received: from mx2.suse.de ([195.135.220.15]:45150 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731279AbeKWB7a (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Nov 2018 20:59:30 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3782BADD7;
        Thu, 22 Nov 2018 15:19:41 +0000 (UTC)
From:   Coly Li <colyli@suse.de>
To:     linux-bcache@vger.kernel.org
Cc:     linux-block@vger.kernel.org, Coly Li <colyli@suse.de>
Subject: [PATCH 0/5] Writeback performance tuning options
Date:   Thu, 22 Nov 2018 23:19:19 +0800
Message-Id: <20181122151924.103644-1-colyli@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

I receive requirement to provide options to permit people to do research
on writeback performance tuning for their extreme heavy workloads. And
these options are required to be disabled by default to avoid changing
current code behavior.
 
This series adds several disabled-by-default options for writeback
performance tuning.

- Auto gc after writeback accomplished
  sysfs entry gc_after_writeback is added, if it is explicitly enabled,
  gc thread will be forced woken up when writeback accomplished and
  all cache data are clean. This behavior will shrink bcache B+ tree
  and discard clean SSD space, which might be helpful for following
  write request. The following patches cover this option,
  - bcache: introduce force_wake_up_gc()
  - bcache: option to automatically run gc thread after writeback
    accomplished

- Tunnable cutoff writeback and cutoff writeback sync
  Currently cutoff writeback and cutoff wrireback sync are fixed value
  defined by macro. There is no way for people to set a larger value and
  test the resulting performance behavior. Now they can be specificed
  as dynamic module load time parameter (bch_cutoff_writeback, and
  bch_cutof_writeback_sync), and won't change after bcache module
  loaded. Now people can test and observe the behavior on their own
  cache device with larger cutoff writeback values. The following
  patches cover these 2 options,
  - bcache: add MODULE_DESCRIPTION information
  - bcache: make cutoff_writeback and cutoff_writeback_sync tunnable
  - bcache: set writeback_percent in a flexible range

- A more flexible writeback_percent range
  Currently writeback_percent is in range of [0, 40], because cutoff
  writeback value is defind as 40 by a macro. This patch permits the
  value to be specified in range [0, bch_cutoff_writeback], while the
  maximum value of bch_cutoff_writeback can be 70. Now people may have
  a more flexible writeback_percent parameter range to test and observe
  how bcache writeback code behaves on their own cache hardware. The
  following patch covers this change,
  - bcache: set writeback_percent in a flexible range

If anyone is also interested on writeback performance tuning with these
tunnable options, I do appreciate if you find a better performance
number with the non-default option values, and share them with us.

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

 drivers/md/bcache/bcache.h    | 14 ++++++++++++++
 drivers/md/bcache/btree.h     | 18 +++++++++++++++++
 drivers/md/bcache/super.c     | 45 +++++++++++++++++++++++++++++++++++++++++--
 drivers/md/bcache/sysfs.c     | 36 +++++++++++++++++++---------------
 drivers/md/bcache/writeback.c | 27 ++++++++++++++++++++++++++
 drivers/md/bcache/writeback.h | 12 ++++++++++--
 6 files changed, 132 insertions(+), 20 deletions(-)

-- 
2.16.4

