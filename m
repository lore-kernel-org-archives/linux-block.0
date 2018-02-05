Return-Path: <sagigrim@gmail.com>
Return-Path: <sagigrim@gmail.com>
Subject: Re: [PATCH 00/24] InfiniBand Transport (IBTRS) and Network Block
 Device (IBNBD)
To: Jinpu Wang <jinpu.wang@profitbricks.com>,
 Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "roman.penyaev@profitbricks.com" <roman.penyaev@profitbricks.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 "danil.kipnis@profitbricks.com" <danil.kipnis@profitbricks.com>,
 "hch@infradead.org" <hch@infradead.org>,
 "ogerlitz@mellanox.com" <ogerlitz@mellanox.com>,
 "axboe@kernel.dk" <axboe@kernel.dk>
References: <20180202140904.2017-1-roman.penyaev@profitbricks.com>
 <1517591106.2675.28.camel@sandisk.com>
 <CAMGffEkhqR9Z5bkMfnVn8an2OUM8k+jYoR5EFdtv3k9en1bh=w@mail.gmail.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <40a7fc35-f86c-1d9d-f057-e5822708fc32@grimberg.me>
Date: Mon, 5 Feb 2018 13:36:22 +0200
MIME-Version: 1.0
In-Reply-To: <CAMGffEkhqR9Z5bkMfnVn8an2OUM8k+jYoR5EFdtv3k9en1bh=w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>


> Hi Bart,
> 
> My another 2 cents:)
> On Fri, Feb 2, 2018 at 6:05 PM, Bart Van Assche <Bart.VanAssche@wdc.com> wrote:
>> On Fri, 2018-02-02 at 15:08 +0100, Roman Pen wrote:
>>> o Simple configuration of IBNBD:
>>>     - Server side is completely passive: volumes do not need to be
>>>       explicitly exported.
>>
>> That sounds like a security hole? I think the ability to configure whether or
>> not an initiator is allowed to log in is essential and also which volumes an
>> initiator has access to.
> Our design target for well controlled production environment, so
> security is handle in other layer.

What will happen to a new adopter of the code you are contributing?
