Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7182AC433DB
	for <linux-block@archiver.kernel.org>; Mon, 29 Mar 2021 15:27:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38B2D6191C
	for <linux-block@archiver.kernel.org>; Mon, 29 Mar 2021 15:27:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbhC2P1N (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 29 Mar 2021 11:27:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45304 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230298AbhC2P0p (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 29 Mar 2021 11:26:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617031604;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=gsHnRstXCJ2DSJIgHD1YqFweYnoKVb1FTD1xjcqPODM=;
        b=RgTVpHy5VhBn4d6gsPwm//nB1cgCjyrgd1ChQ7On0iRFjXQauFXpqcBd9/vIzzDRlgxpYS
        fKxCd/C7C8BLgdTcQAd5YTGXBcyKg95gcEVK2WtMvAGeyYI4f5kPdPbRK4KOGQp9xi/huw
        apiuOTQIVNff8bnjb5l/iY7Ua8gj2FM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-160-6ZoWfG_pO2WhCFESSmWKrA-1; Mon, 29 Mar 2021 11:26:40 -0400
X-MC-Unique: 6ZoWfG_pO2WhCFESSmWKrA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 748148030A1;
        Mon, 29 Mar 2021 15:26:39 +0000 (UTC)
Received: from localhost (ovpn-12-50.pek2.redhat.com [10.72.12.50])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E375D5D6A1;
        Mon, 29 Mar 2021 15:26:27 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V4 00/12] block: support bio based io polling
Date:   Mon, 29 Mar 2021 23:26:10 +0800
Message-Id: <20210329152622.173035-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

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

V4:
	- cover one more test_bit(QUEUE_FLAG_POLL, ...) suggested by
	  Jeffle(01/12)
	- drop patch of 'block: add helper of blk_create_io_context'
	- add new helper of blk_create_io_poll_context() (03/12)
	- drain submission queues in exit_io_context(), suggested by
	  Jeffle(08/13)
	- considering shared io context case for blk_bio_poll_io_drain()
	(08/13)
	- fix one issue in blk_bio_poll_pack_groups() as suggested by
	Jeffle(08/13)
	- add reviewed-by tag
V3:
	- fix cookie returned for bio based driver, as suggested by Jeffle Xu
	- draining pending bios when submission context is exiting
	- patch style and comment fix, as suggested by Mike
	- allow poll context data to be NULL by always polling on submission queue
	- remove RFC, and reviewed-by

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

Ming Lei (8):
  block: add helper of blk_queue_poll
  block: add one helper to free io_context
  block: create io poll context for submission and poll task
  block: add req flag of REQ_POLL_CTX
  block: add new field into 'struct bvec_iter'
  block: prepare for supporting bio_list via other link
  block: use per-task poll context to implement bio based io polling
  blk-mq: limit hw queues to be polled in each blk_poll()

 block/bio.c                   |   5 +
 block/blk-core.c              | 256 ++++++++++++++++++++++++++--
 block/blk-ioc.c               |  15 +-
 block/blk-mq.c                | 306 +++++++++++++++++++++++++++++++++-
 block/blk-sysfs.c             |  16 +-
 block/blk.h                   |  58 +++++++
 drivers/md/dm-table.c         |  24 +++
 drivers/md/dm.c               |  14 ++
 drivers/nvme/host/core.c      |   2 +-
 include/linux/bio.h           | 132 ++++++++-------
 include/linux/blk_types.h     |  22 ++-
 include/linux/blkdev.h        |   4 +
 include/linux/bvec.h          |   8 +
 include/linux/device-mapper.h |   1 +
 include/linux/iocontext.h     |   2 +
 include/trace/events/kyber.h  |   6 +-
 16 files changed, 776 insertions(+), 95 deletions(-)

-- 
2.29.2

