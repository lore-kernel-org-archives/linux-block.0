Return-Path: <sagigrim@gmail.com>
Return-Path: <sagigrim@gmail.com>
Subject: Re: [PATCH rfc 3/5] irq_poll: wire up irq_am
To: Bart Van Assche <Bart.VanAssche@wdc.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Cc: "hch@lst.de" <hch@lst.de>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
 "idanb@mellanox.com" <idanb@mellanox.com>, "axboe@kernel.dk"
 <axboe@kernel.dk>
References: <20180205220316.30236-1-sagi@grimberg.me>
 <20180205220316.30236-4-sagi@grimberg.me> <1518053304.2870.95.camel@wdc.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <5d0abc5a-5b5d-33d2-954c-3ec92272b99f@grimberg.me>
Date: Mon, 12 Feb 2018 21:40:52 +0200
MIME-Version: 1.0
In-Reply-To: <1518053304.2870.95.camel@wdc.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

Hey Bart,

>> +void irq_poll_init_am(struct irq_poll *iop, unsigned int nr_events,
>> +        unsigned short nr_levels, unsigned short start_level, irq_poll_am_fn *amfn)
>> +{
>> +	iop->amfn = amfn;
>> +	irq_am_init(&iop->am, nr_events, nr_levels, start_level, irq_poll_am);
>> +}
> 
> This function has a large number of parameters and most of them are passed verbatim to
> irq_am_init(). Please consider to introduce a structure for these parameters such that
> the number of function arguments stays reasonable.

I can definitely change that.
