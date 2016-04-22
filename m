Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Fri, 22 Apr 2016 14:41:10 -0400
From: Tejun Heo <tj@kernel.org>
To: Paolo Valente <paolo.valente@linaro.org>
Cc: Jens Axboe <axboe@kernel.dk>, Fabio Checconi <fchecconi@gmail.com>,
	Arianna Avanzini <avanzini.arianna@gmail.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	ulf.hansson@linaro.org, linus.walleij@linaro.org,
	broonie@kernel.org
Subject: Re: [PATCH RFC 10/22] block, bfq: add full hierarchical scheduling
 and cgroups support
Message-ID: <20160422184110.GX7822@mtj.duckdns.org>
References: <1454364778-25179-1-git-send-email-paolo.valente@linaro.org>
 <1454364778-25179-11-git-send-email-paolo.valente@linaro.org>
 <20160211222824.GD3741@mtj.duckdns.org>
 <57174CA7.5000706@linaro.org>
 <20160422181321.GV7822@mtj.duckdns.org>
 <ABE90C54-FE45-4713-87D8-6CD591CB04A2@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <ABE90C54-FE45-4713-87D8-6CD591CB04A2@linaro.org>
List-ID: <linux-block@vger.kernel.org>

Hello, Paolo.

On Fri, Apr 22, 2016 at 08:19:47PM +0200, Paolo Valente wrote:
> > So, a kworker would jump through different workqueues and issue IOs
> > for different writeback domains and the context can't be tied to the
> > issuing task.  The cgroup membership should be determined directly
> > from the bio.
> 
> Yes. My doubt arises from the fact that the only source of intense I/O
> is the dd (I have executed it alone). In contrast, group changes occur
> at a high frequency during all the execution of the dd. Apparently I
> cannot see any other I/O induced by the dd. Journaling issues sync
> requests.
> 
> >  cfq uses per-cgroup async queue.  I'm not sure how this
> > would map to bfq tho.
> 
> It’s the same. But this is the part I’m checking.

Ah, right, I was confused.  cic is always associated with the task and
yes a writeback worker can trigger blkcg changed events frequently as
it walks through different cgroups.  Is this an issue?

Thanks.

-- 
tejun
