Return-Path: <hare@suse.de>
Subject: Re: [PATCH v2] sd: Check for unaligned partial completion
To: Damien Le Moal <damien.lemoal@wdc.com>, Jens Axboe <axboe@kernel.dk>
References: <20170214090049.29910-1-damien.lemoal@wdc.com>
Cc: linux-block@vger.kernel.org, Shaun Tancheff <shaun@tancheff.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <e6e85814-66ae-7b59-47f7-a48fdff5a3f4@suse.de>
Date: Tue, 14 Feb 2017 10:08:14 +0100
MIME-Version: 1.0
In-Reply-To: <20170214090049.29910-1-damien.lemoal@wdc.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 02/14/2017 10:00 AM, Damien Le Moal wrote:
> Commit "mpt3sas: Force request partial completion alignment" was not
> considering the case of REQ_TYPE_FS commands not operating on sector
> size units (e.g. REQ_OP_ZONE_REPORT and its 64B aligned partial
> replies). This could result is incorrectly retrying (forever) those
> commands.
> 
> Move the partial completion alignement check of mpt3sas to sd_done so
> that the check comes after good_bytes & resid corrections of done in
> that function depending on the request command to avoid false positive.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> ---
>  drivers/scsi/mpt3sas/mpt3sas_scsih.c | 15 ---------------
>  drivers/scsi/sd.c                    | 20 ++++++++++++++++++++
>  2 files changed, 20 insertions(+), 15 deletions(-)
> 
And indeed, I like this version far better than the mpt3sas-specific one.

Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: F. Imend�rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N�rnberg)
