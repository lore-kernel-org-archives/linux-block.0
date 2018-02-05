Return-Path: <danil.kipnis@profitbricks.com>
MIME-Version: 1.0
In-Reply-To: <40a7fc35-f86c-1d9d-f057-e5822708fc32@grimberg.me>
References: <20180202140904.2017-1-roman.penyaev@profitbricks.com>
 <1517591106.2675.28.camel@sandisk.com> <CAMGffEkhqR9Z5bkMfnVn8an2OUM8k+jYoR5EFdtv3k9en1bh=w@mail.gmail.com>
 <40a7fc35-f86c-1d9d-f057-e5822708fc32@grimberg.me>
From: Danil Kipnis <danil.kipnis@profitbricks.com>
Date: Mon, 5 Feb 2018 14:38:00 +0100
Message-ID: <CAHg0HuxawAjCf711gkKKiQbbLskNsvUDhP+m32oiGFsY2BRz5g@mail.gmail.com>
Subject: Re: [PATCH 00/24] InfiniBand Transport (IBTRS) and Network Block
 Device (IBNBD)
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Jinpu Wang <jinpu.wang@profitbricks.com>, Bart Van Assche <Bart.VanAssche@wdc.com>,
	"roman.penyaev@profitbricks.com" <roman.penyaev@profitbricks.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, "hch@infradead.org" <hch@infradead.org>,
	"ogerlitz@mellanox.com" <ogerlitz@mellanox.com>, "axboe@kernel.dk" <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

>
>> Hi Bart,
>>
>> My another 2 cents:)
>> On Fri, Feb 2, 2018 at 6:05 PM, Bart Van Assche <Bart.VanAssche@wdc.com>
>> wrote:
>>>
>>> On Fri, 2018-02-02 at 15:08 +0100, Roman Pen wrote:
>>>>
>>>> o Simple configuration of IBNBD:
>>>>     - Server side is completely passive: volumes do not need to be
>>>>       explicitly exported.
>>>
>>>
>>> That sounds like a security hole? I think the ability to configure
>>> whether or
>>> not an initiator is allowed to log in is essential and also which volumes
>>> an
>>> initiator has access to.
>>
>> Our design target for well controlled production environment, so
>> security is handle in other layer.
>
>
> What will happen to a new adopter of the code you are contributing?

Hi Sagi, Hi Bart,
thanks for your feedback.
We considered the "storage cluster" setup, where each ibnbd client has
access to each ibnbd server. Each ibnbd server manages devices under
his "dev_search_path" and can provide access to them to any ibnbd
client in the network. On top of that Ibnbd server has an additional
"artificial" restriction, that a device can be mapped in writable-mode
by only one client at once.

-- 
Danil
