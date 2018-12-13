Return-Path: <SRS0=8pZC=OW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB88BC65BAE
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 21:34:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74F1D20811
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 21:34:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AuG/lLff"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74F1D20811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbeLMVeP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Dec 2018 16:34:15 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:44074 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726453AbeLMVeP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Dec 2018 16:34:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Message-Id:Date:Subject:Cc:To:From:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=S0QkPq2LFj1Clud54dGp20AXUacTuU3/6PnUkoyizxc=; b=AuG/lLffgkcjl2pZ3ePo7lQxx
        aGIRLMVhb0zEH3ChwCLOl0W9nkQMPBYmk39K5GnJkN6/2bpivGdpDBI6bzrltgxQiVNb6VOF4U6ah
        d7DYA4P79qWpWINgSWdltiBlxIbmFxrDhRVtHhqizJiBuwJkASlofLcTIkt7TgHTBsnVyY27CVp83
        QGxXxLnFVxTZM1UjTeNANcW1lEsP/GvbptgEbHNKeKjUzGrbEO+fsmecpg3VXRa8uD6CFxwjb+ZNe
        JhYcYEj/cYXk5SGO81iEi5cMqpk2tFgrexMI+JJB7Jk9wYFABxkZATHxUHwnaL/4gWgCimYzwlvXu
        HhhlX+C9A==;
Received: from [2601:647:4800:973f:7888:b13c:bff:87b0] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gXYcW-0002ho-GH; Thu, 13 Dec 2018 21:34:14 +0000
From:   Sagi Grimberg <sagi@grimberg.me>
To:     linux-nvme@lists.infradead.org
Cc:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v3 0/6] restore nvme-rdma polling
Date:   Thu, 13 Dec 2018 13:34:04 -0800
Message-Id: <20181213213410.9841-1-sagi@grimberg.me>
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

 block/blk-core.c            |  3 ++
 block/blk-mq.c              |  8 -----
 drivers/nvme/host/core.c    | 38 ++++++++++++++++++++----
 drivers/nvme/host/fabrics.c | 25 ++++++++++++----
 drivers/nvme/host/fabrics.h |  5 +++-
 drivers/nvme/host/fc.c      |  2 +-
 drivers/nvme/host/nvme.h    |  2 +-
 drivers/nvme/host/rdma.c    | 58 +++++++++++++++++++++++++++++++++----
 drivers/nvme/host/tcp.c     |  2 +-
 drivers/nvme/target/loop.c  |  2 +-
 include/linux/blk-mq.h      | 10 +++++++
 include/linux/blk_types.h   | 11 -------
 12 files changed, 125 insertions(+), 41 deletions(-)

-- 
2.17.1

