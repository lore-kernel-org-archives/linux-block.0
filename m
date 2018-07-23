Return-Path: <penguin-kernel@i-love.sakura.ne.jp>
Subject: Re: [PATCH] block: ioprio: Replace GFP_ATOMIC with GFP_KERNEL in
 set_task_ioprio()
To: Christoph Hellwig <hch@infradead.org>, Jia-Ju Bai <baijiaju1990@gmail.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180723022116.6919-1-baijiaju1990@gmail.com>
 <20180723071803.GA30817@infradead.org>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <8dab79c6-eb75-b013-1f83-3af43a7052cb@I-love.SAKURA.ne.jp>
Date: Tue, 24 Jul 2018 06:49:32 +0900
MIME-Version: 1.0
In-Reply-To: <20180723071803.GA30817@infradead.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 2018/07/23 16:18, Christoph Hellwig wrote:
> Looks good,

Looks bad. :-(

SYSCALL_DEFINE3(ioprio_set, int, which, int, who, int, ioprio)
{
(...snipped...)
	rcu_read_lock();
(...snipped...)
	ret = set_task_ioprio(p, ioprio);
(...snipped...)
	rcu_read_unlock();
(...snipped...)
}

> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> But to me it seems that btrfs and maybe ext4 as well would be much
> better off just setting a per-IO priority in the bio.
> 
> Any chance yo could look into that?
> 
