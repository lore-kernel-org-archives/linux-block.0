Return-Path: <SRS0=GKUn=VJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C75C2C742A2
	for <linux-block@archiver.kernel.org>; Fri, 12 Jul 2019 02:47:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A60D6208E4
	for <linux-block@archiver.kernel.org>; Fri, 12 Jul 2019 02:47:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729197AbfGLCrj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Jul 2019 22:47:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60940 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729051AbfGLCrj (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Jul 2019 22:47:39 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 25DD2C057EC6;
        Fri, 12 Jul 2019 02:47:39 +0000 (UTC)
Received: from localhost (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 01098600CD;
        Fri, 12 Jul 2019 02:47:35 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Keith Busch <keith.busch@intel.com>
Subject: [RFC PATCH 0/7] blk-mq: improvement on handling IO during CPU hotplug
Date:   Fri, 12 Jul 2019 10:47:19 +0800
Message-Id: <20190712024726.1227-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Fri, 12 Jul 2019 02:47:39 +0000 (UTC)
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

But no drivers or blk-mq do that before one hctx becomes dead(all
CPUs for one hctx are offline), and even it is worse, blk-mq stills tries
to run hw queue after hctx is dead, see blk_mq_hctx_notify_dead().

This patchset tries to address the issue by two stages:

1) add one new cpuhp state of CPUHP_AP_BLK_MQ_ONLINE

- mark the hctx as internal stopped, and drain all in-flight requests
if the hctx is going to be dead.

2) re-submit IO in the state of CPUHP_BLK_MQ_DEAD after the hctx becomes dead

- steal bios from the request, and resubmit them via generic_make_request(),
then these IO will be mapped to other live hctx for dispatch

Please comment & review, thanks!


Ming Lei (7):
  blk-mq: add new state of BLK_MQ_S_INTERNAL_STOPPED
  blk-mq: add blk-mq flag of BLK_MQ_F_NO_MANAGED_IRQ
  blk-mq: stop to handle IO before hctx's all CPUs become offline
  blk-mq: add callback of .free_request
  SCSI: implement .free_request callback
  blk-mq: re-submit IO in case that hctx is dead
  blk-mq: handle requests dispatched from IO scheduler in case that hctx
    is dead

 block/blk-mq-debugfs.c     |   2 +
 block/blk-mq-tag.c         |   2 +-
 block/blk-mq-tag.h         |   2 +
 block/blk-mq.c             | 147 ++++++++++++++++++++++++++++++++++---
 block/blk-mq.h             |   3 +-
 drivers/block/loop.c       |   2 +-
 drivers/md/dm-rq.c         |   2 +-
 drivers/scsi/scsi_lib.c    |  13 ++++
 include/linux/blk-mq.h     |  12 +++
 include/linux/cpuhotplug.h |   1 +
 10 files changed, 170 insertions(+), 16 deletions(-)

Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Keith Busch <keith.busch@intel.com>


-- 
2.20.1

