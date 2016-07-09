Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Sat, 9 Jul 2016 10:53:21 -0400
From: Tejun Heo <tj@kernel.org>
To: Ming Lei <tom.leiming@gmail.com>
Cc: aaronlee0817 <aaronlee0817@163.com>, Jens Axboe <axboe@kernel.dk>,
	Ming Lin <mlin@kernel.org>, Shaohua Li <shli@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	cgroup@vger.kernel.org, jiale0817.li@samsung.com,
	yanzi.zhang@samsung.com, zhen1.zhang@samsung.com,
	linux-block <linux-block@vger.kernel.org>
Subject: Re: Re: cgroup: Fix split bio been throttled more than once
Message-ID: <20160709145321.GA3337@htj.duckdns.org>
References: <77238e99.142c5.155b660564f.Coremail.aaronlee0817@163.com>
 <CACVXFVPO-7EEK02SUH16NtnwpE807KuYQHybBYYqVbXGZSzX2A@mail.gmail.com>
 <20160706140919.GH3262@mtj.duckdns.org>
 <27824f6f.127ab.155c59d8a24.Coremail.aaronlee0817@163.com>
 <CACVXFVPW9TjTnUzAGRFu+mLhaoYTYLopTPvzJcRs85MmdVW=9A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CACVXFVPW9TjTnUzAGRFu+mLhaoYTYLopTPvzJcRs85MmdVW=9A@mail.gmail.com>
List-ID: <linux-block@vger.kernel.org>

Hello, Ming.

On Fri, Jul 08, 2016 at 06:35:06PM +0800, Ming Lei wrote:
> I am wondering why REQ_THROTTLED is cleared for the original bio
> even it has been charged and will be issued to driver, and is it allowed
> to throttle and charge the same bio for many times?

So, IIUC, the flag is just to prevent the bio from recursing while
being issued from blk-throtl after queued there for throttling.  We
can probably extend the flag.  I'm not sure how it'd interact with
stacked drivers tho.  It'd definitely need to be cleared before
traveling down to a lower level device.

Thanks.

-- 
tejun
