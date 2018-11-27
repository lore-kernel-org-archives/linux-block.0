Return-Path: <SRS0=Byed=OG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C961C43441
	for <linux-block@archiver.kernel.org>; Tue, 27 Nov 2018 23:16:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60BF820873
	for <linux-block@archiver.kernel.org>; Tue, 27 Nov 2018 23:16:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UJcnPuzR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60BF820873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbeK1KPw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 28 Nov 2018 05:15:52 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:37644 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbeK1KPw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Nov 2018 05:15:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Message-Id:Date:Subject:Cc:To:From:
        Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=jWtUApLj/KA8nLYeZTDTkz1KdS1vDsxQVoEMIV7xvJQ=; b=UJcnPuzRk6uO0mTe/BstfWxgY
        WnDUFBRVxgP3rYrvaY7Tzcn3eojaXA3HFJShg1eYLt/qIHOFp/2uFSbQeKcCR8feqk5pcJ6SfLFEx
        454fZo8Rs9pTYP2qgPNF/di3GYVil33IEeJ10jYMJX7aMTV8M3mtu+p+mkxnIro4LIS5r5w4RDj7x
        EWHXcUqUttqeD9xEy2RmUDoAeTfXTyY9wJ4fM65c+sQSKMqQtEOJi2d5BLTY3bC3IHWDVT2jZacp6
        gYURDxEQhBR2NwJxQ+a7sbO7vYU/pklFjxl3TMpmcJw6JTRJktPDoUrJLHK1h+E5a/m8b9W7ZapIs
        lw7XyZkmg==;
Received: from [2600:1700:65a0:78e0:514:7862:1503:8e4d] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gRmaa-0007cp-Fc; Tue, 27 Nov 2018 23:16:20 +0000
From:   Sagi Grimberg <sagi@grimberg.me>
To:     linux-nvme@lists.infradead.org
Cc:     linux-block@vger.kernel.org, netdev@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH v4 00/13] TCP transport binding for NVMe over Fabrics
Date:   Tue, 27 Nov 2018 15:16:02 -0800
Message-Id: <20181127231615.9446-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.17.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Changes from v3:
- various changes based on comments from christoph
  - removed unused variables
  - united send/recv iter initialization
  - removed unneeded void * casting
  - fixed long lines
  - removed unneeded wrappers (nvme_tcp_free_tagset and friends)
  - remove null sgl setting
  - fixed socket callbacks naming
  - reworked nvmet-tcp send_list processing
- omitted nvme-cli patches as no changes were made to them and no negative
  feedback was accepted since v3

Changes from v2:
- fixed stupid missing symbol export for skb_copy_and_hash_datagram_iter 
- dropped patch that moved err_work and connect_work to nvme_ctrl
- fixed maxr2t icreq validation
- got rid of host and target send/recv context structures by moving
  the members directly to their parent structure along with some struct
  documentation
- removed bh disable when locking the queue lock
- moved definition in nvme-tcp.h to appropriate patch
- added patch to rework nvme-cli trtype handling for discovery log entries
  a bit
- rebased on top of nvme-4.21 branch
- cleaned up some checkpatch warnings
- collected review tags

Changes from v1:
- unified skb_copy_datagram_iter and skb_copy_and_csum_datagram (and the
  new skb_hash_and_copy_datagram_iter) to a single code path
- removed nvmet modparam budgets (made them a define set to their default
  values)
- fixed nvme-tcp host chained r2t transfers reported off-list
- made .install_queue callout return nvme status code
- Added some review tags
- rebased on top of nvme-4.21 branch (nvme tree) + sqflow disable patches

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

Also, @netdev mailing list is cc'd as this patch set contains generic
helpers for online digest calculation (patches 1-3).

The patchset structure:
- patches 1-6 are prep to add a helper for digest calculation online
  with data placement
- patches 7-9 are preparatory patches for NVMe/TCP
- patches 10-13 implements NVMe/TCP

Thanks to the members of the Fabrics Linux Driver team that helped
development, testing and benchmarking this work.

Gitweb code is available at:

	git://git.infradead.org/nvme.git nvme-tcp

Sagi Grimberg (13):
  ath6kl: add ath6kl_ prefix to crypto_type
  datagram: open-code copy_page_to_iter
  iov_iter: pass void csum pointer to csum_and_copy_to_iter
  datagram: consolidate datagram copy to iter helpers
  iov_iter: introduce hash_and_copy_to_iter helper
  datagram: introduce skb_copy_and_hash_datagram_iter helper
  nvmet: Add install_queue callout
  nvme-fabrics: allow user passing header digest
  nvme-fabrics: allow user passing data digest
  nvme-tcp: Add protocol header
  nvmet-tcp: add NVMe over TCP target driver
  nvmet: allow configfs tcp trtype configuration
  nvme-tcp: add NVMe over TCP host driver

 drivers/net/wireless/ath/ath6kl/cfg80211.c |    2 +-
 drivers/net/wireless/ath/ath6kl/common.h   |    2 +-
 drivers/net/wireless/ath/ath6kl/wmi.c      |    6 +-
 drivers/net/wireless/ath/ath6kl/wmi.h      |    6 +-
 drivers/nvme/host/Kconfig                  |   15 +
 drivers/nvme/host/Makefile                 |    3 +
 drivers/nvme/host/fabrics.c                |   10 +
 drivers/nvme/host/fabrics.h                |    4 +
 drivers/nvme/host/tcp.c                    | 2242 ++++++++++++++++++++
 drivers/nvme/target/Kconfig                |   10 +
 drivers/nvme/target/Makefile               |    2 +
 drivers/nvme/target/configfs.c             |    1 +
 drivers/nvme/target/fabrics-cmd.c          |   10 +
 drivers/nvme/target/nvmet.h                |    1 +
 drivers/nvme/target/tcp.c                  | 1735 +++++++++++++++
 include/linux/nvme-tcp.h                   |  189 ++
 include/linux/nvme.h                       |    1 +
 include/linux/skbuff.h                     |    3 +
 include/linux/uio.h                        |    5 +-
 lib/iov_iter.c                             |   19 +-
 net/core/datagram.c                        |  159 +-
 21 files changed, 4320 insertions(+), 105 deletions(-)
 create mode 100644 drivers/nvme/host/tcp.c
 create mode 100644 drivers/nvme/target/tcp.c
 create mode 100644 include/linux/nvme-tcp.h

-- 
2.17.1

