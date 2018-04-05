Return-Path: <borntraeger@de.ibm.com>
Subject: Re: [PATCH] blk-mq: only run mapped hw queues in
 blk_mq_run_hw_queues()
From: Christian Borntraeger <borntraeger@de.ibm.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Stefan Haberland <sth@linux.vnet.ibm.com>,
        Christoph Hellwig <hch@lst.de>
References: <d3a45ead-7d6c-a7b2-0d7a-9d54f9e66e4a@de.ibm.com>
 <20180329094016.GA17190@ming.t460p>
 <e30f880e-6c30-c1fe-2fa1-4b92992fe864@de.ibm.com>
 <20180329104806.GB17537@ming.t460p>
 <be80d226-2211-8e6c-dc30-a45088fe14b6@de.ibm.com>
 <20180329114313.GC17537@ming.t460p>
 <adb2321f-ebed-d65a-c4d0-275c492fed53@de.ibm.com>
 <20180330025340.GB12412@ming.t460p>
 <f4ac3dba-9b06-9896-38b3-0b173a072d3d@de.ibm.com>
 <20180405160503.GA20818@ming.t460p> <20180405161142.GA20972@ming.t460p>
 <3a72f42f-db90-6092-5e1b-0579d2095daa@de.ibm.com>
Date: Thu, 5 Apr 2018 19:43:20 +0200
MIME-Version: 1.0
In-Reply-To: <3a72f42f-db90-6092-5e1b-0579d2095daa@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <201539a5-c81a-5f5b-dc8f-f3999886f81e@de.ibm.com>
List-ID: <linux-block@vger.kernel.org>



On 04/05/2018 07:39 PM, Christian Borntraeger wrote:
> 
> 
> On 04/05/2018 06:11 PM, Ming Lei wrote:
>>>
>>> Could you please apply the following patch and provide the dmesg boot log?
>>
>> And please post out the 'lscpu' log together from the test machine too.
> 
> attached.
> 
> As I said before this seems to go way with CONFIG_NR_CPUS=64 or smaller.
> We have 282 nr_cpu_ids here (max 141CPUs on that z13 with SMT2) but only 8 Cores
> == 16 threads.

To say it differently 
The whole system has up to 141 cpus, but this LPAR has only 8 cpus assigned. So we
have 16 CPUS (SMT) but this could become up to 282 IF I would do CPU hotplug. (But
this is not used here).
