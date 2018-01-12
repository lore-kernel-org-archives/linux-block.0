Return-Path: <holger@applied-asynchrony.com>
Subject: Re: [PATCH IMPROVEMENT] block, bfq: limit sectors served with
 interactive weight raising
To: Paolo Valente <paolo.valente@linaro.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block <linux-block@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Ulf Hansson <ulf.hansson@linaro.org>, broonie@kernel.org,
 linus.walleij@linaro.org, bfq-iosched@googlegroups.com,
 oleksandr@natalenko.name
References: <20171228111917.2767-1-paolo.valente@linaro.org>
 <5a9c6573-84a6-ae7b-7058-f202c7187065@applied-asynchrony.com>
 <12660CC7-AD89-434A-9BEA-BA0B4C362807@linaro.org>
From: =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
Message-ID: <c1cb979a-007c-7607-0c02-4f9110f90a13@applied-asynchrony.com>
Date: Fri, 12 Jan 2018 11:15:11 +0100
MIME-Version: 1.0
In-Reply-To: <12660CC7-AD89-434A-9BEA-BA0B4C362807@linaro.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 01/12/18 06:58, Paolo Valente wrote:
> 
> 
>> Il giorno 28 dic 2017, alle ore 15:00, Holger Hoffstätte <holger@applied-asynchrony.com> ha scritto:
>>
>>
>> On 12/28/17 12:19, Paolo Valente wrote:
>> (snip half a tech report ;)
>>
>> So either this or the previous patch ("limit tags for writes and async I/O"
>> can lead to a hard, unrecoverable hang with heavy writes. Since I couldn't
>> log into the affected system anymore I couldn't get any stack traces, blk-mq
>> debug output etc. but there was nothing in dmesg/on the console, so it
>> wasn't a BUG/OOPS.
>>
>> -h
> 
> Hi Holger,
> if, as I guess, this problem hasn't gone away for you, I have two
> requests:
> 1) could you share your exact test
> 2) if nothing happens in my systems with your test, would you be
> willing to retry with the dev version of bfq?  It should be able to
> tell us what takes to your hang.  If you are willing to do this test,
> I'll prepare a branch with everything already configured for you.

Hi,

thanks for following up but there's no need for any of that; it turned out
to be something else since I got the same hang without those patches at
least once (during a btrfs balance, even though it didn't look like btrfs'
fault directly; more like block/mm/helpers.

So on January 7 I posted to linux-block et.al. where I said
"So this turned out to be something else, sorry for the false alarm."
but apparently that didn't make it through since it's not in the
archives either. Sorry.

Long story short, the good news is that I've been running with both patches
since then without any issue. :)

cheers
Holger
