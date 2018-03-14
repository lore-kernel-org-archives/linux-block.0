Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:41675 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751649AbeCNPmy (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Mar 2018 11:42:54 -0400
Subject: Re: [PATCH] dm mpath: fix passing integrity data
To: Steffen Maier <maier@linux.vnet.ibm.com>, dm-devel@redhat.com,
        Mikulas Patocka <mpatocka@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>
Cc: linux-block@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Hannes Reinecke <hare@suse.com>, linux-s390@vger.kernel.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Fedor Loshakov <loshakov@linux.vnet.ibm.com>
References: <20180314143306.98405-1-maier@linux.vnet.ibm.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <86a221de-7a22-4bcc-113f-13a96f02bfb1@suse.de>
Date: Wed, 14 Mar 2018 16:42:51 +0100
MIME-Version: 1.0
In-Reply-To: <20180314143306.98405-1-maier@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 03/14/2018 03:33 PM, Steffen Maier wrote:
> After v4.12 commit e2460f2a4bc7 ("dm: mark targets that pass integrity
> data"), dm-multipath, e.g. on DIF+DIX SCSI disk paths, does not support
> block integrity any more. So add it to the whitelist.
> 
> This is also a pre-requisite to use block integrity with other dm layer(s)
> on top of multipath, such as kpartx partitions (dm-linear) or LVM.
> 
> Signed-off-by: Steffen Maier <maier@linux.vnet.ibm.com>
> Bisected-by: Fedor Loshakov <loshakov@linux.vnet.ibm.com>
> Fixes: e2460f2a4bc7 ("dm: mark targets that pass integrity data")
> Cc: <stable@vger.kernel.org> #4.12+
> ---
>  drivers/md/dm-mpath.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/md/dm-mpath.c b/drivers/md/dm-mpath.c
> index 3fde9e9faddd..c174f0c53dc9 100644
> --- a/drivers/md/dm-mpath.c
> +++ b/drivers/md/dm-mpath.c
> @@ -2023,7 +2023,8 @@ static int multipath_busy(struct dm_target *ti)
>  static struct target_type multipath_target = {
>  	.name = "multipath",
>  	.version = {1, 12, 0},
> -	.features = DM_TARGET_SINGLETON | DM_TARGET_IMMUTABLE,
> +	.features = DM_TARGET_SINGLETON | DM_TARGET_IMMUTABLE |
> +		    DM_TARGET_PASSES_INTEGRITY,
>  	.module = THIS_MODULE,
>  	.ctr = multipath_ctr,
>  	.dtr = multipath_dtr,
> 
Ho-hum.
Thanks for this.

Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 Nürnberg
GF: F. Imendörffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG Nürnberg)
