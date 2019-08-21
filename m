Return-Path: <SRS0=wMiD=WR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9531C3A59E
	for <linux-block@archiver.kernel.org>; Wed, 21 Aug 2019 09:15:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C2A422DA7
	for <linux-block@archiver.kernel.org>; Wed, 21 Aug 2019 09:15:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726349AbfHUJPR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Aug 2019 05:15:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53978 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726317AbfHUJPQ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Aug 2019 05:15:16 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 80EA9315C009;
        Wed, 21 Aug 2019 09:15:16 +0000 (UTC)
Received: from localhost (ovpn-8-29.pek2.redhat.com [10.72.8.29])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D28C11001B09;
        Wed, 21 Aug 2019 09:15:10 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Hannes Reinecke <hare@suse.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Mike Snitzer <snitzer@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH V2 0/6] block: don't acquire .sysfs_lock before removing mq & iosched kobjects
Date:   Wed, 21 Aug 2019 17:15:00 +0800
Message-Id: <20190821091506.21196-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Wed, 21 Aug 2019 09:15:16 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

The 1st 4 patches cleans up current uses on q->sysfs_lock.

The 5th patch adds one helper for checking if queue is registered.

The last patch splits .sysfs_lock into two locks: one is only for
sync .store/.show from sysfs, the other one is for pretecting kobjects
registering/unregistering. Meantime avoid to acquire .sysfs_lock when
removing mq & iosched kobjects, so that the reported deadlock can
be fixed.

V2:
	- remove several uses on .sysfs_lock
	- Remove blk_mq_register_dev()
	- add one helper for checking queue registered
	- split .sysfs_lock into two locks

Bart Van Assche (1):
  block: Remove blk_mq_register_dev()

Ming Lei (5):
  block: don't hold q->sysfs_lock in elevator_init_mq
  blk-mq: don't hold q->sysfs_lock in blk_mq_map_swqueue
  blk-mq: don't hold q->sysfs_lock in blk_mq_realloc_hw_ctxs()
  block: add helper for checking if queue is registered
  block: split .sysfs_lock into two locks

 block/blk-core.c       |  1 +
 block/blk-mq-sysfs.c   | 23 ++++------------
 block/blk-mq.c         | 10 -------
 block/blk-sysfs.c      | 50 +++++++++++++++++++++-------------
 block/blk-wbt.c        |  2 +-
 block/blk.h            |  2 +-
 block/elevator.c       | 62 +++++++++++++++++++++++++++++++-----------
 include/linux/blk-mq.h |  1 -
 include/linux/blkdev.h |  2 ++
 9 files changed, 88 insertions(+), 65 deletions(-)

Cc: Christoph Hellwig <hch@infradead.org>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Greg KH <gregkh@linuxfoundation.org>
Cc: Mike Snitzer <snitzer@redhat.com>
Cc: Bart Van Assche <bvanassche@acm.org>


-- 
2.20.1

