Return-Path: <jianchao.w.wang@oracle.com>
Subject: Re: [PATCH] blk-mq: Rework blk-mq timeout handling again
To: Bart Van Assche <Bart.VanAssche@wdc.com>, "hch@lst.de" <hch@lst.de>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "israelr@mellanox.com" <israelr@mellanox.com>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "sebott@linux.ibm.com" <sebott@linux.ibm.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "maxg@mellanox.com"
 <maxg@mellanox.com>,
        "tj@kernel.org" <tj@kernel.org>
References: <20180510175607.27937-1-bart.vanassche@wdc.com>
 <73f77c62-25ca-0915-6f5b-452d60258f05@oracle.com>
 <20180511123519.GA14123@lst.de>
 <13279046837412fd5cfe845a27e469a23125caf3.camel@wdc.com>
 <beab60f7-5fee-f1d8-12c3-c43d005d6427@oracle.com>
 <4f773949c3e32a9d65ab09159fb7b6988349e91b.camel@wdc.com>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <b7f45d6b-f2a2-a778-9b58-245ecb99e4d9@oracle.com>
Date: Mon, 14 May 2018 13:15:57 +0800
MIME-Version: 1.0
In-Reply-To: <4f773949c3e32a9d65ab09159fb7b6988349e91b.camel@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Bart

On 05/14/2018 12:03 PM, Bart Van Assche wrote:
> On Mon, 2018-05-14 at 09:37 +0800, jianchao.wang wrote:
>> In addition, on a 64bit system, how do you set up the timer with a 32bit deadline ?
> 
> If timeout handling occurs less than (1 << 31) / HZ seconds after a request has been
> submitted then a 32-bit variable is sufficient to store the deadline. If you want to
> verify the implementation, please have a look at the int32_t variables in
> blk_mq_check_expired().
> 
a 32bit deadline is indeed OK to judge whether a request is timeout or not.
but how is the expires value determined for __blk_add_timer -> mod_timer ?
as we know, when a request is started, we need to arm a timer for it.
the expires value is 'unsigned long'.

Thanks
Jianchao 
