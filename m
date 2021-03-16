Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E718AC433E9
	for <linux-block@archiver.kernel.org>; Tue, 16 Mar 2021 03:17:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8DFF6508E
	for <linux-block@archiver.kernel.org>; Tue, 16 Mar 2021 03:17:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbhCPDRV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 15 Mar 2021 23:17:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32536 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234902AbhCPDRL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 Mar 2021 23:17:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615864631;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=8eYh0DIWl8wBr3z0zSAva45a4IdtTQ49vVigt7lTGOA=;
        b=b7q0f8SpcniKLv50LjsqUlT1ZACY9qDsl+jF4DrkhV4NdeRZrUfX4gStfCNkCmG61idj2Q
        nKen4k2QqsZnvOvIIQZCN0p0kWTvMmsVgB5JsM0zTByU4Q0jgzip47kH3vVF5bxKVZQiVG
        SeRsPwG6aYpx3GDGjMopY8sgtqWNEGc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-23-q4IJxz76N6mMvJKYcTuCPw-1; Mon, 15 Mar 2021 23:17:08 -0400
X-MC-Unique: q4IJxz76N6mMvJKYcTuCPw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4D8C418460E1;
        Tue, 16 Mar 2021 03:17:07 +0000 (UTC)
Received: from localhost (ovpn-12-86.pek2.redhat.com [10.72.12.86])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 85D6E614FB;
        Tue, 16 Mar 2021 03:16:56 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        Ming Lei <ming.lei@redhat.com>
Subject: [RFC PATCH 00/11] block: support bio based io polling
Date:   Tue, 16 Mar 2021 11:15:12 +0800
Message-Id: <20210316031523.864506-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

Add per-task io poll context for holding HIPRI blk-mq/underlying bios
queued from bio based driver's io submission context, and reuse one bio
padding field for storing 'cookie' returned from submit_bio() for these
bios. Also explicitly end these bios in poll context by adding two
new bio flags.

In this way, we needn't to poll all underlying hw queues any more,
which is implemented in Jeffle's patches. And we can just poll hw queues
in which there is HIPRI IO queued.

Usually io submission and io poll share same context, so the added io
poll context data is just like one stack variable, and the cost for
saving bios is cheap.

Any comments are welcome.


Jeffle Xu (4):
  block/mq: extract one helper function polling hw queue
  block: add queue_to_disk() to get gendisk from request_queue
  block: add poll_capable method to support bio-based IO polling
  dm: support IO polling for bio-based dm device

Ming Lei (7):
  block: add helper of blk_queue_poll
  block: add one helper to free io_context
  block: add helper of blk_create_io_context
  block: create io poll context for submission and poll task
  block: add req flag of REQ_TAG
  block: add new field into 'struct bvec_iter'
  block: use per-task poll context to implement bio based io poll

 block/bio.c                   |   5 +
 block/blk-core.c              | 161 ++++++++++++++++++++++++++---
 block/blk-ioc.c               |  12 ++-
 block/blk-mq.c                | 189 ++++++++++++++++++++++++++++++++--
 block/blk-sysfs.c             |  14 ++-
 block/blk.h                   |  45 ++++++++
 drivers/md/dm-table.c         |  24 +++++
 drivers/md/dm.c               |  14 +++
 drivers/nvme/host/core.c      |   2 +-
 include/linux/blk_types.h     |   7 ++
 include/linux/blkdev.h        |   4 +
 include/linux/bvec.h          |   9 ++
 include/linux/device-mapper.h |   1 +
 include/linux/iocontext.h     |   2 +
 include/trace/events/kyber.h  |   6 +-
 15 files changed, 466 insertions(+), 29 deletions(-)

-- 
2.29.2

