Return-Path: <borntraeger@de.ibm.com>
Subject: Re: 4.14: WARNING: CPU: 4 PID: 2895 at block/blk-mq.c:1144 with
 virtio-blk (also 4.12 stable)
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Bart Van Assche <Bart.VanAssche@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
References: <276625a9-44fb-719d-9281-caacefdbb99f@de.ibm.com>
 <eceae481-cf9a-0429-7a15-c363a8e7bc2a@kernel.dk>
 <1ddd1cd4-2862-849e-7849-82544bcb86be@de.ibm.com>
 <08e6f35a-4f49-973e-99f7-6087b44337c4@kernel.dk>
 <20171122072857.GA19338@lst.de>
 <a1d51b13-c034-e0c8-9428-e360b2c898c3@kernel.dk>
 <20171123143453.GA29715@lst.de>
 <cdca47a9-05cc-2676-57fe-904ce8ad5fbc@de.ibm.com>
 <20171123182542.GA2680@lst.de>
 <899f1638-cca4-28e6-3225-51505a053d45@de.ibm.com>
 <20171123183232.GA2845@lst.de>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu, 23 Nov 2017 19:59:55 +0100
MIME-Version: 1.0
In-Reply-To: <20171123183232.GA2845@lst.de>
Content-Type: text/plain; charset=utf-8
Message-Id: <92ef1aae-90b5-f14f-390e-bfab97899431@de.ibm.com>
List-ID: <linux-block@vger.kernel.org>



On 11/23/2017 07:32 PM, Christoph Hellwig wrote:
> On Thu, Nov 23, 2017 at 07:28:31PM +0100, Christian Borntraeger wrote:
>> zfcp on s390.
> 
> Ok, so it can't be the interrupt code, but probably is the blk-mq-cpumap.c
> changes.  Can you try to revert just those for a quick test?


Hmm, I get further in boot, but the system seems very sluggish and it does not
seem to be able to access the scsi disks (get data from them)

 
