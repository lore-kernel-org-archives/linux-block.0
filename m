Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] block, bfq: return nbytes and not zero from struct cftype
 .write() method
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Paolo Valente <paolo.valente@linaro.org>, linux-block@vger.kernel.org,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Arianna Avanzini <avanzini.arianna@gmail.com>
References: <f574e019-00f2-96c3-fc32-541c6584ca96@maciej.szmigiero.name>
 <19c68f93-017d-cda1-632f-039ca3ca0158@kernel.dk>
 <1f2ca124-bb7c-d02c-07cd-4afe6a634ee6@maciej.szmigiero.name>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <cb3a6209-9474-2b4d-1ff8-2e2f7c3367fb@kernel.dk>
Date: Fri, 17 Aug 2018 11:38:57 -0600
MIME-Version: 1.0
In-Reply-To: <1f2ca124-bb7c-d02c-07cd-4afe6a634ee6@maciej.szmigiero.name>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 8/17/18 11:27 AM, Maciej S. Szmigiero wrote:
> On 16.08.2018 21:11, Jens Axboe wrote:
>> On 8/15/18 3:56 PM, Maciej S. Szmigiero wrote:
>>> The value that struct cftype .write() method returns is then directly
>>> returned to userspace as the value returned by write() syscall, so it
>>> should be the number of bytes actually written (or consumed) and not zero.
>>>
>>> Returning zero from write() syscall makes programs like /bin/echo or bash
>>> spin.
>>
>> Applied, thanks.
> 
> Thanks.
> 
>> Just a heads-up that gmail thinks your email is spam.
> 
> Thanks for the information - it looks like gmail just doesn't like my
> email server for some reason.

This one came through fine, jfyi.

-- 
Jens Axboe
