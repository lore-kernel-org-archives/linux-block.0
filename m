Return-Path: <hch@lst.de>
Date: Tue, 13 Mar 2018 17:36:20 +0100
From: "hch@lst.de" <hch@lst.de>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "hch@lst.de" <hch@lst.de>, "axboe@kernel.dk" <axboe@kernel.dk>,
	"jiufei.xue@linux.alibaba.com" <jiufei.xue@linux.alibaba.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH v2] block: bio_check_eod() needs to consider partition
Message-ID: <20180313163620.GA12392@lst.de>
References: <20180313091819.26881-1-hch@lst.de> <7c4181b7-788f-bf90-8397-c09beceedcb7@kernel.dk> <1520958339.2638.8.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1520958339.2638.8.camel@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Tue, Mar 13, 2018 at 04:25:40PM +0000, Bart Van Assche wrote:
> On Tue, 2018-03-13 at 07:49 -0700, Jens Axboe wrote:
> > On 3/13/18 2:18 AM, Christoph Hellwig wrote:
> > > bio_check_eod() should check partiton size not the whole disk if
> > > bio->bi_partno is non-zero.  Does this by taking the call to bio_check_eod
> > > into blk_partition_remap.
> > 
> > Applied, thanks.
> 
> Hello Christoph and Jens,
> 
> I think that this patch introduces a severe regression: with this patch applied
> a VM that I use for kernel testing doesn't boot anymore. If I revert this patch
> that VM boots fine again. This is what I see on the serial console with this
> patch applied:

Ok, please revert this for now.  I'm off for today and will look into
it tomorrow.
