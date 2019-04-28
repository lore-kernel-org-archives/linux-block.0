Return-Path: <SRS0=nOxH=S6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15F63C43218
	for <linux-block@archiver.kernel.org>; Sun, 28 Apr 2019 07:39:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB6B2206BF
	for <linux-block@archiver.kernel.org>; Sun, 28 Apr 2019 07:39:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbfD1Hjn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 28 Apr 2019 03:39:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36678 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726483AbfD1Hjn (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sun, 28 Apr 2019 03:39:43 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 55C55C049E20;
        Sun, 28 Apr 2019 07:39:43 +0000 (UTC)
Received: from localhost (ovpn-8-32.pek2.redhat.com [10.72.8.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 353B317D08;
        Sun, 28 Apr 2019 07:39:39 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        "Ewan D . Milne" <emilne@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chuck Lever <chuck.lever@oracle.com>, netdev@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: [PATCH V4 0/3] scsi: core: avoid big pre-allocation for sg list
Date:   Sun, 28 Apr 2019 15:39:29 +0800
Message-Id: <20190428073932.9898-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Sun, 28 Apr 2019 07:39:43 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

Since supporting to blk-mq, big pre-allocation for sg list is introduced,
this way is very unfriendly wrt. memory consumption.

There were Red Hat internal reports that some scsi_debug based tests
can't be run any more because of too big pre-allocation.

Also lpfc users commplained that 1GB+ ram is pre-allocatd for single
HBA.

sg_alloc_table_chained() is improved to support variant size of 1st
pre-allocated SGL in the 1st patch as suggested by Christoph.

The other two patches try to address this issue by allocating sg list runtime,
meantime pre-allocating one or two inline sg entries for small IO. This
ways follows NVMe's approach wrt. sg list allocation.

V4:
	- add parameter to sg_alloc_table_chained()/sg_free_table_chained()
	directly, and update current callers

V3:
	- improve sg_alloc_table_chained() to accept variant size of
	the 1st pre-allocated SGL
	- applies the improved sg API to address the big pre-allocation
	issue

V2:
	- move inline sg table initializetion into one helper
	- introduce new helper for getting inline sg
	- comment log fix


Ming Lei (3):
  lib/sg_pool.c: improve APIs for allocating sg pool
  scsi: core: avoid to pre-allocate big chunk for protection meta data
  scsi: core: avoid to pre-allocate big chunk for sg list

 drivers/nvme/host/fc.c            |  7 ++++---
 drivers/nvme/host/rdma.c          |  7 ++++---
 drivers/nvme/target/loop.c        |  4 ++--
 drivers/scsi/scsi_lib.c           | 31 ++++++++++++++++++++++---------
 include/linux/scatterlist.h       | 11 +++++++----
 lib/scatterlist.c                 | 36 +++++++++++++++++++++++-------------
 lib/sg_pool.c                     | 37 +++++++++++++++++++++++++++----------
 net/sunrpc/xprtrdma/svc_rdma_rw.c |  5 +++--
 8 files changed, 92 insertions(+), 46 deletions(-)

Cc: Christoph Hellwig <hch@lst.de>
Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Ewan D. Milne <emilne@redhat.com>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Chuck Lever <chuck.lever@oracle.com>
Cc: netdev@vger.kernel.org
Cc: linux-nvme@lists.infradead.org

-- 
2.9.5

