Return-Path: <SRS0=iCYb=RZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7A51C43381
	for <linux-block@archiver.kernel.org>; Fri, 22 Mar 2019 13:14:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91A55204FD
	for <linux-block@archiver.kernel.org>; Fri, 22 Mar 2019 13:14:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728265AbfCVNN6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Mar 2019 09:13:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:55124 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728552AbfCVNN6 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Mar 2019 09:13:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BDCE2ABD5;
        Fri, 22 Mar 2019 13:13:56 +0000 (UTC)
From:   Johannes Thumshirn <jthumshirn@suse.de>
To:     Jens Axboe <axboe@fb.com>
Cc:     Hannes Reinecke <hare@suse.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
        Linux Block Layer Mailinglist <linux-block@vger.kernel.org>,
        Linux FSDEVEL Mailinglist <linux-fsdevel@vger.kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH v2 0/3] add flag for tracking bio allocation
Date:   Fri, 22 Mar 2019 14:13:43 +0100
Message-Id: <20190322131346.20169-1-jthumshirn@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hannes recently sent a patch in [1] to fix an Oops caused by
__blkdev_direct_IO_simple() doing bio submissions from the stack and which
ended up being freed bio bio_free(). As bio_free() expected a bio which was
allocated by bio_alloc_bioset() it crashed.

I've sent out a different aproach to tackling this problem and both Jens and
Jan leaned to my solution, namely adding another bio flag tracking the
allocation.

As we start to run out of flags, Jens has killed the BIO_SEG_VALID flag in a
preparation patch and I added a compile time check as a safety net, so we're
not accidentially overriding the high 3 bits of bi_flags, which are used for
the BVEC_POOL_IDX().

This set has passed a full xfstests run on both BTRFS and XFS (against zram
disks) and a full blktests run without introducing any regressions.

[1] https://lore.kernel.org/linux-block/20190320081253.129688-1-hare@suse.de/

Jens Axboe (1):
  block: bio: kill BIO_SEG_VALID flag

Johannes Thumshirn (2):
  block: bio: ensure newly added bio flags don't override BVEC_POOL_IDX
  block: bio: introduce BIO_ALLOCED flag and check it in bio_free

 block/bio.c               | 17 ++++++++++++-----
 block/blk-merge.c         | 11 ++++-------
 drivers/md/raid5.c        |  2 +-
 include/linux/blk_types.h | 27 +++++++++++++++------------
 4 files changed, 32 insertions(+), 25 deletions(-)

-- 
2.16.4

