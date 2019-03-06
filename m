Return-Path: <SRS0=tltz=RJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2565FC43381
	for <linux-block@archiver.kernel.org>; Wed,  6 Mar 2019 08:48:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0553206DD
	for <linux-block@archiver.kernel.org>; Wed,  6 Mar 2019 08:48:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729619AbfCFIsn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Mar 2019 03:48:43 -0500
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:47752 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726391AbfCFIsm (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Mar 2019 03:48:42 -0500
Received: from Internal Mail-Server by MTLPINE1 (envelope-from talgi@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 6 Mar 2019 10:48:39 +0200
Received: from gen-l-vrt-691.mtl.labs.mlnx (gen-l-vrt-691.mtl.labs.mlnx [10.141.69.1])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x268mdKZ017339;
        Wed, 6 Mar 2019 10:48:39 +0200
Received: from gen-l-vrt-691.mtl.labs.mlnx (localhost [127.0.0.1])
        by gen-l-vrt-691.mtl.labs.mlnx (8.15.2/8.15.2/Debian-11ubuntu1) with ESMTP id x268mdJl057811;
        Wed, 6 Mar 2019 10:48:39 +0200
Received: (from talgi@localhost)
        by gen-l-vrt-691.mtl.labs.mlnx (8.15.2/8.15.2/Submit) id x268mXb6057808;
        Wed, 6 Mar 2019 10:48:33 +0200
From:   Tal Gilboa <talgi@mellanox.com>
To:     linux-rdma@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
Cc:     Yishai Hadas <yishaih@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        Tal Gilboa <talgi@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Idan Burstein <idanb@mellanox.com>,
        Yamin Friedman <yaminf@mellanox.com>,
        Max Gurtovoy <maxg@mellanox.com>
Subject: [RFC/PATCH net-next 0/9] net/dim: Support for multiple implementations
Date:   Wed,  6 Mar 2019 10:48:23 +0200
Message-Id: <20190306084832.57753-1-talgi@mellanox.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

net_dim.h lib exposes an implementation of the DIM algorithm for dynamically-tuned interrupt
moderation for networking interfaces.

We need the same behavior for any block CQ. The main motivation is two benefit from maximized
completion rate and reduced interrupt overhead that DIM may provide.

Current DIM implementation prioritizes reducing interrupt overhead over latency. Also, in
order to reduce DIM's own overhead, the algorithm might take take some time to identify it
needs to change profiles. For these reasons we got to the understanding that a slightly
modified algorithm is needed. Early tests with current implementation show it doesn't react
fast and sharply enough in order to satisfy the block CQ needs.

I would like to suggest an implementation for block DIM. The idea is to expose the new
functionality without the risk of breaking Net DIM behavior for netdev. Below are main
similarities and differences between the two implementations and general guidelines for the
suggested solution.

Performance tests over ConnectX-5 100GbE NIC show a 200% improvement on tail latency when
switching from high load traffic to low load traffic.

Common logic, main DIM procedure:
- Calculate current stats from a given sample
- Compare current stats vs. previous iteration stats
- Make a decision -> choose a new profile

Differences:
- Different parameters for moving between profiles
- Different moderation values and number of profiles
- Different sampled data

Suggested solution:
- Common logic will be declared in include/linux/dim.h and implemented in lib/dim/dim.c
- Net DIM (existing) logic will be declared in include/linux/net_dim.h and implemented in
  lib/dim/net_dim.c, which will use the common logic from dim.h
- Block DIM logic will be declared in /include/linux/block_dim.h and implemented in
  lib/dim/blk_dim.c.
  This new implementation will expose modified versions of profiles, dim_step() and dim_decision()

Pros for this solution are:
- Zero impact on existing net_dim implementation and usage
- Relatively more code reuse (compared to two separate solutions)
- Readiness for future implementations

Tal Gilboa (6):
  linux/dim: Move logic to dim.h
  linux/dim: Remove "net" prefix from internal DIM members
  linux/dim: Rename externally exposed macros
  linux/dim: Rename net_dim_sample() to net_dim_create_sample()
  linux/dim: Rename externally used net_dim members
  linux/dim: Move implementation to .c files

Yamin Friedman (3):
  linux/dim: Add completions count to dim_sample
  linux/dim: Implement blk_dim.h
  drivers/infiniband: Use blk_dim in infiniband driver

 MAINTAINERS                                   |   3 +
 drivers/infiniband/core/cq.c                  |  75 +++-
 drivers/infiniband/hw/mlx4/qp.c               |   2 +-
 drivers/infiniband/hw/mlx5/qp.c               |   2 +-
 drivers/net/ethernet/broadcom/bcmsysport.c    |  20 +-
 drivers/net/ethernet/broadcom/bcmsysport.h    |   2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  13 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |   2 +-
 .../net/ethernet/broadcom/bnxt/bnxt_debugfs.c |   4 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_dim.c |   7 +-
 .../net/ethernet/broadcom/genet/bcmgenet.c    |  18 +-
 .../net/ethernet/broadcom/genet/bcmgenet.h    |   2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en.h  |   8 +-
 .../net/ethernet/mellanox/mlx5/core/en_dim.c  |  12 +-
 .../ethernet/mellanox/mlx5/core/en_ethtool.c  |   4 +-
 .../net/ethernet/mellanox/mlx5/core/en_main.c |  22 +-
 .../net/ethernet/mellanox/mlx5/core/en_txrx.c |  10 +-
 include/linux/blk_dim.h                       |  56 +++
 include/linux/dim.h                           | 126 +++++++
 include/linux/irq_poll.h                      |   7 +
 include/linux/net_dim.h                       | 338 +-----------------
 include/rdma/ib_verbs.h                       |  11 +-
 lib/Kconfig                                   |   7 +
 lib/Makefile                                  |   1 +
 lib/dim/Makefile                              |  14 +
 lib/dim/blk_dim.c                             | 114 ++++++
 lib/dim/dim.c                                 |  92 +++++
 lib/dim/net_dim.c                             | 193 ++++++++++
 lib/irq_poll.c                                |  13 +-
 29 files changed, 778 insertions(+), 400 deletions(-)
 create mode 100644 include/linux/blk_dim.h
 create mode 100644 include/linux/dim.h
 create mode 100644 lib/dim/Makefile
 create mode 100644 lib/dim/blk_dim.c
 create mode 100644 lib/dim/dim.c
 create mode 100644 lib/dim/net_dim.c

-- 
2.19.1

