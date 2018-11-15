Return-Path: <SRS0=/6aj=N2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E3B1C43441
	for <linux-block@archiver.kernel.org>; Thu, 15 Nov 2018 17:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 450B52087A
	for <linux-block@archiver.kernel.org>; Thu, 15 Nov 2018 17:17:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GHRYsMwB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 450B52087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightbitslabs.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388265AbeKPDZJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Nov 2018 22:25:09 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:44496 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388395AbeKPDZJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Nov 2018 22:25:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Message-Id:Date:Subject:Cc:To:From:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=VjUIXK4TAYzPM4qbxbVQ5+ZFJqWsGe+897BiQ2rYimY=; b=GHRYsMwBpUdc12O4WGmPTGcKO
        7iHyCxsrxDK7SOVKFJELvam9pjHULByvQjFpx4WSfwVZk4+V+niGOBXHQ2ikN5Hn5cFfv/kktVkBs
        9v3CLT7EqnWNyVpo+m50iBQKOZdhddwyXgbXSlc+BK7obfBT79POWsF5B60NTT8bz3HhpuQ7cBilY
        CG/Nh+0tEi0mk2TJ0tWqzKVy3kxRRZLZmOQb+H449snv/I7ajRs+ka6du0pMclO03OmhVRTB2s8Or
        ZkLzQTgpzPP8SaQRdtWpMgQCKn1q2+1oagcgvpCYaF9/8sbxzIEgaaT4mulOeIDynWmPqPzbRPY5a
        +OXiRJ3Gw==;
Received: from [52.119.64.114] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gNLFk-0002LK-0z; Thu, 15 Nov 2018 17:16:28 +0000
From:   Sagi Grimberg <sagi@lightbitslabs.com>
To:     linux-nvme@lists.infradead.org
Cc:     linux-block@vger.kernel.org, netdev@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCH 00/11] TCP transport binding for NVMe over Fabrics
Date:   Thu, 15 Nov 2018 09:16:12 -0800
Message-Id: <20181115171626.9306-1-sagi@lightbitslabs.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch set implements the NVMe over Fabrics TCP host and the target
drivers. Now NVMe over Fabrics can run on every Ethernet port in the world.
The implementation conforms to NVMe over Fabrics 1.1 specification (which
will include already publicly available NVMe/TCP transport binding, TP 8000).

The host driver hooks into the NVMe host stack and implements the TCP
transport binding for NVMe over Fabrics. The NVMe over Fabrics TCP host
driver is responsible for establishing a NVMe/TCP connection, TCP event
and error handling and data-plane messaging and stream processing.

The target driver hooks into the NVMe target core stack and implements
the TCP transport binding. The NVMe over Fabrics target driver is
responsible for accepting and establishing NVMe/TCP connections, TCP
event and error handling, and data-plane messaging and stream processing.

The implementation of both the host and target are fairly simple and
straight-forward. Every NVMe queue is backed by a TCP socket that provides
us reliable, in-order delivery of fabrics capsules and/or data.

All NVMe queues are sharded over a private bound workqueue such that we
always have a single context handling the byte stream and we don't need
to worry about any locking/serialization. In addition, close attention
was paid to a completely non-blocking data plane to minimize context
switching and/or unforced scheduling.

I piggybacked nvme-cli patches to the set for completeness.

Also, @netdev mailing list is cc'd as this patch set contains generic
helpers for online digest calculation (patches 1-3).

The patchset structure:
- patches 1-3 adds a helper for digest calculation online with data placement
- patches 4-8 are preparatory patches for NVMe/TCP
- patches 9-11 implements NVMe/TCP
- patches 12-14 are nvme-cli additions for NVMe/TCP

Thanks to the members of the Fabrics Linux Driver team that helped development,
testing and benchmarking this work.

Gitweb code is available at:

	git://git.infradead.org/nvme.git nvme-tcp

Sagi Grimberg (11):
  ath6kl: add ath6kl_ prefix to crypto_type
  iov_iter: introduce hash_and_copy iter helpers
  datagram: introduce skb_copy_and_hash_datagram_iter helper
  nvme-core: add work elements to struct nvme_ctrl
  nvmet: Add install_queue callout
  nvmet: allow configfs tcp trtype configuration
  nvme-fabrics: allow user passing header digest
  nvme-fabrics: allow user passing data digest
  nvme-tcp: Add protocol header
  nvmet-tcp: add NVMe over TCP target driver
  nvme-tcp: add NVMe over TCP host driver

 drivers/net/wireless/ath/ath6kl/cfg80211.c |    2 +-
 drivers/net/wireless/ath/ath6kl/common.h   |    2 +-
 drivers/net/wireless/ath/ath6kl/wmi.c      |    6 +-
 drivers/net/wireless/ath/ath6kl/wmi.h      |    6 +-
 drivers/nvme/host/Kconfig                  |   15 +
 drivers/nvme/host/Makefile                 |    3 +
 drivers/nvme/host/fabrics.c                |   10 +
 drivers/nvme/host/fabrics.h                |    4 +
 drivers/nvme/host/fc.c                     |   18 +-
 drivers/nvme/host/nvme.h                   |    2 +
 drivers/nvme/host/rdma.c                   |   19 +-
 drivers/nvme/host/tcp.c                    | 2305 ++++++++++++++++++++
 drivers/nvme/target/Kconfig                |   10 +
 drivers/nvme/target/Makefile               |    2 +
 drivers/nvme/target/configfs.c             |    1 +
 drivers/nvme/target/fabrics-cmd.c          |    9 +
 drivers/nvme/target/nvmet.h                |    1 +
 drivers/nvme/target/tcp.c                  | 1746 +++++++++++++++
 include/linux/nvme-tcp.h                   |  189 ++
 include/linux/nvme.h                       |    1 +
 include/linux/skbuff.h                     |    3 +
 include/linux/uio.h                        |    5 +
 lib/iov_iter.c                             |   31 +
 net/core/datagram.c                        |   90 +
 24 files changed, 4451 insertions(+), 29 deletions(-)
 create mode 100644 drivers/nvme/host/tcp.c
 create mode 100644 drivers/nvme/target/tcp.c
 create mode 100644 include/linux/nvme-tcp.h

-- 
2.17.1

