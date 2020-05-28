Return-Path: <SRS0=lWBJ=7K=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AE98C433E0
	for <linux-block@archiver.kernel.org>; Thu, 28 May 2020 08:01:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6CA020B80
	for <linux-block@archiver.kernel.org>; Thu, 28 May 2020 08:01:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L7pxlj7E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725839AbgE1IBQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 May 2020 04:01:16 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55987 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725901AbgE1IBP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 May 2020 04:01:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590652874;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=PbJoT2F2lFRbK3iDIBBxpGnGYKEW9Z+Ntt/XK5EwBqs=;
        b=L7pxlj7EZBOpPQRvZZyd31mH1qpvfQSxLhvc71c5v6bKfb4MLHZLaT6aTDAZ16r7Vcda38
        nCn4n4seO1uBJpJiBkjQEs6Yo5+vtoKkGcZDiA3FL5UgtPMprU+AEa2osfjA20wzucr79/
        AIwiypz3Wjjpyc4A0N1d8zyiSe4ohJE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-430-ioCAz0LJPCef8TEk8gJ8Rg-1; Thu, 28 May 2020 04:01:08 -0400
X-MC-Unique: ioCAz0LJPCef8TEk8gJ8Rg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1261580183C;
        Thu, 28 May 2020 08:01:07 +0000 (UTC)
Received: from localhost (ovpn-12-189.pek2.redhat.com [10.72.12.189])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 72F90D01E0;
        Thu, 28 May 2020 08:01:03 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH V3 0/6] blk-mq: support batching dispatch from scheduler
Date:   Thu, 28 May 2020 16:00:47 +0800
Message-Id: <20200528080053.1062653-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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

Baolin has tested V1 and found performance on MMC can be improved.

Patches can be found from the following tree too:

	https://github.com/ming1/linux/commits/v5.7-rc-blk-mq-batching-submission

Patch 1 ~ 4 are improvement and cleanup, which can't applied without
supporting batching dispatch.

Patch 5 ~ 6 starts to support batching dispatch from scheduler.


[1] https://lore.kernel.org/linux-block/20200512075501.GF1531898@T590/#r
[2] https://lore.kernel.org/linux-block/fe6bd8b9-6ed9-b225-f80c-314746133722@grimberg.me/

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

 block/blk-mq-sched.c    |  95 ++++++++++++++++++++++++++++-----
 block/blk-mq.c          | 115 ++++++++++++++++++++++++++--------------
 block/blk-mq.h          |  15 +++---
 drivers/scsi/scsi_lib.c |   8 ++-
 include/linux/blk-mq.h  |   4 +-
 5 files changed, 168 insertions(+), 69 deletions(-)

Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Baolin Wang <baolin.wang7@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>
-- 
2.25.2

