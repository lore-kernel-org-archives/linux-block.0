Return-Path: <SRS0=t+Ub=SH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AC71C282CE
	for <linux-block@archiver.kernel.org>; Fri,  5 Apr 2019 22:59:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED7172175B
	for <linux-block@archiver.kernel.org>; Fri,  5 Apr 2019 22:59:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726218AbfDEW7d (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 5 Apr 2019 18:59:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54908 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725973AbfDEW7d (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 5 Apr 2019 18:59:33 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E11A159444;
        Fri,  5 Apr 2019 22:59:32 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5EF9C648BE;
        Fri,  5 Apr 2019 22:59:30 +0000 (UTC)
Date:   Fri, 5 Apr 2019 18:59:29 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        Alasdair G Kergon <agk@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [git pull] device mapper fixes for 5.1-rc4
Message-ID: <20190405225928.GB26473@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Fri, 05 Apr 2019 22:59:33 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

The following changes since commit 79a3aaa7b82e3106be97842dedfd8429248896e6:

  Linux 5.1-rc3 (2019-03-31 14:39:29 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-5.1/dm-fixes

for you to fetch changes up to 4ed319c6ac08e9a28fca7ac188181ac122f4de84:

  dm integrity: fix deadlock with overlapping I/O (2019-04-05 18:49:08 -0400)

Please pull, thanks.
Mike

----------------------------------------------------------------
- Two queue_limits stacking fixes: disable discards if underlying driver
  does.  And propagate BDI_CAP_STABLE_WRITES to fix sporadic checksum
  errors.

- Fix that reverts a DM core limit that wasn't needed given that
  dm-crypt was already updated to impose an equivalent limit.

- Fix dm-init to properly establish 'const' for __initconst array.

- Fix deadlock in DM integrity target that occurs when overlapping IO is
  being issued to it.  And two smaller fixes to the DM integrity target.

----------------------------------------------------------------
Andi Kleen (1):
      dm init: fix const confusion for dm_allowed_targets array

Ilya Dryomov (1):
      dm table: propagate BDI_CAP_STABLE_WRITES to fix sporadic checksum errors

Mike Snitzer (1):
      dm: disable DISCARD if the underlying storage no longer supports it

Mikulas Patocka (3):
      dm integrity: change memcmp to strncmp in dm_integrity_ctr
      dm: revert 8f50e358153d ("dm: limit the max bio size as BIO_MAX_PAGES * PAGE_SIZE")
      dm integrity: fix deadlock with overlapping I/O

YueHaibing (1):
      dm integrity: make dm_integrity_init and dm_integrity_exit static

 drivers/md/dm-core.h      |  1 +
 drivers/md/dm-init.c      |  2 +-
 drivers/md/dm-integrity.c | 16 +++++++---------
 drivers/md/dm-rq.c        | 11 +++++++----
 drivers/md/dm-table.c     | 39 +++++++++++++++++++++++++++++++++++++++
 drivers/md/dm.c           | 30 +++++++++++++++++-------------
 6 files changed, 72 insertions(+), 27 deletions(-)
