Return-Path: <SRS0=qX1g=65=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46C8EC433DF
	for <linux-block@archiver.kernel.org>; Fri, 15 May 2020 01:42:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 206CA2065F
	for <linux-block@archiver.kernel.org>; Fri, 15 May 2020 01:42:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AkaVUd/H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726216AbgEOBmL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 May 2020 21:42:11 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:35014 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726170AbgEOBmL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 May 2020 21:42:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589506929;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=qsnG25CPWDXMOE2a6UF+Jw5RGNZKv3s+x5lHPR9/oP8=;
        b=AkaVUd/HKAZDEN2CR38mCT8LOW6ZYRq+g42jbgfreYG+kjJhMJpe1bZjCaG5/rjea4Wjkc
        AxJbZSUVm1FFuwPZp0r2a0gnhC0ePpOl9uSStrlX9NRN9/9bM5VEu5m0hT0/HEhWAne7U6
        SZByplWRZATU0mBBXAb1feKxtMFfo6Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-281-Pirfz8W2NVuqrC3tZ3gP6g-1; Thu, 14 May 2020 21:42:06 -0400
X-MC-Unique: Pirfz8W2NVuqrC3tZ3gP6g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A4C0A835B47;
        Fri, 15 May 2020 01:42:04 +0000 (UTC)
Received: from localhost (ovpn-12-94.pek2.redhat.com [10.72.12.94])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0E3256E50D;
        Fri, 15 May 2020 01:42:00 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 0/6] blk-mq: improvement CPU hotplug(simplified version)
Date:   Fri, 15 May 2020 09:41:47 +0800
Message-Id: <20200515014153.2403464-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

Thomas mentioned:
    "
     That was the constraint of managed interrupts from the very beginning:
    
      The driver/subsystem has to quiesce the interrupt line and the associated
      queue _before_ it gets shutdown in CPU unplug and not fiddle with it
      until it's restarted by the core when the CPU is plugged in again.
    "

But no drivers or blk-mq do that before one hctx becomes inactive(all
CPUs for one hctx are offline), and even it is worse, blk-mq stills tries
to run hw queue after hctx is dead, see blk_mq_hctx_notify_dead().

This patchset tries to address the issue by the following approach:

- before the last cpu in hctx->cpumask is going to offline, mark this
hctx as inactive

- disable preempt during allocating tag for request, and after tag
is allocated, check if this hctx is inactive. If yes, give up this
allocation and try remote allocation from online CPUs

- before hctx becomes inactive, drain all allocated requests on this
hctx

Thanks John Garry for running lots of tests on arm64 with this previous
version patches and co-working on investigating all kinds of issues.

Thanks Christoph for review on old versions of this patches.

https://github.com/ming1/linux/commits/v5.7-rc-blk-mq-improve-cpu-hotplug

Ming Lei (6):
  blk-mq: allocate request on cpu in hctx->cpumask for
    blk_mq_alloc_request_hctx
  blk-mq: set data->ctx and data->hctx explicitly in blk_mq_get_request
  blk-mq: add blk_mq_all_tag_iter
  blk-mq: prepare for draining IO when hctx's all CPUs are offline
  blk-mq: disable preempt during allocating request tag
  blk-mq: stop to allocate new requst and drain request before hctx
    becomes inactive

 block/blk-mq-debugfs.c     |   2 +
 block/blk-mq-tag.c         |  47 +++++++++-
 block/blk-mq-tag.h         |   2 +
 block/blk-mq.c             | 184 ++++++++++++++++++++++++++++++++-----
 block/blk-mq.h             |   1 +
 drivers/block/loop.c       |   2 +-
 drivers/md/dm-rq.c         |   2 +-
 include/linux/blk-mq.h     |  10 ++
 include/linux/cpuhotplug.h |   1 +
 9 files changed, 221 insertions(+), 30 deletions(-)

Cc: John Garry <john.garry@huawei.com>
Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
-- 
2.25.2

