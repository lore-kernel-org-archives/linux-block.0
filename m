Return-Path: <htejun@gmail.com>
Return-Path: <htejun@gmail.com>
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 6 Jul 2016 10:09:19 -0400
From: Tejun Heo <tj@kernel.org>
To: Ming Lei <tom.leiming@gmail.com>
Cc: Jiale Li <aaronlee0817@163.com>, Jens Axboe <axboe@kernel.dk>,
	Ming Lin <mlin@kernel.org>, Shaohua Li <shli@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	cgroup@vger.kernel.org, jiale0817.li@samsung.com,
	yanzi.zhang@samsung.com, zhen1.zhang@samsung.com,
	linux-block <linux-block@vger.kernel.org>
Subject: Re: cgroup: Fix split bio been throttled more than once
Message-ID: <20160706140919.GH3262@mtj.duckdns.org>
References: <77238e99.142c5.155b660564f.Coremail.aaronlee0817@163.com>
 <CACVXFVPO-7EEK02SUH16NtnwpE807KuYQHybBYYqVbXGZSzX2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CACVXFVPO-7EEK02SUH16NtnwpE807KuYQHybBYYqVbXGZSzX2A@mail.gmail.com>
List-ID: <linux-block@vger.kernel.org>

Hello, Ming.

On Wed, Jul 06, 2016 at 09:10:00AM +0800, Ming Lei wrote:
> > Then we did some research and find that in kernel version 4.3 brought in
> > blk_queue_split() function to split the big size bio into several parts,
> > and some of them are calling the generic_make_request() again, this result
> > the bio been throttled more than once. so the actual bio sent to device is
> > less than we expected.
> 
> Except for blk_queue_split(), there are other(stacked) drivers which call
> generic_make_request() too, such as drbd, dm, md and bcache.

So, blk-throtl already uses REQ_THROTTLED to avoid throttling the same
bio multiple times.  The problem seems that the flag isn't maintained
through clone.

> >
> > We have checked the newest kernel of 4.7-rc5, this problem is still exist.
> >
> > Based on this kind of situation, we propose a fix solution to add a flag bit
> > in bio to let the splited bio bypass the blk_queue_split(). Below is the patch
> > we used to fix this problem.
> 
> The splitted bio is just a fast-cloned bio(except for discard bio) and not very
> special compared with other fast-cloned bio, which is quite common used.
> 
> So I guess what you need is to bypass BIO_CLONED bio for this purpose
> since all fast-cloned bio shares the same bvec table of the source bio.

Depending on how a device handles a bio, that could allow bios to
bypass throttling entirely, no?  Wouldn't adding REQ_THROTTLED to
REQ_CLONE_MASK work?

Thanks.

-- 
tejun
