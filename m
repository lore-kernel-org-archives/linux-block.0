Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Fri, 22 Apr 2016 15:32:21 -0400
From: Tejun Heo <tj@kernel.org>
To: Paolo Valente <paolo.valente@linaro.org>
Cc: Jens Axboe <axboe@kernel.dk>, Fabio Checconi <fchecconi@gmail.com>,
	Arianna Avanzini <avanzini.arianna@gmail.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	ulf.hansson@linaro.org, linus.walleij@linaro.org,
	broonie@kernel.org
Subject: Re: [PATCH RFC 10/22] block, bfq: add full hierarchical scheduling
 and cgroups support
Message-ID: <20160422193221.GY7822@mtj.duckdns.org>
References: <1454364778-25179-1-git-send-email-paolo.valente@linaro.org>
 <1454364778-25179-11-git-send-email-paolo.valente@linaro.org>
 <20160211222824.GD3741@mtj.duckdns.org>
 <57174CA7.5000706@linaro.org>
 <20160422181321.GV7822@mtj.duckdns.org>
 <ABE90C54-FE45-4713-87D8-6CD591CB04A2@linaro.org>
 <20160422184110.GX7822@mtj.duckdns.org>
 <C1A89D63-CBC4-4C92-8D5A-9FB55A53FBCF@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <C1A89D63-CBC4-4C92-8D5A-9FB55A53FBCF@linaro.org>
List-ID: <linux-block@vger.kernel.org>

Hello, Paolo.

On Fri, Apr 22, 2016 at 09:05:14PM +0200, Paolo Valente wrote:
> > Ah, right, I was confused.  cic is always associated with the task and
> > yes a writeback worker can trigger blkcg changed events frequently as
> > it walks through different cgroups.  Is this an issue?
> 
> That’s exactly the source of my confusion: why does the worker walk
> through different cgroups all the time if the I/O is originated by
> the same process, which never changes group?

Because the workqueue workers aren't tied to individual workqueues,
they wander around serving different workqueues.  This might change if
we eventually update workqueues to be cgroup aware but for now it's
expected to happen.

Thanks.

-- 
tejun
