Return-Path: <SRS0=oQb0=OX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64DBEC43612
	for <linux-block@archiver.kernel.org>; Fri, 14 Dec 2018 19:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFF0920879
	for <linux-block@archiver.kernel.org>; Fri, 14 Dec 2018 19:06:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="g2vDrd9X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730657AbeLNTGO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 14 Dec 2018 14:06:14 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:39952 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730659AbeLNTGN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Dec 2018 14:06:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Message-Id:Date:Subject:Cc:To:From:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=YBh005hj5l95m+IEbr6EKNTzV45g6K47MQ49zTTNG74=; b=g2vDrd9XUtym725KpHVHTC7gP
        XufA54glS02kfhjOvirO1FlWIVR7LrXc92pIpFjf3/qRAE6OjAZgKjad7kfz6939XdPatgAigGf0Q
        QiHlwVx9/0DrkRg7m1NmCoXwe0fj5ycgk91W1RR8SgsUjjkQ50wH9WY0S7fWattQrj2D05Jg7QSRh
        HkoLALkSemjl5NhWjOqXSO5BjzeLbhB2yVejOQ6mUSKhwKWU+vMrMUnhpr7v1HcXsIjZFM0/5VLrq
        19nNhdeANndHnwLXDJLOvfso0kB0n/rbLSEo4ukpY/cof2sYu7PptfMdB2gB9x7uPl481jN8L7d98
        7WzEtM6qA==;
Received: from [2600:1700:65a0:78e0:514:7862:1503:8e4d] (helo=sagi-Latitude-E7470.lbits)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gXsmq-0002PK-8s; Fri, 14 Dec 2018 19:06:12 +0000
From:   Sagi Grimberg <sagi@grimberg.me>
To:     linux-nvme@lists.infradead.org
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v4 0/6] restore nvme-rdma polling
Date:   Fri, 14 Dec 2018 11:06:04 -0800
Message-Id: <20181214190610.20086-1-sagi@grimberg.me>
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

Changes from v3:
- renamed nvme_rdma_poller_queue to nvme_rdma_poll_queue
- dropped explicit setting of QUEUE_FLAG_POLL in the connect_q
- report nr_maps=3 only if we got opts->nr_poll_queues
- dropped local cq variable from nvme_rdma_poll

Changes from v2:
- move blk_execute_rq_polled to nvme-core
- turn off REQ_HIPRI if polling is not supported (e.g. for stacking devices)
- omit nvme-cli patch - can be taken from v2
- removed blk_tag_to_qc_t and open-coded it in request_to_tag instead

Changes from v1:
- get rid of ib_change_cq_ctx
- poll for nvmf connect over poll queues

Christoph Hellwig (1):
  block: clear REQ_HIPRI if polling is not supported

Sagi Grimberg (5):
  block: make request_to_qc_t public
  nvme-core: optionally poll sync commands
  nvme-fabrics: allow nvmf_connect_io_queue to poll
  nvme-fabrics: allow user to pass in nr_poll_queues
  nvme-rdma: implement polling queue map

 block/blk-core.c            |  3 +++
 block/blk-mq.c              |  8 ------
 drivers/nvme/host/core.c    | 38 ++++++++++++++++++++++++----
 drivers/nvme/host/fabrics.c | 25 ++++++++++++++-----
 drivers/nvme/host/fabrics.h |  5 +++-
 drivers/nvme/host/fc.c      |  2 +-
 drivers/nvme/host/nvme.h    |  2 +-
 drivers/nvme/host/rdma.c    | 49 ++++++++++++++++++++++++++++++++-----
 drivers/nvme/host/tcp.c     |  2 +-
 drivers/nvme/target/loop.c  |  2 +-
 include/linux/blk-mq.h      | 10 ++++++++
 include/linux/blk_types.h   | 11 ---------
 12 files changed, 116 insertions(+), 41 deletions(-)

-- 
2.17.1

