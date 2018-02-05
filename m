Return-Path: <sagigrim@gmail.com>
Return-Path: <sagigrim@gmail.com>
Subject: Re: [PATCH 00/24] InfiniBand Transport (IBTRS) and Network Block
 Device (IBNBD)
To: Roman Pen <roman.penyaev@profitbricks.com>, linux-block@vger.kernel.org,
 linux-rdma@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>,
 Bart Van Assche <bart.vanassche@sandisk.com>,
 Or Gerlitz <ogerlitz@mellanox.com>,
 Danil Kipnis <danil.kipnis@profitbricks.com>,
 Jack Wang <jinpu.wang@profitbricks.com>
References: <20180202140904.2017-1-roman.penyaev@profitbricks.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <23dcfda7-eac1-ed13-b24e-3586c284ee55@grimberg.me>
Date: Mon, 5 Feb 2018 14:16:03 +0200
MIME-Version: 1.0
In-Reply-To: <20180202140904.2017-1-roman.penyaev@profitbricks.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

Hi Roman and the team,

On 02/02/2018 04:08 PM, Roman Pen wrote:
> This series introduces IBNBD/IBTRS modules.
> 
> IBTRS (InfiniBand Transport) is a reliable high speed transport library
> which allows for establishing connection between client and server
> machines via RDMA.

So its not strictly infiniband correct?

  It is optimized to transfer (read/write) IO blocks
> in the sense that it follows the BIO semantics of providing the
> possibility to either write data from a scatter-gather list to the
> remote side or to request ("read") data transfer from the remote side
> into a given set of buffers.
> 
> IBTRS is multipath capable and provides I/O fail-over and load-balancing
> functionality.

Couple of questions on your multipath implementation?
1. What was your main objective over dm-multipath?
2. What was the consideration of this implementation over
creating a stand-alone bio based device node to reinject the
bio to the original block device?

> IBNBD (InfiniBand Network Block Device) is a pair of kernel modules
> (client and server) that allow for remote access of a block device on
> the server over IBTRS protocol. After being mapped, the remote block
> devices can be accessed on the client side as local block devices.
> Internally IBNBD uses IBTRS as an RDMA transport library.
> 
> Why?
> 
>     - IBNBD/IBTRS is developed in order to map thin provisioned volumes,
>       thus internal protocol is simple and consists of several request
> 	 types only without awareness of underlaying hardware devices.

Can you explain how the protocol is developed for thin-p? What are the
essence of how its suited for it?

>     - IBTRS was developed as an independent RDMA transport library, which
>       supports fail-over and load-balancing policies using multipath, thus
> 	 it can be used for any other IO needs rather than only for block
> 	 device.

What do you mean by "any other IO"?

>     - IBNBD/IBTRS is faster than NVME over RDMA.  Old comparison results:
>       https://www.spinics.net/lists/linux-rdma/msg48799.html
>       (I retested on latest 4.14 kernel - there is no any significant
> 	  difference, thus I post the old link).

That is interesting to learn.

Reading your reference brings a couple of questions though,
- Its unclear to me how ibnbd performs reads without performing memory
   registration. Is it using the global dma rkey?

- Its unclear to me how there is a difference in noreg in writes,
   because for small writes nvme-rdma never register memory (it uses
   inline data).

- Looks like with nvme-rdma you max out your iops at 1.6 MIOPs, that
   seems considerably low against other reports. Can you try and explain
   what was the bottleneck? This can be a potential bug and I (and the
   rest of the community is interesting in knowing more details).

- srp/scst comparison is really not fair having it in legacy request
   mode. Can you please repeat it and report a bug to either linux-rdma
   or to the scst mailing list?

- Your latency measurements are surprisingly high for a null target
   device (even for low end nvme device actually) regardless of the
   transport implementation.

For example:
- QD=1 read latency is 648.95 for ibnbd (I assume usecs right?) which is
   fairly high. on nvme-rdma its 1058 us, which means over 1 millisecond
   and even 1.254 ms for srp. Last time I tested nvme-rdma read QD=1
   latency I got ~14 us. So something does not add up here. If this is
   not some configuration issue, then we have serious bugs to handle..

- QD=16 the read latencies are > 10ms for null devices?! I'm having
   troubles understanding how you were able to get such high latencies
   (> 100 ms for QD>=100)

Can you share more information about your setup? It would really help
us understand more.

>     - Major parts of the code were rewritten, simplified and overall code
>       size was reduced by a quarter.

That is good to know.
