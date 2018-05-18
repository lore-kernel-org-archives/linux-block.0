Return-Path: <axboe@kernel.dk>
Subject: Re: blk-mq: make sure that correct hctx->dispatch_from is set
To: Bart Van Assche <Bart.VanAssche@wdc.com>,
 "huhai@kylinos.cn" <huhai@kylinos.cn>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "ming.lei@redhat.com" <ming.lei@redhat.com>
References: <tencent_47349987636D0D2B620828E0@qq.com>
 <6c265e65-d248-f6e0-1be4-e4223f1a4ed6@kernel.dk>
 <07c44734-2aeb-79b2-6404-893b575debd5@kernel.dk>
 <tencent_128A9294097C7C620337BAAF@qq.com>
 <a59b0cd1a5bddf8f00eda21e3eaadfe02db52311.camel@wdc.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <fd2ce5bb-0226-7d53-9f4e-c024640e2e07@kernel.dk>
Date: Fri, 18 May 2018 09:15:46 -0600
MIME-Version: 1.0
In-Reply-To: <a59b0cd1a5bddf8f00eda21e3eaadfe02db52311.camel@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 5/18/18 9:10 AM, Bart Van Assche wrote:
> On Fri, 2018-05-18 at 22:46 +0800, huhai wrote:
>> Yes, it is more readable
>>
>> Finally, thank you for reminding me. Next time I'll change gmail to submit patch.
> 
> Hello Huhai,
> 
> Please have a look at Documentation/process/email-clients.rst.

Yeah, I did point at that one too.

For sending out patches, I would strongly recommend just using git send-email.
It works fine with gmail, that's what I always use.

$ cat ~/.gitconfig
[sendemail]
from = Jens Axboe <axboe@kernel.dk>
smtpserver = smtp.gmail.com
smtpuser = axboe@kernel.dk
smtpencryption = tls
smtppass = <insert pass or appcode here>
smtpserverport = 587

-- 
Jens Axboe
