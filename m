Return-Path: <tom.leiming@gmail.com>
MIME-Version: 1.0
In-Reply-To: <27824f6f.127ab.155c59d8a24.Coremail.aaronlee0817@163.com>
References: <77238e99.142c5.155b660564f.Coremail.aaronlee0817@163.com>
 <CACVXFVPO-7EEK02SUH16NtnwpE807KuYQHybBYYqVbXGZSzX2A@mail.gmail.com>
 <20160706140919.GH3262@mtj.duckdns.org> <27824f6f.127ab.155c59d8a24.Coremail.aaronlee0817@163.com>
From: Ming Lei <tom.leiming@gmail.com>
Date: Fri, 8 Jul 2016 18:35:06 +0800
Message-ID: <CACVXFVPW9TjTnUzAGRFu+mLhaoYTYLopTPvzJcRs85MmdVW=9A@mail.gmail.com>
Subject: Re: Re: cgroup: Fix split bio been throttled more than once
To: aaronlee0817 <aaronlee0817@163.com>
Cc: Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>, Ming Lin <mlin@kernel.org>,
	Shaohua Li <shli@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, cgroup@vger.kernel.org,
	jiale0817.li@samsung.com, yanzi.zhang@samsung.com, zhen1.zhang@samsung.com,
	linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

On Thu, Jul 7, 2016 at 9:48 PM, aaronlee0817 <aaronlee0817@163.com> wrote:
>>At 2016-07-06 22:09:19, "Tejun Heo" <tj@kernel.org> wrote:
>>Hello, Ming.
>>
>>On Wed, Jul 06, 2016 at 09:10:00AM +0800, Ming Lei wrote:
>>> > Then we did some research and find that in kernel version 4.3 brought
>>> > in
>>> > blk_queue_split() function to split the big size bio into several
>>> > parts,
>>> > and some of them are calling the generic_make_request() again, this
>>> > result
>>> > the bio been throttled more than once. so the actual bio sent to devi=
ce
>>> > is
>>> > less than we expected.
>>>
>>> Except for blk_queue_split(), there are other(stacked) drivers which ca=
ll
>>> generic_make_request() too, such as drbd, dm, md and bcache.
>>
>>So, blk-throtl already uses REQ_THROTTLED to avoid throttling the same
>>bio multiple times.  The problem seems that the flag isn't maintained
>>through clone.
>
> Yea=EF=BC=8C REQ_THROTTLED is used to avoid throttling the same bio multi=
ple times,
> but cannot avoid counting the same bio multiple times, this makes the cou=
nts
> of
> dispatched bytes no real.
> Before bringing in splitting, it works well.But now, this cannot cover al=
l
> scenarios.
> For example:
>
> generic_make_request()
> blk_throtl_bio
>     bool throttled =3D false
>     throtl_charge_bio()      count the bytes, set REQ_THROTTLED
>     goto out
>     if(!throttled)
>         clean REQ_THROTTLED
>     return
>
> Before return, REQ_THROTTLED will be cleaned.

I am wondering why REQ_THROTTLED is cleared for the original bio
even it has been charged and will be issued to driver, and is it allowed
to throttle and charge the same bio for many times?

If the original bio is accounted, looks the splitted bio and the remainder(=
same
bio with original bio but size is decreased, and is resubmitted) shouldn't
have been accounted again because size of the splitted and the remainder
just equals with size of orignal bio.

Thanks,


> While splitting will copy bio->rw, but REQ_THROTTLED has been cleaned.
> So throttling function will count the bytes again. In this scenario  cann=
ot
> avoid counting the same bio multiple times.
>
>>
>>> >
>>> > We have checked the newest kernel of 4.7-rc5, this problem is still
>>> > exist.
>>> >
>>> > Based on this kind of situation, we propose a fix solution to add a
>>> > flag bit
>>> > in bio to let the splited bio bypass the blk_queue_split(). Below is
>>> > the patch
>>> > we used to fix this problem.
>>>
>>> The splitted bio is just a fast-cloned bio(except for discard bio) and
>>> not very
>>> special compared with other fast-cloned bio, which is quite common used=
.
>>>
>>> So I guess what you need is to bypass BIO_CLONED bio for this purpose
>>> since all fast-cloned bio shares the same bvec table of the source bio.
>>
>>Depending on how a device handles a bio, that could allow bios to
>>bypass throttling entirely, no?  Wouldn't adding REQ_THROTTLED to
>>REQ_CLONE_MASK work?
>>
>>Thanks.
>>
>>--
>>tejun
>
>
>
>



--=20
Ming Lei
