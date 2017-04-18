Return-Path: <jthumshirn@suse.de>
Date: Tue, 18 Apr 2017 16:10:50 +0200
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Bart Van Assche <Bart.VanAssche@sandisk.com>
Cc: "zhaohongjiang@huawei.com" <zhaohongjiang@huawei.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"yanaijie@huawei.com" <yanaijie@huawei.com>,
	"miaoxie@huawei.com" <miaoxie@huawei.com>,
	"jack@suse.cz" <jack@suse.cz>
Subject: Re: [PATCH] ARM: Fix rd_size declaration
Message-ID: <20170418141050.GG6056@linux-x5ow.site>
References: <20170417231003.7178-1-bart.vanassche@sandisk.com>
 <20170418073526.GA6056@linux-x5ow.site>
 <1492524472.2628.3.camel@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1492524472.2628.3.camel@sandisk.com>
List-ID: <linux-block@vger.kernel.org>

On Tue, Apr 18, 2017 at 02:07:53PM +0000, Bart Van Assche wrote:
> Hello Johannes,
> 
> Thanks for the review. But are you aware that with the current content an
> include guard is overkill because it is safe to evaluate the "extern unsigned
> long rd_size" declaration multiple times?

Yes I am. But once someone does changes to this header and forgets the include
guard as well it may cause errors.

I am aware that this is rather cosmetic than needed, that's why I declared it
as a nit.

Byte,
	Johannes

-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: Felix Imend�rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N�rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
