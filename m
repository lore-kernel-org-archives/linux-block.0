Return-Path: <jinpu.wang@profitbricks.com>
MIME-Version: 1.0
In-Reply-To: <03bc01d2a4a9$b8b69f10$2a23dd30$@opengridcomputing.com>
References: <1490352343-20075-1-git-send-email-jinpu.wangl@profitbricks.com> <03bc01d2a4a9$b8b69f10$2a23dd30$@opengridcomputing.com>
From: Jinpu Wang <jinpu.wang@profitbricks.com>
Date: Fri, 24 Mar 2017 15:37:02 +0100
Message-ID: <CAMGffEmhPj4dz4vAR4p2u8=vt+j4gkLRGLpsCgM2mgQ0jYAcww@mail.gmail.com>
Subject: Re: [RFC PATCH 00/28] INFINIBAND NETWORK BLOCK DEVICE (IBNBD)
To: Steve Wise <swise@opengridcomputing.com>
Cc: linux-block@vger.kernel.org,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, Doug Ledford <dledford@redhat.com>,
	Jens Axboe <axboe@kernel.dk>, hch <hch@lst.de>, Fabian Holler <mail@fholler.de>,
	Milind Dumbare <Milind.dumbare@gmail.com>, Michael Wang <yun.wang@profitbricks.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

On Fri, Mar 24, 2017 at 3:20 PM, Steve Wise <swise@opengridcomputing.com> w=
rote:
>>
>> From: Jack Wang <jinpu.wang@profitbricks.com>
>>
>> This series introduces IBNBD/IBTRS kernel modules.
>>
>> IBNBD (InfiniBand network block device) allows for an RDMA transfer of b=
lock
> IO
>> over InfiniBand network. The driver presents itself as a block device on
> client
>> side and transmits the block requests in a zero-copy fashion to the
> server-side
>> via InfiniBand. The server part of the driver converts the incoming buff=
ers
> back
>> into BIOs and hands them down to the underlying block device. As soon as=
 IO
>> responses come back from the drive, they are being transmitted back to t=
he
>> client.
>
> Hey Jack, why is this IB specific?  Can it work over iWARP transports as =
well?
>
> Steve.
>
>
>
Hi Steve,

Because we only use IB in our production, as I replied to Bart, sorry, not =
yet.

Regards,
--=20
Jack Wang
Linux Kernel Developer

ProfitBricks GmbH
Greifswalder Str. 207
D - 10405 Berlin

Tel:       +49 30 577 008  042
Fax:      +49 30 577 008 299
Email:    jinpu.wang@profitbricks.com
URL:      https://www.profitbricks.de

Sitz der Gesellschaft: Berlin
Registergericht: Amtsgericht Charlottenburg, HRB 125506 B
Gesch=C3=A4ftsf=C3=BChrer: Achim Weiss
