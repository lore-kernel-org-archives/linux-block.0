Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 517D1C433FE
	for <linux-block@archiver.kernel.org>; Wed, 29 Sep 2021 04:16:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F2706108F
	for <linux-block@archiver.kernel.org>; Wed, 29 Sep 2021 04:16:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231788AbhI2ESZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Sep 2021 00:18:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36893 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231584AbhI2ESY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Sep 2021 00:18:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632889003;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=D19V9XJqvkGN4+zC8heJ/oDgXubPN0A+TqtDJvrseY4=;
        b=EKhZ5qrFEBh4Vxs52L3G9Y3u3vXR5V3ZeI0xQYHp1yLU9wnkLiQwOpxlIeRC23SNbxnu4Z
        OgBXjpLcaZF531IjxneFerFYIMaHujJfuR68xJvnM7kjbK9dHZlItGcSxNHFYB4mumvH0S
        EIH2hm9u0CfXA/jmQR4DOXIibUy7sSY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-283-kjtJyvqbP3K6uAbv7Q2s3A-1; Wed, 29 Sep 2021 00:16:42 -0400
X-MC-Unique: kjtJyvqbP3K6uAbv7Q2s3A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DEE51802947;
        Wed, 29 Sep 2021 04:16:40 +0000 (UTC)
Received: from localhost (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1FEDE5E255;
        Wed, 29 Sep 2021 04:16:36 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        linux-block@vger.kernel.org
Cc:     Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
        Keith Busch <kbusch@kernel.org>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 0/5] blk-mq: support nested queue quiescing
Date:   Wed, 29 Sep 2021 12:15:54 +0800
Message-Id: <20210929041559.701102-1-ming.lei@redhat.com>
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

Fix the issue by supporting nested queue quiescing. But nvme has very
complicated uses on quiesce/unquiesce, which two may not be called in
pairing, so switch to this way in patch 1~4, and patch 5 provides
nested queue quiesce.


Ming Lei (5):
  nvme: add APIs for stopping/starting admin queue
  nvme: apply nvme API to quiesce/unquiesce admin queue
  nvme: prepare for pairing quiescing and unquiescing
  nvme: paring quiesce/unquiesce
  blk-mq: support nested blk_mq_quiesce_queue()

 block/blk-mq.c             |  20 +++++--
 drivers/nvme/host/core.c   | 107 +++++++++++++++++++++++++++++--------
 drivers/nvme/host/fc.c     |   8 +--
 drivers/nvme/host/nvme.h   |   6 +++
 drivers/nvme/host/pci.c    |   8 +--
 drivers/nvme/host/rdma.c   |  14 ++---
 drivers/nvme/host/tcp.c    |  16 +++---
 drivers/nvme/target/loop.c |   4 +-
 include/linux/blkdev.h     |   2 +
 9 files changed, 135 insertions(+), 50 deletions(-)

-- 
2.31.1

