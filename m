Return-Path: <yyt168@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20170928155315.GK8463@localhost.localdomain>
References: <20170925134031.10548-1-hch@lst.de> <20170925134031.10548-9-hch@lst.de>
 <20170928155315.GK8463@localhost.localdomain>
From: Tony Yang <yyt168@gmail.com>
Date: Fri, 29 Sep 2017 22:21:53 +0800
Message-ID: <CADL4p-rbv8eH0UYjPkA2oTNafZgv16k0rmJEcj2=jz7yyYf8KA@mail.gmail.com>
Subject: Re: [PATCH 8/9] nvme: implement multipath access to nvme subsystems
To: Keith Busch <keith.busch@intel.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

Hi, All

     Because my environment requirements, the kernel must use 4.8.17,
I would like to ask, how to use the kernel 4.8.17 nvme multi-path?
Because I see support for multi-path versions are above 4.13

Expect everyone's help, thank you very much

2017-09-28 23:53 GMT+08:00 Keith Busch <keith.busch@intel.com>:
> On Mon, Sep 25, 2017 at 03:40:30PM +0200, Christoph Hellwig wrote:
>> The new block devices nodes for multipath access will show up as
>>
>>       /dev/nvm-subXnZ
>
> Just thinking ahead ... Once this goes in, someone will want to boot their
> OS from a multipath target. It was a pain getting installers to recognize
> /dev/nvmeXnY as an install destination. I'm not sure if installers have
> gotten any better in the last 5 years about recognizing new block names.
>
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
