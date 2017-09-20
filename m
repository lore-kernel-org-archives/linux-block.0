Return-Path: <jthumshirn@suse.de>
Date: Wed, 20 Sep 2017 10:15:45 +0200
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Tony Yang <yyt168@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 9/9] nvme: implement multipath access to nvme subsystems
Message-ID: <20170920081545.p2a6x4qar3zbz4kw@linux-x5ow.site>
References: <20170918231453.27128-1-hch@lst.de>
 <20170918231453.27128-10-hch@lst.de>
 <CADL4p-pcUCoibEWxfFeLHoYhsM3nuSedoe2QTK-ahys+1+TXbg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <CADL4p-pcUCoibEWxfFeLHoYhsM3nuSedoe2QTK-ahys+1+TXbg@mail.gmail.com>
List-ID: <linux-block@vger.kernel.org>

On Wed, Sep 20, 2017 at 08:18:41AM +0800, Tony Yang wrote:
> Hi , Christoph
> 
>      I use the above code to recompile the kernel. The following error
> occurred. I can't find the blk_steal_bios function. What's the reason
> for that? Hope to get your help, thank you

Hi Ton,

have you puled it from Christoph's git? I just did a git pull and it builds
fine.

Byte,
	Johannes
-- 
Johannes Thumshirn                                          Storage
jthumshirn@suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N�rnberg
GF: Felix Imend�rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N�rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
