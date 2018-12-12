Return-Path: <SRS0=4xS2=OV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40420C65BAF
	for <linux-block@archiver.kernel.org>; Wed, 12 Dec 2018 17:56:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0429020839
	for <linux-block@archiver.kernel.org>; Wed, 12 Dec 2018 17:56:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0429020839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727845AbeLLR4w (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Dec 2018 12:56:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52496 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727808AbeLLR4w (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Dec 2018 12:56:52 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1FF053082E50;
        Wed, 12 Dec 2018 17:56:52 +0000 (UTC)
Received: from localhost (unknown [10.18.25.149])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4BF366012E;
        Wed, 12 Dec 2018 17:56:49 +0000 (UTC)
Date:   Wed, 12 Dec 2018 12:56:48 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        Damien Le Moal <damien.lemoal@wdc.com>
Subject: [git pull] device mapper fixes for 4.20
Message-ID: <20181212175648.GA25049@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Wed, 12 Dec 2018 17:56:52 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

The following changes since commit 2595646791c319cadfdbf271563aac97d0843dc7:

  Linux 4.20-rc5 (2018-12-02 15:07:55 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-4.20/dm-fixes

for you to fetch changes up to 2af6c0703d75fc3ff2e6de19b4b3adab96acc12d:

  dm thin: bump target version (2018-12-12 09:39:54 -0500)

Please pull, thanks.
Mike

----------------------------------------------------------------
- Fix DM cache metadata to verify that a cache has block before trying
  to continue with operation that requires them.

- Fix bio-based DM core's dm_make_request() to properly impose device
  limits on individual bios by making use of blk_queue_split().

- Fix long-standing race with how DM thinp notified userspace of
  thin-pool mode state changes before they were actually made.

- Fix the zoned target's bio completion handling; this is a fairly
  invassive fix at this stage but it is localized to the zoned target.
  Any zoned target users will benefit from this fix.

----------------------------------------------------------------
Damien Le Moal (1):
      dm zoned: Fix target BIO completion handling

Mike Snitzer (4):
      dm cache metadata: verify cache has blocks in blocks_are_clean_separate_dirty()
      dm: call blk_queue_split() to impose device limits on bios
      dm thin: send event about thin-pool state change _after_ making it
      dm thin: bump target version

 drivers/md/dm-cache-metadata.c |   4 ++
 drivers/md/dm-thin.c           |  72 ++++++++++++------------
 drivers/md/dm-zoned-target.c   | 122 +++++++++++++----------------------------
 drivers/md/dm.c                |   2 +
 4 files changed, 81 insertions(+), 119 deletions(-)
