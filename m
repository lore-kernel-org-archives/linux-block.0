Return-Path: <SRS0=nGx8=CR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA8E0C43461
	for <linux-block@archiver.kernel.org>; Tue,  8 Sep 2020 01:24:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 728632193E
	for <linux-block@archiver.kernel.org>; Tue,  8 Sep 2020 01:24:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DXXP+31l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728272AbgIHBYG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 7 Sep 2020 21:24:06 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54186 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728241AbgIHBYG (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 7 Sep 2020 21:24:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599528245;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=gNHtbj3/GfvOaYBkU1y1/R2cKWQdeZVTsoByGcd3vKk=;
        b=DXXP+31lQtnqWhcU6pV9KUnwoYx1KWo36z6+vq9VuLoc2+exDCW+YRFLjd1I6kfuyUzI00
        j1WJXq3rqPm7bGUGG8u6MQWGXmB5yvkWCswwPekYIj4fd46NnS9d21zyE7ncd0j05RzUFV
        Kip/vqnYREw6AveA3MaYJdPpVWG2Npo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-56-s9jYByOENmOT8J2BzjyIng-1; Mon, 07 Sep 2020 21:24:03 -0400
X-MC-Unique: s9jYByOENmOT8J2BzjyIng-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 059331074646;
        Tue,  8 Sep 2020 01:24:02 +0000 (UTC)
Received: from localhost (ovpn-12-217.pek2.redhat.com [10.72.12.217])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 489285D9D3;
        Tue,  8 Sep 2020 01:23:57 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Veronika Kabatova <vkabatov@redhat.com>,
        Sagi Grimberg <sagi@grimberg.me>, Tejun Heo <tj@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH V3 0/3] percpu_ref & block: reduce memory footprint of percpu_ref in fast path
Date:   Tue,  8 Sep 2020 09:23:48 +0800
Message-Id: <20200908012351.1092986-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

The 1st patch removes memory footprint of percpu_ref in fast path
from 7 words to 2 words, since it is often used in fast path and
embedded in user struct.

The 2nd patch moves .q_usage_counter to 1st cacheline of
'request_queue'.

Simple test on null_blk shows ~2% IOPS boost on one 16cores(two threads
per core) machine, dual socket/numa.

V3:
	- fix kernel oops on MD
	- add patch for avoiding to use percpu-refcount internal from md
	  code
	- pass Red Hat CKI test which is done by Veronika Kabatova

V2:
	- pass 'gfp' to kzalloc() for fixing block/027 failure reported by
	kernel test robot
	- protect percpu_ref_is_zero() with destroying percpu-refcount by
	spin lock  

Ming Lei (3):
  percpu_ref: add percpu_ref_inited() for MD
  percpu_ref: reduce memory footprint of percpu_ref in fast path
  block: move 'q_usage_counter' into front of 'request_queue'

 drivers/infiniband/sw/rdmavt/mr.c |   2 +-
 drivers/md/md.c                   |   2 +-
 include/linux/blkdev.h            |   3 +-
 include/linux/percpu-refcount.h   |  46 ++++------
 lib/percpu-refcount.c             | 137 +++++++++++++++++++++++-------
 5 files changed, 126 insertions(+), 64 deletions(-)

Cc: Veronika Kabatova <vkabatov@redhat.com>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Tejun Heo <tj@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Bart Van Assche <bvanassche@acm.org>
-- 
2.25.2

