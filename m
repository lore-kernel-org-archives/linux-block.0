Return-Path: <SRS0=8+4U=63=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5687CC2D0FD
	for <linux-block@archiver.kernel.org>; Wed, 13 May 2020 09:58:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D3CE20575
	for <linux-block@archiver.kernel.org>; Wed, 13 May 2020 09:58:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HgCQ5yII"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387870AbgEMJ6Q (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 May 2020 05:58:16 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:54007 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388197AbgEMJzC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 May 2020 05:55:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589363700;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=UiOxyCO+fStdyJ2z3c3E3S+Yhrqvcy+kh/+3mB7Jm0c=;
        b=HgCQ5yIIsjlvEstmNwrRvxG5flLbvO9TNtvMZ8shJgNi62rN0U81/fn3agkvPxjPjPUdTF
        29PIXWjWeQBY9d9ApyqtNelS6BvEUehHIp+FOxmvVQJgeAB0IEyUoGIWMjUuIzJQyzvLy0
        w2pJvVK0yP8Mg8D40TAd9FJS6Dk3C88=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-356-z2urFnIHN-GWNIK1LnWOVQ-1; Wed, 13 May 2020 05:54:57 -0400
X-MC-Unique: z2urFnIHN-GWNIK1LnWOVQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 284761005510;
        Wed, 13 May 2020 09:54:56 +0000 (UTC)
Received: from localhost (ovpn-12-166.pek2.redhat.com [10.72.12.166])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C05BA1002395;
        Wed, 13 May 2020 09:54:52 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH 0/9] blk-mq: support batching dispatch from scheduler
Date:   Wed, 13 May 2020 17:54:34 +0800
Message-Id: <20200513095443.2038859-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Guys,

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

Patches can be found from the following tree too:

	https://github.com/ming1/linux/commits/v5.7-rc-blk-mq-batching-submission

Patch 1 ~ 7 are improvement and cleanup, which can't applied without
supporting batching dispatch.

Patch 8 ~ 9 starts to support batching dispatch from scheduler.


Please review and comment!


[1] https://lore.kernel.org/linux-block/20200512075501.GF1531898@T590/#r
[2] https://lore.kernel.org/linux-block/fe6bd8b9-6ed9-b225-f80c-314746133722@grimberg.me/


Ming Lei (9):
  blk-mq: pass request queue into get/put budget callback
  blk-mq: pass hctx to blk_mq_dispatch_rq_list
  blk-mq: don't predicate last flag in blk_mq_dispatch_rq_list
  blk-mq: move getting driver tag and bugget into one helper
  blk-mq: move .queue_rq code into one helper
  blk-mq: move code for handling partial dispatch into one helper
  blk-mq: remove dead check from blk_mq_dispatch_rq_list
  blk-mq: pass obtained budget count to blk_mq_dispatch_rq_list
  blk-mq: support batching dispatch in case of io scheduler

 block/blk-mq-sched.c    |  96 ++++++++++++++--
 block/blk-mq.c          | 248 +++++++++++++++++++++-------------------
 block/blk-mq.h          |  15 +--
 drivers/scsi/scsi_lib.c |   8 +-
 include/linux/blk-mq.h  |   4 +-
 5 files changed, 226 insertions(+), 145 deletions(-)

Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Baolin Wang <baolin.wang7@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>

-- 
2.25.2

