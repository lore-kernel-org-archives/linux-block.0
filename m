Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64BAFC433E6
	for <linux-block@archiver.kernel.org>; Thu, 18 Mar 2021 16:50:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 371ED64F1F
	for <linux-block@archiver.kernel.org>; Thu, 18 Mar 2021 16:50:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbhCRQuC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 Mar 2021 12:50:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:54344 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232251AbhCRQtl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Mar 2021 12:49:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616086181;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=EP7yM5rpujErrHx2U82otFcEit6FbUguftQX3M6MNi0=;
        b=PH+FwMAo1jOz6uql/jb5n2a9ExdgWg8u3ry/OUH96EEYEl7s8obXhNBXsYGNLvxFiMtsN3
        GPRW+/kPQsNwxuLxlNkKmZiJoMzhbDzBL24F2m4ZR2BSU1Oz9xOXoPsuyhlKKMMAutkftz
        gkNvOchYb2V81lWoHv7mynf8VWXoKKQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-356-ufvVLZ4aPUCVi82DcUBAsw-1; Thu, 18 Mar 2021 12:49:37 -0400
X-MC-Unique: ufvVLZ4aPUCVi82DcUBAsw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 16FD1100A26F;
        Thu, 18 Mar 2021 16:49:10 +0000 (UTC)
Received: from localhost (ovpn-12-24.pek2.redhat.com [10.72.12.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7E36B6B8F7;
        Thu, 18 Mar 2021 16:48:35 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        Ming Lei <ming.lei@redhat.com>
Subject: [RFC PATCH V2 00/13] block: support bio based io polling
Date:   Fri, 19 Mar 2021 00:48:14 +0800
Message-Id: <20210318164827.1481133-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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

V2:
	- address queue depth scalability issue reported by Jeffle via bio
	group list. Reuse .bi_end_io for linking bios which share same
	.bi_end_io, and support 32 such groups in submit queue. With this way,
	the scalability issue caused by kfifio is solved. Before really
	ending bio, .bi_end_io is recovered from the group head.


Jeffle Xu (4):
  block/mq: extract one helper function polling hw queue
  block: add queue_to_disk() to get gendisk from request_queue
  block: add poll_capable method to support bio-based IO polling
  dm: support IO polling for bio-based dm device

Ming Lei (9):
  block: add helper of blk_queue_poll
  block: add one helper to free io_context
  block: add helper of blk_create_io_context
  block: create io poll context for submission and poll task
  block: add req flag of REQ_TAG
  block: add new field into 'struct bvec_iter'
  block: prepare for supporting bio_list via other link
  block: use per-task poll context to implement bio based io poll
  blk-mq: limit hw queues to be polled in each blk_poll()

 block/bio.c                   |   5 +
 block/blk-core.c              | 248 ++++++++++++++++++++++++++++++++--
 block/blk-ioc.c               |  12 +-
 block/blk-mq.c                | 232 ++++++++++++++++++++++++++++++-
 block/blk-sysfs.c             |  14 +-
 block/blk.h                   |  55 ++++++++
 drivers/md/dm-table.c         |  24 ++++
 drivers/md/dm.c               |  14 ++
 drivers/nvme/host/core.c      |   2 +-
 include/linux/bio.h           | 132 +++++++++---------
 include/linux/blk_types.h     |  20 ++-
 include/linux/blkdev.h        |   4 +
 include/linux/bvec.h          |   9 ++
 include/linux/device-mapper.h |   1 +
 include/linux/iocontext.h     |   2 +
 include/trace/events/kyber.h  |   6 +-
 16 files changed, 686 insertions(+), 94 deletions(-)

-- 
2.29.2

