Return-Path: <roman.penyaev@profitbricks.com>
MIME-Version: 1.0
In-Reply-To: <f0c64f7f-2870-0657-11ec-123a3e99b7a7@grimberg.me>
References: <20180202140904.2017-1-roman.penyaev@profitbricks.com>
 <20180202140904.2017-6-roman.penyaev@profitbricks.com> <1517590473.2675.21.camel@wdc.com>
 <CAJrWOzD0YXWGCpR+BTOAJ7HhuVG_cjuomBK7vpGeTYu3H+DE4w@mail.gmail.com> <f0c64f7f-2870-0657-11ec-123a3e99b7a7@grimberg.me>
From: Roman Penyaev <roman.penyaev@profitbricks.com>
Date: Mon, 5 Feb 2018 18:05:10 +0100
Message-ID: <CAJrWOzCNmYFP4GNwDtXK4xbPpOQK-K6+_UVEQeV5U9aHux8u_g@mail.gmail.com>
Subject: Re: [PATCH 05/24] ibtrs: client: main functionality
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Bart Van Assche <Bart.VanAssche@wdc.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"danil.kipnis@profitbricks.com" <danil.kipnis@profitbricks.com>, "hch@infradead.org" <hch@infradead.org>,
	"ogerlitz@mellanox.com" <ogerlitz@mellanox.com>,
	"jinpu.wang@profitbricks.com" <jinpu.wang@profitbricks.com>, "axboe@kernel.dk" <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Mon, Feb 5, 2018 at 3:14 PM, Sagi Grimberg <sagi@grimberg.me> wrote:
>
>> Indeed, seems sbitmap can be reused.
>>
>> But tags is a part of IBTRS, and is not related to block device at all.
>> One
>> IBTRS connection (session) handles many block devices
>
>
> we use host shared tag sets for the case of multiple block devices.

Unfortunately (or fortunately, depends on the indented mq design) tags are
not shared between hw_queues.  So in our case (1 session queue, N devices)
you always have to specify tags->nr_hw_queues = 1 or magic will not happen
and you will always have more tags than your session supports.  But
nr_hw_queues = 1 kills performance dramatically.  What scales well is
the following: nr_hw_queues == num_online_cpus() == number of QPs in
one session.

>> (or any IO producers).
>
>
> Lets wait until we actually have this theoretical non-block IO
> producers..
>
>> With a tag you get a free slot of a buffer where you can read/write, so
>> once
>> you've allocated a tag you won't sleep on IO path inside a library.
>
>
> Same for block tags (given that you don't set the request queue
> otherwise)
>
>> Also tag
>> helps a lot on IO fail-over to another connection (multipath
>> implementation,
>> which is also a part of the transport library, not a block device), where
>> you
>> simply reuse the same buffer slot (with a tag in your hands) forwarding IO
>> to
>> another RDMA connection.
>
>
> What is the benefit of this detached architecture?

That gives us separated rdma IO library, where ibnbd is one of the players.

> IMO, one reason why you ended up not reusing a lot of the infrastructure
> is yielded from the  attempt to support a theoretical different consumer
> that is not ibnbd.

Well, not quite.  Not using rdma api helpers (we will use it) and not
using tags from block layer (we need tags inside transport) this is not
"a lot of the infrastructure" :)

I would say that we are not fast enough to follow all kernel trends.
That is the major reason, but not other user of ibtrs.

> Did you actually had plans for any other consumers?

Yep, the major target is replicated block storage, that's why separated
transport.

> Personally, I think you will be much better off with a unified approach
> for your block device implementation.

--
Roman
