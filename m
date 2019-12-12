Return-Path: <SRS0=VRi+=2C=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ACE9C43603
	for <linux-block@archiver.kernel.org>; Thu, 12 Dec 2019 14:59:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 168A7206C3
	for <linux-block@archiver.kernel.org>; Thu, 12 Dec 2019 14:59:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AqZbM3GW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728939AbfLLO7G (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 12 Dec 2019 09:59:06 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:59273 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728932AbfLLO7G (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Dec 2019 09:59:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576162744;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=0UiWSkVrKxFCttope591KZVuHQT9QMDA6N5OqeARWXI=;
        b=AqZbM3GWg1r46v3YA2hgtKOaqAdYd/ThJKlu4qvV/9aIhHFPDgY80pqEbF0VKf6Cn41qvy
        pq0RvI+SBw/t6D9KZTti2vQF4jbPA+jNhiUFGd4RFvcm/2P345+7zdKz5ls7Pr+QoojsMl
        S7wSV4n4Jwl0sHajrBz5Y7phCjnmy5k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-382-7imFaNEFOtWAcMnD7jdw4g-1; Thu, 12 Dec 2019 09:59:02 -0500
X-MC-Unique: 7imFaNEFOtWAcMnD7jdw4g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4CB2218552D3;
        Thu, 12 Dec 2019 14:59:01 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B859960BE1;
        Thu, 12 Dec 2019 14:58:58 +0000 (UTC)
Date:   Thu, 12 Dec 2019 09:58:57 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        Alasdair G Kergon <agk@redhat.com>,
        Diego Calleja <diegocg@gmail.com>,
        Eric Biggers <ebiggers@google.com>,
        Hou Tao <houtao1@huawei.com>,
        Nikos Tsironis <ntsironis@arrikto.com>
Subject: [git pull] device mapper fixes for 5.5-rc2
Message-ID: <20191212145857.GA27301@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

The following changes since commit f612b2132db529feac4f965f28a1b9258ea7c22b:

  Revert "dm crypt: use WQ_HIGHPRI for the IO and crypt workqueues" (2019-11-20 17:27:39 -0500)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-5.5/dm-fixes

for you to fetch changes up to 7fc979f8204fb763e203d3e716c17d352eb96b35:

  docs: dm-integrity: remove reference to ARC4 (2019-12-10 10:02:43 -0500)

Please pull, thanks!
Mike

----------------------------------------------------------------
- Fix DM multipath by restoring full path selector functionality for
  bio-based configurations that don't haave a SCSI device handler.

- Fix dm-btree removal to ensure non-root btree nodes have at least
  (max_entries / 3) entries.  This resolves userspace thin_check
  utility's report of "too few entries in btree_node".

- Fix both the DM thin-provisioning and dm-clone targets to properly
  flush the data device prior to metadata commit.  This resolves the
  potential for inconsistency across a power loss event when the data
  device has a volatile writeback cache.

- Small documentation fixes to dm-clone and dm-integrity.

----------------------------------------------------------------
Diego Calleja (1):
      dm: add dm-clone to the documentation index

Eric Biggers (1):
      docs: dm-integrity: remove reference to ARC4

Hou Tao (1):
      dm btree: increase rebalance threshold in __rebalance2()

Mike Snitzer (1):
      dm mpath: remove harmful bio-based optimization

Nikos Tsironis (5):
      dm clone metadata: Track exact changes per transaction
      dm clone metadata: Use a two phase commit
      dm clone: Flush destination device before committing metadata
      dm thin metadata: Add support for a pre-commit callback
      dm thin: Flush data device before committing metadata

 .../admin-guide/device-mapper/dm-integrity.rst     |   2 +-
 Documentation/admin-guide/device-mapper/index.rst  |   1 +
 drivers/md/dm-clone-metadata.c                     | 136 +++++++++++++++------
 drivers/md/dm-clone-metadata.h                     |  17 +++
 drivers/md/dm-clone-target.c                       |  53 ++++++--
 drivers/md/dm-mpath.c                              |  37 +-----
 drivers/md/dm-thin-metadata.c                      |  29 +++++
 drivers/md/dm-thin-metadata.h                      |   7 ++
 drivers/md/dm-thin.c                               |  42 ++++++-
 drivers/md/persistent-data/dm-btree-remove.c       |   8 +-
 10 files changed, 248 insertions(+), 84 deletions(-)

