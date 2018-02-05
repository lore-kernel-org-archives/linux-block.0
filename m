Return-Path: <jinpu.wang@profitbricks.com>
MIME-Version: 1.0
In-Reply-To: <1517589637.3936.16.camel@redhat.com>
References: <20180202140904.2017-1-roman.penyaev@profitbricks.com>
 <1517587623.2675.8.camel@sandisk.com> <1517589637.3936.16.camel@redhat.com>
From: Jinpu Wang <jinpu.wang@profitbricks.com>
Date: Mon, 5 Feb 2018 09:45:15 +0100
Message-ID: <CAMGffEnPREHrsf=Nkj-K0iRbgSoUiqZ4dLo+xzMF6KYofTSQnA@mail.gmail.com>
Subject: Re: [PATCH 00/24] InfiniBand Transport (IBTRS) and Network Block
 Device (IBNBD)
To: Doug Ledford <dledford@redhat.com>, Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "roman.penyaev@profitbricks.com" <roman.penyaev@profitbricks.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"danil.kipnis@profitbricks.com" <danil.kipnis@profitbricks.com>, "hch@infradead.org" <hch@infradead.org>,
	"ogerlitz@mellanox.com" <ogerlitz@mellanox.com>, "axboe@kernel.dk" <axboe@kernel.dk>,
	"sagi@grimberg.me" <sagi@grimberg.me>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Fri, Feb 2, 2018 at 5:40 PM, Doug Ledford <dledford@redhat.com> wrote:
> On Fri, 2018-02-02 at 16:07 +0000, Bart Van Assche wrote:
>> On Fri, 2018-02-02 at 15:08 +0100, Roman Pen wrote:
>> > Since the first version the following was changed:
>> >
>> >    - Load-balancing and IO fail-over using multipath features were added.
>> >    - Major parts of the code were rewritten, simplified and overall code
>> >      size was reduced by a quarter.
>>
>> That is interesting to know, but what happened to the feedback that Sagi and
>> I provided on v1? Has that feedback been addressed? See also
>> https://www.spinics.net/lists/linux-rdma/msg47819.html and
>> https://www.spinics.net/lists/linux-rdma/msg47879.html.
>>
>> Regarding multipath support: there are already two multipath implementations
>> upstream (dm-mpath and the multipath implementation in the NVMe initiator).
>> I'm not sure we want a third multipath implementation in the Linux kernel.
>
> There's more than that.  There was also md-multipath, and smc-r includes
> another version of multipath, plus I assume we support mptcp as well.
>
> But, to be fair, the different multipaths in this list serve different
> purposes and I'm not sure they could all be generalized out and served
> by a single multipath code.  Although, fortunately, md-multipath is
> deprecated, so no need to worry about it, and it is only dm-multipath
> and nvme multipath that deal directly with block devices and assume
> block semantics.  If I read the cover letter right (and I haven't dug
> into the code to confirm this), the ibtrs multipath has much more in
> common with smc-r multipath, where it doesn't really assume a block
> layer device sits on top of it, it's more of a pure network multipath,
> which the implementation of smc-r is and mptcp would be too.  I would
> like to see a core RDMA multipath implementation soon that would
> abstract out some of these multipath tasks, at least across RDMA links,
> and that didn't have the current limitations (smc-r only supports RoCE
> links, and it sounds like ibtrs only supports IB like links, but maybe
> I'm wrong there, I haven't looked at the patches yet).
Hi Doug, hi Bart,

Thanks for your valuable input, here is my 2 cents:

IBTRS multipath is indeed a network multipath, with sysfs interface to
remove/add path dynamically.
IBTRS is built on rdma-cm, so expect to support RoCE and iWARP, but we
mainly tested in IB environment,
slightly tested on RXE.


Regards,
-- 
Jack Wang
Linux Kernel Developer
