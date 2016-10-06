Return-Path: <hare@suse.de>
Subject: Re: [PATCH v2 1/2] ata: Enabling ATA Command Priorities
To: Adam Manzanares <adam.manzanares@hgst.com>, axboe@kernel.dk, tj@kernel.org
References: <1475694007-11999-1-git-send-email-adam.manzanares@hgst.com>
 <1475694007-11999-2-git-send-email-adam.manzanares@hgst.com>
Cc: linux-block@vger.kernel.org, linux-ide@vger.kernel.org
From: Hannes Reinecke <hare@suse.de>
Message-ID: <17c2ca01-0144-fc7d-1024-5f9cff3cd6ee@suse.de>
Date: Thu, 6 Oct 2016 08:23:27 +0200
MIME-Version: 1.0
In-Reply-To: <1475694007-11999-2-git-send-email-adam.manzanares@hgst.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 10/05/2016 09:00 PM, Adam Manzanares wrote:
> This patch checks to see if an ATA device supports NCQ command priorities.
> If so and the user has specified an iocontext that indicates IO_PRIO_CLASS_RT
> and also enables request priorities in the block queue then we build a tf
> with a high priority command.
>
> This patch depends on patch block-Add-iocontext-priority-to-request
>
> Signed-off-by: Adam Manzanares <adam.manzanares@hgst.com>
> ---
>  drivers/ata/libata-core.c | 35 ++++++++++++++++++++++++++++++++++-
>  drivers/ata/libata-scsi.c | 10 +++++++++-
>  drivers/ata/libata.h      |  2 +-
>  include/linux/ata.h       |  6 ++++++
>  include/linux/libata.h    | 18 ++++++++++++++++++
>  5 files changed, 68 insertions(+), 3 deletions(-)
>
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		      zSeries & Storage
hare@suse.de			      +49 911 74053 688
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: J. Hawn, J. Guild, F. Imend�rffer, HRB 16746 (AG N�rnberg)
