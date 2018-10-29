Return-Path: <hare@suse.de>
Subject: Re: [PATCH 02/14] blk-mq: abstract out queue map
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <20181025211626.12692-1-axboe@kernel.dk>
 <20181025211626.12692-3-axboe@kernel.dk>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <7690db18-9834-a13b-6e0d-7a48575ab8ce@suse.de>
Date: Mon, 29 Oct 2018 08:30:29 +0100
MIME-Version: 1.0
In-Reply-To: <20181025211626.12692-3-axboe@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 10/25/18 11:16 PM, Jens Axboe wrote:
> This is in preparation for allowing multiple sets of maps per
> queue, if so desired.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>   block/blk-mq-cpumap.c                 | 10 ++++----
>   block/blk-mq-pci.c                    | 10 ++++----
>   block/blk-mq-rdma.c                   |  4 ++--
>   block/blk-mq-virtio.c                 |  8 +++----
>   block/blk-mq.c                        | 34 ++++++++++++++-------------
>   block/blk-mq.h                        |  8 +++----
>   drivers/block/virtio_blk.c            |  2 +-
>   drivers/nvme/host/pci.c               |  2 +-
>   drivers/scsi/qla2xxx/qla_os.c         |  5 ++--
>   drivers/scsi/scsi_lib.c               |  2 +-
>   drivers/scsi/smartpqi/smartpqi_init.c |  3 ++-
>   drivers/scsi/virtio_scsi.c            |  3 ++-
>   include/linux/blk-mq-pci.h            |  4 ++--
>   include/linux/blk-mq-virtio.h         |  4 ++--
>   include/linux/blk-mq.h                | 13 ++++++++--
>   15 files changed, 63 insertions(+), 49 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
