Return-Path: <SRS0=U0+/=T3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A66C0C04AB3
	for <linux-block@archiver.kernel.org>; Mon, 27 May 2019 15:02:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 826052183F
	for <linux-block@archiver.kernel.org>; Mon, 27 May 2019 15:02:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbfE0PCp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 May 2019 11:02:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56082 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726202AbfE0PCp (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 May 2019 11:02:45 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C9EF43082211;
        Mon, 27 May 2019 15:02:33 +0000 (UTC)
Received: from localhost (ovpn-8-24.pek2.redhat.com [10.72.8.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6E27D7940B;
        Mon, 27 May 2019 15:02:27 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     linux-block@vger.kernel.org,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-scsi@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        John Garry <john.garry@huawei.com>,
        Keith Busch <keith.busch@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Don Brace <don.brace@microsemi.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Sathya Prakash <sathya.prakash@broadcom.com>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 0/5] blk-mq:  Wait for for hctx inflight requests on CPU unplug
Date:   Mon, 27 May 2019 23:02:02 +0800
Message-Id: <20190527150207.11372-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Mon, 27 May 2019 15:02:45 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

blk-mq drivers often use managed IRQ, which affinity is setup
automatically by genirq core.

For managed IRQ, we need to make sure that there isn't in-flight
requests when the managed IRQ is going to shutdown.

This patch waits for inflight requests associated with one
going-to-shutdown managed IRQ in blk-mq's CPU hotplug handler.

One special case is that some SCSI devices have multiple private
completion(reply) queue even though they only have one blk-mq hw queue,
and the private completion queue is associated with one managed
IRQ. Wait for inflight requests for these SCSI device too if last
CPU of the completion queue is going to shutdown.

SCSI device's internal commands aren't covered in this patchset,
and they are much less important than requests from blk-mq/scsi
core.

V2:
	- cover private multiple completion(reply) queue
	- remove timeout during waitting, because some driver doesn't
	implemnt proper .timeout handler.


Ming Lei (5):
  scsi: select reply queue from request's CPU
  blk-mq: introduce .complete_queue_affinity
  scsi: core: implement callback of .complete_queue_affinity
  scsi: implement .complete_queue_affinity
  blk-mq: Wait for for hctx inflight requests on CPU unplug

 block/blk-mq-tag.c                          |  2 +-
 block/blk-mq-tag.h                          |  5 ++
 block/blk-mq.c                              | 94 +++++++++++++++++++--
 drivers/scsi/hisi_sas/hisi_sas_main.c       |  5 +-
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c      | 11 +++
 drivers/scsi/hpsa.c                         | 14 ++-
 drivers/scsi/megaraid/megaraid_sas_base.c   | 10 +++
 drivers/scsi/megaraid/megaraid_sas_fusion.c |  4 +-
 drivers/scsi/mpt3sas/mpt3sas_base.c         | 16 ++--
 drivers/scsi/mpt3sas/mpt3sas_scsih.c        | 11 +++
 drivers/scsi/scsi_lib.c                     | 14 +++
 include/linux/blk-mq.h                      | 12 ++-
 include/scsi/scsi_cmnd.h                    | 11 +++
 include/scsi/scsi_host.h                    | 10 +++
 14 files changed, 197 insertions(+), 22 deletions(-)

-- 
2.20.1

