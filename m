Return-Path: <SRS0=k6TP=4V=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 799D4C3F2D1
	for <linux-block@archiver.kernel.org>; Wed,  4 Mar 2020 15:03:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50DEA20870
	for <linux-block@archiver.kernel.org>; Wed,  4 Mar 2020 15:03:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fJPZ3vAy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbgCDPDI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 4 Mar 2020 10:03:08 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32347 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726661AbgCDPDI (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 4 Mar 2020 10:03:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583334187;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=/RK+kx3gMxL3TIHVwXhY4IgJXaZC2b466NJJZet3AZg=;
        b=fJPZ3vAy7N3ew9xq4H+hxmoEShHDm30Wtr0lqWbEggIgomTj1miJdpe/WY7VC/N5gDouiy
        GgSzJavrcEmvzP4z+xl5A7vLDF0YWYy8eb6kwsoPnY3a7fLrqzt8wlIFzWJ5eHGrT7S467
        bt7flZ9cMJufRUFp3Eh8xK0Hk0vWUKQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-80-MXQE4cxkP0yRIugtVRnjQg-1; Wed, 04 Mar 2020 10:03:03 -0500
X-MC-Unique: MXQE4cxkP0yRIugtVRnjQg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E0959189F77A;
        Wed,  4 Mar 2020 15:03:01 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4445691D8C;
        Wed,  4 Mar 2020 15:02:58 +0000 (UTC)
Date:   Wed, 4 Mar 2020 10:02:57 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        Alasdair G Kergon <agk@redhat.com>,
        Hou Tao <houtao1@huawei.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Theodore Ts'o <tytso@mit.edu>
Subject: [git pull] device mapper fixes for 5.6-rc5
Message-ID: <20200304150257.GA19885@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

The following changes since commit 47ace7e012b9f7ad71d43ac9063d335ea3d6820b:

  dm: fix potential for q->make_request_fn NULL pointer (2020-01-27 14:52:36 -0500)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-5.6/dm-fixes

for you to fetch changes up to 636be4241bdd88fec273b38723e44bad4e1c4fae:

  dm: bump version of core and various targets (2020-03-03 11:10:21 -0500)

Please pull, thanks!
Mike

----------------------------------------------------------------
- Fix request-based DM's congestion_fn and actually wire it up to the
  bdi.

- Extend dm-bio-record to track additional struct bio members needed
  by DM integrity target.

- Fix DM core to properly advertise that a device is suspended during
  unload (between the presuspend and postsuspend hooks).  This change
  is a prereq for related DM integrity and DM writecache fixes.  It
  elevates DM integrity's 'suspending' state tracking to DM core.

- Four stable fixes for DM integrity target.

- Fix crash in DM cache target due to incorrect work item cancelling.

- Fix DM thin metadata lockdep warning that was introduced during 5.6
  merge window.

- Fix DM zoned target's chunk work refcounting that regressed during
  recent conversion to refcount_t.

- Bump the minor version for DM core and all target versions that have
  seen interface changes or important fixes during the 5.6 cycle.

----------------------------------------------------------------
Hou Tao (1):
      dm: fix congested_fn for request-based device

Mike Snitzer (3):
      dm bio record: save/restore bi_end_io and bi_integrity
      dm integrity: use dm_bio_record and dm_bio_restore
      dm: bump version of core and various targets

Mikulas Patocka (6):
      dm integrity: fix recalculation when moving from journal mode to bitmap mode
      dm integrity: fix a deadlock due to offloading to an incorrect workqueue
      dm integrity: fix invalid table returned due to argument count mismatch
      dm cache: fix a crash due to incorrect work item cancelling
      dm: report suspended device during destroy
      dm writecache: verify watermark during resume

Shin'ichiro Kawasaki (1):
      dm zoned: Fix reference counter initial value of chunk works

Theodore Ts'o (1):
      dm thin metadata: fix lockdep complaint

 drivers/md/dm-bio-record.h    | 15 ++++++++
 drivers/md/dm-cache-target.c  |  6 ++--
 drivers/md/dm-integrity.c     | 84 ++++++++++++++++++++++---------------------
 drivers/md/dm-mpath.c         |  2 +-
 drivers/md/dm-thin-metadata.c |  2 +-
 drivers/md/dm-verity-target.c |  2 +-
 drivers/md/dm-writecache.c    | 16 ++++++---
 drivers/md/dm-zoned-target.c  | 10 +++---
 drivers/md/dm.c               | 22 ++++++------
 include/uapi/linux/dm-ioctl.h |  4 +--
 10 files changed, 94 insertions(+), 69 deletions(-)

