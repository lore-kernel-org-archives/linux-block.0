Return-Path: <danil.kipnis@profitbricks.com>
MIME-Version: 1.0
In-Reply-To: <1518024719.2870.39.camel@wdc.com>
References: <20180202140904.2017-1-roman.penyaev@profitbricks.com>
 <1517591106.2675.28.camel@sandisk.com> <CAMGffEkhqR9Z5bkMfnVn8an2OUM8k+jYoR5EFdtv3k9en1bh=w@mail.gmail.com>
 <1517847408.3764.5.camel@wdc.com> <alpine.DEB.2.20.1802071031590.21957@nuc-kabylake>
 <CAJrWOzBrbV0yJvCvKxAK2Arujf7wiCx_Xoo9jdiwDRj93Lq7Yg@mail.gmail.com> <1518024719.2870.39.camel@wdc.com>
From: Danil Kipnis <danil.kipnis@profitbricks.com>
Date: Thu, 8 Feb 2018 18:38:21 +0100
Message-ID: <CAHg0HuxRz4=fhX1P3yk9sQ+q_MUXoj=062aQ9fcwP8awjm09jA@mail.gmail.com>
Subject: Re: [PATCH 00/24] InfiniBand Transport (IBTRS) and Network Block
 Device (IBNBD)
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "roman.penyaev@profitbricks.com" <roman.penyaev@profitbricks.com>, "cl@linux.com" <cl@linux.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "hch@infradead.org" <hch@infradead.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"jinpu.wang@profitbricks.com" <jinpu.wang@profitbricks.com>, "sagi@grimberg.me" <sagi@grimberg.me>,
	"ogerlitz@mellanox.com" <ogerlitz@mellanox.com>, "axboe@kernel.dk" <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Wed, Feb 7, 2018 at 6:32 PM, Bart Van Assche <Bart.VanAssche@wdc.com> wrote:
> On Wed, 2018-02-07 at 18:18 +0100, Roman Penyaev wrote:
>> So the question is: are there real life setups where
>> some of the local IB network members can be untrusted?
>
> Hello Roman,
>
> You may want to read more about the latest evolutions with regard to network
> security. An article that I can recommend is the following: "Google reveals
> own security regime policy trusts no network, anywhere, ever"
> (https://www.theregister.co.uk/2016/04/06/googles_beyondcorp_security_policy/).
>
> If data-centers would start deploying RDMA among their entire data centers
> (maybe they are already doing this) then I think they will want to restrict
> access to block devices to only those initiator systems that need it.
>
> Thanks,
>
> Bart.
>
>

Hi Bart,

thanks for the link to the article. To the best of my understanding,
the guys suggest to authenticate the devices first and only then
authenticate the users who use the devices in order to get access to a
corporate service. They also mention in the presentation the current
trend of moving corporate services into the cloud. But I think this is
not about the devices from which that cloud is build of. Isn't a cloud
first build out of devices connected via IB and then users (and their
devices) are provided access to the services of that cloud as a whole?
If a malicious user already plugged his device into an IB switch of a
cloud internal infrastructure, isn't it game over anyway? Can't he
just take the hard drives instead of mapping them?

Thanks,

Danil.
