Return-Path: <tom.leiming@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20160706150629.GA31684@mtj.duckdns.org>
References: <77238e99.142c5.155b660564f.Coremail.aaronlee0817@163.com>
 <20160705222626.GC25394@htj.duckdns.org> <458d1946.12fa6.155c0b80d60.Coremail.aaronlee0817@163.com>
 <20160706150629.GA31684@mtj.duckdns.org>
From: Ming Lei <tom.leiming@gmail.com>
Date: Wed, 6 Jul 2016 23:39:29 +0800
Message-ID: <CACVXFVOr+nFvFge-VOR+Jsci2hp263r7F-NZ8N2d5wsfDDOpWg@mail.gmail.com>
Subject: Re: Re: cgroup: Fix split bio been throttled more than once
To: Tejun Heo <tj@kernel.org>
Cc: aaronlee0817 <aaronlee0817@163.com>, Jens Axboe <axboe@kernel.dk>, Ming Lin <mlin@kernel.org>,
	Shaohua Li <shli@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, cgroup@vger.kernel.org,
	jiale0817.li@samsung.com, yanzi.zhang@samsung.com, zhen1.zhang@samsung.com,
	linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

On Wed, Jul 6, 2016 at 11:06 PM, Tejun Heo <tj@kernel.org> wrote:
> Hello,
>
> On Wed, Jul 06, 2016 at 10:58:55PM +0800, aaronlee0817 wrote:
>> >But that said, can't we just copy BIO_THROTLED while splitting?
>>
>> In my opinion=EF=BC=8C copying BIO_THROTLED while splitting doesn't work
>> with this, because, the bio within the limit will not set BIO_THROTLED
>> but will be split, and back to call generic_make_request(), and will be
>> count twice.
>
> I see.  It's just a bit weird that we're marking this from clone site
> when it's an issue which is specific to throttling.  The thing is
> depending on how bio clone is used, it could misbehave in the other

The cloned bio often need to be submitted via generic_make_request().

> direction (bio not accounted at all).  What we want to know is whether
> a bio has been previously accounted or not, rather than whether a bio
> is a result of splitting.  I think it'd be better to track that
> instead.

Looks the flag of BIO_THROTLED doesn't work well, and it should have
been set if the bio is accounted, and seems not related with splitting.

Thanks,
Ming

>
> Thanks.
>
> --
> tejun
> --
> To unsubscribe from this list: send the line "unsubscribe linux-block" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--=20
Ming Lei
