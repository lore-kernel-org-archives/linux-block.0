Return-Path: <SRS0=8pZC=OW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86353C65BAE
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 06:38:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B8A620849
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 06:38:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iiHgvJu4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B8A620849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbeLMGiX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Dec 2018 01:38:23 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:35070 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726641AbeLMGiX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Dec 2018 01:38:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Message-Id:Date:Subject:Cc:To:From:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=diLEn7pAwnEeRQA3FDyw5UjJv6hWCkT1Q235CCZWI8I=; b=iiHgvJu4baNH5K94B7VBEHWdk
        JPrnRbSo77gqGIZyYtKFadOPpLa+TqFWANC3+YNAzok6nvOHB8t7e516LcKnfgGATWRITKJs00vep
        rKrmOkvrjxS946W/+2XYWm2psNtiiPQEmgjD+HksoHTOJrFINk9jn3eVizSLvL135TsTLaFOu+4KG
        9GCHf49TCMIED4h1vc+RWb0a2DoEMuDC99ZmcazvHXEnqv7HGClojm6fMgOv5r/Gu67djtznBq7fK
        0eHv3bQIhYPVZRb9LsbBR0YAtbhQfblolrp8VTKorlmzORu6AKul4vo3hcrlhxM8u5cMUGEW/qlDG
        lty7KRrkQ==;
Received: from [2601:647:4800:973f:7888:b13c:bff:87b0] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gXKdY-0006LR-VR; Thu, 13 Dec 2018 06:38:21 +0000
From:   Sagi Grimberg <sagi@grimberg.me>
To:     linux-nvme@lists.infradead.org
Cc:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v2 0/6] restore nvme-rdma polling
Date:   Wed, 12 Dec 2018 22:38:12 -0800
Message-Id: <20181213063819.13614-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.17.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add an additional queue mapping for polling queues that will
host polling for latency critical I/O.

Allocate the poll queues with IB_POLL_DIRECT context. For nvmf connect
we introduce a new blk_execute_rq_polled to poll for the completion and
have nvmf_connect_io_queue use it for conneting polling queues.

Finally, we turn off polling support for nvme-multipath as it won't invoke
polling and our completion queues no longer generates any interrupts for
it. I didn't come up with a good way to get around it so far...

Changes from v1:
- get rid of ib_change_cq_ctx
- poll for nvmf connect over poll queues

Sagi Grimberg (6):
  block: introduce blk_execute_rq_polled
  nvme-core: allow __nvme_submit_sync_cmd to poll
  nvme-fabrics: allow nvmf_connect_io_queue to poll
  nvme-fabrics: allow user to pass in nr_poll_queues
  nvme-rdma: implement polling queue map
  nvme-multipath: disable polling for underlying namespace request queue

 block/blk-exec.c            | 29 +++++++++++++++++++
 block/blk-mq.c              |  8 -----
 drivers/nvme/host/core.c    | 15 ++++++----
 drivers/nvme/host/fabrics.c | 25 ++++++++++++----
 drivers/nvme/host/fabrics.h |  5 +++-
 drivers/nvme/host/fc.c      |  2 +-
 drivers/nvme/host/nvme.h    |  2 +-
 drivers/nvme/host/rdma.c    | 58 +++++++++++++++++++++++++++++++++----
 drivers/nvme/host/tcp.c     |  2 +-
 drivers/nvme/target/loop.c  |  2 +-
 include/linux/blk-mq.h      |  8 +++++
 include/linux/blkdev.h      |  2 ++
 12 files changed, 128 insertions(+), 30 deletions(-)

-- 
2.17.1

