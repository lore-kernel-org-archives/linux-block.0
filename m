Return-Path: <Bart.VanAssche@wdc.com>
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "linux@armlinux.org.uk" <linux@armlinux.org.uk>
CC: "zhaohongjiang@huawei.com" <zhaohongjiang@huawei.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "yanaijie@huawei.com"
	<yanaijie@huawei.com>, "miaoxie@huawei.com" <miaoxie@huawei.com>,
	"jack@suse.cz" <jack@suse.cz>
Subject: Re: [PATCH] ARM: Fix rd_size declaration
Date: Wed, 21 Jun 2017 20:26:07 +0000
Message-ID: <1498076766.26050.1.camel@wdc.com>
References: <20170503194600.16089-1-bart.vanassche@sandisk.com>
In-Reply-To: <20170503194600.16089-1-bart.vanassche@sandisk.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Wed, 2017-05-03 at 12:46 -0700, Bart Van Assche wrote:
> The global variable 'rd_size' is declared as 'int' in source file
> arch/arm/kernel/atags_parse.c and as 'unsigned long' in
> drivers/block/brd.c. Fix this inconsistency. Additionally, remove
> the declarations of rd_image_start, rd_prompt and rd_doload from
> parse_tag_ramdisk() since these duplicate existing declarations
> in <linux/initrd.h>.

(replying to my own e-mail)

Hello Russell,

Did I send this patch to the right maintainer? If so, do you want to share
any feedback about this patch?

Thanks,

Bart.=
