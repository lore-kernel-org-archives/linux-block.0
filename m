Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "linux@armlinux.org.uk" <linux@armlinux.org.uk>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "jack@suse.cz" <jack@suse.cz>,
	"zhaohongjiang@huawei.com" <zhaohongjiang@huawei.com>, "yanaijie@huawei.com"
	<yanaijie@huawei.com>, "axboe@kernel.dk" <axboe@kernel.dk>,
	"miaoxie@huawei.com" <miaoxie@huawei.com>
Subject: Re: [PATCH] ARM: Fix rd_size declaration
Date: Wed, 26 Apr 2017 20:51:35 +0000
Message-ID: <1493239894.2632.15.camel@sandisk.com>
References: <20170417231003.7178-1-bart.vanassche@sandisk.com>
In-Reply-To: <20170417231003.7178-1-bart.vanassche@sandisk.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Mon, 2017-04-17 at 16:10 -0700, Bart Van Assche wrote:
> The global variable 'rd_size' is declared as 'int' in source file
> arch/arm/kernel/atags_parse.c and as 'unsigned long' in
> drivers/block/brd.c. Fix this inconsistency.
> [ ... ]

Hello Russell,

Have I sent this patch to the right maintainer?

Thanks,

Bart.=
