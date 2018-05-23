Return-Path: <jianchao.w.wang@oracle.com>
Subject: Re: [PATCH] block: kyber: make kyber more friendly with merging
To: =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>,
        Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1527000509-2619-1-git-send-email-jianchao.w.wang@oracle.com>
 <163c5760-cf0e-faea-ee4e-ac5d688310fe@applied-asynchrony.com>
 <00e5dfd4-d3a2-b008-3d8b-390a788f61c9@kernel.dk>
 <7c93b85f-6a02-bdcf-5e92-a9533500df20@kernel.dk>
 <fc26ef08-2e2a-3b2d-2190-8419307b243e@applied-asynchrony.com>
From: "jianchao.wang" <jianchao.w.wang@oracle.com>
Message-ID: <d5c15cb9-cef9-3d05-8895-b826fa1c7f01@oracle.com>
Date: Wed, 23 May 2018 09:59:15 +0800
MIME-Version: 1.0
In-Reply-To: <fc26ef08-2e2a-3b2d-2190-8419307b243e@applied-asynchrony.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

Hi Jens and Holger

Thank for your kindly response.
That's really appreciated.

I will post next version based on Jens' patch.

Thanks
Jianchao

On 05/23/2018 02:32 AM, Holger Hoffstätte wrote:
>>>> This looks great but prevents kyber from being built as module,
>>>> which is AFAIK supposed to work (and works now):
>>>>
>>>> ..
>>>>   CC [M]  block/kyber-iosched.o
>>>>   Building modules, stage 2.
>>>>   MODPOST 313 modules
>>>> ERROR: "bio_attempt_back_merge" [block/kyber-iosched.ko] undefined!
>>>> ERROR: "bio_attempt_front_merge" [block/kyber-iosched.ko] undefined!
>>>> ERROR: "bio_attempt_discard_merge" [block/kyber-iosched.ko] undefined!
>>>> ERROR: "blk_try_merge" [block/kyber-iosched.ko] undefined!
>>>> ERROR: "blk_rq_merge_ok" [block/kyber-iosched.ko] undefined!
>>>> ..
>>>>
>>>> It does build fine when compiled in, obviously. :)
>>> It's basically duplicating the contents of blk_attempt_plug_merge().
>>> I would suggest abstracting out the list loop and merge check
>>> into a helper, that could then both be called from kyber and the
>>> plug merge function.
>> See attached, prep patch and yours rebased on top of it.
> That was quick. :)
> 
> Applies smoothly on top of my 4.16++ tree, now builds correctly as
> module and is reproducibly (slightly) faster even on my pedestrian
> SATA SSDs, now on par or occasionally even faster than mq-deadline.
> What's not to like? So:
> 
> Tested-by: Holger Hoffstätte <holger@applied-asynchrony.com>
