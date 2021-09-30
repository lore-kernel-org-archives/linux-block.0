Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E491C433EF
	for <linux-block@archiver.kernel.org>; Thu, 30 Sep 2021 12:56:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E533F6126A
	for <linux-block@archiver.kernel.org>; Thu, 30 Sep 2021 12:56:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348682AbhI3M60 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 Sep 2021 08:58:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:51106 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348530AbhI3M60 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Sep 2021 08:58:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633006603;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=RX9RlcTs+c2zIM/RTHHCkJJbaueEK8M/sumCaOzGWXE=;
        b=CNpQ6iXNlwgv3X1kjKClWZag7n6Jwfzpn5p5rPajR55LgRDApFNI0m5ici1zqjTCv02ZMA
        uto8sMnLTc8ojXJZz7JGRoYBiJ+s1QSrXlPJmhAw3L0Vpe/428IQajEsWJ2tD9n+MP+D6U
        HKi/r6kEjBT3yFNyiNbWVweD7muHThM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-46-iatLPiA2N1uVDvZ-eOW8Xg-1; Thu, 30 Sep 2021 08:56:41 -0400
X-MC-Unique: iatLPiA2N1uVDvZ-eOW8Xg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 60EC38145E6;
        Thu, 30 Sep 2021 12:56:40 +0000 (UTC)
Received: from localhost (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CCA625D9CA;
        Thu, 30 Sep 2021 12:56:26 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc:     Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 0/5] blk-mq: support concurrent queue quiescing
Date:   Thu, 30 Sep 2021 20:56:16 +0800
Message-Id: <20210930125621.1161726-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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

V2:
	- replace mutex with atomic ops for supporting paring quiesce &
	  unquiesce


Ming Lei (5):
  nvme: add APIs for stopping/starting admin queue
  nvme: apply nvme API to quiesce/unquiesce admin queue
  nvme: prepare for pairing quiescing and unquiescing
  nvme: paring quiesce/unquiesce
  blk-mq: support concurrent queue quiesce/unquiesce

 block/blk-mq.c             | 20 +++++++++--
 drivers/nvme/host/core.c   | 70 ++++++++++++++++++++++++++------------
 drivers/nvme/host/fc.c     |  8 ++---
 drivers/nvme/host/nvme.h   |  4 +++
 drivers/nvme/host/pci.c    |  8 ++---
 drivers/nvme/host/rdma.c   | 14 ++++----
 drivers/nvme/host/tcp.c    | 16 ++++-----
 drivers/nvme/target/loop.c |  4 +--
 include/linux/blkdev.h     |  2 ++
 9 files changed, 96 insertions(+), 50 deletions(-)

-- 
2.31.1

