Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-sn1nam02on0065.outbound.protection.outlook.com ([104.47.36.65]:46322
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1030255AbdDSSEY (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Apr 2017 14:04:24 -0400
Subject: Re: [PATCH] lightnvm: assume 64-bit lba numbers
To: Arnd Bergmann <arnd@arndb.de>, Matias Bjorling <mb@lightnvm.io>
References: <20170419173931.3902058-1-arnd@arndb.de>
CC: =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <jg@lightnvm.io>,
        Jens Axboe <axboe@fb.com>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <matias@cnexlabs.com>
Message-ID: <0c7f0894-4817-09c4-93b9-8158bbc6a562@cnexlabs.com>
Date: Wed, 19 Apr 2017 20:04:13 +0200
MIME-Version: 1.0
In-Reply-To: <20170419173931.3902058-1-arnd@arndb.de>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 04/19/2017 07:39 PM, Arnd Bergmann wrote:
> The driver uses both u64 and sector_t to refer to offsets, and assigns between the
> two. This causes one harmless warning when sector_t is 32-bit:
>
> drivers/lightnvm/pblk-rb.c: In function 'pblk_rb_write_entry_gc':
> include/linux/lightnvm.h:215:20: error: large integer implicitly truncated to unsigned type [-Werror=overflow]
> drivers/lightnvm/pblk-rb.c:324:22: note: in expansion of macro 'ADDR_EMPTY'
>
> As the driver is already doing this inconsistently, changing the type
> won't make it worse and is an easy way to avoid the warning.
>
> Fixes: a4bd217b4326 ("lightnvm: physical block device (pblk) target")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/lightnvm/pblk.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/lightnvm/pblk.h b/drivers/lightnvm/pblk.h
> index c82120ce3be5..11ed7d83f572 100644
> --- a/drivers/lightnvm/pblk.h
> +++ b/drivers/lightnvm/pblk.h
> @@ -119,7 +119,7 @@ struct pblk_w_ctx {
>  	struct bio_list bios;		/* Original bios - used for completion
>  					 * in REQ_FUA, REQ_FLUSH case
>  					 */
> -	sector_t lba;			/* Logic addr. associated with entry */
> +	u64 lba;			/* Logic addr. associated with entry */
>  	struct ppa_addr ppa;		/* Physic addr. associated with entry */
>  	int flags;			/* Write context flags */
>  };
>

Thanks Arnd. Jens, could you pick this up? Thank you
