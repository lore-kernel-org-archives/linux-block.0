Return-Path: <holger@applied-asynchrony.com>
Subject: Re: [PATCH] blk-wbt: Avoid lock contention and thundering herd issue
 in wbt_wait
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
References: <6bab69c9-b787-b12f-7738-72e05bf74444@kernel.dk>
 <761bb0ab416649b8bf3bac1706124456@EX13D13UWB002.ant.amazon.com>
 <7f6c399d-bda1-0bbf-4ea1-07fc510ed1eb@kernel.dk>
 <3498fbfb-e9f3-7606-1fc3-904a0e61ff57@kernel.dk>
 <168d80ac73a44a6f9242c47c164778fc@EX13D13UWB002.ant.amazon.com>
 <c5152431-6e36-6f6e-616e-1cfbd974817d@kernel.dk>
 <20180820224241.GA72523@8c8590bceeee.ant.amazon.com>
 <70e2063a-53fa-2475-eed9-07db277c8c0d@kernel.dk>
 <b2adf708-d396-94ac-b123-8027d3839fd1@kernel.dk>
 <20180822040126.GA18736@kaos-source-ops-60001.pdx1.amazon.com>
 <76ecb022-f167-67eb-8801-111fc209bbaa@kernel.dk>
 <834649ab-62d6-bc7f-ec60-6c1654ea3f26@applied-asynchrony.com>
 <d8c171ce-6dfe-e9e5-5673-8443cfec5f01@kernel.dk>
 <ed71fb8f-1f36-c216-5886-269c77250e29@kernel.dk>
 <1c40bce3-24fc-f473-5263-a04a677a3f69@applied-asynchrony.com>
 <727c76cc-3578-2272-eaaf-834213d929e1@kernel.dk>
 <ae772eed-6488-acd2-4122-73a10a669b99@applied-asynchrony.com>
 <6f0e6f3d-060b-1dd7-b91e-5e9df3f485cb@kernel.dk>
From: =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
Message-ID: <ee45647b-d848-5be0-6ae1-4349e68a15ca@applied-asynchrony.com>
Date: Wed, 22 Aug 2018 21:58:49 +0200
MIME-Version: 1.0
In-Reply-To: <6f0e6f3d-060b-1dd7-b91e-5e9df3f485cb@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

On 08/22/18 21:46, Jens Axboe wrote:
> On 8/22/18 1:37 PM, Holger Hoffstätte wrote:
>> On 08/22/18 21:17, Jens Axboe wrote:
>>>> So the obvious suspect is the new return of UINT_MAX from get_limit() to
>>>> __wbt_wait(). I first suspected that I mispatched something, but it's all
>>>> like in mainline or your tree. Even the recently moved-around atomic loop
>>>> inside rq_wait_inc_below() is 1:1 the same and looks like it should.
>>>> Now building mainline and see where that leads me.
>>
>> So mainline + your tree's last 4 patches works fine, as suspected.
>> It's all me, as usual.
> 
> That's a relief!
> 
>>> I wonder if it's a signedness thing? Can you try and see if using INT_MAX
>>> instead changes anything?
>>
>> Beat me to it while I was rebooting ;-)
>> Exactly what I also found a minute ago:
>>
>> $diff -rup linux-4.18.4/block/blk-rq-qos.c linux/block/blk-rq-qos.c
>> ..
>> -bool rq_wait_inc_below(struct rq_wait *rq_wait, int limit)
>> +bool rq_wait_inc_below(struct rq_wait *rq_wait, unsigned int limit)
>> ..
>>
>> Moo! Patching now.
> 
> At least we have an explanation for why it didn't work.

Luckily I can still read and 22f17952c7 is conveniently called "blk-rq-qos:
make depth comparisons unsigned"! Needless to say with that thrown into the
mix all is good again. Sorry for the confusion & thanks for your patience.

cheers!
Holger
