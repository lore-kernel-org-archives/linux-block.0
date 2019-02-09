Return-Path: <SRS0=Do5T=QQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E6F4C282C4
	for <linux-block@archiver.kernel.org>; Sat,  9 Feb 2019 04:53:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D8CB20857
	for <linux-block@archiver.kernel.org>; Sat,  9 Feb 2019 04:53:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbfBIExS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Feb 2019 23:53:18 -0500
Received: from mx2.suse.de ([195.135.220.15]:57548 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726222AbfBIExS (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 8 Feb 2019 23:53:18 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2FCC4AF6F;
        Sat,  9 Feb 2019 04:53:17 +0000 (UTC)
From:   Coly Li <colyli@suse.de>
To:     axboe@kernel.dk
Cc:     linux-bcache@vger.kernel.org, linux-block@vger.kernel.org,
        Coly Li <colyli@suse.de>
Subject: [PATCH 00/19] bcache patches for Linux v5.1 
Date:   Sat,  9 Feb 2019 12:52:52 +0800
Message-Id: <20190209045311.15677-1-colyli@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

This is the bcache patch set for Linux v5.1 merge window.

In this series, we have 4 majour contributers for 19 changes,
- Colin Ian King contributes a patch to improve indent format.
- Danial Axtens fixes a bug by not caching DISCARD/TRIM bio onto cache
  device, to avoid an oops in block layer code.
- Junhui Tang contributes a fix which removes a bogus BUG_ON() panic
  by stale and dirty keys.
- I fixes a series of input overflow issues in bcache sysfs interface,
  and export backing device uuid and name for user space tool. There
  also is a patch to fix caching read ahead metadata issue for XFS.

Please take them in your for-next.

Thanks in advance.

Coly Li
---

Colin Ian King (1):
  bcache: fix indentation issue, remove tabs on a hunk of code

Coly Li (16):
  bcache: not use hard coded memset size in bch_cache_accounting_clear()
  bcache: export backing_dev_name via sysfs
  bcache: export backing_dev_uuid via sysfs
  bcache: improve sysfs_strtoul_clamp()
  bcache: fix input integer overflow of congested threshold
  bcache: fix input overflow to sequential_cutoff
  bcache: add sysfs_strtoul_bool() for setting bit-field variables
  bcache: use sysfs_strtoul_bool() to set bit-field variables
  bcache: fix input overflow to writeback_delay
  bcache: fix potential div-zero error of writeback_rate_i_term_inverse
  bcache: fix potential div-zero error of writeback_rate_p_term_inverse
  bcache: fix input overflow to writeback_rate_minimum
  bcache: fix input overflow to journal_delay_ms
  bcache: fix input overflow to cache set io_error_limit
  bcache: fix input overflow to cache set sysfs file io_error_halflife
  bcache: use (REQ_META|REQ_PRIO) to indicate bio for metadata

Daniel Axtens (1):
  bcache: never writeback a discard operation

Tang Junhui (1):
  bcache: treat stale && dirty keys as bad keys

 drivers/md/bcache/extents.c   | 13 +++----
 drivers/md/bcache/request.c   |  7 ++--
 drivers/md/bcache/stats.c     |  2 +-
 drivers/md/bcache/super.c     | 30 ++++++++--------
 drivers/md/bcache/sysfs.c     | 81 +++++++++++++++++++++++++++++++------------
 drivers/md/bcache/sysfs.h     | 23 ++++++++++--
 drivers/md/bcache/writeback.h |  3 ++
 7 files changed, 109 insertions(+), 50 deletions(-)

-- 
2.16.4

