Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93295C433F5
	for <linux-block@archiver.kernel.org>; Sat,  9 Oct 2021 03:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 683B260EE2
	for <linux-block@archiver.kernel.org>; Sat,  9 Oct 2021 03:47:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbhJIDte (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Oct 2021 23:49:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54457 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229561AbhJIDte (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 8 Oct 2021 23:49:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633751257;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=QupAqVSNhmjXK/aXyLiaiaiGdci7w3/gOP38K27m4Y8=;
        b=b/Utw1HfFUCjBOsbF1fCthdS+KvDy5Qgo0CdP36PLS1y81/KucJWAkHCvDdtZQyhNub+LZ
        efF0/5JZCWdomBen49rfCWjfsAqb/1GJdxXkYNAASfPNAdLmB+oaiishd2el0t9M/DUx2z
        kXs9RzqW4G4zq/VYtSLSb1NThKUqOC0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-371-HOLnPP8yMKycadiJlaQNlg-1; Fri, 08 Oct 2021 23:47:31 -0400
X-MC-Unique: HOLnPP8yMKycadiJlaQNlg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2B6085127;
        Sat,  9 Oct 2021 03:47:30 +0000 (UTC)
Received: from localhost (ovpn-8-20.pek2.redhat.com [10.72.8.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 58868179B3;
        Sat,  9 Oct 2021 03:47:24 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc:     Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 0/6] blk-mq: support concurrent queue quiescing
Date:   Sat,  9 Oct 2021 11:47:07 +0800
Message-Id: <20211009034713.1489183-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello,

request queue quiescing has been applied in lots of block drivers and
block core from different/un-related code paths. So far, both quiesce
and unquiesce changes the queue state unconditionally. This way has
caused trouble, such as, driver is quiescing queue for its own purpose,
however block core's queue quiesce may come because of elevator switch,
updating nr_requests or other queue attributes, then un-expected
unquiesce may come too early.

It has been observed kernel panic when running stress test on dm-mpath
suspend and updating nr_requests.

Fix the issue by supporting concurrent queue quiescing. But nvme has very
complicated uses on quiesce/unquiesce, which two may not be called in
pairing, so switch to this way in patch 1~4, and patch 5 provides
nested queue quiesce.

V3:
	- add patch 5/6 to clear NVME_CTRL_ADMIN_Q_STOPPED for nvme-loop
	  after reallocating admin queue
	- take Bart's suggestion to add warning in blk_mq_unquiesce_queue()
	& update commit log

V2:
	- replace mutex with atomic ops for supporting paring quiesce &
	  unquiesce


Ming Lei (6):
  nvme: add APIs for stopping/starting admin queue
  nvme: apply nvme API to quiesce/unquiesce admin queue
  nvme: prepare for pairing quiescing and unquiescing
  nvme: paring quiesce/unquiesce
  nvme: loop: clear NVME_CTRL_ADMIN_Q_STOPPED after admin queue is
    reallocated
  blk-mq: support concurrent queue quiesce/unquiesce

 block/blk-mq.c             | 21 ++++++++++--
 drivers/nvme/host/core.c   | 70 ++++++++++++++++++++++++++------------
 drivers/nvme/host/fc.c     |  8 ++---
 drivers/nvme/host/nvme.h   |  4 +++
 drivers/nvme/host/pci.c    |  8 ++---
 drivers/nvme/host/rdma.c   | 14 ++++----
 drivers/nvme/host/tcp.c    | 16 ++++-----
 drivers/nvme/target/loop.c |  6 ++--
 include/linux/blkdev.h     |  2 ++
 9 files changed, 99 insertions(+), 50 deletions(-)

-- 
2.31.1

