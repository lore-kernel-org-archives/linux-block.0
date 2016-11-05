Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 1/4] block: add scalable completion tracking of requests
To: Ming Lei <tom.leiming@gmail.com>
References: <1478034325-28232-1-git-send-email-axboe@fb.com>
 <1478034325-28232-2-git-send-email-axboe@fb.com>
 <CACVXFVME3jpraUR8cp_i-YFYu4rk4gUCZqOi86PpCHGRrh9c_g@mail.gmail.com>
 <bd83d2b6-3e7f-18c0-45d6-7b9f6c015722@fb.com>
 <CACVXFVM0atkprhvin8CXaxMJhx+p_hJtpbkJfxQDskojSSNHGQ@mail.gmail.com>
 <f1a797b7-6cbd-d3b9-3b33-d38b554c1227@fb.com>
 <CACVXFVNnZoXOjVmfaCk+qhTf6W3UG6feUPsHWHYin2q0ELK4Ww@mail.gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-block <linux-block@vger.kernel.org>, Christoph Hellwig <hch@lst.de>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <5272bdb8-8a75-36ac-11d9-33d3719fa2ce@kernel.dk>
Date: Sat, 5 Nov 2016 14:59:47 -0600
MIME-Version: 1.0
In-Reply-To: <CACVXFVNnZoXOjVmfaCk+qhTf6W3UG6feUPsHWHYin2q0ELK4Ww@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 11/04/2016 05:13 PM, Ming Lei wrote:
>> Yes, that might be a good idea, since it doesn't cost us anything.
>> For the mq case, I'm hard pressed to think of areas where we could
>> complete IO in parallel on the same software queue. You'll never have
>> a software queue mapped to multiple hardware queues. So we should
>> essentially be serialized.
>
> For blk-mq, blk_mq_stat_add() is called in __blk_mq_complete_request()
> which is often run from interrupt handler, and the CPU serving the
> interrupt can be different with the submitting CPU for rq->mq_ctx. And
> there can be several CPUs handling the interrupts originating from
> same sw queue.

BTW, one small improvement might be to call blk_mq_stat_add() on the
curent ctx, in case it's different than rq->mq_ctx. That can happen if
we have multiple CPUs per hardware queue. In reality, even for that
case, a real race is rare. You'd have to rebalance interrupt masks
basically, at least on x86 where multiple CPUs in the IRQ affinity mask
still always trigger on the first one.

So while we could just grab the current ctx instead, I don't think it's
going to make a difference in practice.


-- 
Jens Axboe
