Return-Path: <prvs=0626c35109=borntraeger@de.ibm.com>
Subject: Re: [PATCH] blk-mq: only run mapped hw queues in
 blk_mq_run_hw_queues()
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Stefan Haberland <sth@linux.vnet.ibm.com>,
        Christoph Hellwig <hch@lst.de>
References: <20180328012035.17565-1-ming.lei@redhat.com>
 <ab28ea2a-9061-a4bb-723f-7db46d9a61c2@kernel.dk>
 <ebd41c63-5b64-23a7-1914-4abdedf3c9b2@de.ibm.com>
 <20180328152617.GA6071@ming.t460p>
 <19cb3f30-a2aa-5d3b-acad-95c882615929@de.ibm.com>
 <20180329020021.GA29317@ming.t460p>
 <b3f7e1b5-2de4-80d3-8125-c2a1da8ba9a6@de.ibm.com>
 <20180329095214.GB17190@ming.t460p>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu, 29 Mar 2018 12:11:27 +0200
MIME-Version: 1.0
In-Reply-To: <20180329095214.GB17190@ming.t460p>
Content-Type: text/plain; charset=utf-8
Message-Id: <c9329fd1-934d-2ef2-9c08-0ad9beb3058d@de.ibm.com>
List-ID: <linux-block@vger.kernel.org>



On 03/29/2018 11:52 AM, Ming Lei wrote:
> From the debugfs log, hctx0 is mapped to lots of CPU, so it shouldn't be
> unmapped, could you check if it is hctx0 which is unmapped when the
> warning is triggered? If not, what is the unmapped hctx? And you can do
> that by adding one extra line:
> 
> 	printk("unmapped hctx %d", hctx->queue_num);

Where do you want that printk?
> 
> Thanks,
> Ming
