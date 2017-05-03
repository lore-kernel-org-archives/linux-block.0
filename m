Return-Path: <Bart.VanAssche@sandisk.com>
From: Bart Van Assche <Bart.VanAssche@sandisk.com>
To: "linux@armlinux.org.uk" <linux@armlinux.org.uk>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "jack@suse.cz" <jack@suse.cz>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"zhaohongjiang@huawei.com" <zhaohongjiang@huawei.com>, "yanaijie@huawei.com"
	<yanaijie@huawei.com>, "axboe@kernel.dk" <axboe@kernel.dk>,
	"miaoxie@huawei.com" <miaoxie@huawei.com>
Subject: Re: [PATCH] ARM: Fix rd_size declaration
Date: Wed, 3 May 2017 19:38:17 +0000
Message-ID: <1493840295.3901.32.camel@sandisk.com>
References: <20170417231003.7178-1-bart.vanassche@sandisk.com>
	 <1493239894.2632.15.camel@sandisk.com>
	 <20170503192541.GE22219@n2100.armlinux.org.uk>
In-Reply-To: <20170503192541.GE22219@n2100.armlinux.org.uk>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Wed, 2017-05-03 at 20:25 +0100, Russell King - ARM Linux wrote:
> There were comments on the patch which seemed to be unresolved.

Do you mean the header guard? That's easy to resolve.

> However, it would be nice if rd_size could go with some other related
> declarations somewhere (if there are any.)

Sorry but I don't know about any other declarations that should be moved
into a brd header file.

Bart.=
