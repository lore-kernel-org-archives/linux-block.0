Return-Path: <axboe@kernel.dk>
Subject: Re: for-4.12/block branch
To: Bart Van Assche <Bart.VanAssche@sandisk.com>
References: <1492788745.2550.1.camel@sandisk.com>
 <f6e71f2a-ad0b-c884-1e16-a2062c70b6cf@fb.com>
 <1492792278.2550.5.camel@sandisk.com>
 <b248fae1-c51f-be03-d27c-a9730b65132a@fb.com>
 <1492792852.2550.7.camel@sandisk.com>
 <5e5870a4-bbff-8486-f28c-49127a9c60a5@fb.com>
 <fae5b2be-b18e-cb1c-675e-79869f678c7e@kernel.dk>
 <1492794346.2550.12.camel@sandisk.com>
 <b57a4bf4-5c70-8c10-476c-105907b09510@kernel.dk>
 <1492796361.2550.22.camel@sandisk.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <bf1227a6-e295-da91-e0d8-6767162f68b1@kernel.dk>
Date: Fri, 21 Apr 2017 11:53:44 -0600
MIME-Version: 1.0
In-Reply-To: <1492796361.2550.22.camel@sandisk.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-block@vger.kernel.org>

On 04/21/2017 11:39 AM, Bart Van Assche wrote:
> On Fri, 2017-04-21 at 11:07 -0600, Jens Axboe wrote:
>> Let me know what that bisection yields.
> 
> Hello Jens,
> 
> Although I still have to double-check the result, this is what git bisect
> reported:
> 
> b00c53e8f411a0b2be036c41852c6858541afbf7 is the first bad commit
> commit b00c53e8f411a0b2be036c41852c6858541afbf7
> Author: Jens Axboe <axboe@fb.com>
> Date:   Thu Apr 20 16:40:36 2017 -0600
> 
>     blk-mq: fix schedule-while-atomic with scheduler attached
> 
> I have attached my kernel config to this e-mail. Please let me know if you
> need more information.

That would have been my prime suspect as well, since it is fiddling
with the preempt counts. I'll double check the patch.

-- 
Jens Axboe
