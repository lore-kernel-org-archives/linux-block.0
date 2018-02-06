Return-Path: <roman.penyaev@profitbricks.com>
MIME-Version: 1.0
In-Reply-To: <23dcfda7-eac1-ed13-b24e-3586c284ee55@grimberg.me>
References: <20180202140904.2017-1-roman.penyaev@profitbricks.com> <23dcfda7-eac1-ed13-b24e-3586c284ee55@grimberg.me>
From: Roman Penyaev <roman.penyaev@profitbricks.com>
Date: Tue, 6 Feb 2018 14:12:35 +0100
Message-ID: <CAJrWOzDmU_RWxaY+eXjZ3Az162gr9Bax8=5+1FYj4vzYDoxp7g@mail.gmail.com>
Subject: Re: [PATCH 00/24] InfiniBand Transport (IBTRS) and Network Block
 Device (IBNBD)
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>,
	Bart Van Assche <bart.vanassche@sandisk.com>, Or Gerlitz <ogerlitz@mellanox.com>,
	Danil Kipnis <danil.kipnis@profitbricks.com>, Jack Wang <jinpu.wang@profitbricks.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

Hi Sagi,

On Mon, Feb 5, 2018 at 1:16 PM, Sagi Grimberg <sagi@grimberg.me> wrote:
> Hi Roman and the team,
>
> On 02/02/2018 04:08 PM, Roman Pen wrote:
>>
>> This series introduces IBNBD/IBTRS modules.
>>
>> IBTRS (InfiniBand Transport) is a reliable high speed transport library
>> which allows for establishing connection between client and server
>> machines via RDMA.
>
>
> So its not strictly infiniband correct?

This is RDMA.  Original IB prefix is a bit confusing, that's true.

>  It is optimized to transfer (read/write) IO blocks
>>
>> in the sense that it follows the BIO semantics of providing the
>> possibility to either write data from a scatter-gather list to the
>> remote side or to request ("read") data transfer from the remote side
>> into a given set of buffers.
>>
>> IBTRS is multipath capable and provides I/O fail-over and load-balancing
>> functionality.
>
>
> Couple of questions on your multipath implementation?
> 1. What was your main objective over dm-multipath?

No objections, mpath is a part of the transport ibtrs library.

> 2. What was the consideration of this implementation over
> creating a stand-alone bio based device node to reinject the
> bio to the original block device?

ibnbd and ibtrs are separate, on fail-over or load-balancing
we work with IO requests inside a library.

>> IBNBD (InfiniBand Network Block Device) is a pair of kernel modules
>> (client and server) that allow for remote access of a block device on
>> the server over IBTRS protocol. After being mapped, the remote block
>> devices can be accessed on the client side as local block devices.
>> Internally IBNBD uses IBTRS as an RDMA transport library.
>>
>> Why?
>>
>>     - IBNBD/IBTRS is developed in order to map thin provisioned volumes,
>>       thus internal protocol is simple and consists of several request
>>          types only without awareness of underlaying hardware devices.
>
>
> Can you explain how the protocol is developed for thin-p? What are the
> essence of how its suited for it?

Here I wanted to emphasize, that we do not support any HW commands,
like nvme does, thus internal protocol consists of several commands.
So answering on your question "how the protocol is developed for thin-p"
I would put it another way around: "protocol does nothing to support
real device, because all we need is to map thin-p volumes".  It is just
simpler.

>>     - IBTRS was developed as an independent RDMA transport library, which
>>       supports fail-over and load-balancing policies using multipath, thus
>>          it can be used for any other IO needs rather than only for block
>>          device.
>
>
> What do you mean by "any other IO"?

I mean other IO producers, not only ibnbd, since this is just a transport
library.

>
>>     - IBNBD/IBTRS is faster than NVME over RDMA.  Old comparison results:
>>       https://www.spinics.net/lists/linux-rdma/msg48799.html
>>       (I retested on latest 4.14 kernel - there is no any significant
>>           difference, thus I post the old link).
>
>
> That is interesting to learn.
>
> Reading your reference brings a couple of questions though,
> - Its unclear to me how ibnbd performs reads without performing memory
>   registration. Is it using the global dma rkey?

Yes, global rkey.

WRITE: writes from client
READ: writes from server

> - Its unclear to me how there is a difference in noreg in writes,
>   because for small writes nvme-rdma never register memory (it uses
>   inline data).

No support for that.

> - Looks like with nvme-rdma you max out your iops at 1.6 MIOPs, that
>   seems considerably low against other reports. Can you try and explain
>   what was the bottleneck? This can be a potential bug and I (and the
>   rest of the community is interesting in knowing more details).

Sure, I can try.  BTW, what are other reports and numbers?

> - srp/scst comparison is really not fair having it in legacy request
>   mode. Can you please repeat it and report a bug to either linux-rdma
>   or to the scst mailing list?

Yep, I can retest with mq.

> - Your latency measurements are surprisingly high for a null target
>   device (even for low end nvme device actually) regardless of the
>   transport implementation.

Hm, network configuration?  These are results on machines dedicated
to our team for testing in one of our datacenters. Nothing special
in configuration.

> For example:
> - QD=1 read latency is 648.95 for ibnbd (I assume usecs right?) which is
>   fairly high. on nvme-rdma its 1058 us, which means over 1 millisecond
>   and even 1.254 ms for srp. Last time I tested nvme-rdma read QD=1
>   latency I got ~14 us. So something does not add up here. If this is
>   not some configuration issue, then we have serious bugs to handle..
>
> - QD=16 the read latencies are > 10ms for null devices?! I'm having
>   troubles understanding how you were able to get such high latencies
>   (> 100 ms for QD>=100)

What QD stands for? queue depth?  This is not a queue depth, this is
how many fio jobs are dedicated.

And regarding latencies: I can suspect only network configuration.


> Can you share more information about your setup? It would really help
> us understand more.

Everything is specified in the google doc sheet.  Also you can
download the fio files, links are also provided, at the bottom.

https://www.spinics.net/lists/linux-rdma/msg48799.html


[1] FIO runner and results extractor script:
    https://drive.google.com/open?id=0B8_SivzwHdgSS2RKcmc4bWg0YjA

[2] Archive with FIO configurations and results:
    https://drive.google.com/open?id=0B8_SivzwHdgSaDlhMXV6THhoRXc

[3] Google sheet with performance measurements:
    https://drive.google.com/open?id=1sCTBKLA5gbhhkgd2USZXY43VL3zLidzdqDeObZn9Edc

[4] NVMEoF configuration:
    https://drive.google.com/open?id=0B8_SivzwHdgSTzRjbGtmaVR6LWM

[5] SCST configuration:
    https://drive.google.com/open?id=0B8_SivzwHdgSM1B5eGpKWmFJMFk



--
Roman
