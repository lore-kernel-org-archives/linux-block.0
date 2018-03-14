Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:32930 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751348AbeCNToE (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Mar 2018 15:44:04 -0400
Date: Wed, 14 Mar 2018 15:44:01 -0400
From: Mike Snitzer <snitzer@redhat.com>
To: Steffen Maier <maier@linux.vnet.ibm.com>
Cc: dm-devel@redhat.com, Mikulas Patocka <mpatocka@redhat.com>,
        linux-block@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Hannes Reinecke <hare@suse.com>, linux-s390@vger.kernel.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Fedor Loshakov <loshakov@linux.vnet.ibm.com>
Subject: Re: dm mpath: fix passing integrity data
Message-ID: <20180314194401.GA9609@redhat.com>
References: <20180314143306.98405-1-maier@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180314143306.98405-1-maier@linux.vnet.ibm.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Wed, Mar 14 2018 at 10:33am -0400,
Steffen Maier <maier@linux.vnet.ibm.com> wrote:

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

Thanks, I've queued this for 4.16-rc6, will send to Linus tomorrow.
