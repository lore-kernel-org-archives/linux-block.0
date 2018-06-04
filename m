Return-Path: <danil.kipnis@profitbricks.com>
MIME-Version: 1.0
References: <20180202140904.2017-1-roman.penyaev@profitbricks.com>
 <1517591106.2675.28.camel@sandisk.com> <CAMGffEkhqR9Z5bkMfnVn8an2OUM8k+jYoR5EFdtv3k9en1bh=w@mail.gmail.com>
 <1517847408.3764.5.camel@wdc.com> <alpine.DEB.2.20.1802071031590.21957@nuc-kabylake>
 <CAJrWOzBrbV0yJvCvKxAK2Arujf7wiCx_Xoo9jdiwDRj93Lq7Yg@mail.gmail.com>
 <1518024719.2870.39.camel@wdc.com> <CAHg0HuxRz4=fhX1P3yk9sQ+q_MUXoj=062aQ9fcwP8awjm09jA@mail.gmail.com>
 <1518113395.3611.54.camel@wdc.com>
In-Reply-To: <1518113395.3611.54.camel@wdc.com>
From: Danil Kipnis <danil.kipnis@profitbricks.com>
Date: Mon, 4 Jun 2018 14:27:12 +0200
Message-ID: <CAHg0HuziOZm-+1wPwWHZirUPiPATjM1P26c4fUOiXVtTdo0qTw@mail.gmail.com>
Subject: Re: [PATCH 00/24] InfiniBand Transport (IBTRS) and Network Block
 Device (IBNBD)
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
	linux-rdma@vger.kernel.org, Roman Penyaev <roman.penyaev@profitbricks.com>,
	Jack Wang <jinpu.wang@profitbricks.com>, ogerlitz@mellanox.com,
	Sagi Grimberg <sagi@grimberg.me>, axboe@kernel.dk, cl@linux.com
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

Hi Doug,

thanks for the feedback. You read the cover letter correctly: our
transport library implements multipath (load balancing and failover)
on top of RDMA API. Its name "IBTRS" is slightly misleading in that
regard: it can sit on top of ROCE as well. The library allows for
"bundling" multiple rdma "paths" (source addr - destination addr pair)
into one "session". So our session consists of one or more paths and
each path under the hood consists of as many QPs (each connecting
source with destination) as there are CPUs on the client system. The
user load (In our case IBNBD is a block device and generates some
block requests) is load-balanced on per cpu-basis.
I understand, this is something very different to what smc-r is doing.
Am I right? Do you know what stage MP-RDMA development currently is?

Best,

Danil Kipnis.

P.S. Sorry for the duplicate if any, first mail was returned cause of html.

On Thu, Feb 8, 2018 at 7:10 PM Bart Van Assche <Bart.VanAssche@wdc.com> wro=
te:
>
> On Thu, 2018-02-08 at 18:38 +0100, Danil Kipnis wrote:
> > thanks for the link to the article. To the best of my understanding,
> > the guys suggest to authenticate the devices first and only then
> > authenticate the users who use the devices in order to get access to a
> > corporate service. They also mention in the presentation the current
> > trend of moving corporate services into the cloud. But I think this is
> > not about the devices from which that cloud is build of. Isn't a cloud
> > first build out of devices connected via IB and then users (and their
> > devices) are provided access to the services of that cloud as a whole?
> > If a malicious user already plugged his device into an IB switch of a
> > cloud internal infrastructure, isn't it game over anyway? Can't he
> > just take the hard drives instead of mapping them?
>
> Hello Danil,
>
> It seems like we each have been focussing on different aspects of the art=
icle.
> The reason I referred to that article is because I read the following in
> that article: "Unlike the conventional perimeter security model, BeyondCo=
rp
> doesn=E2=80=99t gate access to services and tools based on a user=E2=80=
=99s physical location
> or the originating network [ ... ] The zero trust architecture spells tro=
uble
> for traditional attacks that rely on penetrating a tough perimeter to wal=
tz
> freely within an open internal network." Suppose e.g. that an organizatio=
n
> decides to use RoCE or iWARP for connectivity between block storage initi=
ator
> systems and block storage target systems and that it has a single company=
-
> wide Ethernet network. If the target system does not restrict access base=
d
> on initiator IP address then any penetrator would be able to access all t=
he
> block devices exported by the target after a SoftRoCE or SoftiWARP initia=
tor
> driver has been loaded. If the target system however restricts access bas=
ed
> on the initiator IP address then that would make it harder for a penetrat=
or
> to access the exported block storage devices. Instead of just penetrating=
 the
> network access, IP address spoofing would have to be used or access would
> have to be obtained to a system that has been granted access to the targe=
t
> system.
>
> Thanks,
>
> Bart.
>
>


--=20
Danil Kipnis
Linux Kernel Developer
