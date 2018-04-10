Return-Path: <jianchao.w.wang@oracle.com>
Subject: Re: [PATCH v4] blk-mq: Fix race conditions in request timeout
 handling
To: Bart Van Assche <Bart.VanAssche@wdc.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
Cc: "hch@lst.de" <hch@lst.de>, "tj@kernel.org" <tj@kernel.org>,
        "israelr@mellanox.com" <israelr@mellanox.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "maxg@mellanox.com" <maxg@mellanox.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>
References: <20180410013455.7448-1-bart.vanassche@wdc.com>
 <f6fcc94b-412c-1552-477e-ba0b0927006c@oracle.com>
 <1131f89179501c54c04d61d81bc46a83ba87df27.camel@wdc.com>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <a073fa7a-d23e-dafa-0d7d-e5caababe7b0@oracle.com>
Date: Tue, 10 Apr 2018 22:32:20 +0800
MIME-Version: 1.0
In-Reply-To: <1131f89179501c54c04d61d81bc46a83ba87df27.camel@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Bart

Thanks for your kindly response.

On 04/10/2018 09:01 PM, Bart Van Assche wrote:
> On Tue, 2018-04-10 at 15:59 +0800, jianchao.wang wrote:
>> If yes, how does the timeout handler get the freed request when the tag has been freed ?
> 
> Hello Jianchao,
> 
> Have you noticed that the timeout handler does not check whether or not the request
> tag is freed? Additionally, I don't think it would be possible to add such a check
> to the timeout code without introducing a new race condition.

Doesn't blk_mq_queue_tag_busy_iter only iterate the tags that has been allocated/set ?
When the request is freed, the tag will be cleared through blk_mq_put_tag->sbitmap_queue_clear
Do I miss something else ?

Thanks
Jianchao

> 
> 
