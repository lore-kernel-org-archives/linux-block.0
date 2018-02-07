Return-Path: <roman.penyaev@profitbricks.com>
MIME-Version: 1.0
In-Reply-To: <20180206161005.GE10095@ziepe.ca>
References: <20180202140904.2017-1-roman.penyaev@profitbricks.com>
 <20180202140904.2017-4-roman.penyaev@profitbricks.com> <b706bb5f-b317-fc3a-8ada-066a2a26e9ce@grimberg.me>
 <CAJrWOzC7f8T3gLAyywx2yY-UFrN+SO1Eb99jtRnB58dr7XdXxg@mail.gmail.com> <20180206161005.GE10095@ziepe.ca>
From: Roman Penyaev <roman.penyaev@profitbricks.com>
Date: Wed, 7 Feb 2018 11:34:52 +0100
Message-ID: <CAJrWOzCT581UagL=FwwukOam4kCsc-9cLs3vmpzqF67Tn7QyzA@mail.gmail.com>
Subject: Re: [PATCH 03/24] ibtrs: core: lib functions shared between client
 and server modules
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
	linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@infradead.org>, Bart Van Assche <bart.vanassche@sandisk.com>,
	Or Gerlitz <ogerlitz@mellanox.com>, Danil Kipnis <danil.kipnis@profitbricks.com>,
	Jack Wang <jinpu.wang@profitbricks.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Tue, Feb 6, 2018 at 5:10 PM, Jason Gunthorpe <jgg@ziepe.ca> wrote:
> On Tue, Feb 06, 2018 at 01:01:23PM +0100, Roman Penyaev wrote:
>
>> >> +static int ibtrs_ib_dev_init(struct ibtrs_ib_dev *d, struct ib_device
>> >> *dev)
>> >> +{
>> >> +       int err;
>> >> +
>> >> +       d->pd = ib_alloc_pd(dev, IB_PD_UNSAFE_GLOBAL_RKEY);
>> >> +       if (IS_ERR(d->pd))
>> >> +               return PTR_ERR(d->pd);
>> >> +       d->dev = dev;
>> >> +       d->lkey = d->pd->local_dma_lkey;
>> >> +       d->rkey = d->pd->unsafe_global_rkey;
>> >> +
>> >> +       err = ibtrs_query_device(d);
>> >> +       if (unlikely(err))
>> >> +               ib_dealloc_pd(d->pd);
>> >> +
>> >> +       return err;
>> >> +}
>> >
>> >
>> > I must say that this makes me frustrated.. We stopped doing these
>> > sort of things long time ago. No way we can even consider accepting
>> > the unsafe use of the global rkey exposing the entire memory space for
>> > remote access permissions.
>> >
>> > Sorry for being blunt, but this protocol design which makes a concious
>> > decision to expose unconditionally is broken by definition.
>>
>> I suppose we can also afford the same trick which nvme does: provide
>> register_always module argument, can we?  That can be also interesting
>> to measure the performance difference.
>
> I can be firmer than Sagi - new code that has IB_PD_UNSAFE_GLOBAL_RKEY
> at can not be accepted upstream.
>
> Once you get that fixed, you should go and read my past comments on
> how to properly order dma mapping and completions and fix that
> too. Then redo your performance..

Clear.

--
Roman
