Return-Path: <SRS0=A22s=WX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58147C3A5A3
	for <linux-block@archiver.kernel.org>; Tue, 27 Aug 2019 11:02:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38D1720674
	for <linux-block@archiver.kernel.org>; Tue, 27 Aug 2019 11:02:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728559AbfH0LCA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Aug 2019 07:02:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58694 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726125AbfH0LCA (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Aug 2019 07:02:00 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0B706A4D3E4;
        Tue, 27 Aug 2019 11:02:00 +0000 (UTC)
Received: from localhost (ovpn-8-27.pek2.redhat.com [10.72.8.27])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 330D060471;
        Tue, 27 Aug 2019 11:01:52 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Hannes Reinecke <hare@suse.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Mike Snitzer <snitzer@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@wdc.com>
Subject: [PATCH V4 0/5] block: don't acquire .sysfs_lock before removing mq & iosched kobjects
Date:   Tue, 27 Aug 2019 19:01:43 +0800
Message-Id: <20190827110148.808-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.68]); Tue, 27 Aug 2019 11:02:00 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

The 1st 3 patches cleans up current uses on q->sysfs_lock.

The 4th patch adds one helper for checking if queue is registered.

The last patch splits .sysfs_lock into two locks: one is only for
sync .store/.show from sysfs, the other one is for pretecting kobjects
registering/unregistering. Meantime avoid to acquire .sysfs_lock when
removing mq & iosched kobjects, so that the reported deadlock can
be fixed.

V4:
	- address comments from Bart
	- update comments, add comments about releasing sysfs_lock in elevator_switch_mq
	- fix a race in blk_register_queue by holding sysfs_lock for
	  emitting KOBJ_ADD
	- only the 5th patch is updated

V3:
	- drop the 4th patch in V2, which is wrong, meantime not necesary
	  for fixing this deadlock
	- replace comment with one WARN_ON_ONCE() in patch 2
	- add reviewed-by tag

V2:
	- remove several uses on .sysfs_lock
	- Remove blk_mq_register_dev()
	- add one helper for checking queue registered
	- split .sysfs_lock into two locks


Bart Van Assche (1):
  block: Remove blk_mq_register_dev()

Ming Lei (4):
  block: don't hold q->sysfs_lock in elevator_init_mq
  blk-mq: don't hold q->sysfs_lock in blk_mq_map_swqueue
  block: add helper for checking if queue is registered
  block: split .sysfs_lock into two locks

 block/blk-core.c       |  1 +
 block/blk-mq-sysfs.c   | 23 ++++----------
 block/blk-mq.c         |  7 -----
 block/blk-sysfs.c      | 50 +++++++++++++++++------------
 block/blk-wbt.c        |  2 +-
 block/blk.h            |  2 +-
 block/elevator.c       | 71 +++++++++++++++++++++++++++++++-----------
 include/linux/blk-mq.h |  1 -
 include/linux/blkdev.h |  2 ++
 9 files changed, 94 insertions(+), 65 deletions(-)

Cc: Christoph Hellwig <hch@infradead.org>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Greg KH <gregkh@linuxfoundation.org>
Cc: Mike Snitzer <snitzer@redhat.com>
Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Damien Le Moal <damien.lemoal@wdc.com>

-- 
2.20.1

