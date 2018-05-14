Return-Path: <jianchao.w.wang@oracle.com>
Subject: Re: [PATCH] blk-mq: Rework blk-mq timeout handling again
To: Bart Van Assche <Bart.VanAssche@wdc.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "israelr@mellanox.com" <israelr@mellanox.com>,
        "sagi@grimberg.me" <sagi@grimberg.me>, "hch@lst.de" <hch@lst.de>,
        "sebott@linux.ibm.com" <sebott@linux.ibm.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "maxg@mellanox.com" <maxg@mellanox.com>,
        "tj@kernel.org" <tj@kernel.org>
References: <20180510175607.27937-1-bart.vanassche@wdc.com>
 <73f77c62-25ca-0915-6f5b-452d60258f05@oracle.com>
 <b38e338c651b2e39d259eca5bc559308d8aa4a24.camel@wdc.com>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <3410e6c1-6c1c-564c-466b-3335263ef4b1@oracle.com>
Date: Mon, 14 May 2018 09:48:13 +0800
MIME-Version: 1.0
In-Reply-To: <b38e338c651b2e39d259eca5bc559308d8aa4a24.camel@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Bart

On 05/11/2018 11:26 PM, Bart Van Assche wrote:
> The bug is in the above trace_printk() call: blk_rq_deadline() must only be used
> for the legacy block layer and not for blk-mq code. If you have a look at the value
> of the das.deadline field then one can see that the value of that field is correct:

blk_rq_deadline is used by __blk_add_timer, and __blk_add_timer is also used by blk_mq_add_timer.
This is why I used blk_rq_deadline to print out the value in my test.
on 64bit system, das.deadline will be a correct value,  what if the jiffies has crossed the 32bit boundary ?

> 0xffff550c - 0xffff37c0 = 7500 = 30 * 250. Does that mean that HZ = 250 on the system
> on which you ran this test?
> 

Yes, the HZ is 250

Thanks
Jianchao
