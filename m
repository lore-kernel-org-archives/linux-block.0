Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8AA2C433EF
	for <linux-block@archiver.kernel.org>; Tue, 21 Dec 2021 14:15:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232757AbhLUOPl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 Dec 2021 09:15:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:53113 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238372AbhLUOPk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 Dec 2021 09:15:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640096140;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=e2oTUlJaeF3yESVZCUgm3zD53Jvxm4IdLR2kK36kHuI=;
        b=M5uHpnJpFv1pqNBwKk0D5B8eKHzE7uAO1wdfqITGjS83QyrWMJzemBwKpoMHvI8N7TSIb+
        m6jao3tvDiqSlcsi6ccCojw58Jbc7jJIAjLSqQYvhPjOHCMAHzZ9LrwK3Dv9V0NxxvBoTU
        qXPxNWSA2cfSL5h9JzyAr+XAxV818kE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-86-aKMV2H3EOoufjzMe1S1wag-1; Tue, 21 Dec 2021 09:15:36 -0500
X-MC-Unique: aKMV2H3EOoufjzMe1S1wag-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C24A31023F52;
        Tue, 21 Dec 2021 14:15:35 +0000 (UTC)
Received: from localhost (ovpn-8-30.pek2.redhat.com [10.72.8.30])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 501A94BC6F;
        Tue, 21 Dec 2021 14:15:04 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Mike Snitzer <snitzer@redhat.com>
Cc:     linux-block@vger.kernel.org, dm-devel@redhat.com,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 0/3] blk-mq/dm-rq: support BLK_MQ_F_BLOCKING for dm-rq
Date:   Tue, 21 Dec 2021 22:14:56 +0800
Message-Id: <20211221141459.1368176-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

dm-rq may be built on blk-mq device which marks BLK_MQ_F_BLOCKING, so
dm_mq_queue_rq() may become to sleep current context.

Fixes the issue by allowing dm-rq to set BLK_MQ_F_BLOCKING in case that
any underlying queue is marked as BLK_MQ_F_BLOCKING.

DM request queue is allocated before allocating tagset, this way is a
bit special, so we need to pre-allocate srcu payload, then use the queue
flag of QUEUE_FLAG_BLOCKING for locking dispatch.


Ming Lei (3):
  block: split having srcu from queue blocking
  block: add blk_alloc_disk_srcu
  dm: mark dm queue as blocking if any underlying is blocking

 block/blk-core.c       |  2 +-
 block/blk-mq.c         |  6 +++---
 block/blk-mq.h         |  2 +-
 block/blk-sysfs.c      |  2 +-
 block/genhd.c          |  5 +++--
 drivers/md/dm-rq.c     |  5 ++++-
 drivers/md/dm-rq.h     |  3 ++-
 drivers/md/dm-table.c  | 14 ++++++++++++++
 drivers/md/dm.c        |  5 +++--
 drivers/md/dm.h        |  1 +
 include/linux/blkdev.h |  5 +++--
 include/linux/genhd.h  | 12 ++++++++----
 12 files changed, 44 insertions(+), 18 deletions(-)

-- 
2.31.1

