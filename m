Return-Path: <hare@suse.de>
Subject: Re: [PATCH 08/28] scsi: kill off the legacy IO path
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-ide@vger.kernel.org
References: <20181025211039.11559-1-axboe@kernel.dk>
 <20181025211039.11559-9-axboe@kernel.dk>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <d7903792-ecba-3627-3115-ce0e71652a67@suse.de>
Date: Mon, 29 Oct 2018 07:48:11 +0100
MIME-Version: 1.0
In-Reply-To: <20181025211039.11559-9-axboe@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 10/25/18 11:10 PM, Jens Axboe wrote:
> Cc: linux-scsi@vger.kernel.org
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>   Documentation/scsi/scsi-parameters.txt |   5 -
>   drivers/scsi/Kconfig                   |  12 -
>   drivers/scsi/cxlflash/main.c           |   6 -
>   drivers/scsi/hosts.c                   |  29 +-
>   drivers/scsi/lpfc/lpfc_scsi.c          |   2 +-
>   drivers/scsi/qedi/qedi_main.c          |   3 +-
>   drivers/scsi/qla2xxx/qla_os.c          |  30 +-
>   drivers/scsi/scsi.c                    |   5 +-
>   drivers/scsi/scsi_debug.c              |   3 +-
>   drivers/scsi/scsi_error.c              |   2 +-
>   drivers/scsi/scsi_lib.c                | 624 ++-----------------------
>   drivers/scsi/scsi_priv.h               |   1 -
>   drivers/scsi/scsi_scan.c               |  10 +-
>   drivers/scsi/scsi_sysfs.c              |   8 +-
>   drivers/scsi/ufs/ufshcd.c              |   6 -
>   include/scsi/scsi_host.h               |  18 +-
>   include/scsi/scsi_tcq.h                |  14 +-
>   17 files changed, 73 insertions(+), 705 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
