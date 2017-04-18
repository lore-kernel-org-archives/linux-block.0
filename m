Return-Path: <jthumshirn@suse.de>
Date: Tue, 18 Apr 2017 09:35:26 +0200
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Russell King <linux@armlinux.org.uk>, Jens Axboe <axboe@kernel.dk>,
	Jan Kara <jack@suse.cz>, yanaijie@huawei.com,
	zhaohongjiang@huawei.com, miaoxie@huawei.com,
	linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org
Subject: Re: [PATCH] ARM: Fix rd_size declaration
Message-ID: <20170418073526.GA6056@linux-x5ow.site>
References: <20170417231003.7178-1-bart.vanassche@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20170417231003.7178-1-bart.vanassche@sandisk.com>
List-ID: <linux-block@vger.kernel.org>

On Mon, Apr 17, 2017 at 04:10:03PM -0700, Bart Van Assche wrote:
> The global variable 'rd_size' is declared as 'int' in source file
> arch/arm/kernel/atags_parse.c and as 'unsigned long' in
> drivers/block/brd.c. Fix this inconsistency.
> 
> Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: Jan Kara <jack@suse.cz>
> Cc: <yanaijie@huawei.com>
> Cc: <zhaohongjiang@huawei.com>
> Cc: <miaoxie@huawei.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-block@vger.kernel.org
> ---
> diff --git a/include/linux/brd.h b/include/linux/brd.h
> new file mode 100644
> index 000000000000..dbb0f92fefc8
> --- /dev/null
> +++ b/include/linux/brd.h
> @@ -0,0 +1 @@
> +extern unsigned long rd_size;

Small nit, can you add an include guard here as well?

Thanks,
	Johannes

-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: Felix Imend�rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N�rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
