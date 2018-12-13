Return-Path: <SRS0=8pZC=OW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3722C67839
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 19:56:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A23D20811
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 19:56:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oFmwfIV6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A23D20811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728843AbeLMT4L (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Dec 2018 14:56:11 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:44580 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727951AbeLMT4L (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Dec 2018 14:56:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=o7SIJ5734xRgfYNFsQV7juw5u4tvLwpwC9zBhCFvKSQ=; b=oFmwfIV6nZgmQnMQT3Si8mEh89
        UYMJ++eytdRRXMGVaKaGAu8wpO1IpY3WWRzCpa8rXLVdS3CrVl1nv8rxaWlGoW3/WJmiAA7jqOVke
        MXgz37IHqkRC12dH4eSCLZabdHIbAuqtP2DaDV9rLarC0QPIDlW1b6eSj/6OvyTclegBZiF4woC8x
        h3DGnVU4UVaIlUhvN84eDloa5IS2MDPJu/u2QZxGoXIFM04df2gs/jt1lBLyanCuhdwfVny2nd0tx
        ICLHf+clYjmr2CC0KK7sNQRwof7IwjOc5qycnIfek1JatPuiQiDbKjB8P4dovBXsI36gKiww85RL2
        MvlaOjbg==;
Received: from 089144198147.atnat0007.highway.a1.net ([89.144.198.147] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gXX5d-0001uU-OQ; Thu, 13 Dec 2018 19:56:10 +0000
Date:   Thu, 13 Dec 2018 20:56:07 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
Subject: [GIT PULL] second batch of nvme updates for 4.21
Message-ID: <20181213195607.GA7751@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

here is the second large chunk of nvme updates for 4.21:

 - host and target support for NVMe over TCP (Sagi Grimberg,
	Roy Shterman, Solganik Alexander)
 - error log page support in target (Chaitanya Kulkarni)

plus small fixes and improvements from Jens Axboe and Chengguang Xu.

The following changes since commit 0273ac349f08f4ff9ef88aaaf9c9f2aa6e87d2be:

  blkcg: handle dying request_queue when associating a blkg (2018-12-12 17:43:33 -0700)

are available in the Git repository at:

  git://git.infradead.org/nvme.git nvme-4.21

for you to fetch changes up to b65bb777ef2237030f2802f2263ae9a0108f7acf:

  nvme-rdma: support separate queue maps for read and write (2018-12-13 09:59:10 +0100)

----------------------------------------------------------------
Chaitanya Kulkarni (12):
      nvme: remove nvme_common command cdw10 array
      nvme: add error log page slot definition
      nvmet: add error-log definitions
      nvmet: add interface to update error-log page
      nvmet: add error log support in the core
      nvmet: add error log support for fabrics-cmd
      nvmet: add error log support for rdma backend
      nvmet: add error log support for admin-cmd
      nvmet: add error log support for bdev backend
      nvmet: add error log support for file backend
      nvmet: add error log page cmd handler
      nvmet: update smart log with num err log entries

Chengguang Xu (1):
      nvme: add __exit annotation

Jens Axboe (1):
      nvme: provide fallback for discard alloc failure

Sagi Grimberg (19):
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
      nvmet: remove unused variable
      blk-mq-rdma: pass in queue map to blk_mq_rdma_map_queues
      nvme-fabrics: add missing nvmf_ctrl_options documentation
      nvme-fabrics: allow user to set nr_write_queues for separate queue maps
      nvme-tcp: support separate queue maps for read and write
      nvme-rdma: support separate queue maps for read and write

 block/blk-mq-rdma.c                        |    8 +-
 drivers/net/wireless/ath/ath6kl/cfg80211.c |    2 +-
 drivers/net/wireless/ath/ath6kl/common.h   |    2 +-
 drivers/net/wireless/ath/ath6kl/wmi.c      |    6 +-
 drivers/net/wireless/ath/ath6kl/wmi.h      |    6 +-
 drivers/nvme/host/Kconfig                  |   15 +
 drivers/nvme/host/Makefile                 |    3 +
 drivers/nvme/host/core.c                   |   61 +-
 drivers/nvme/host/fabrics.c                |   23 +
 drivers/nvme/host/fabrics.h                |   10 +
 drivers/nvme/host/lightnvm.c               |    6 +-
 drivers/nvme/host/nvme.h                   |    5 +-
 drivers/nvme/host/rdma.c                   |   28 +-
 drivers/nvme/host/tcp.c                    | 2277 ++++++++++++++++++++++++++++
 drivers/nvme/host/trace.h                  |    4 +-
 drivers/nvme/target/Kconfig                |   10 +
 drivers/nvme/target/Makefile               |    2 +
 drivers/nvme/target/admin-cmd.c            |   76 +-
 drivers/nvme/target/configfs.c             |    1 +
 drivers/nvme/target/core.c                 |  106 +-
 drivers/nvme/target/discovery.c            |   14 +-
 drivers/nvme/target/fabrics-cmd.c          |   58 +-
 drivers/nvme/target/io-cmd-bdev.c          |   87 +-
 drivers/nvme/target/io-cmd-file.c          |   35 +-
 drivers/nvme/target/nvmet.h                |   16 +-
 drivers/nvme/target/rdma.c                 |   10 +-
 drivers/nvme/target/tcp.c                  | 1737 +++++++++++++++++++++
 include/linux/blk-mq-rdma.h                |    2 +-
 include/linux/nvme-tcp.h                   |  189 +++
 include/linux/nvme.h                       |   22 +-
 include/linux/skbuff.h                     |    3 +
 include/linux/uio.h                        |    5 +-
 lib/iov_iter.c                             |   19 +-
 net/core/datagram.c                        |  159 +-
 34 files changed, 4794 insertions(+), 213 deletions(-)
 create mode 100644 drivers/nvme/host/tcp.c
 create mode 100644 drivers/nvme/target/tcp.c
 create mode 100644 include/linux/nvme-tcp.h
