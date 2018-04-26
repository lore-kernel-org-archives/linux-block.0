Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 26 Apr 2018 12:18:47 -0700
From: Tejun Heo <tj@kernel.org>
To: Jiang Biao <jiang.biao2@zte.com.cn>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, zhong.weidong@zte.com.cn,
	wen.yang99@zte.com.cn
Subject: Re: [PATCH 2/2] blkcg: init root blkcg_gq under lock
Message-ID: <20180426191847.GS1911913@devbig577.frc2.facebook.com>
References: <1524110769-107033-1-git-send-email-jiang.biao2@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1524110769-107033-1-git-send-email-jiang.biao2@zte.com.cn>
List-ID: <linux-block@vger.kernel.org>

Hello,

On Thu, Apr 19, 2018 at 12:06:09PM +0800, Jiang Biao wrote:
> The initializing of q->root_blkg is currently outside of queue lock
> and rcu, so the blkg may be destroied before the initializing, which
> may cause dangling/null references. On the other side, the destroys
> of blkg are protected by queue lock or rcu. Put the initializing
> inside the queue lock and rcu to make it safer.

Hmm... I can't think of a scenario where the above could happen.  The
queue is still being initialized and no one else has access to it, so
I can't see how it could be destroyed.  Can you please describe the
sequence of events?  Have you actually observed this happening?

Thanks.

-- 
tejun
