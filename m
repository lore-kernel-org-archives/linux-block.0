Return-Path: <SRS0=+obT=ZO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C3D1C432C3
	for <linux-block@archiver.kernel.org>; Fri, 22 Nov 2019 15:38:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E81C20706
	for <linux-block@archiver.kernel.org>; Fri, 22 Nov 2019 15:38:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TOVD9Jnl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbfKVPiA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Nov 2019 10:38:00 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:57097 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbfKVPh7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Nov 2019 10:37:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574437078;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=JgOI0RV/c/0FOorScknSDAMGZ0YD4/StvR8vLEuMFig=;
        b=TOVD9JnlsoulLDxlOnZr96Kbpja3kbM0XykAue/C0r3h6YuSTxfm5IqdmS4LLzmfX8s/PL
        cEG1K2r89rKWLUhZxF8lJvLYRzhIJD41sIrnl3dNpQI6UTwz8WchZjzVA1ZtnlhOpdMwhq
        Rcl8Yp+SF8seKXbC0VzslSkUvohykDI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-6-jMfLaM6KOrezRf8XTnDOBA-1; Fri, 22 Nov 2019 10:37:55 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AD6BC8C6BBD;
        Fri, 22 Nov 2019 15:37:52 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6ECE02934B;
        Fri, 22 Nov 2019 15:37:48 +0000 (UTC)
Date:   Fri, 22 Nov 2019 10:37:47 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        Alasdair G Kergon <agk@redhat.com>,
        Bryan Gurney <bgurney@redhat.com>,
        Dmitry Fomichev <dmitry.fomichev@wdc.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Heinz Mauelshagen <heinzm@redhat.com>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Maged Mokhtar <mmokhtar@petasan.org>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nikos Tsironis <ntsironis@arrikto.com>
Subject: [git pull] device mapper changes for 5.5
Message-ID: <20191122153747.GA23143@redhat.com>
MIME-Version: 1.0
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: jMfLaM6KOrezRf8XTnDOBA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

The following changes since commit a99d8080aaf358d5d23581244e5da23b35e340b9=
:

  Linux 5.4-rc6 (2019-11-03 14:07:26 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git =
tags/for-5.5/dm-changes

for you to fetch changes up to f612b2132db529feac4f965f28a1b9258ea7c22b:

  Revert "dm crypt: use WQ_HIGHPRI for the IO and crypt workqueues" (2019-1=
1-20 17:27:39 -0500)

Please pull, thanks!
Mike

----------------------------------------------------------------
- Fix DM core to disallow stacking request-based DM on partitions.

- Fix DM raid target to properly resync raidset even if bitmap needed
  additional pages.

- Fix DM crypt performance regression due to use of WQ_HIGHPRI for the
  IO and crypt workqueues.

- Fix DM integrity metadata layout that was aligned on 128K boundary
  rather than the intended 4K boundary (removes 124K of wasted space for
  each metadata block).

- Improve the DM thin, cache and clone targets to use spin_lock_irq
  rather than spin_lock_irqsave where possible.

- Fix DM thin single thread performance that was lost due to needless
  workqueue wakeups.

- Fix DM zoned target performance that was lost due to excessive backing
  device checks.

- Add ability to trigger write failure with the DM dust test target.

- Fix whitespace indentation in drivers/md/Kconfig.

- Various smalls fixes and cleanups (e.g. use struct_size, fix
  uninitialized variable, variable renames, etc).

----------------------------------------------------------------
Bryan Gurney (3):
      dm dust: change result vars to r
      dm dust: change ret to r in dust_map_read and dust_map
      dm dust: add limited write failure mode

Dmitry Fomichev (1):
      dm zoned: reduce overhead of backing device checks

Gustavo A. R. Silva (1):
      dm stripe: use struct_size() in kmalloc()

Heinz Mauelshagen (4):
      dm raid: change rs_set_dev_and_array_sectors API and callers
      dm raid: to ensure resynchronization, perform raid set grow in preres=
ume
      dm raid: simplify rs_setup_recovery call chain
      dm raid: streamline rs_get_progress() and its raid_status() caller si=
de

Jeffle Xu (1):
      dm thin: wakeup worker only when deferred bios exist

Krzysztof Kozlowski (1):
      dm: Fix Kconfig indentation

Maged Mokhtar (1):
      dm writecache: handle REQ_FUA

Mike Snitzer (2):
      dm table: do not allow request-based DM to stack on partitions
      Revert "dm crypt: use WQ_HIGHPRI for the IO and crypt workqueues"

Mikulas Patocka (6):
      dm writecache: fix uninitialized variable warning
      dm clone: replace spin_lock_irqsave with spin_lock_irq
      dm thin: replace spin_lock_irqsave with spin_lock_irq
      dm bio prison: replace spin_lock_irqsave with spin_lock_irq
      dm cache: replace spin_lock_irqsave with spin_lock_irq
      dm integrity: fix excessive alignment of metadata runs

Nathan Chancellor (1):
      dm raid: Remove unnecessary negation of a shift in raid10_format_to_m=
d_layout

Nikos Tsironis (1):
      dm clone: add bucket_lock_irq/bucket_unlock_irq helpers

 .../admin-guide/device-mapper/dm-integrity.rst     |   5 +
 .../admin-guide/device-mapper/dm-raid.rst          |   2 +
 drivers/md/Kconfig                                 |  54 +++----
 drivers/md/dm-bio-prison-v1.c                      |  27 ++--
 drivers/md/dm-bio-prison-v2.c                      |  26 ++--
 drivers/md/dm-cache-target.c                       |  77 ++++------
 drivers/md/dm-clone-metadata.c                     |  29 ++--
 drivers/md/dm-clone-metadata.h                     |   4 +-
 drivers/md/dm-clone-target.c                       |  62 ++++----
 drivers/md/dm-crypt.c                              |   9 +-
 drivers/md/dm-dust.c                               |  97 ++++++++----
 drivers/md/dm-integrity.c                          |  28 +++-
 drivers/md/dm-raid.c                               | 164 +++++++++++------=
----
 drivers/md/dm-stripe.c                             |  15 +-
 drivers/md/dm-table.c                              |  27 +---
 drivers/md/dm-thin.c                               | 118 +++++++--------
 drivers/md/dm-writecache.c                         |   5 +-
 drivers/md/dm-zoned-metadata.c                     |  29 ++--
 drivers/md/dm-zoned-reclaim.c                      |   8 +-
 drivers/md/dm-zoned-target.c                       |  54 +++++--
 drivers/md/dm-zoned.h                              |   2 +
 include/linux/device-mapper.h                      |   3 -
 22 files changed, 433 insertions(+), 412 deletions(-)

