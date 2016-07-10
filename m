Return-Path: <tom.leiming@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20160709145321.GA3337@htj.duckdns.org>
References: <77238e99.142c5.155b660564f.Coremail.aaronlee0817@163.com>
 <CACVXFVPO-7EEK02SUH16NtnwpE807KuYQHybBYYqVbXGZSzX2A@mail.gmail.com>
 <20160706140919.GH3262@mtj.duckdns.org> <27824f6f.127ab.155c59d8a24.Coremail.aaronlee0817@163.com>
 <CACVXFVPW9TjTnUzAGRFu+mLhaoYTYLopTPvzJcRs85MmdVW=9A@mail.gmail.com> <20160709145321.GA3337@htj.duckdns.org>
From: Ming Lei <tom.leiming@gmail.com>
Date: Sun, 10 Jul 2016 16:58:43 +0800
Message-ID: <CACVXFVP+7Jf0_tw_d+ygPb3FRirBASE8FYv0L4O3cm0KvxrWKA@mail.gmail.com>
Subject: Re: Re: cgroup: Fix split bio been throttled more than once
To: Tejun Heo <tj@kernel.org>
Cc: aaronlee0817 <aaronlee0817@163.com>, Jens Axboe <axboe@kernel.dk>, Ming Lin <mlin@kernel.org>,
	Shaohua Li <shli@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, cgroup@vger.kernel.org,
	jiale0817.li@samsung.com, yanzi.zhang@samsung.com, zhen1.zhang@samsung.com,
	linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

On Sat, Jul 9, 2016 at 10:53 PM, Tejun Heo <tj@kernel.org> wrote:
> Hello, Ming.
>
> On Fri, Jul 08, 2016 at 06:35:06PM +0800, Ming Lei wrote:
>> I am wondering why REQ_THROTTLED is cleared for the original bio
>> even it has been charged and will be issued to driver, and is it allowed
>> to throttle and charge the same bio for many times?
>
> So, IIUC, the flag is just to prevent the bio from recursing while
> being issued from blk-throtl after queued there for throttling.  We
> can probably extend the flag.  I'm not sure how it'd interact with
> stacked drivers tho.  It'd definitely need to be cleared before
> traveling down to a lower level device.

I think I understand it now, in case of stacked driver, the cloned bio
will be submitted
to a new request queue belonging to lower disk, and orignal bio's
REQ_THROTTLED flag should be cleared.

But in case of bio splitting, the remainder bio is just the orignal
bio with front part
splitted out, and it need to submit to same queue again, so it should be
bypassed of throttling because it has been charged already.

So looks Jiale's patch is correct, also seems 'blkg_rwstat_add()' should be
avoided for the remainder bio too in blkcg_bio_issue_check().

thanks,
Ming Lei
