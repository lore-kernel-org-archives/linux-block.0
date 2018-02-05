Return-Path: <sagigrim@gmail.com>
Return-Path: <sagigrim@gmail.com>
Subject: Re: [PATCH 05/24] ibtrs: client: main functionality
To: Roman Penyaev <roman.penyaev@profitbricks.com>,
 Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 "danil.kipnis@profitbricks.com" <danil.kipnis@profitbricks.com>,
 "hch@infradead.org" <hch@infradead.org>,
 "ogerlitz@mellanox.com" <ogerlitz@mellanox.com>,
 "jinpu.wang@profitbricks.com" <jinpu.wang@profitbricks.com>,
 "axboe@kernel.dk" <axboe@kernel.dk>
References: <20180202140904.2017-1-roman.penyaev@profitbricks.com>
 <20180202140904.2017-6-roman.penyaev@profitbricks.com>
 <1517590473.2675.21.camel@wdc.com>
 <CAJrWOzD0YXWGCpR+BTOAJ7HhuVG_cjuomBK7vpGeTYu3H+DE4w@mail.gmail.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <f0c64f7f-2870-0657-11ec-123a3e99b7a7@grimberg.me>
Date: Mon, 5 Feb 2018 16:14:43 +0200
MIME-Version: 1.0
In-Reply-To: <CAJrWOzD0YXWGCpR+BTOAJ7HhuVG_cjuomBK7vpGeTYu3H+DE4w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>


> Indeed, seems sbitmap can be reused.
> 
> But tags is a part of IBTRS, and is not related to block device at all.  One
> IBTRS connection (session) handles many block devices

we use host shared tag sets for the case of multiple block devices.

> (or any IO producers).

Lets wait until we actually have this theoretical non-block IO
producers..

> With a tag you get a free slot of a buffer where you can read/write, so once
> you've allocated a tag you won't sleep on IO path inside a library.

Same for block tags (given that you don't set the request queue
otherwise)

> Also tag
> helps a lot on IO fail-over to another connection (multipath implementation,
> which is also a part of the transport library, not a block device), where you
> simply reuse the same buffer slot (with a tag in your hands) forwarding IO to
> another RDMA connection.

What is the benefit of this detached architecture? IMO, one reason why
you ended up not reusing a lot of the infrastructure is yielded from the
attempt to support a theoretical different consumer that is not ibnbd.
Did you actually had plans for any other consumers?

Personally, I think you will be much better off with a unified approach
for your block device implementation.
