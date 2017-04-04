Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-db5eur01on0052.outbound.protection.outlook.com ([104.47.2.52]:46223
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751073AbdDDHwb (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 4 Apr 2017 03:52:31 -0400
Subject: Re: [PATCH rfc 0/6] Automatic affinity settings for nvme over rdma
To: Sagi Grimberg <sagi@grimberg.me>, <linux-rdma@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>, <linux-block@vger.kernel.org>
References: <1491140492-25703-1-git-send-email-sagi@grimberg.me>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@mellanox.com>,
        Or Gerlitz <ogerlitz@mellanox.com>,
        Christoph Hellwig <hch@lst.de>
From: Max Gurtovoy <maxg@mellanox.com>
Message-ID: <86ed1762-a990-691f-e043-3d7dcac8fe85@mellanox.com>
Date: Tue, 4 Apr 2017 10:51:47 +0300
MIME-Version: 1.0
In-Reply-To: <1491140492-25703-1-git-send-email-sagi@grimberg.me>
Content-Type: text/plain; charset="windows-1255"; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

>
> Any feedback is welcome.

Hi Sagi,

the patchset looks good and of course we can add support for more 
drivers in the future.
have you run some performance testing with the nvmf initiator ?


>
> Sagi Grimberg (6):
>   mlx5: convert to generic pci_alloc_irq_vectors
>   mlx5: move affinity hints assignments to generic code
>   RDMA/core: expose affinity mappings per completion vector
>   mlx5: support ->get_vector_affinity
>   block: Add rdma affinity based queue mapping helper
>   nvme-rdma: use intelligent affinity based queue mappings
>
>  block/Kconfig                                      |   5 +
>  block/Makefile                                     |   1 +
>  block/blk-mq-rdma.c                                |  56 +++++++++++
>  drivers/infiniband/hw/mlx5/main.c                  |  10 ++
>  drivers/net/ethernet/mellanox/mlx5/core/en_main.c  |   5 +-
>  drivers/net/ethernet/mellanox/mlx5/core/eq.c       |   9 +-
>  drivers/net/ethernet/mellanox/mlx5/core/eswitch.c  |   2 +-
>  drivers/net/ethernet/mellanox/mlx5/core/health.c   |   2 +-
>  drivers/net/ethernet/mellanox/mlx5/core/main.c     | 106 +++------------------
>  .../net/ethernet/mellanox/mlx5/core/mlx5_core.h    |   1 -
>  drivers/nvme/host/rdma.c                           |  13 +++
>  include/linux/blk-mq-rdma.h                        |  10 ++
>  include/linux/mlx5/driver.h                        |   2 -
>  include/rdma/ib_verbs.h                            |  24 +++++
>  14 files changed, 138 insertions(+), 108 deletions(-)
>  create mode 100644 block/blk-mq-rdma.c
>  create mode 100644 include/linux/blk-mq-rdma.h
>
