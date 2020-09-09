Return-Path: <SRS0=1Rjj=CS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F3D7C43461
	for <linux-block@archiver.kernel.org>; Wed,  9 Sep 2020 07:18:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 394BC21741
	for <linux-block@archiver.kernel.org>; Wed,  9 Sep 2020 07:18:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LFht01Sg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725877AbgIIHSa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Sep 2020 03:18:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36384 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725772AbgIIHS1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 9 Sep 2020 03:18:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599635906;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=+wEruRxAJjrmlSOAHKv/rV6Jug/EyrZcjQjuyHvA45g=;
        b=LFht01Sg3xYeazNJvi9kHaP6G3+k3COcsDwuUYSvEf63JayMD7Tp4HWL9GoEFP7LKAusO5
        OpsPWAmGGEKY7wWC4vwSermvgERr8q7GT6PbLCngS1XXPgKdc0rXMCSj69RNH682MYPxtI
        508gKlXchHXJXvXCbuy1Kfb9Y/O3e1Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-515-5r-hCqJsMJyEZPXWaqrx3Q-1; Wed, 09 Sep 2020 03:18:23 -0400
X-MC-Unique: 5r-hCqJsMJyEZPXWaqrx3Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1D3E418BA296;
        Wed,  9 Sep 2020 07:18:22 +0000 (UTC)
Received: from localhost (ovpn-12-76.pek2.redhat.com [10.72.12.76])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C6C488356F;
        Wed,  9 Sep 2020 07:18:17 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Cc:     Ming Lei <ming.lei@redhat.com>,
        Veronika Kabatova <vkabatov@redhat.com>,
        Sagi Grimberg <sagi@grimberg.me>, Tejun Heo <tj@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH V4 0/3] percpu_ref & block: reduce memory footprint of percpu_ref in fast path
Date:   Wed,  9 Sep 2020 15:18:10 +0800
Message-Id: <20200909071813.1580038-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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

V4:
	- rename percpu_ref_inited as percpu_ref_is_initialized

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
  percpu_ref: add percpu_ref_is_initialized for MD
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

