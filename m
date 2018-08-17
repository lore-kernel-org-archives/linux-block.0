Return-Path: <axboe@kernel.dk>
Subject: Re: blk-mq 5-8 times slower for bmap-tools
To: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>,
 paolo.valente@linaro.org
Cc: linux-block@vger.kernel.org, Ben Hutchings <ben@decadent.org.uk>
References: <CAPybu_2k-0d=8NxL7kr757QcWOnXyU_TAyV7DMwiMrSDkiXfgA@mail.gmail.com>
 <5F152F61-4DBE-4394-939B-D5F82EEE72AE@linaro.org>
 <CAPybu_3_ZJ8KopMM6fxvHXkXmdLUyqPZoXx=fx=nDYOXsvesHg@mail.gmail.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <42235a21-ff82-1b78-afa2-8d5d662c1048@kernel.dk>
Date: Fri, 17 Aug 2018 11:41:41 -0600
MIME-Version: 1.0
In-Reply-To: <CAPybu_3_ZJ8KopMM6fxvHXkXmdLUyqPZoXx=fx=nDYOXsvesHg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 8/17/18 11:39 AM, Ricardo Ribalda Delgado wrote:
> Hello Paolo
> On Fri, Aug 17, 2018 at 7:35 PM Paolo Valente <paolo.valente@linaro.org> wrote:
>>
>>
>>
>>> Il giorno 17 ago 2018, alle ore 19:31, Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com> ha scritto:
>>>
>>> Hello
>>>
>>> Coming from: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=906328
>>>
>>> bmaptools is kind of a "smart dd" tool, that lets you write images
>>> very fast and securely. Since the last Debian Kernel update it has
>>> become 5-8 times slower.
>>>
>>> After some debugging, we have figured out that the reason for that
>>> slowness is the Multi-Queue Block IO Queueing Mechanism.
>>>
>>> Debian maintainer has pointed out that in the near future the single
>>> queue will be deprecated.
>>>
>>> My question is if we can get a similar perfomance for bmaptools with
>>> blk-mq and how?
>>>
>>
>> Have you also checked what happens after switching to a different I/O
>> scheduler for the involved drive (among none, mq-deadline, bfq and
>> kyber)?
> 
> I have only tried mq-deadline and none (because they are enabled by
> default on Debian). Both produce results in the same range: 5-8 times
> slower.
> 
> I could easily enable kyber:
> cat /boot/config-4.17.0-1-amd64  | grep CONFIG_MQ_IOSCHED
> CONFIG_MQ_IOSCHED_DEADLINE=y
> CONFIG_MQ_IOSCHED_KYBER=m
> 
> But I left the card reader on the office, so any test would have to
> wait until monday sorry :(

Can someone describe what bmaptools does? IOW, how is it different than
dd? Does it use multiple threads for both reads and writes?

-- 
Jens Axboe
