Return-Path: <baijiaju1990@gmail.com>
Return-Path: <baijiaju1990@gmail.com>
Subject: Re: [PATCH] block: ioprio: Replace GFP_ATOMIC with GFP_KERNEL in
 set_task_ioprio()
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
 Christoph Hellwig <hch@infradead.org>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180723022116.6919-1-baijiaju1990@gmail.com>
 <20180723071803.GA30817@infradead.org>
 <8dab79c6-eb75-b013-1f83-3af43a7052cb@I-love.SAKURA.ne.jp>
From: Jia-Ju Bai <baijiaju1990@gmail.com>
Message-ID: <00149ccf-71d7-14e9-fb64-9b8b2ca1e74e@gmail.com>
Date: Tue, 24 Jul 2018 09:42:28 +0800
MIME-Version: 1.0
In-Reply-To: <8dab79c6-eb75-b013-1f83-3af43a7052cb@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>



On 2018/7/24 5:49, Tetsuo Handa wrote:
> On 2018/07/23 16:18, Christoph Hellwig wrote:
>> Looks good,
> Looks bad. :-(
>
> SYSCALL_DEFINE3(ioprio_set, int, which, int, who, int, ioprio)
> {
> (...snipped...)
> 	rcu_read_lock();
> (...snipped...)
> 	ret = set_task_ioprio(p, ioprio);
> (...snipped...)
> 	rcu_read_unlock();
> (...snipped...)

Oops, my tool does not handle SYSCALL_DEFINE3()...
Sorry for my incorrect report.


Best wishes,
Jia-Ju Bai
