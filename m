Return-Path: <logang@deltatee.com>
To: Marta Rybczynska <mrybczyn@kalray.eu>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org,
 linux-nvdimm@lists.01.org, linux-block@vger.kernel.org,
 Stephen Bates <sbates@raithlin.com>, Christoph Hellwig <hch@lst.de>,
 Jens Axboe <axboe@kernel.dk>, Keith Busch <keith.busch@intel.com>,
 Sagi Grimberg <sagi@grimberg.me>, Bjorn Helgaas <bhelgaas@google.com>,
 Jason Gunthorpe <jgg@mellanox.com>, Max Gurtovoy <maxg@mellanox.com>,
 Dan Williams <dan.j.williams@intel.com>, =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?=
 <jglisse@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <20180104190137.7654-1-logang@deltatee.com>
 <20180104190137.7654-10-logang@deltatee.com>
 <281272464.115248600.1515166226009.JavaMail.zimbra@kalray.eu>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <a284e33f-c10d-0540-cd24-ad1993a042b6@deltatee.com>
Date: Fri, 5 Jan 2018 11:14:38 -0700
MIME-Version: 1.0
In-Reply-To: <281272464.115248600.1515166226009.JavaMail.zimbra@kalray.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Subject: Re: [PATCH 09/12] nvme-pci: Use PCI p2pmem subsystem to manage the
 CMB
List-ID: <linux-block@vger.kernel.org>



On 05/01/18 08:30 AM, Marta Rybczynska wrote:
>> @@ -429,10 +429,7 @@ static void __nvme_submit_cmd(struct nvme_queue *nvmeq,
>> {
>> 	u16 tail = nvmeq->sq_tail;
>>
>> -	if (nvmeq->sq_cmds_io)
>> -		memcpy_toio(&nvmeq->sq_cmds_io[tail], cmd, sizeof(*cmd));
>> -	else
>> -		memcpy(&nvmeq->sq_cmds[tail], cmd, sizeof(*cmd));
>> +	memcpy(&nvmeq->sq_cmds[tail], cmd, sizeof(*cmd));
>>
> 
> Why is it always memcpy() and not memcpy_toio()? I'd expect something like
> if (nvmeq->sq_cmds_is_io)
> 	memcpy_toio(&nvmeq->sq_cmds_io[tail], cmd, sizeof(*cmd));
> else
> 	memcpy(&nvmeq->sq_cmds[tail], cmd, sizeof(*cmd));

We're going on the assumption that memory mapped with 
devm_memremap_pages() can be treated as regular memory. So memcpy_toio 
is not necessary for P2P memory.

Logan
