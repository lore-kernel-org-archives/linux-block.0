Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FBB3C433FE
	for <linux-block@archiver.kernel.org>; Fri,  4 Dec 2020 21:07:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2499622CF8
	for <linux-block@archiver.kernel.org>; Fri,  4 Dec 2020 21:07:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726301AbgLDVG6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 4 Dec 2020 16:06:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:54029 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726075AbgLDVG6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 4 Dec 2020 16:06:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607115932;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=L7QFj40xlovDuelReET/gYjvgxdsLVAdbelGUl23rc8=;
        b=bT4SViPMsSAy1fXK4sGkjv+hqDk2lhNip3DoXxul72ZOj8ZtVBiiYjCrxA9GZMbNsAiBkW
        YYGC8MynNGydclX7rF67aJldtRKOQKoXkzWZRmzkfOCMlJfrzg3ST6WlfZFbFEGITcBc7A
        9XzxBkHvfxCadldFdhvGdWK0FvO37u0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-322-TJYsPvuJPYiO0aWrVvlbPA-1; Fri, 04 Dec 2020 16:05:27 -0500
X-MC-Unique: TJYsPvuJPYiO0aWrVvlbPA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C1AE2800D53;
        Fri,  4 Dec 2020 21:05:25 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7E2C81002391;
        Fri,  4 Dec 2020 21:05:22 +0000 (UTC)
Date:   Fri, 4 Dec 2020 16:05:21 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        Alasdair G Kergon <agk@redhat.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sergei Shtepa <sergei.shtepa@veeam.com>,
        Thomas Gleixner <tglx@linutronix.de>, axboe@kernel.dk,
        vgoyal@redhat.com
Subject: [git pull] device mapper fixes for 5.10-rc7
Message-ID: <20201204210521.GA3937@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

The following changes since commit 09162bc32c880a791c6c0668ce0745cf7958f576:

  Linux 5.10-rc4 (2020-11-15 16:44:31 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-5.10/dm-fixes

for you to fetch changes up to bde3808bc8c2741ad3d804f84720409aee0c2972:

  dm: remove invalid sparse __acquires and __releases annotations (2020-12-04 15:25:18 -0500)

Please pull, thanks!
Mike

----------------------------------------------------------------
- Fix DM's bio splitting changes that were made during v5.9.
  Restores splitting in terms of varied per-target ti->max_io_len
  rather than use block core's single stacked 'chunk_sectors' limit.

- Like DM crypt, update DM integrity to not use crypto drivers that
  have CRYPTO_ALG_ALLOCATES_MEMORY set.

- Fix DM writecache target's argument parsing and status display.

- Remove needless BUG() from dm writecache's persistent_memory_claim()

- Remove old gcc workaround in DM cache target's block_div() for ARM
  link errors now that gcc >= 4.9 is required.

- Fix RCU locking in dm_blk_report_zones and dm_dax_zero_page_range.

- Remove old, and now frowned upon, BUG_ON(in_interrupt()) in
  dm_table_event().

- Remove invalid sparse annotations from dm_prepare_ioctl() and
  dm_unprepare_ioctl().

----------------------------------------------------------------
Mike Snitzer (4):
      dm writecache: remove BUG() and fail gracefully instead
      dm: fix IO splitting
      dm: fix double RCU unlock in dm_dax_zero_page_range() error path
      dm: remove invalid sparse __acquires and __releases annotations

Mikulas Patocka (3):
      dm integrity: don't use drivers that have CRYPTO_ALG_ALLOCATES_MEMORY
      dm writecache: advance the number of arguments when reporting max_age
      dm writecache: fix the maximum number of arguments

Nick Desaulniers (1):
      Revert "dm cache: fix arm link errors with inline"

Sergei Shtepa (1):
      dm: fix bug with RCU locking in dm_blk_report_zones

Thomas Gleixner (1):
      dm table: Remove BUG_ON(in_interrupt())

 block/blk-merge.c            |  2 +-
 drivers/md/dm-cache-target.c |  4 ----
 drivers/md/dm-integrity.c    |  4 ++--
 drivers/md/dm-table.c        | 11 -----------
 drivers/md/dm-writecache.c   |  6 ++++--
 drivers/md/dm.c              | 29 +++++++++++++++--------------
 include/linux/blkdev.h       | 11 ++++++-----
 7 files changed, 28 insertions(+), 39 deletions(-)

