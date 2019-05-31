Return-Path: <SRS0=RDeE=T7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBBE7C28CC0
	for <linux-block@archiver.kernel.org>; Fri, 31 May 2019 02:28:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95C9F25F06
	for <linux-block@archiver.kernel.org>; Fri, 31 May 2019 02:28:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbfEaC20 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 May 2019 22:28:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48842 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726372AbfEaC2Z (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 May 2019 22:28:25 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1296E3082A49;
        Fri, 31 May 2019 02:28:25 +0000 (UTC)
Received: from localhost (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 19D777E322;
        Fri, 31 May 2019 02:28:18 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        John Garry <john.garry@huawei.com>,
        Don Brace <don.brace@microsemi.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Sathya Prakash <sathya.prakash@broadcom.com>,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 0/9] blk-mq/scsi: convert private reply queue into blk_mq hw queue
Date:   Fri, 31 May 2019 10:27:52 +0800
Message-Id: <20190531022801.10003-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Fri, 31 May 2019 02:28:25 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

The 1st patch introduces support hostwide tags for multiple hw queues
via the simplest approach to share single 'struct blk_mq_tags' instance
among all hw queues. In theory, this way won't cause any performance drop.
Even small IOPS improvement can be observed on random IO on
null_blk/scsi_debug.

By applying the hostwide tags for MQ, we can convert some SCSI driver's
private reply queue into generic blk-mq hw queue, then at least two
improvement can be obtained:

1) the private reply queue maping can be removed from drivers, since the
mapping has been implemented as generic API in blk-mq core

2) it helps to solve the generic managed IRQ race[1] during CPU hotplug
in generic way, otherwise we have to re-invent new way to address the
same issue for these drivers using private reply queue.


[1] https://lore.kernel.org/linux-block/20190527150207.11372-1-ming.lei@redhat.com/T/#m6d95e2218bdd712ffda8f6451a0bb73eb2a651af

Any comment and test feedback are appreciated.

Thanks,
Ming

Hannes Reinecke (1):
  scsi: Add template flag 'host_tagset'

Ming Lei (8):
  blk-mq: allow hw queues to share hostwide tags
  block: null_blk: introduce module parameter of 'g_host_tags'
  scsi_debug: support host tagset
  scsi: introduce scsi_cmnd_hctx_index()
  scsi: hpsa: convert private reply queue to blk-mq hw queue
  scsi: hisi_sas_v3: convert private reply queue to blk-mq hw queue
  scsi: megaraid: convert private reply queue to blk-mq hw queue
  scsi: mp3sas: convert private reply queue to blk-mq hw queue

 block/blk-mq-debugfs.c                      |  1 +
 block/blk-mq-sched.c                        |  8 +++
 block/blk-mq-tag.c                          |  6 ++
 block/blk-mq.c                              | 14 ++++
 block/elevator.c                            |  5 +-
 drivers/block/null_blk_main.c               |  6 ++
 drivers/scsi/hisi_sas/hisi_sas.h            |  2 +-
 drivers/scsi/hisi_sas/hisi_sas_main.c       | 36 +++++-----
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c      | 46 +++++--------
 drivers/scsi/hpsa.c                         | 49 ++++++--------
 drivers/scsi/megaraid/megaraid_sas_base.c   | 50 +++++---------
 drivers/scsi/megaraid/megaraid_sas_fusion.c |  4 +-
 drivers/scsi/mpt3sas/mpt3sas_base.c         | 74 ++++-----------------
 drivers/scsi/mpt3sas/mpt3sas_base.h         |  3 +-
 drivers/scsi/mpt3sas/mpt3sas_scsih.c        | 17 +++++
 drivers/scsi/scsi_debug.c                   |  3 +
 drivers/scsi/scsi_lib.c                     |  2 +
 include/linux/blk-mq.h                      |  1 +
 include/scsi/scsi_cmnd.h                    | 15 +++++
 include/scsi/scsi_host.h                    |  3 +
 20 files changed, 168 insertions(+), 177 deletions(-)

-- 
2.20.1

