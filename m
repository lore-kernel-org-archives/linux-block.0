Return-Path: <SRS0=1XAp=BR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F365CC433E3
	for <linux-block@archiver.kernel.org>; Fri,  7 Aug 2020 16:03:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0D4421744
	for <linux-block@archiver.kernel.org>; Fri,  7 Aug 2020 16:03:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TcwCe/Jr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbgHGQDv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Aug 2020 12:03:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57948 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725815AbgHGQDu (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 Aug 2020 12:03:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596816230;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=YMyCdU/wtaUjxoSfIDmr2Y0P8qtFYAHXESuGcMNn9Ck=;
        b=TcwCe/JrO8gw5ixRFmCCsZgMaV4mWgueTlbh0bpUDU2WI2bTCzt8hE1Sx9FWJFedHWW1sn
        FW0o8/DxXAP3LLwvkxmAaBE/GuGqVGpHBgQh4sDvMMpZ1kDSJ7R7rwebUgfoWh1ZCj67mT
        9X08681ezwOIas2Mxcdw/DCG93HME/0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-174-_5aVZ4KBPWe37zQpt--3eA-1; Fri, 07 Aug 2020 12:03:48 -0400
X-MC-Unique: _5aVZ4KBPWe37zQpt--3eA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A1EB352706;
        Fri,  7 Aug 2020 16:03:28 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5E8BC5D9D5;
        Fri,  7 Aug 2020 16:03:28 +0000 (UTC)
Date:   Fri, 7 Aug 2020 12:03:27 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        Alasdair G Kergon <agk@redhat.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Ignat Korchagin <ignat@cloudflare.com>,
        JeongHyeon Lee <jhs2.lee@samsung.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        John Dorminy <jdorminy@redhat.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Ming Lei <ming.lei@redhat.com>,
        yangerkun <yangerkun@huawei.com>
Subject: [git pull] device mapper changes for 5.9
Message-ID: <20200807160327.GA977@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

The following changes since commit 11ba468877bb23f28956a35e896356252d63c983:

  Linux 5.8-rc5 (2020-07-12 16:34:50 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-5.9/dm-changes

for you to fetch changes up to a9cb9f4148ef6bb8fabbdaa85c42b2171fbd5a0d:

  dm: don't call report zones for more than the user requested (2020-08-04 16:31:12 -0400)

Please pull, thanks!
Mike

----------------------------------------------------------------
- DM multipath locking fixes around m->flags tests and improvements to
  bio-based code so that it follows patterns established by
  request-based code.

- Request-based DM core improvement to eliminate unnecessary call to
  blk_mq_queue_stopped().

- Add "panic_on_corruption" error handling mode to DM verity target.

- DM bufio fix to to perform buffer cleanup from a workqueue rather
  than wait for IO in reclaim context from shrinker.

- DM crypt improvement to optionally avoid async processing via
  workqueues for reads and/or writes -- via "no_read_workqueue" and
  "no_write_workqueue" features.  This more direct IO processing
  improves latency and throughput with faster storage.  Avoiding
  workqueue IO submission for writes (DM_CRYPT_NO_WRITE_WORKQUEUE) is
  a requirement for adding zoned block device support to DM crypt.

- Add zoned block device support to DM crypt.  Makes use of
  DM_CRYPT_NO_WRITE_WORKQUEUE and a new optional feature
  (DM_CRYPT_WRITE_INLINE) that allows write completion to wait for
  encryption to complete.  This allows write ordering to be preserved,
  which is needed for zoned block devices.

- Fix DM ebs target's check for REQ_OP_FLUSH.

- Fix DM core's report zones support to not report more zones than
  were requested.

- A few small compiler warning fixes.

- DM dust improvements to return output directly to the user rather
  than require they scrape the system log for output.

----------------------------------------------------------------
Damien Le Moal (5):
      dm crypt: Enable zoned block device support
      dm verity: Fix compilation warning
      dm raid: Remove empty if statement
      dm ioctl: Fix compilation warning
      dm init: Set file local variable static

Ignat Korchagin (1):
      dm crypt: add flags to optionally bypass kcryptd workqueues

JeongHyeon Lee (1):
      dm verity: add "panic_on_corruption" error handling mode

Johannes Thumshirn (1):
      dm: don't call report zones for more than the user requested

John Dorminy (1):
      dm ebs: Fix incorrect checking for REQ_OP_FLUSH

Mike Snitzer (7):
      dm mpath: changes from initial m->flags locking audit
      dm mpath: take m->lock spinlock when testing QUEUE_IF_NO_PATH
      dm mpath: push locking down to must_push_back_rq()
      dm mpath: factor out multipath_queue_bio
      dm mpath: rework __map_bio()
      dm mpath: rename current_pgpath to pgpath in multipath_prepare_ioctl
      dm mpath: use double checked locking in fast path

Mikulas Patocka (1):
      dm bufio: do buffer cleanup from a workqueue

Ming Lei (1):
      dm rq: don't call blk_mq_queue_stopped() in dm_stop_queue()

yangerkun (2):
      dm dust: report some message results directly back to user
      dm dust: add interface to list all badblocks

 .../admin-guide/device-mapper/dm-dust.rst          |  32 ++++-
 Documentation/admin-guide/device-mapper/verity.rst |   4 +
 drivers/md/dm-bufio.c                              |  60 ++++++---
 drivers/md/dm-crypt.c                              | 129 ++++++++++++++++--
 drivers/md/dm-dust.c                               |  58 ++++++--
 drivers/md/dm-ebs-target.c                         |   2 +-
 drivers/md/dm-init.c                               |   2 +-
 drivers/md/dm-ioctl.c                              |   2 +-
 drivers/md/dm-mpath.c                              | 146 ++++++++++++++-------
 drivers/md/dm-raid.c                               |   2 -
 drivers/md/dm-rq.c                                 |   3 -
 drivers/md/dm-verity-target.c                      |  13 +-
 drivers/md/dm-verity-verify-sig.h                  |  14 +-
 drivers/md/dm-verity.h                             |   3 +-
 drivers/md/dm.c                                    |   3 +-
 15 files changed, 355 insertions(+), 118 deletions(-)

