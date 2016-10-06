Return-Path: <hare@suse.de>
Subject: Re: [PATCH v2 2/2] block: Add iocontext priority to request
To: Adam Manzanares <adam.manzanares@hgst.com>, axboe@kernel.dk, tj@kernel.org
References: <1475694007-11999-1-git-send-email-adam.manzanares@hgst.com>
 <1475694007-11999-3-git-send-email-adam.manzanares@hgst.com>
Cc: linux-block@vger.kernel.org, linux-ide@vger.kernel.org
From: Hannes Reinecke <hare@suse.de>
Message-ID: <5e96d531-8636-8e63-0ea8-e134676109c2@suse.de>
Date: Thu, 6 Oct 2016 08:24:54 +0200
MIME-Version: 1.0
In-Reply-To: <1475694007-11999-3-git-send-email-adam.manzanares@hgst.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 10/05/2016 09:00 PM, Adam Manzanares wrote:
> Patch adds an association between iocontext ioprio and the ioprio of
> a request. This feature is only enabled if a queue flag is set to
> indicate that requests should have ioprio associated with them. The
> queue flag is exposed as the req_prio queue sysfs entry.
>
> Signed-off-by: Adam Mananzanares <adam.manzanares@hgst.com>
> ---
>  block/blk-core.c       |  8 +++++++-
>  block/blk-sysfs.c      | 32 ++++++++++++++++++++++++++++++++
>  include/linux/blkdev.h |  2 ++
>  3 files changed, 41 insertions(+), 1 deletion(-)
>
As the previous patch depends on this one it should actually be the 
first in the series.

But other than that:

Reviewed-by: Hannes Reinecke <hare@xuse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		      zSeries & Storage
hare@suse.de			      +49 911 74053 688
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: J. Hawn, J. Guild, F. Imend�rffer, HRB 16746 (AG N�rnberg)
