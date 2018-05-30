Return-Path: <jianchao.w.wang@oracle.com>
Subject: Re: [PATCH] block: kyber: make kyber more friendly with merging
To: Ming Lei <tom.leiming@gmail.com>
Cc: Omar Sandoval <osandov@osandov.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1527000509-2619-1-git-send-email-jianchao.w.wang@oracle.com>
 <20180522200214.GF9536@vader>
 <c0b8f2e3-b286-06a7-306d-141f155eff01@oracle.com>
 <CACVXFVN=LHTq=x9n7U7gciR41rWfTHn9uHmZMUHt6=RdvJanXQ@mail.gmail.com>
 <bef30b73-bf68-929e-26b5-08f63e5ca885@oracle.com>
 <CACVXFVNLq7CiBMTDPRcHLNZBWLYXWCpdb4G0iqBUon9f-GpsAA@mail.gmail.com>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <08921b9d-0f31-f31d-096f-6c4f3a1e4d4f@oracle.com>
Date: Wed, 30 May 2018 17:20:10 +0800
MIME-Version: 1.0
In-Reply-To: <CACVXFVNLq7CiBMTDPRcHLNZBWLYXWCpdb4G0iqBUon9f-GpsAA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi ming

On 05/30/2018 05:13 PM, Ming Lei wrote:
>> Yes, it maybe good for merging of 'none', because the rq_list is split into 3
>> lists, and not need to iterate the whole rq_list any more.
>> But what's about the dispatch when there is no io scheduler.
> blk_mq_flush_busy_ctxs() and blk_mq_dequeue_from_ctx() should work
> fine in case of 'none' if per-domain list is added to ctx. Then we can make
> none to be a bit fair on READ/WRITE.
> 

But how to determine when to dispatch READ, WRITE or other more, when there is no io scheduler ?

Thanks
Jianchao
