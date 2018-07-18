Return-Path: <keith.busch@linux.intel.com>
Date: Wed, 18 Jul 2018 15:33:21 -0600
From: Keith Busch <keith.busch@linux.intel.com>
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "hch@lst.de" <hch@lst.de>,
	"keith.busch@intel.com" <keith.busch@intel.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"ming.lei@redhat.com" <ming.lei@redhat.com>
Subject: Re: [RFC PATCH 3/3] blk-mq: Remove generation seqeunce
Message-ID: <20180718213321.GC32160@localhost.localdomain>
References: <20180713154346.GA18955@localhost.localdomain>
 <a32b251bd3c0a186e5c5ba82656a85fbdcc0c5e4.camel@wdc.com>
 <20180713184712.GA19419@localhost.localdomain>
 <291a13b35af1b65fbbe99a3a9cfc7d570a620cd9.camel@wdc.com>
 <20180713235807.GA19967@localhost.localdomain>
 <20180718195650.GA20336@lst.de>
 <20180718205321.GA32160@localhost.localdomain>
 <c67f3da64914a436bc76f3ec0bc261ee6178cd14.camel@wdc.com>
 <20180718211711.GB32160@localhost.localdomain>
 <3f0f26c5503bbe3c3222129d758aa2f85c14fb45.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3f0f26c5503bbe3c3222129d758aa2f85c14fb45.camel@wdc.com>
List-ID: <linux-block@vger.kernel.org>

On Wed, Jul 18, 2018 at 09:30:11PM +0000, Bart Van Assche wrote:
> On Wed, 2018-07-18 at 15:17 -0600, Keith Busch wrote:
> > There are not that many blk-mq drivers, so we can go through them all.
> 
> I'm not sure that's the right approach. I think it is the responsibility of
> the block layer to handle races between completion handling and timeout
> handling and that this is not the responsibility of e.g. a block driver. If
> you look at e.g. the legacy block layer then you will see that it takes care
> of this race and that legacy block drivers do not have to worry about this
> race.

Reverting doesn't handle the race at all. It just ignores completions
and puts the responsibility on the drivers to handle the race because
that's what scsi wants to happen.
