Return-Path: <tom.leiming@gmail.com>
MIME-Version: 1.0
In-Reply-To: <08921b9d-0f31-f31d-096f-6c4f3a1e4d4f@oracle.com>
References: <1527000509-2619-1-git-send-email-jianchao.w.wang@oracle.com>
 <20180522200214.GF9536@vader> <c0b8f2e3-b286-06a7-306d-141f155eff01@oracle.com>
 <CACVXFVN=LHTq=x9n7U7gciR41rWfTHn9uHmZMUHt6=RdvJanXQ@mail.gmail.com>
 <bef30b73-bf68-929e-26b5-08f63e5ca885@oracle.com> <CACVXFVNLq7CiBMTDPRcHLNZBWLYXWCpdb4G0iqBUon9f-GpsAA@mail.gmail.com>
 <08921b9d-0f31-f31d-096f-6c4f3a1e4d4f@oracle.com>
From: Ming Lei <tom.leiming@gmail.com>
Date: Wed, 30 May 2018 17:44:28 +0800
Message-ID: <CACVXFVPKdqb7p-xMQ_8c7Wa26s6O-36Pi0xNHMRDDR1Ar+bDhA@mail.gmail.com>
Subject: Re: [PATCH] block: kyber: make kyber more friendly with merging
To: "jianchao.wang" <jianchao.w.wang@oracle.com>
Cc: Omar Sandoval <osandov@osandov.com>, Jens Axboe <axboe@kernel.dk>,
	linux-block <linux-block@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

On Wed, May 30, 2018 at 5:20 PM, jianchao.wang
<jianchao.w.wang@oracle.com> wrote:
> Hi ming
>
> On 05/30/2018 05:13 PM, Ming Lei wrote:
>>> Yes, it maybe good for merging of 'none', because the rq_list is split into 3
>>> lists, and not need to iterate the whole rq_list any more.
>>> But what's about the dispatch when there is no io scheduler.
>> blk_mq_flush_busy_ctxs() and blk_mq_dequeue_from_ctx() should work
>> fine in case of 'none' if per-domain list is added to ctx. Then we can make
>> none to be a bit fair on READ/WRITE.
>>
>
> But how to determine when to dispatch READ, WRITE or other more, when there is no io scheduler ?
>

For blk-mq, no io scheduler means 'none' actually, and it works like a
scheduler too, but just shares driver tags, IMO.

Wrt. the current code of 'none', blk-mq just picks up one request from
ctx->rq_list
directly in FIFO style. If READ/WRITE lists are introduced, only
blk_mq_dequeue_from_ctx() is effected, there are several choices
left for us:

1) keep the FIFO style of current behaviour by using req->start_time_ns

2) READ/WRIRE fair style by picking up request from the lists in round-robin
order

3) or others

It just will make more choices for us, :-)

Thanks,
Ming Lei
