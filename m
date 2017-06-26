Return-Path: <linux+axboe=kernel.dk@armlinux.org.uk>
Date: Mon, 26 Jun 2017 10:38:41 +0100
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "zhaohongjiang@huawei.com" <zhaohongjiang@huawei.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"yanaijie@huawei.com" <yanaijie@huawei.com>,
	"miaoxie@huawei.com" <miaoxie@huawei.com>,
	"jack@suse.cz" <jack@suse.cz>
Subject: Re: [PATCH] ARM: Fix rd_size declaration
Message-ID: <20170626093841.GF4902@n2100.armlinux.org.uk>
References: <20170503194600.16089-1-bart.vanassche@sandisk.com>
 <1498076766.26050.1.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1498076766.26050.1.camel@wdc.com>
Sender: Russell King - ARM Linux <linux@armlinux.org.uk>
List-ID: <linux-block@vger.kernel.org>

On Wed, Jun 21, 2017 at 08:26:07PM +0000, Bart Van Assche wrote:
> On Wed, 2017-05-03 at 12:46 -0700, Bart Van Assche wrote:
> > The global variable 'rd_size' is declared as 'int' in source file
> > arch/arm/kernel/atags_parse.c and as 'unsigned long' in
> > drivers/block/brd.c. Fix this inconsistency. Additionally, remove
> > the declarations of rd_image_start, rd_prompt and rd_doload from
> > parse_tag_ramdisk() since these duplicate existing declarations
> > in <linux/initrd.h>.
> 
> (replying to my own e-mail)
> 
> Hello Russell,
> 
> Did I send this patch to the right maintainer? If so, do you want to share
> any feedback about this patch?

Acked-by: Russell King <rmk+kernel@armlinux.org.uk>

I think it's fine from an ARM point of view.  It seems most of this patch
is to do with initrds, so I guess if no one else is interested in it,
akpm may pick it up.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
