Return-Path: <mb@lightnvm.io>
Return-Path: <mb@lightnvm.io>
Subject: Re: problem with bio handling on raid5 and pblk
To: =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@javigon.com>,
 Jens Axboe <axboe@kernel.dk>, shli@kernel.org
Cc: linux-raid@vger.kernel.org, linux-block@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, Huaicheng Li <huaicheng@cs.uchicago.edu>
References: <66350920-EC5E-447F-B5DF-0F3C2CDEAA65@javigon.com>
From: =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <97678ddd-140f-5a8b-75ee-cbb584308260@lightnvm.io>
Date: Thu, 22 Mar 2018 18:00:54 +0100
MIME-Version: 1.0
In-Reply-To: <66350920-EC5E-447F-B5DF-0F3C2CDEAA65@javigon.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 03/22/2018 03:34 PM, Javier Gonz�lez wrote:
> Hi,
> 
> I have been looking into a bug report when using pblk and raid5 on top
> and I am having problems understanding if the problem is in pblk's bio
> handling or on raid5's bio assumptions on the completion path.
> 
> The problem occurs on the read path. In pblk, we take a reference to
> every read bio as it enters, and release it after completing the bio.
> 
>     generic_make_request()
>     pblk_submit_read()
>       bio_get()
>       ...
>       bio_endio()
>       bio_put()
> 
> The problem seems to be that on raid5's bi_end_io completion path,
> raid5_end_read_request(), bio_reset() is called. When put together
> with pblk's bio handling:
> 
>     generic_make_request()
>     pblk_submit_read()
>       bio_get()
>       ...
>       bio_endio()
>       raid5_end_read_request()
>         bio_reset()
>       bio_put()
> 
> it results in the newly reset bio being put immediately, thus freed.
> When the bio is reused then, we have an invalid pointer. In the report
> we received things crash at BUG_ON(bio->bi_next) at
> generic_make_request().
> 
> As far as I understand, it is part of the bio normal operation for
> drivers under generic_make_request() to be able to take references and
> release them after bio completion. Thus, in this case, the assumption
> made by raid5, that it can issue a bio_reset() is incorrect. But I might
> be missing an implicit cross layer rule that we are violating in pblk.
> Any ideas?
> 
> This said, after analyzing the problem from pblk's perspective, I see
> not reason to use bio_get()/bio_put() in the read path as it is at the
> pblk level that we are submitting bio_endio(), thus we cannot risk the
> bio being freed underneath us. Is this reasoning correct? I remember I
> introduced these at the time there was a bug on the aio path, which was
> not cleaning up correctly and could trigger an early bio free, but
> revisiting it now, it seems unnecessary.
> 
> Thanks for the help!
> 
> Javier
> 

I think I sent a longer e-mail to you and Huaicheng about this a while 
back.

The problem is that the pblk encapsulates the bio in its own request. So 
the bio's are freed before the struct request completion is done (as you 
identify). If you can make the completion path (as bio's are completed 
before the struct request completion fn is called) to not use the bio, 
then the bio_get/put code can be removed.

If it needs the bio on the completion path (e.g., for partial reads, and 
if needed in the struct request completion path), one should clone the 
bio, submit, and complete the original bio afterwards.
