Return-Path: <sagigrim@gmail.com>
Return-Path: <sagigrim@gmail.com>
Subject: Re: [PATCH v2 07/10] nvme-pci: Use PCI p2pmem subsystem to manage the
 CMB
To: Keith Busch <keith.busch@intel.com>, Oliver <oohall@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>,
 "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
 linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>,
 Jason Gunthorpe <jgg@mellanox.com>, =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?=
 <jglisse@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Max Gurtovoy <maxg@mellanox.com>,
 Christoph Hellwig <hch@lst.de>
References: <20180228234006.21093-1-logang@deltatee.com>
 <20180228234006.21093-8-logang@deltatee.com>
 <CAOSf1CEj1vmLLd27-642=XSnL9ODkpEC0qLHA2_W5_7rV5+4Pg@mail.gmail.com>
 <20180305160004.GA30975@localhost.localdomain>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <36c78987-006a-a97f-1d18-b0a08cbea9d4@grimberg.me>
Date: Mon, 5 Mar 2018 21:57:27 +0200
MIME-Version: 1.0
In-Reply-To: <20180305160004.GA30975@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>


>>> -       if (nvmeq->sq_cmds_io)
>>> -               memcpy_toio(&nvmeq->sq_cmds_io[tail], cmd, sizeof(*cmd));
>>> -       else
>>> -               memcpy(&nvmeq->sq_cmds[tail], cmd, sizeof(*cmd));
>>> +       memcpy(&nvmeq->sq_cmds[tail], cmd, sizeof(*cmd));
>>
>> Hmm, how safe is replacing memcpy_toio() with regular memcpy()? On PPC
>> the _toio() variant enforces alignment, does the copy with 4 byte
>> stores, and has a full barrier after the copy. In comparison our
>> regular memcpy() does none of those things and may use unaligned and
>> vector load/stores. For normal (cacheable) memory that is perfectly
>> fine, but they can cause alignment faults when targeted at MMIO
>> (cache-inhibited) memory.
>>
>> I think in this particular case it might be ok since we know SEQs are
>> aligned to 64 byte boundaries and the copy is too small to use our
>> vectorised memcpy(). I'll assume we don't need explicit ordering
>> between writes of SEQs since the existing code doesn't seem to care
>> unless the doorbell is being rung, so you're probably fine there too.
>> That said, I still think this is a little bit sketchy and at the very
>> least you should add a comment explaining what's going on when the CMB
>> is being used. If someone more familiar with the NVMe driver could
>> chime in I would appreciate it.
> 
> I may not be understanding the concern, but I'll give it a shot.
> 
> You're right, the start of any SQE is always 64-byte aligned, so that
> should satisfy alignment requirements.
> 
> The order when writing multiple/successive SQEs in a submission queue
> does matter, and this is currently serialized through the q_lock.
> 
> The order in which the bytes of a single SQE is written doesn't really
> matter as long as the entire SQE is written into the CMB prior to writing
> that SQ's doorbell register.
> 
> The doorbell register is written immediately after copying a command
> entry into the submission queue (ignore "shadow buffer" features),
> so the doorbells written to commands submitted is 1:1.
> 
> If a CMB SQE and DB order is not enforced with the memcpy, then we do
> need a barrier after the SQE's memcpy and before the doorbell's writel.

Keith, while we're on this, regardless of cmb, is SQE memcopy and DB 
update ordering always guaranteed?

If you look at mlx4 (rdma device driver) that works exactly the same as
nvme you will find:
--
                 qp->sq.head += nreq;

                 /*
                  * Make sure that descriptors are written before
                  * doorbell record.
                  */
                 wmb();

                 writel(qp->doorbell_qpn,
                        to_mdev(ibqp->device)->uar_map + 
MLX4_SEND_DOORBELL);

                 /*
                  * Make sure doorbells don't leak out of SQ spinlock
                  * and reach the HCA out of order.
                  */
                 mmiowb();
--

That seems to explicitly make sure to place a barrier before updating
the doorbell. So as I see it, either ordering is guaranteed and the
above code is redundant, or nvme needs to do the same.

Thoughts?
