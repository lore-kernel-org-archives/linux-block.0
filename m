Return-Path: <SRS0=F1yh=7P=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E05D1C433E0
	for <linux-block@archiver.kernel.org>; Tue,  2 Jun 2020 09:15:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF34C206C3
	for <linux-block@archiver.kernel.org>; Tue,  2 Jun 2020 09:15:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hLDlUEwh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726217AbgFBJPW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Jun 2020 05:15:22 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30117 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726174AbgFBJPV (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Jun 2020 05:15:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591089320;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=qMrQ4R1tiZ47KbGCJ++c4QAwStEuwv3FF+UcNLv0ce0=;
        b=hLDlUEwhkG/bwI7/lkAE69+UTpNHuNfS+eOmNdHx1rf62tUPLtFzjkjDsL+p+y6GEvBM03
        ECS0JZUSjGcR32WwT9WOvNNJ5xvgDnmzYnD+TZ5xzyKCEsobOy8puTs+roFXGC5DBWfhcW
        OAjfWAQXTVIqMLR9Bt/5ZsRDDdAc2cY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-13-tYgeqOAEP7yro0rdLhzozQ-1; Tue, 02 Jun 2020 05:15:15 -0400
X-MC-Unique: tYgeqOAEP7yro0rdLhzozQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B5BE9835B47;
        Tue,  2 Jun 2020 09:15:13 +0000 (UTC)
Received: from localhost (ovpn-12-167.pek2.redhat.com [10.72.12.167])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E44736C77F;
        Tue,  2 Jun 2020 09:15:09 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH V4 0/6] blk-mq: support batching dispatch from scheduler
Date:   Tue,  2 Jun 2020 17:14:56 +0800
Message-Id: <20200602091502.1822499-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

More and more drivers want to get batching requests queued from
block layer, such as mmc[1], and tcp based storage drivers[2]. Also
current in-tree users have virtio-scsi, virtio-blk and nvme.

For none, we already support batching dispatch.

But for io scheduler, every time we just take one request from scheduler
and pass the single request to blk_mq_dispatch_rq_list(). This way makes
batching dispatch not possible when io scheduler is applied. One reason
is that we don't want to hurt sequential IO performance, becasue IO
merge chance is reduced if more requests are dequeued from scheduler
queue.

Tries to start the support by dequeuing more requests from scheduler
if budget is enough and device isn't busy.

Simple fio test over virtio-scsi shows IO can get improved by 5~10%.

Baolin has tested previous versions and found performance on MMC can be improved.

Patches can be found from the following tree too:

	https://github.com/ming1/linux/commits/v5.7-rc-blk-mq-batching-submission

Patch 1 ~ 4 are improvement and cleanup, which can't applied without
supporting batching dispatch.

Patch 5 ~ 6 starts to support batching dispatch from scheduler.



[1] https://lore.kernel.org/linux-block/20200512075501.GF1531898@T590/#r
[2] https://lore.kernel.org/linux-block/fe6bd8b9-6ed9-b225-f80c-314746133722@grimberg.me/

V4:
	- fix releasing budgets and avoids IO hang(5/6)
	- dispatch more batches if the device can accept more(6/6)
	- verified by running more tests

V3:
	- add reviewed-by tag
	- fix one typo
	- fix one budget leak issue in case that .queue_rq returned *_RESOURCE in 5/6

V2:
	- remove 'got_budget' from blk_mq_dispatch_rq_list
	- drop patch for getting driver tag & handling partial dispatch


Ming Lei (6):
  blk-mq: pass request queue into get/put budget callback
  blk-mq: pass hctx to blk_mq_dispatch_rq_list
  blk-mq: move getting driver tag and budget into one helper
  blk-mq: remove dead check from blk_mq_dispatch_rq_list
  blk-mq: pass obtained budget count to blk_mq_dispatch_rq_list
  blk-mq: support batching dispatch in case of io scheduler

 block/blk-mq-sched.c    | 116 +++++++++++++++++++++++++++++++++++-----
 block/blk-mq.c          | 115 +++++++++++++++++++++++++--------------
 block/blk-mq.h          |  15 +++---
 drivers/scsi/scsi_lib.c |   8 ++-
 include/linux/blk-mq.h  |   4 +-
 5 files changed, 187 insertions(+), 71 deletions(-)

Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Baolin Wang <baolin.wang7@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>
-- 
2.25.2

