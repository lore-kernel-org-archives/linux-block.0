Return-Path: <hare@suse.de>
Subject: Re: [PATCH 02/14] block: rename BLK_EH_NOT_HANDLED to BLK_EH_DONE
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Keith Busch <keith.busch@intel.com>
Cc: Bart Van Assche <bart.vanassche@wdc.com>, Ming Lei <ming.lei@redhat.com>,
 Josef Bacik <josef@toxicpanda.com>, Tejun Heo <tj@kernel.org>,
 Lee Duncan <lduncan@suse.com>, Chris Leech <cleech@redhat.com>,
 Rafael David Tinoco <rafael.tinoco@canonical.com>,
 linux-block@vger.kernel.org, linux-scsi@vger.kernel.org
References: <20180523121941.8632-1-hch@lst.de>
 <20180523121941.8632-3-hch@lst.de>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <70bffe47-8956-819a-6cae-d6327cff990e@suse.de>
Date: Wed, 23 May 2018 15:22:26 +0200
MIME-Version: 1.0
In-Reply-To: <20180523121941.8632-3-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 05/23/2018 02:19 PM, Christoph Hellwig wrote:
> The BLK_EH_NOT_HANDLED implies nothing happen, but very often that
> is not what is happening - instead the driver already completed the
> command.  Fix the symbolic name to reflect that a little better.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   Documentation/scsi/scsi_eh.txt            | 4 ++--
>   block/blk-mq.c                            | 2 +-
>   block/blk-timeout.c                       | 2 +-
>   drivers/block/nbd.c                       | 2 +-
>   drivers/message/fusion/mptsas.c           | 2 +-
>   drivers/s390/block/dasd.c                 | 6 +++---
>   drivers/scsi/gdth.c                       | 2 +-
>   drivers/scsi/libiscsi.c                   | 2 +-
>   drivers/scsi/megaraid/megaraid_sas_base.c | 2 +-
>   drivers/scsi/mvumi.c                      | 2 +-
>   drivers/scsi/qla4xxx/ql4_os.c             | 2 +-
>   drivers/scsi/scsi_error.c                 | 4 ++--
>   drivers/scsi/scsi_transport_fc.c          | 4 ++--
>   drivers/scsi/scsi_transport_srp.c         | 4 ++--
>   drivers/scsi/ufs/ufshcd.c                 | 6 +++---
>   include/linux/blkdev.h                    | 2 +-
>   include/scsi/scsi_host.h                  | 2 +-
>   17 files changed, 25 insertions(+), 25 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
