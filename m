Return-Path: <SRS0=69Bb=5X=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D63A1C2BABC
	for <linux-block@archiver.kernel.org>; Tue,  7 Apr 2020 09:29:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AACF420769
	for <linux-block@archiver.kernel.org>; Tue,  7 Apr 2020 09:29:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BAZ62IVZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbgDGJ3T (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Apr 2020 05:29:19 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44612 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726353AbgDGJ3S (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Apr 2020 05:29:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586251757;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=zRmYnW7628q203AnRkZmBOZvzAxfTlhPlz81qkx3SUY=;
        b=BAZ62IVZpMfMO/bCi496z/hVpeLH6WuWuClpucfdu5jkAn5RSjz5v2HCiNX3aEUsjILDwn
        da/ypJcEPw+bC8f+gbN2zIn5gCfKimn/FuAU2Ll9qS4BfURITWIqnRXRNBEif3DVNmnpqL
        jiLhpTinpsKrlC16YhQM0RtuKMO6zkw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-327-G2G_czmxPXWfzGhh3rFwTQ-1; Tue, 07 Apr 2020 05:29:12 -0400
X-MC-Unique: G2G_czmxPXWfzGhh3rFwTQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3B4AF800D50;
        Tue,  7 Apr 2020 09:29:11 +0000 (UTC)
Received: from localhost (ovpn-8-23.pek2.redhat.com [10.72.8.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 902F392F83;
        Tue,  7 Apr 2020 09:29:07 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        John Garry <john.garry@huawei.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH V6 0/8] blk-mq: improvement CPU hotplug
Date:   Tue,  7 Apr 2020 17:28:53 +0800
Message-Id: <20200407092901.314228-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Content-Transfer-Encoding: quoted-printable
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

Thomas mentioned:
    "
     That was the constraint of managed interrupts from the very beginnin=
g:
   =20
      The driver/subsystem has to quiesce the interrupt line and the asso=
ciated
      queue _before_ it gets shutdown in CPU unplug and not fiddle with i=
t
      until it's restarted by the core when the CPU is plugged in again.
    "

But no drivers or blk-mq do that before one hctx becomes inactive(all
CPUs for one hctx are offline), and even it is worse, blk-mq stills tries
to run hw queue after hctx is dead, see blk_mq_hctx_notify_dead().

This patchset tries to address the issue by two stages:

1) add one new cpuhp state of CPUHP_AP_BLK_MQ_ONLINE

- mark the hctx as internal stopped, and drain all in-flight requests
if the hctx is going to be dead.

2) re-submit IO in the state of CPUHP_BLK_MQ_DEAD after the hctx becomes =
dead

- steal bios from the request, and resubmit them via generic_make_request=
(),
then these IO will be mapped to other live hctx for dispatch

Please comment & review, thanks!

https://github.com/ming1/linux/commits/v5.6-blk-mq-improve-cpu-hotplug

V6:
	- simplify getting driver tag, so that we can drain in-flight
	  requests correctly without using synchronize_rcu()
	- handle re-submission of flush & passthrough request correctly

V5:
	- rename BLK_MQ_S_INTERNAL_STOPPED as BLK_MQ_S_INACTIVE
	- re-factor code for re-submit requests in cpu dead hotplug handler
	- address requeue corner case

V4:
	- resubmit IOs in dispatch list in case that this hctx is dead=20

V3:
	- re-organize patch 2 & 3 a bit for addressing Hannes's comment
	- fix patch 4 for avoiding potential deadlock, as found by Hannes

V2:
	- patch4 & patch 5 in V1 have been merged to block tree, so remove
	  them
	- address comments from John Garry and Minwoo



Ming Lei (8):
  blk-mq: assign rq->tag in blk_mq_get_driver_tag
  blk-mq: add new state of BLK_MQ_S_INACTIVE
  blk-mq: prepare for draining IO when hctx's all CPUs are offline
  blk-mq: stop to handle IO and drain IO before hctx becomes inactive
  block: add blk_end_flush_machinery
  blk-mq: re-submit IO in case that hctx is inactive
  blk-mq: handle requests dispatched from IO scheduler in case of
    inactive hctx
  block: deactivate hctx when the hctx is actually inactive

 block/blk-flush.c          | 143 +++++++++++++---
 block/blk-mq-debugfs.c     |   2 +
 block/blk-mq-tag.c         |   2 +-
 block/blk-mq-tag.h         |   2 +
 block/blk-mq.c             | 331 ++++++++++++++++++++++++++++++-------
 block/blk-mq.h             |  24 +--
 block/blk.h                |   9 +-
 drivers/block/loop.c       |   2 +-
 drivers/md/dm-rq.c         |   2 +-
 include/linux/blk-mq.h     |   6 +
 include/linux/cpuhotplug.h |   1 +
 11 files changed, 420 insertions(+), 104 deletions(-)

Cc: John Garry <john.garry@huawei.com>
Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
--=20
2.25.2

